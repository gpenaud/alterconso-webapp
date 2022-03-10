# ============================================================================ #
#                           SOURCE CODE COMPILATION                            #
# ============================================================================ #

FROM node:17-bullseye-slim AS cagette-sourcecode

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/neko
ENV HAXE_LIBCACHE /root/haxe/haxe_libraries
ENV PATH          /root/haxe/:$PATH

# Neko environment variables
ENV NEKOPATH        /root/haxe/neko
ENV LD_LIBRARY_PATH /root/haxe/neko
ENV PATH            /root/haxe/neko/:$PATH

RUN \
  apt-get --yes update && apt-get --yes install \
    curl \
    zip

RUN \
  curl --output /tmp/cagette.zip --show-error --location "https://github.com/CagetteNet/cagette/releases/download/last_full_haxe_cagette/last_full_haxe._cagette.zip" && \
  unzip /tmp/cagette.zip -d "/tmp" && rm -f /tmp/cagette.zip && \
  mv "/tmp/last_full_hx _cagette/app" /app

RUN \
  npm install --global \
    lix \
    haxe-modular

# Backend part
# ------------------------------------------------------------------------------

WORKDIR /app/backend

RUN \
  # cagette-pro is a private repository and requires authentication
  rm haxe_libraries/cagette-pro.hxml && \
  lix download

RUN \
  chmod 777 /app/lang/master/tmp && \
  cp /app/config.xml.dist /app/config.xml

# Fix git version problem - we use a ziped package there, not a git repository
RUN sed -i 's/.*public static var VERSION.*/        public static var VERSION = "1.0.0";/' /app/src/App.hx
RUN haxe cagette.hxml

# Frontend part
# ------------------------------------------------------------------------------

WORKDIR /app/frontend

RUN lix download

# Fix git version problem - we use a ziped package there, not a git repository
RUN sed -i 's/.*public static var VERSION.*/        public static var VERSION = "1.0.0";/' /app/js/App.hx
RUN haxe cagetteJs.hxml

# ============================================================================ #
#                   APPLICATION CONFIGURATION AND EXECUTION                    #
# ============================================================================ #

FROM debian:bullseye-slim

COPY --from=cagette-sourcecode /app  /var/www/cagette

RUN \
  apt-get --yes update && apt-get --no-install-recommends --yes install \
    apache2 \
    ca-certificates \
    haxe \
    imagemagick \
    libapache2-mod-neko \
    # allow setcap command to be used
    libcap2-bin

# Haxe environment variables
ENV HAXE_STD_PATH   /usr/lib/x86_64-linux-gnu/neko
ENV NEKOPATH        /usr/lib/x86_64-linux-gnu/neko
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/neko

# install and run templo
# ------------------------------------------------------------------------------

RUN \
  haxelib setup /usr/share/haxelib && \
  haxelib install templo && \
  cd /usr/lib && \
  haxelib run templo

# configure apache2
# ------------------------------------------------------------------------------

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2

RUN \
  a2enmod rewrite && \
  a2enmod neko && \
  sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf && \
  sed -i 's!/var/www/html!/var/www/cagette/www!g' /etc/apache2/sites-available/000-default.conf && \
  chmod --recursive o+rwx /var/log/apache2 /var/run/apache2 && \
  # allow apache2 to be executed by user www-data
  setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2 && \
  setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2ctl && \
  service apache2 restart

# clean up packages
# ------------------------------------------------------------------------------

RUN \
  apt-get --yes --purge remove \
    haxe \
    imagemagick \
    libcap2-bin \
  && rm -rf /var/lib/apt/lists/*

# execute apache2
# ------------------------------------------------------------------------------

USER www-data
WORKDIR /var/www/cagette

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]

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

COPY ./docker/app /app

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
  lix download && \
  chmod 777 /app/lang/master/tmp

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

RUN \
  apt-get --yes update && apt-get --no-install-recommends --yes install \
    apache2 \
    ca-certificates \
    haxe \
    imagemagick \
    libapache2-mod-neko \
    # allow setcap command to be used
    libcap2-bin

COPY --chown=www-data:www-data --from=cagette-sourcecode /app  /var/www/cagette

# Haxe environment variables
ENV HAXE_STD_PATH   /usr/lib/x86_64-linux-gnu/neko
ENV NEKOPATH        /usr/lib/x86_64-linux-gnu/neko
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/neko
ENV PATH            /usr/lib/:$PATH

# install and run templo
# ------------------------------------------------------------------------------

RUN \
  haxelib setup /usr/share/haxelib && \
  haxelib install templo && \
  cd /usr/lib && \
  haxelib run templo

# configure apache2
# ------------------------------------------------------------------------------

# apache environmant variables
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2

# cagette environmant variables
ARG CAGETTE_SMTP_USER
ARG CAGETTE_SMTP_PASSWORD
ARG CAGETTE_SQL_LOG
ARG CAGETTE_SQL_DEBUG

# enable modules
RUN \
  a2enmod ssl && \
  a2enmod rewrite && \
  a2enmod neko

# remove default vhosts
RUN rm -f \
  /etc/apache2/sites-available/000-default.conf \
  /etc/apache2/sites-enabled/000-default.conf

# copy certificates
COPY ./docker/httpd/certificates /etc/apache2/certificates

# copy vhost configuration
COPY ./docker/httpd/vhosts/https.conf /etc/apache2/sites-available/cagette.localhost.conf
COPY ./docker/httpd/vhosts/https.conf /etc/apache2/sites-enabled/cagette.localhost.conf

# create apache2 certificates directory
RUN \
  chmod --recursive o+rwx /var/log/apache2 /var/run/apache2 && \
  mkdir -p /etc/apache2/certificates

# link logs to stderr and stdout
RUN \
  ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
  ln -sf /proc/self/fd/1 /var/log/apache2/error.log

RUN \
  cp /var/www/cagette/config.xml.dist /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_user.*/        smtp_user="'"${CAGETTE_SMTP_USER}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_pass.*/        smtp_pass="'"${CAGETTE_SMTP_PASSWORD}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*sqllog.*/        sqllog="'"${CAGETTE_SQL_LOG}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*debug.*/        debug="'"${CAGETTE_SQL_DEBUG}"'"/' /var/www/cagette/config.xml

RUN service apache2 restart

# execute apache2
# ------------------------------------------------------------------------------

USER root
WORKDIR /var/www/cagette

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

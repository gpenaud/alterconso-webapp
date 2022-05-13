# ============================================================================ #
#                           SOURCE CODE COMPILATION                            #
# ============================================================================ #

# image: node:17-bullseye-slim
FROM node@sha256:47704b6439c27955da5fd53b94d40157171203a6e7e7b1422ca404dab05fed00 AS cagette-sourcecode

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/neko
ENV HAXE_LIBCACHE /root/haxe/haxe_libraries
ENV PATH          /root/haxe/:$PATH

# Neko environment variables
ENV NEKOPATH        /root/haxe/neko
ENV LD_LIBRARY_PATH /root/haxe/neko
ENV PATH            /root/haxe/neko/:$PATH

RUN npm install --global \
  git \
  lix \
  haxe-modular

# backend dependencies compilation
COPY ./docker/app/backend /app/backend
COPY ./docker/app/devLibs /app/devLibs
# download lix dependencies for backend
# NOTE: cagette-pro is a private repository and requires authentication, so we remove it
RUN cd /app/backend && rm haxe_libraries/cagette-pro.hxml && lix download

# frontend dependencies compilation
COPY ./docker/app/frontend /app/frontend
# download lix dependencies for frontend
RUN cd /app/frontend && lix download

# copy sources
COPY ./docker/app/build /app/build
COPY ./docker/app/common /app/common
COPY ./docker/app/data /app/data
COPY ./docker/app/js /app/js
COPY ./docker/app/lang /app/lang
COPY ./docker/app/src /app/src
COPY ./docker/app/www /app/www
COPY ./docker/app/config.xml.dist /app/config.xml

RUN chmod 777 /app/lang/master/tmp

RUN cd /app/backend && haxe cagette.hxml
RUN cd /app/frontend && haxe cagetteJs.hxml

# ============================================================================ #
#                   APPLICATION CONFIGURATION AND EXECUTION                    #
# ============================================================================ #

# image: debian:bullseye-slim
FROM debian@sha256:fbaacd55d14bd0ae0c0441c2347217da77ad83c517054623357d1f9d07f79f5e

RUN \
  apt-get --yes update && apt-get --no-install-recommends --yes install \
    apache2 \
    ca-certificates \
    cron \
    curl \
    haxe \
    imagemagick \
    libapache2-mod-neko \
    # allow setcap command to be used
    libcap2-bin \
    procps

COPY --chown=www-data:www-data --from=cagette-sourcecode /app  /var/www/cagette

# Haxe environment variables
ENV HAXE_STD_PATH   /usr/lib/x86_64-linux-gnu/neko
ENV NEKOPATH        /usr/lib/x86_64-linux-gnu/neko
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/neko
ENV PATH            /usr/lib/x86_64-linux-gnu/neko:$PATH
ENV HAXE_LIBCACHE   /root/haxe/haxe_libraries

# install and run templo
# ------------------------------------------------------------------------------

RUN \
  haxelib setup /usr/share/haxelib && \
  haxelib install templo && \
  cd /usr/lib/x86_64-linux-gnu/neko && \
  haxelib run templo

# configure apache2
# ------------------------------------------------------------------------------

# apache environmant variables
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2

# cagette environmant variables
ARG CAGETTE_SMTP_HOST
ARG CAGETTE_SMTP_PORT
ARG CAGETTE_SMTP_USER
ARG CAGETTE_SMTP_PASSWORD
ARG CAGETTE_SQL_LOG
ARG CAGETTE_DEBUG

# remove default vhosts
RUN rm -f \
  /etc/apache2/sites-available/000-default.conf \
  /etc/apache2/sites-enabled/000-default.conf

# copy apache2 related files
COPY ./docker/httpd/apache2.conf /etc/apache2/apache2.conf
COPY ./docker/httpd/certificates /etc/apache2/certificates
COPY ./docker/httpd/vhosts/https.conf /etc/apache2/sites-available/cagette.localhost.conf
COPY ./docker/httpd/vhosts/https.conf /etc/apache2/sites-enabled/cagette.localhost.conf

# copy cron file
COPY --chown=www-data:www-data ./crontab.sh /var/www/cagette/crontab.sh
RUN sh /var/www/cagette/crontab.sh

# run multiples apache2-related operations
RUN \
  chmod --recursive o+rwx /var/log/apache2 /var/run/apache2 && \
  mkdir -p /etc/apache2/certificates && \
  # prepare apache2 logs
  ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
  ln -sf /proc/self/fd/1 /var/log/apache2/error.log

RUN \
  # prepare apache2 to be executed as www-data user
  setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2ctl && \
  setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2

RUN \
  sed -i 's/.*smtp_host.*/        smtp_host="'"${CAGETTE_SMTP_HOST}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_port.*/        smtp_port="'"${CAGETTE_SMTP_PORT}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_user.*/        smtp_user="'"${CAGETTE_SMTP_USER}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_pass.*/        smtp_pass="'"${CAGETTE_SMTP_PASSWORD}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*sqllog.*/        sqllog="'"${CAGETTE_SQL_LOG}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*debug.*/        debug="'"${CAGETTE_DEBUG}"'"/' /var/www/cagette/config.xml

# configure modules
RUN \
  a2dismod -f auth_basic && \
  a2dismod -f authn_core && \
  a2dismod -f authn_file && \
  a2dismod -f authz_host && \
  a2dismod -f authz_user && \
  a2dismod -f autoindex && \
  a2dismod -f deflate && \
  a2dismod -f status

RUN \
  a2enmod ssl && \
  a2enmod rewrite && \
  a2enmod neko

RUN \
  service apache2 restart && \
  rm /var/run/apache2/apache2.pid

# execute apache2
# ------------------------------------------------------------------------------

USER www-data
WORKDIR /var/www/cagette
EXPOSE 80

CMD ["sh", "-c", "/usr/sbin/service cron start && /usr/sbin/apache2ctl -D FOREGROUND"]

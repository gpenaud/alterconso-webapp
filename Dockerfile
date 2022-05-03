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

# FROM debian:bullseye-slim
FROM node:17-bullseye-slim

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
    libcap2-bin

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

# copy cron file
COPY --chown=www-data:www-data ./crontab.sh /var/www/cagette/crontab.sh
RUN sh /var/www/cagette/crontab.sh

# create apache2 certificates directory
RUN \
  chmod --recursive o+rwx /var/log/apache2 /var/run/apache2 && \
  mkdir -p /etc/apache2/certificates

# link logs to stderr and stdout
RUN \
  ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
  ln -sf /proc/self/fd/1 /var/log/apache2/error.log

RUN \
  sed -i 's/.*smtp_host.*/        smtp_host="'"${CAGETTE_SMTP_HOST}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_port.*/        smtp_port="'"${CAGETTE_SMTP_PORT}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_user.*/        smtp_user="'"${CAGETTE_SMTP_USER}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*smtp_pass.*/        smtp_pass="'"${CAGETTE_SMTP_PASSWORD}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*sqllog.*/        sqllog="'"${CAGETTE_SQL_LOG}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*debug.*/        debug="'"${CAGETTE_DEBUG}"'"/' /var/www/cagette/config.xml

RUN service apache2 restart

# execute apache2
# ------------------------------------------------------------------------------

USER root
WORKDIR /var/www/cagette
EXPOSE 80

CMD ["sh", "-c", "/usr/sbin/service cron start && /usr/sbin/apache2ctl -D FOREGROUND"]

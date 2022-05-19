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
COPY ./src/backend /app/backend
COPY ./src/devLibs /app/devLibs
# download lix dependencies for backend
# NOTE: cagette-pro is a private repository and requires authentication, so we remove it
RUN cd /app/backend && rm haxe_libraries/cagette-pro.hxml && lix download

# frontend dependencies compilation
COPY ./src/frontend /app/frontend
# download lix dependencies for frontend
RUN cd /app/frontend && lix download

# copy sources
COPY ./src/build /app/build
COPY ./src/common /app/common
COPY ./src/data /app/data
COPY ./src/js /app/js
COPY ./src/lang /app/lang
COPY ./src/src /app/src
COPY ./src/www /app/www
COPY ./src/config.xml.dist /app/config.xml

RUN chmod 777 /app/lang/master/tmp

RUN cd /app/backend && haxe cagette.hxml
RUN cd /app/frontend && haxe cagetteJs.hxml

# ============================================================================ #
#                   APPLICATION CONFIGURATION AND EXECUTION                    #
# ============================================================================ #

# image: debian:bullseye-slim
FROM debian@sha256:fbaacd55d14bd0ae0c0441c2347217da77ad83c517054623357d1f9d07f79f5e

# ensure to be able to recompile haxe code for debugging purpose
COPY --from=cagette-sourcecode /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=cagette-sourcecode /usr/local/bin /usr/local/bin
COPY --from=cagette-sourcecode /root/haxe /root/haxe

RUN \
  apt-get --yes update && apt-get --no-install-recommends --yes install \
    apache2 \
    ca-certificates \
    cron \
    curl \
    haxe \
    libapache2-mod-neko \
    # allow setcap command to be used for apache2 command execution as non-root users
    libcap2-bin

COPY --chown=www-data:www-data --from=cagette-sourcecode /app /var/www/cagette

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
ARG CAGETTE_CACHETPL

# remove default vhosts
RUN rm --force \
  /etc/apache2/sites-available/000-default.conf \
  /etc/apache2/sites-enabled/000-default.conf

# copy apache2 related files
COPY ./services/apache2/apache2.conf /etc/apache2/apache2.conf
COPY ./services/apache2/certificates /etc/apache2/certificates
COPY ./services/apache2/vhosts/https.conf /etc/apache2/sites-available/cagette.localhost.conf
COPY ./services/apache2/vhosts/https.conf /etc/apache2/sites-enabled/cagette.localhost.conf

# copy cron file
COPY --chown=www-data:www-data ./scripts/crontab.sh /var/www/cagette/crontab.sh
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
  sed -i 's/.*debug.*/        debug="'"${CAGETTE_DEBUG}"'"/' /var/www/cagette/config.xml && \
  sed -i 's/.*cachetpl.*/        cachetpl="'"${CAGETTE_CACHETPL}"'"/' /var/www/cagette/config.xml

# configure modules
RUN \
  a2dismod --quiet --force auth_basic && \
  a2dismod --quiet --force authn_core && \
  a2dismod --quiet --force authn_file && \
  a2dismod --quiet --force authz_host && \
  a2dismod --quiet --force authz_user && \
  a2dismod --quiet --force autoindex && \
  a2dismod --quiet --force status

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

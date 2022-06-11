# ============================================================================ #
#                           SOURCE CODE COMPILATION                            #
# ============================================================================ #

# image: node:17-bullseye-slim
FROM node@sha256:47704b6439c27955da5fd53b94d40157171203a6e7e7b1422ca404dab05fed00 AS alterconso-sourcecode

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
COPY ./app/backend /app/backend
COPY ./app/devLibs /app/devLibs
# download lix dependencies for backend
# NOTE: cagette-pro is a private repository and requires authentication, so we remove it
RUN cd /app/backend && rm haxe_libraries/cagette-pro.hxml && lix download

# frontend dependencies compilation
COPY ./app/frontend /app/frontend
# download lix dependencies for frontend
RUN cd /app/frontend && lix download

# copy sources
COPY ./app/build /app/build
COPY ./app/common /app/common
COPY ./app/data /app/data
COPY ./app/js /app/js
COPY ./app/lang /app/lang
COPY ./app/src /app/src
COPY ./app/www /app/www
COPY ./app/config.xml.dist /app/config.xml

RUN chmod 777 /app/lang/master/tmp

RUN cd /app/backend && haxe cagette.hxml
RUN cd /app/frontend && haxe cagetteJs.hxml

# ============================================================================ #
#                   APPLICATION CONFIGURATION AND EXECUTION                    #
# ============================================================================ #

# image: debian:bullseye-slim
FROM debian@sha256:fbaacd55d14bd0ae0c0441c2347217da77ad83c517054623357d1f9d07f79f5e

# Configure timezone
ENV TZ="Europe/Paris"

# ensure to be able to recompile haxe code for debugging purpose
COPY --from=alterconso-sourcecode /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=alterconso-sourcecode /usr/local/bin /usr/local/bin
COPY --from=alterconso-sourcecode /root/haxe /root/haxe

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

COPY --chown=www-data:www-data --from=alterconso-sourcecode /app /var/www/alterconso

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

# remove default vhosts
RUN rm --force \
  /etc/apache2/sites-available/000-default.conf \
  /etc/apache2/sites-enabled/000-default.conf

# copy cron file
COPY --chown=www-data:www-data ./scripts/crontab.sh /var/www/alterconso/crontab.sh
RUN sh /var/www/alterconso/crontab.sh

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
WORKDIR /var/www/alterconso
EXPOSE 80

CMD ["sh", "-c", "/usr/sbin/service cron start && /usr/sbin/apache2ctl -D FOREGROUND"]

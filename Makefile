## permanent variables
.ONESHELL:
SHELL 			:= /bin/bash
PROJECT			?= github.com/gpenaud/cagette-webapp
RELEASE			?= $(shell git describe --tags --abbrev=0)
CURRENT_TAG ?= $(shell git describe --exact-match --tags 2> /dev/null)
COMMIT			?= $(shell git rev-parse --short HEAD)
BUILD_TIME  ?= $(shell date -u '+%Y-%m-%d_%H:%M:%S')

## Build webapp image
build:
	@[ "${CURRENT_TAG}" ] || echo "no tag found at commit ${COMMIT}"
	@[ "${CURRENT_TAG}" ] && docker build --tag cagette/webapp:${CURRENT_TAG} .

## Tag webapp image
tag:
	@[ "${CURRENT_TAG}" ] || echo "no tag found at commit ${COMMIT}"
	@[ "${CURRENT_TAG}" ] && docker tag cagette/webapp:${CURRENT_TAG} rg.fr-par.scw.cloud/le-portail/cagette/webapp:${CURRENT_TAG}

## Push webapp image to scaleway repository
push:
	@[ "${CURRENT_TAG}" ] || echo "no tag found at commit ${COMMIT}"
	@[ "${CURRENT_TAG}" ] && docker push rg.fr-par.scw.cloud/le-portail/cagette/webapp:${CURRENT_TAG}

## Build, Tag, then Push image at ${tag} version
publish: build tag push

## Start, then log cagette stack locally
up:
	docker-compose up --detach
	docker-compose logs --follow webapp mailer

## Start, then log cagette stack locally, but force build first (without --no-cache option)
up-with-build:
	docker-compose up --build --detach
	docker-compose logs --follow webapp mailer

## Stop local cagette stack
down:
	docker-compose down --volumes

## Connect within webapp container with /bin/bash
enter:
	docker-compose exec --user root webapp bash

## clear images cached
cache-clear:
	docker-compose exec --user root --workdir /var/www/cagette/www webapp sh -c "rm -rf file/"

# ---------------------------------------------------------------------------- #

SQL_FILE := inject.sql

## Backups database in its development version
database-backup:
	docker-compose exec mysql sh -c "mysqldump --no-tablespaces -u docker -pdocker db > ${SQL_FILE}"
	docker cp $(shell docker-compose ps -q mysql):/${SQL_FILE} configuration/mysql/dumps/${SQL_FILE}

## Backups database from its development version
database-restore:
	docker cp configuration/mysql/scripts/${SQL_FILE} $(shell docker-compose ps -q mysql):/${SQL_FILE}
	docker-compose exec mysql sh -c "mysql -u docker -pdocker db < ${SQL_FILE}"

# ---------------------------------------------------------------------------- #

recompile-backend:
	docker-compose exec --user root --workdir /var/www/cagette/backend webapp  sh -c "haxe cagette.hxml"

recompile-frontend:
	docker-compose exec --user root --workdir /var/www/cagette/frontend webapp sh -c "haxe cagetteJs.hxml"

test-generic:
	docker-compose exec --user root --workdir /var/www/cagette/www webapp sh -c "neko index.n cron/test"

test-product-import:
	docker-compose exec --user root --workdir /var/www/cagette/www webapp sh -c "neko index.n product/debugimport"

## Install mkcert for self-signed certificates generation
certificates-install-mkcert:
	sudo apt install --yes libnss3-tools
	sudo wget -O /usr/local/bin/mkcert "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64" && chmod +x /usr/local/bin/mkcert
	mkcert -install

## Generate self-signed certificates
certificates-generate:
	mkcert -cert-file configuration/apache2/certificates/cert.pem -key-file configuration/apache2/certificates/key.pem alterconso.localhost
	chmod 0644 configuration/apache2/certificates/key.pem

## Colors
COLOR_RESET       = $(shell tput sgr0)
COLOR_ERROR       = $(shell tput setaf 1)
COLOR_COMMENT     = $(shell tput setaf 3)
COLOR_TITLE_BLOCK = $(shell tput setab 4)

## Display this help text
help:
	@printf "\n"
	@printf "${COLOR_TITLE_BLOCK}${PROJECT} Makefile${COLOR_RESET}\n"
	@printf "\n"
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make build\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-_0-9@]+:/ { \
				helpLine = match(lastLine, /^## (.*)/); \
				helpCommand = substr($$1, 0, index($$1, ":")); \
				helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
				printf " ${COLOR_INFO}%-29s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
		{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

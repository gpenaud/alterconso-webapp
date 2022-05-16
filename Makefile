## Build mailer image
build:
	@[ "${tag}" ] || ( echo "tag variable must be set"; exit 1 )
	docker build --tag cagette/webapp:${tag} .

## Tag mailer image
tag:
	@[ "${tag}" ] || ( echo "tag variable must be set"; exit 1 )
	docker tag cagette/webapp:${tag} rg.fr-par.scw.cloud/le-portail/cagette/webapp:${tag}

## Push mailer image to scaleway repository
push:
	@[ "${tag}" ] || ( echo "tag variable must be set"; exit 1 )
	docker push rg.fr-par.scw.cloud/le-portail/cagette/webapp:${tag}

## Build, Tag, then Push image at ${tag} version
publish: build tag push

## Start, then log cagette stack locally
up:
	source environment.txt && docker-compose up --build --detach
	docker-compose logs --follow cagette mailer

## Stop local cagette stack
down:
	docker-compose down --volumes

## Connect within webapp container with /bin/bash
enter:
	docker-compose exec cagette bash

## Backups database in its development version
database-backup:
	docker-compose exec mysql sh -c "mysqldump --no-tablespaces -u docker -pdocker db > development.sql"
	docker cp $(shell docker-compose ps -q mysql):/development.sql docker/mysql/dumps/development.sql

## Backups database from its development version
database-restore:
	docker cp docker/mysql/dumps/${DUMP} $(shell docker-compose ps -q mysql):/${DUMP}
	docker-compose exec mysql sh -c "mysql -u docker -pdocker db < ${DUMP}"

## Install mkcert for self-signed certificates generation
certificates-install-mkcert:
	sudo apt install --yes libnss3-tools
	sudo wget -O /usr/local/bin/mkcert "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64" && chmod +x /usr/local/bin/mkcert
	mkcert -install

## Generate self-signed certificates
certificates-generate:
	mkcert -cert-file docker/httpd/certificates/cert.pem -key-file docker/httpd/certificates/key.pem cagette.localhost
	chmod 0644 docker/httpd/certificates/key.pem

## special variables
SHELL := /bin/bash
.ONESHELL:

## Permanent variables
PROJECT			?= github.com/gpenaud/cagette
RELEASE			?= $(shell git describe --tags --abbrev=0)
COMMIT			?= $(shell git rev-parse --short HEAD)
BUILD_TIME  ?= $(shell date -u '+%Y-%m-%d_%H:%M:%S')

## Colors
COLOR_RESET       = $(shell tput sgr0)
COLOR_ERROR       = $(shell tput setaf 1)
COLOR_COMMENT     = $(shell tput setaf 3)
COLOR_TITLE_BLOCK = $(shell tput setab 4)

DUMP ?= development.sql

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

SHELL := /bin/bash
ONESHELL:

## permanent variables
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

## display this help text
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
				printf " ${COLOR_INFO}%-15s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
		{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

## start cagette stack locally
up:
	source environment.txt && docker-compose up --build --detach
	docker-compose logs --follow cagette mailer

## stop local cagette stack
down:
	docker-compose down --volumes

enter:
	docker-compose exec cagette bash

cagette-debug:
	docker-compose exec cagette sh -c "cd /var/www/cagette/www; neko index.n cron/debug"

database-backup:
	docker-compose exec mysql sh -c "mysqldump --no-tablespaces -u docker -pdocker db > development.sql"
	docker cp $(shell docker-compose ps -q mysql):/development.sql docker/mysql/dumps/development.sql

database-restore:
	docker cp docker/mysql/dumps/${DUMP} $(shell docker-compose ps -q mysql):/${DUMP}
	docker-compose exec mysql sh -c "mysql -u docker -pdocker db < ${DUMP}"

debug-backend-prepare:
	docker-compose exec cagette sh -c "npm install --global lix haxe-modular; cd backend && lix download"

debug-backend-refresh:
	docker-compose exec cagette sh -c "cd backend && haxe cagette.hxml"

debug-frontend-prepare:
	docker-compose exec cagette sh -c "npm install --global lix haxe-modular; cd frontend && lix download"

debug-frontend-refresh:
	docker-compose exec cagette sh -c "cd frontend && haxe cagetteJs.hxml"

## package and index helm chart
package-helm:
	helm package --destination helm/ helm/
	helm repo index helm/

install-mkcert:
	sudo apt install --yes libnss3-tools
	sudo wget -O /usr/local/bin/mkcert "https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64" && chmod +x /usr/local/bin/mkcert
	mkcert -install

generate-certificates:
	mkcert -cert-file docker/httpd/certificates/cert.pem -key-file docker/httpd/certificates/key.pem cagette.localhost
	chmod 0644 docker/httpd/certificates/key.pem

## permanent variables
PROJECT			?= github.com/gpenaud/poc-lxc-terraform
RELEASE			?= $(shell git describe --tags --abbrev=0)
COMMIT			?= $(shell git rev-parse --short HEAD)
BUILD_TIME  ?= $(shell date -u '+%Y-%m-%d_%H:%M:%S')

## Colors
COLOR_RESET       = $(shell tput sgr0)
COLOR_ERROR       = $(shell tput setaf 1)
COLOR_COMMENT     = $(shell tput setaf 3)
COLOR_TITLE_BLOCK = $(shell tput setab 4)

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

## init terraform modules
init:
	terraform -chdir=ops/terraform init

## install AWS infrastructure
install: apply

## plan high-level infrastructure
plan:
	terraform -chdir=ops/terraform plan

## destroy high-level infrastructure
uninstall:
	terraform -chdir=ops/terraform destroy -auto-approve -compact-warnings

## install docker on existing infrastructure
deploy:
	ansible-playbook -i "$(shell terraform -chdir=ops/terraform output -raw instance_ip)," ops/ansible/playbooks/development/main.yml

## upload the whole archive to AWS instance
upload:
	ansible-playbook -i "$(shell terraform -chdir=ops/terraform output -raw instance_ip)," ops/ansible/playbooks/development/upload.yml

## copy docker-compose.yml and Dockerfile on existing infrastructure
copy:
	ansible-playbook -i "$(shell terraform -chdir=ops/terraform output -raw instance_ip)," ops/ansible/playbooks/development/copy.yml

## ssh directly in AWS instance
ssh:
	ssh ubuntu@$(shell terraform -chdir=ops/terraform output -raw instance_ip)

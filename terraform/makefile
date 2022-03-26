SHELL=bash
.SHELLFLAGS=-ec -o pipefail

docker=docker
docker_compose=$(docker) compose
docker_compose_run=$(docker_compose) run --rm -T

terraform_init_args?=

.PHONY: all
all: ## do everything (default target)

.PHONY: validate
validate:
	terraform init $(terraform_init_args)
	terraform fmt -check -diff -recursive .
	terraform validate
	$(docker_compose_run) tflint .

.PHONY: validate-fix
validate-fix:
	terraform fmt -diff -recursive .

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

SHELL=bash
.SHELLFLAGS=-ec -o pipefail

docker=docker
docker_compose=$(docker) compose
docker_compose_run=$(docker_compose) run --rm -T

trivy_args?=

.PHONY: validate-security
validate-security: ## Validate security misconfigurations and vulnerabilities
	$(docker_compose_run) trivy fs $(trivy_args) .

.PHONY: lock-image-digests
lock-image-digests: ## Generate images digests
	$(docker_compose_run) docker-lock lock generate
	$(docker_compose_run) docker-lock lock rewrite

.PHONY: verify-image-digests
verify-image-digests: ## Verify images digests
	$(docker_compose_run) docker-lock lock verify

help: ## Print this text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

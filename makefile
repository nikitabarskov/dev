SHELL=bash
.SHELLFLAGS=-ec -o pipefail

docker=docker
docker_compose=$(docker) compose
docker_compose_run=$(docker_compose) run --rm -T

trivy_args?=

.PHONY: validate-security
validate-security:
	$(docker_compose_run) trivy config $(trivy_args) .

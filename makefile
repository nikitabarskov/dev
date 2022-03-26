SHELL=bash
.SHELLFLAGS=-ec -o pipefail

docker=docker
docker_compose=$(docker) compose
docker_compose_run=$(docker_compose) run --rm -T

trivy_args?=

.PHONY: validate-security
validate-security:
	$(docker_compose_run) trivy config $(trivy_args) .

.PHONY: lock-image-digests
lock-image-digests:
	$(docker_compose_run) docker-lock lock generate
	$(docker_compose_run) docker-lock lock rewrite

.PHONY: verify-image-digests
verify-image-digests:
	$(docker_compose_run) docker-lock lock verify

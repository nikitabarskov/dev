FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.74.1@sha256:768ca359e78845b35d51bd2b5ea0fd77376374044d5aaa8e9afe3dff951a7e4c as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:f9447046d79b15cc07dee763f4ac45880a899570dab0801fc9a9eb2efa52c091 as node

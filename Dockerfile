FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.69.1@sha256:27e9373f5d3dd65b8675723f868e43c14cd777b59c1fee47e60858c37c99f385 as syft
FROM docker.io/library/node:19.5.0-buster-slim@sha256:871673a1451a2d0a8b0e2a08d1d89a5f6f3b91d158eae8d4d3aa7f77bb7b5c3f as node

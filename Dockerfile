FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.58.0@sha256:01c0cacd38fe8982c92a877c6aa031231dfae442681253fbabbdc03b8c49ad0f as grype
FROM docker.io/anchore/syft:v0.69.1@sha256:27e9373f5d3dd65b8675723f868e43c14cd777b59c1fee47e60858c37c99f385 as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:f9447046d79b15cc07dee763f4ac45880a899570dab0801fc9a9eb2efa52c091 as node

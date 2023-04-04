FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.60.0@sha256:99ce84510337b79fcd502d217f36b547e71b6af23bfb69062f5c94ee602afd15 as grype
FROM docker.io/anchore/syft:v0.76.0@sha256:2e78580c1e866d9afbb899f9270b377714101d1d203bd2886f31a7c0ab78e6fa as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:f9447046d79b15cc07dee763f4ac45880a899570dab0801fc9a9eb2efa52c091 as node

FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.76.0@sha256:2e78580c1e866d9afbb899f9270b377714101d1d203bd2886f31a7c0ab78e6fa as syft
FROM docker.io/library/node:20.0.0-buster-slim@sha256:a61a572e76b668a300dd0683ed6e62d8cf7018e9f443231904fd7c6e4ce6ccce as node

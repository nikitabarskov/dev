FROM docker.io/aquasec/trivy:0.36.1@sha256:fcd4eddc8082be2d7c929cb07c989d62d2d50669513b8a0889116b40feab435f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.80.0@sha256:c53319814784f80de09b3f9504b87b6a4a24b7b1558a99d7713bf34c3174f384 as syft
FROM docker.io/library/node:20.1.0-buster-slim@sha256:34f21a675893db99e6225e3d31b83d2da48a0d95a9f379e257b7fa9ccc104299 as node

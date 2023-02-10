FROM docker.io/aquasec/trivy:0.37.2@sha256:3ecdcc400357a63bf1257f266467779e816a6a74053e1f7afd369af4b60282e8 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.69.1@sha256:27e9373f5d3dd65b8675723f868e43c14cd777b59c1fee47e60858c37c99f385 as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:f9447046d79b15cc07dee763f4ac45880a899570dab0801fc9a9eb2efa52c091 as node

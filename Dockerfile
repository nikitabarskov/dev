FROM docker.io/aquasec/trivy:0.35.0@sha256:9ff19e5b6cc17b5dd1e5e7ce46023d98ec03f80c4906024e7e23f5aad0606475 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.65.0@sha256:9ec6dba81feb02439f6ed80c0ea586351ee42185dea37c1a2ce4b5be1ab77181 as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:c24fe48ab350be9bd751546f26a15fff70d8d806444dbd49c89d410c10bf85fa as node

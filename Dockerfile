FROM docker.io/aquasec/trivy:0.48.3@sha256:e587c4e3cd7c2b6fb6cc44caffa6ef35ac1f2043ed2eb969b53a97b0cc7c7129 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.90.0@sha256:69d84e41b7efd62c0fa6978e01cde25464fa41bdad36068e1a53046e8c590588 as syft
FROM docker.io/library/node:20.7.0-buster-slim@sha256:7335a8fbad9037dcdd1cc7f9581aa71fe2914c6921c88cf759556885231c3e91 as node

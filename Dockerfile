FROM docker.io/aquasec/trivy:0.44.1@sha256:8e1831ca426f152477857e10f02a9e1373aaf7f87966214aba92cdcf431367e1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.72.0@sha256:630f21d880b0d0094054bf8c1d1a4c7ceecb1b10d23fc9e2ae85d51494b3a572 as grype
FROM docker.io/anchore/syft:v0.90.0@sha256:69d84e41b7efd62c0fa6978e01cde25464fa41bdad36068e1a53046e8c590588 as syft
FROM docker.io/library/node:20.7.0-buster-slim@sha256:7335a8fbad9037dcdd1cc7f9581aa71fe2914c6921c88cf759556885231c3e91 as node

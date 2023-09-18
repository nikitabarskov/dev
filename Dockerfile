FROM docker.io/aquasec/trivy:0.44.1@sha256:8e1831ca426f152477857e10f02a9e1373aaf7f87966214aba92cdcf431367e1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.68.1@sha256:79a0f2b90eb2da45c077bf4fe83885fd062c0f566c7c76d73ed7f50d56b45bdb as grype
FROM docker.io/anchore/syft:v0.86.1@sha256:f2794d19ace079ec97defa96c4b75bdb7544ac96bf146497a7620aafa48603c6 as syft
FROM docker.io/library/node:20.5.1-buster-slim@sha256:da50d2b32237e613ea2c8e84b875fc7dd32e99e4fe92edf23849fb7674ee0152 as node

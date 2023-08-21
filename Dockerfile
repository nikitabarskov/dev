FROM docker.io/aquasec/trivy:0.44.1@sha256:8e1831ca426f152477857e10f02a9e1373aaf7f87966214aba92cdcf431367e1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.86.1@sha256:f2794d19ace079ec97defa96c4b75bdb7544ac96bf146497a7620aafa48603c6 as syft
FROM docker.io/library/node:20.5.1-buster-slim@sha256:0a813cfd8330270922f4c027de285427d74906b523227a85a031436e78342909 as node

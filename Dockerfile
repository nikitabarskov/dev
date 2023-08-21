FROM docker.io/aquasec/trivy:0.44.1@sha256:8e1831ca426f152477857e10f02a9e1373aaf7f87966214aba92cdcf431367e1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.87.1@sha256:52ab5880130ed6d4c522cc9b15aee74a0115c5614e1cef2cd4c855dd493c65ae as syft
FROM docker.io/library/node:20.5.1-buster-slim@sha256:da50d2b32237e613ea2c8e84b875fc7dd32e99e4fe92edf23849fb7674ee0152 as node

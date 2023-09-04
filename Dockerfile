FROM docker.io/aquasec/trivy:0.45.0@sha256:75e9057efeece9914e6fe527b4a35e30258d050909f80ba633c3935923f4347e as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.86.1@sha256:f2794d19ace079ec97defa96c4b75bdb7544ac96bf146497a7620aafa48603c6 as syft
FROM docker.io/library/node:20.5.1-buster-slim@sha256:da50d2b32237e613ea2c8e84b875fc7dd32e99e4fe92edf23849fb7674ee0152 as node

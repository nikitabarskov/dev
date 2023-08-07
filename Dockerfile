FROM docker.io/aquasec/trivy:0.44.0@sha256:a302712ce9c6fdc703e01da58a60ff007f1c2ff12d2946e18d7b5e96529bbfcf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.86.1@sha256:f2794d19ace079ec97defa96c4b75bdb7544ac96bf146497a7620aafa48603c6 as syft
FROM docker.io/library/node:20.5.0-buster-slim@sha256:256d2a685d5c474d2d0731c77088f372376b7117ef24d68c09aaefab16c50b47 as node

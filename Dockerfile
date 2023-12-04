FROM docker.io/aquasec/trivy:0.44.1@sha256:8e1831ca426f152477857e10f02a9e1373aaf7f87966214aba92cdcf431367e1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.65.1@sha256:cc1ca15456918632961f930dd7a91fe24768a967f4e6ef24704ac681fcf10c10 as grype
FROM docker.io/anchore/syft:v0.98.0@sha256:b353bf516310fcbc86676bb20849929298034e80f15873e63da18acdf7080b4e as syft
FROM docker.io/library/node:20.7.0-buster-slim@sha256:7335a8fbad9037dcdd1cc7f9581aa71fe2914c6921c88cf759556885231c3e91 as node

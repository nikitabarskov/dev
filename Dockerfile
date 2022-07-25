FROM docker.io/aquasec/trivy:0.30.2@sha256:c1f77715f816281bab18e8e1226946cb007a1755e7ba1b9098eaee84e1c765eb as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.43.0@sha256:1f0ba3ad5098743723ff6a2877cb880d0b3ec0511dbef0a6f30158a617f56e61 as grype
FROM docker.io/anchore/syft:v0.51.0@sha256:833a9a25934898999419d5535e55ece68c148fca9bb8ab7d695a44d688618a24 as syft
FROM docker.io/library/node:18.6.0-buster-slim@sha256:45d62ee60e3547014ba7902b210f1e2a4025d455c53958cb7a715702e3e56afd as node

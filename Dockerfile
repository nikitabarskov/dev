FROM docker.io/aquasec/trivy:0.30.3@sha256:28aa2d7633fd0754fc82cc8a353928043d6eebdea451d4401f51b7cb3e9f34c1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.49.0@sha256:24b5c40d16a635326fb5d5e7260e7f30b1b3ef59030bf6c7510e664e97f02bd3 as grype
FROM docker.io/anchore/syft:v0.52.0@sha256:3f8085b0bbd5768cecbbda359a6f4353c658082a820e394f9983ed764ec98109 as syft
FROM docker.io/library/node:18.6.0-buster-slim@sha256:45d62ee60e3547014ba7902b210f1e2a4025d455c53958cb7a715702e3e56afd as node

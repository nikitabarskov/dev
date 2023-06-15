FROM docker.io/aquasec/trivy:0.42.1@sha256:49a0b08589b7577f3e21a7d479284c69dc4d27cbb86bd07ad36773f075581313 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.3@sha256:3bd0e02814d15734ad360ea3619807714feff950a1da221758d91bf224e62cc1 as grype
FROM docker.io/anchore/syft:v0.83.1@sha256:0f98d58b87b3bf5c4676c0d6481f9430f240ec19d39d6127e3d8a081408fe376 as syft
FROM docker.io/library/node:20.3.0-buster-slim@sha256:9f4d4a6ebe2aa2068f53347e17e37995f0b2b5f372094354d6f8a155fdd3a5e6 as node

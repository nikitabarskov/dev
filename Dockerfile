FROM docker.io/aquasec/trivy:0.42.1@sha256:49a0b08589b7577f3e21a7d479284c69dc4d27cbb86bd07ad36773f075581313 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.3@sha256:3bd0e02814d15734ad360ea3619807714feff950a1da221758d91bf224e62cc1 as grype
FROM docker.io/anchore/syft:v0.83.0@sha256:69fcf21cdd4c577d6949dca4d28549d19724b244dfb539509544be166b53ead3 as syft
FROM docker.io/library/node:20.3.0-buster-slim@sha256:639255a720a094e77e463a1ef405546338c0a3e47d971b94929a2d2015dc37f3 as node

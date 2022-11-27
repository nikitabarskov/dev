FROM docker.io/aquasec/trivy:0.34.0@sha256:a5544f44ca957135921410f4d3fa340d42b6ab56bbb6bf7406d783df9e84f95f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.53.1@sha256:459cde4f00bc6dddceba040cd9f3d1ff3f09bd025912bab4a7d1590bf049e164 as grype
FROM docker.io/anchore/syft:v0.62.1@sha256:5ff167f9f3c840fb619921b1bdd4b93973a58f72a61ba9934ac01d76a31d48e0 as syft
FROM docker.io/library/node:19.1.0-buster-slim@sha256:1cb6af2c286dc3c6eb8973b116853729d0d4d5130a845efc03ac18920772ecfe as node

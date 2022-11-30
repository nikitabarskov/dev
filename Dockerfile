FROM docker.io/aquasec/trivy:0.34.0@sha256:a5544f44ca957135921410f4d3fa340d42b6ab56bbb6bf7406d783df9e84f95f as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.53.1@sha256:459cde4f00bc6dddceba040cd9f3d1ff3f09bd025912bab4a7d1590bf049e164 as grype
FROM docker.io/anchore/syft:v0.62.2@sha256:8f818bde569b708291a4172ac962fffadfbb8a4fce2ac4073f5b343fb2c85568 as syft
FROM docker.io/library/node:19.2.0-buster-slim@sha256:4108042226221e609bebab7217957281498e23e02782b6a9a784652bf77c13f5 as node

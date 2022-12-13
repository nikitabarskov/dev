FROM docker.io/aquasec/trivy:0.35.0@sha256:9ff19e5b6cc17b5dd1e5e7ce46023d98ec03f80c4906024e7e23f5aad0606475 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.53.1@sha256:459cde4f00bc6dddceba040cd9f3d1ff3f09bd025912bab4a7d1590bf049e164 as grype
FROM docker.io/anchore/syft:v0.62.3@sha256:fa62c5f7f74880fc859e1472b804624b8226f3cb6f87ce024fb4040ad5f1bb1b as syft
FROM docker.io/library/node:19.2.0-buster-slim@sha256:6dad9cf9e88b32683fd77dadd4019fe67db2bf33e5327b3ce62bca7cef3da2d5 as node

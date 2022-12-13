FROM docker.io/aquasec/trivy:0.35.0@sha256:9ff19e5b6cc17b5dd1e5e7ce46023d98ec03f80c4906024e7e23f5aad0606475 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.53.1@sha256:459cde4f00bc6dddceba040cd9f3d1ff3f09bd025912bab4a7d1590bf049e164 as grype
FROM docker.io/anchore/syft:v0.63.0@sha256:2d1fe42abf014cfed92015b1255b1ad41702ac7939571a6935d8979306932406 as syft
FROM docker.io/library/node:19.2.0-buster-slim@sha256:6dad9cf9e88b32683fd77dadd4019fe67db2bf33e5327b3ce62bca7cef3da2d5 as node

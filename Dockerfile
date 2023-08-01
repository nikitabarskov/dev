FROM docker.io/aquasec/trivy:0.44.0@sha256:a302712ce9c6fdc703e01da58a60ff007f1c2ff12d2946e18d7b5e96529bbfcf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.64.1@sha256:817cd94d43652f9a76d96ce0bc4e37303b1331a8c9dc29886b68aa35714336d8 as grype
FROM docker.io/anchore/syft:v0.85.0@sha256:dd40bc09ff2bf3b860c399e7cf5c2db088e84c85937ac05fdeca3cd88fe2a728 as syft
FROM docker.io/library/node:20.5.0-buster-slim@sha256:5ed5abcffd0051b3f6a5db12190e297f3d4bfd7f76e10c40631ee24ae7d4c139 as node

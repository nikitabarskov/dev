FROM docker.io/aquasec/trivy:0.43.1@sha256:944a044451791617cc0ed2ee4d1942a4f66b790d527fcd0575a6b399ccbc05a1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.64.1@sha256:817cd94d43652f9a76d96ce0bc4e37303b1331a8c9dc29886b68aa35714336d8 as grype
FROM docker.io/anchore/syft:v0.85.0@sha256:dd40bc09ff2bf3b860c399e7cf5c2db088e84c85937ac05fdeca3cd88fe2a728 as syft
FROM docker.io/library/node:20.4.0-buster-slim@sha256:b7318db81ab681021d98276902fd6c8feb5a575660f88ec105c735180e25635e as node

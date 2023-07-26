FROM docker.io/aquasec/trivy:0.43.1@sha256:944a044451791617cc0ed2ee4d1942a4f66b790d527fcd0575a6b399ccbc05a1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.64.2@sha256:06d97d03bded18b392e08177a84f3436376d18b6c22fd8fde45c2f38f04fd6ed as grype
FROM docker.io/anchore/syft:v0.85.0@sha256:dd40bc09ff2bf3b860c399e7cf5c2db088e84c85937ac05fdeca3cd88fe2a728 as syft
FROM docker.io/library/node:20.5.0-buster-slim@sha256:5ed5abcffd0051b3f6a5db12190e297f3d4bfd7f76e10c40631ee24ae7d4c139 as node

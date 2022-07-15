FROM docker.io/aquasec/trivy:0.30.0@sha256:754edb50cdad04c2b60f105b7266c5fe0c360f682cb2b135d68a3434dce52783 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.42.0@sha256:ceb824abc494dde2fbf5efeb7acc8f73f5d00bc5a6c1edc62f26892366e59920 as grype
FROM docker.io/anchore/syft:v0.51.0@sha256:833a9a25934898999419d5535e55ece68c148fca9bb8ab7d695a44d688618a24 as syft

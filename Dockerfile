FROM docker.io/aquasec/trivy:0.41.0@sha256:d1796f197930d89590b1cbfbbda9f80ae6e878a1cb77dc652b198dba5c17dcdf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.0@sha256:2c1d7b66d4965ae2d80bc9349b17dd21e0bf4cf188100ac1025f4bbeea13e5bb as grype
FROM docker.io/anchore/syft:v0.80.0@sha256:c53319814784f80de09b3f9504b87b6a4a24b7b1558a99d7713bf34c3174f384 as syft
FROM docker.io/library/node:20.2.0-buster-slim@sha256:78a766ab4c6d15a1abd4c13d5220374609b227c18b70ae303cef42111ff09283 as node

FROM docker.io/aquasec/trivy:0.40.0@sha256:de367bfafb18b42df66a85ba896378aecf0c9cf227b10488e66a294d109234a6 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.76.0@sha256:2e78580c1e866d9afbb899f9270b377714101d1d203bd2886f31a7c0ab78e6fa as syft
FROM docker.io/library/node:19.4.0-buster-slim@sha256:f9447046d79b15cc07dee763f4ac45880a899570dab0801fc9a9eb2efa52c091 as node

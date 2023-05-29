FROM docker.io/aquasec/trivy:0.41.0@sha256:d1796f197930d89590b1cbfbbda9f80ae6e878a1cb77dc652b198dba5c17dcdf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.2@sha256:41ff6c197f9174757014eba135e606f296f1003ae6cad36d4df5396b4111696f as grype
FROM docker.io/anchore/syft:v0.82.0@sha256:d20096d5c42a8f023499a9bba80a93994609f0d5af123dfe6ff15db1c8921652 as syft
FROM docker.io/library/node:20.2.0-buster-slim@sha256:f2641d974ac635f33e3c2f9c4bc34c125886cd923650341b354efb43976d98c5 as node

FROM docker.io/aquasec/trivy:0.41.0@sha256:d1796f197930d89590b1cbfbbda9f80ae6e878a1cb77dc652b198dba5c17dcdf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.61.1@sha256:9d326e7fc0e4914481a2b0c458a0eb0891b04d00569a6f92bdc549507f2089a0 as grype
FROM docker.io/anchore/syft:v0.80.0@sha256:c53319814784f80de09b3f9504b87b6a4a24b7b1558a99d7713bf34c3174f384 as syft
FROM docker.io/library/node:20.2.0-buster-slim@sha256:f2641d974ac635f33e3c2f9c4bc34c125886cd923650341b354efb43976d98c5 as node

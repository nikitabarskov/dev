FROM docker.io/aquasec/trivy:0.41.0@sha256:d1796f197930d89590b1cbfbbda9f80ae6e878a1cb77dc652b198dba5c17dcdf as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.1@sha256:68ee7d7e962b0dcb2faac9af893d16e465e0238aec72e7fd14d7df17dc8fe9af as grype
FROM docker.io/anchore/syft:v0.81.0@sha256:77a93d5403247750930a2883b180e1a8b6805483fc72af7d49a2c48c8f26d202 as syft
FROM docker.io/library/node:20.2.0-buster-slim@sha256:f2641d974ac635f33e3c2f9c4bc34c125886cd923650341b354efb43976d98c5 as node

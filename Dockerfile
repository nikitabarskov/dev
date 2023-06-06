FROM docker.io/aquasec/trivy:0.42.0@sha256:b75725d2c11ff54a5fe23f6e8b9a8c6177b8bf5221f08697cf0eed43442b1bfa as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.62.2@sha256:41ff6c197f9174757014eba135e606f296f1003ae6cad36d4df5396b4111696f as grype
FROM docker.io/anchore/syft:v0.83.0@sha256:69fcf21cdd4c577d6949dca4d28549d19724b244dfb539509544be166b53ead3 as syft
FROM docker.io/library/node:20.2.0-buster-slim@sha256:f2641d974ac635f33e3c2f9c4bc34c125886cd923650341b354efb43976d98c5 as node

FROM docker.io/aquasec/trivy:0.35.0@sha256:9ff19e5b6cc17b5dd1e5e7ce46023d98ec03f80c4906024e7e23f5aad0606475 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.54.0@sha256:54b90e986877546e6efca39c11ea32c8efc0b808b8d8f35f97db1a4536aed558 as grype
FROM docker.io/anchore/syft:v0.64.0@sha256:b65156161cbffed1376e23dc8aa3de6541499ae4eb2e2d29eb24cd1288ce298b as syft
FROM docker.io/library/node:19.3.0-buster-slim@sha256:0c1598fe3766d576c21d6d28978e6e782a2df07bf9089ae5ff6ee73e6f885a98 as node

FROM docker.io/aquasec/trivy:0.35.0@sha256:9ff19e5b6cc17b5dd1e5e7ce46023d98ec03f80c4906024e7e23f5aad0606475 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.55.0@sha256:663a068a4b4f194b9fc42f5412b48afa47dae3c2e9573d011b72dcd2dae0477a as grype
FROM docker.io/anchore/syft:v0.62.3@sha256:fa62c5f7f74880fc859e1472b804624b8226f3cb6f87ce024fb4040ad5f1bb1b as syft
FROM docker.io/library/node:19.3.0-buster-slim@sha256:0c1598fe3766d576c21d6d28978e6e782a2df07bf9089ae5ff6ee73e6f885a98 as node

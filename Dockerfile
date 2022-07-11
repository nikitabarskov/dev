FROM docker.io/aquasec/trivy:0.29.2@sha256:8c2e83606e7687708f4c9638c6ea7f8578b169ca79bb74012ce3da856dda09db as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.41.0@sha256:b10141434e4b0490efb9b840d292ace03b2d86f84cebdd89e4c237f0e530d2bc as grype
FROM docker.io/anchore/syft:v0.50.0@sha256:5184b9ef92522f3e187d81b2a2c745e85b257bab46ff3f90c4c2f30814d1d420 as syft

FROM docker.io/aquasec/trivy:0.49.1@sha256:91494b87ddc64f62860d52997532643956c24eeee0d0dda317d563c28c8581bc as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.74.6@sha256:369cb95271beb3fab6a9f99490210a60f3c998c928d921c97379bf5b753c8c50 as grype
FROM docker.io/anchore/syft:v1.0.1@sha256:d49defada853900861d55491ba549ab334148d51b11f23942abecb39ea83d4db as syft
FROM docker.io/library/node:20.11.1-buster-slim@sha256:cb17b5868d11ec6f2ecf30ce43330ca3e4c7fe1b20955af4de9d8f7d81a87b0a as node

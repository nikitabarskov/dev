FROM docker.io/aquasec/trivy:0.49.1@sha256:91494b87ddc64f62860d52997532643956c24eeee0d0dda317d563c28c8581bc as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.74.7@sha256:5468ba7a3deb00b9f39e86101daaa99e02edec28ee789c31ada37837147e545e as grype
FROM docker.io/anchore/syft:v0.105.0@sha256:e3dbedff17aaec7d06c6509fa42c6454ee2ed346299606fce6589096dc9efd70 as syft
FROM docker.io/library/node:20.11.1-buster-slim@sha256:cb17b5868d11ec6f2ecf30ce43330ca3e4c7fe1b20955af4de9d8f7d81a87b0a as node

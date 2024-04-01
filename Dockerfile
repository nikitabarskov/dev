FROM docker.io/aquasec/trivy:0.49.1@sha256:91494b87ddc64f62860d52997532643956c24eeee0d0dda317d563c28c8581bc as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.74.6@sha256:369cb95271beb3fab6a9f99490210a60f3c998c928d921c97379bf5b753c8c50 as grype
FROM docker.io/anchore/syft:v0.105.0@sha256:e3dbedff17aaec7d06c6509fa42c6454ee2ed346299606fce6589096dc9efd70 as syft
FROM docker.io/library/node:20.12.0-buster-slim@sha256:97305db8aca5eaf34a4e6940474bc76b4eb822e402a35fdd2fd4c3e72e4e7eea as node

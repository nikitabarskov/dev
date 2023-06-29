FROM docker.io/aquasec/trivy:0.42.1@sha256:49a0b08589b7577f3e21a7d479284c69dc4d27cbb86bd07ad36773f075581313 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.63.0@sha256:ed7f056fb0ff7e8cc44572cff45c8c64f08968b9efb4b40a8c321817dbb577f9 as grype
FROM docker.io/anchore/syft:v0.84.0@sha256:bd5ef3acf08b5be457905430f8fcda530d907bb173bf086e4749acb41077acb1 as syft
FROM docker.io/library/node:20.3.1-buster-slim@sha256:649fa9ac54050c1df95e0bd0fee6f4c89816463ad4eaeb08721be1b9de9b2a6d as node

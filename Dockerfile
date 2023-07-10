FROM docker.io/aquasec/trivy:0.43.1@sha256:944a044451791617cc0ed2ee4d1942a4f66b790d527fcd0575a6b399ccbc05a1 as trivy
FROM docker.io/safewaters/docker-lock:0.8.10-alpine@sha256:e4563cc6ecb6b6f290d9ebfe3745a49b300d2d3edd495b61a85bc7e079175e4e as docker-lock
FROM docker.io/anchore/grype:v0.63.1@sha256:625264635ab1864f2c95eddfc1d3d8c9f46e012adedb6e5c935dee1e4d921b55 as grype
FROM docker.io/anchore/syft:v0.84.1@sha256:1b1d190a2cc0f761861380f603f7b3489aa0aba01dc856dc9f7fae9e3673761c as syft
FROM docker.io/library/node:20.3.1-buster-slim@sha256:ab11ebed5e12a423963a3ea11e365fc24498354b78301bedfaef4e214fa88587 as node

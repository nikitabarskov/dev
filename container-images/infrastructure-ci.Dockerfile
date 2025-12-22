FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:e752109625c62399de8ca55bdba9089d20523b0236dad2ec45b59d15aff072ad AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:399b579c34b7e9ecdfd7295eaac93b9790fc027d302056913490039d35e9eef3 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

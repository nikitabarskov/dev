FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:78a977a79c55e3e0bdccedf2508c278bd43bd8692cecadad2978292827138bc6 AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:399b579c34b7e9ecdfd7295eaac93b9790fc027d302056913490039d35e9eef3 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

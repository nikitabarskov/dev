FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:5c7b901f1415bf18f3bc431bfd6e6f059b2c3504416e6c5dce2c7d30dee2fbdf AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:399b579c34b7e9ecdfd7295eaac93b9790fc027d302056913490039d35e9eef3 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

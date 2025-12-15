FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:ba4f94ceb39458052541b20b83ddf84f59592f8682c2f3e5a33ae16799970477 AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:399b579c34b7e9ecdfd7295eaac93b9790fc027d302056913490039d35e9eef3 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

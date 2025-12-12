FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:ba4f94ceb39458052541b20b83ddf84f59592f8682c2f3e5a33ae16799970477 AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:233c9c2093bafdfda961fedcd4de6bcb0622c105501d05397bfc1a5ff2308f13 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

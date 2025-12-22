FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:83f41908021dc5aee751d71903f007f8ddffecbad6a9d1ca25deb9cc2b035f01 AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:097e1f876a727f35b1d7ea7d05dada2cd2504e0a57177b7c55561ba7ecee1c43 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

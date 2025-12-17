FROM ghcr.io/nikitabarskov/base-ci:latest@sha256:83f41908021dc5aee751d71903f007f8ddffecbad6a9d1ca25deb9cc2b035f01 AS base-ci
FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:399b579c34b7e9ecdfd7295eaac93b9790fc027d302056913490039d35e9eef3 AS opentofu

FROM base-ci AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

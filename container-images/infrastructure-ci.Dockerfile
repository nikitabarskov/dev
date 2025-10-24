FROM ghcr.io/opentofu/opentofu:1-minimal AS opentofu
FROM docker.io/library/alpine:3 AS alpine

FROM alpine AS just

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
    apk add --no-cache just git

FROM just AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

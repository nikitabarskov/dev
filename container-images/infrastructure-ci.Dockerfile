FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:e8b80de6a840eb0e19d82aecbdaa2e2718cb107d15dbe849e6b550955aceacd2 AS opentofu
FROM docker.io/library/fedora:43@sha256:6cd815d862109208adf6040ea13391fe6aeb87a9dc80735c2ab07083fdf5e03a AS fedora

FROM fedora AS build

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf install -y \
    --setopt=install_weak_deps=False \
    --nodocs \
    just \
    git \
    tar

FROM build AS main

WORKDIR /workspace

COPY --from=opentofu --link /usr/local/bin/tofu /usr/local/bin/tofu

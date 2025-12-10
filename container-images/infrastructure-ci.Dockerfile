FROM ghcr.io/opentofu/opentofu:1-minimal@sha256:233c9c2093bafdfda961fedcd4de6bcb0622c105501d05397bfc1a5ff2308f13 AS opentofu
FROM docker.io/library/fedora:42@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522 AS fedora

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

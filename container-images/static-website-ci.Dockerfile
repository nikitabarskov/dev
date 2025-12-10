FROM docker.io/library/fedora:42@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522 AS fedora
FROM ghcr.io/gohugoio/hugo:v0.152.2@sha256:d2952bdcfa3b0b25ca3d2104394c2883ffa86abb88855515f01b23b5e8f1355b AS hugo
FROM index.docker.io/rclone/rclone@sha256:02b53fd7695153844b18fc5afa270fceb3c29a88e85b5c9be6b130ec5c698b2a AS rclone

FROM fedora AS build

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf install -y \
    --setopt=install_weak_deps=False \
    --nodocs \
    just \
    git \
    tar \
    hugo \
    go

FROM build AS main

WORKDIR /workspace

COPY --from=rclone --link /usr/local/bin/rclone /usr/local/bin/rclone

RUN hugo version && \
    rclone version

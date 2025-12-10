FROM docker.io/library/fedora:43@sha256:6cd815d862109208adf6040ea13391fe6aeb87a9dc80735c2ab07083fdf5e03a AS fedora
FROM index.docker.io/rclone/rclone@sha256:02b53fd7695153844b18fc5afa270fceb3c29a88e85b5c9be6b130ec5c698b2a AS rclone

FROM fedora AS build

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf copr enable -y @go-sig/golang-rawhide && \
    dnf install -y \
    --setopt=install_weak_deps=False \
    --nodocs \
    just \
    git \
    tar \
    hugo \
    golang \
    nodejs

FROM build AS main

WORKDIR /workspace

COPY --from=rclone --link /usr/local/bin/rclone /usr/local/bin/rclone

RUN hugo version && \
    rclone version && \
    go version

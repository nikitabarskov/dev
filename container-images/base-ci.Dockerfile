FROM docker.io/library/fedora:42@sha256:aa7befe5cfd1f0e062728c16453cd1c479d4134c7b85eac00172f3025ab0d522 AS fedora

FROM fedora AS main

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf copr enable -y jdxcode/mise && \
    dnf install -y \
    --setopt=install_weak_deps=False \
    --nodocs \
    git \
    tar \
    mise

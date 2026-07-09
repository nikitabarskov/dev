FROM docker.io/library/fedora:44@sha256:498c452f32a739b61f0ef215bce9924ebc4866cbe44710f58157d77723b7a6d2 AS main

LABEL org.opencontainers.image.title="base-ci" \
      org.opencontainers.image.description="Base CI image with mise on Fedora" \
      org.opencontainers.image.maintainer="Nikita Barskov <nbarskov@gmail.com>" \
      org.opencontainers.image.source="https://github.com/nikitabarskov/container-images"

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf copr enable -y jdxcode/mise && \
    dnf install -y \
    --setopt=install_weak_deps=False \
    --nodocs \
    git \
    tar \
    mise \
    libatomic && \
    dnf clean all && \
    useradd --create-home --shell /bin/bash ci && \
    mise --version

USER ci

FROM docker.io/library/ubuntu:22.04@sha256:4b1d0c4a2d2aaf63b37111f34eb9fa89fa1bf53dd6e4ca954d47caebca4005c2 as ubuntu
FROM ghcr.io/terraform-linters/tflint:v0.43.0@sha256:b1390a0d414ca59f93eaa53ecd0461118d191df4e3f89c3b3ee1be5a385498d8 as tflint


FROM ubuntu as tfswitch

RUN apt update && \
    apt install --yes --no-install-recommends \
    curl \
    jq \
    ca-certificates

WORKDIR /srv/src

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV terraform_switcher_version "0.13.1288"

COPY terraform-switcher_${terraform_switcher_version}_checksums.txt terraform-switcher_${terraform_switcher_version}_checksums.txt

RUN OS=$(uname -s) && \
    ARCH=$(uname -m) &&  \
    curl  --location --remote-name  "https://github.com/warrensbox/terraform-switcher/releases/download/${terraform_switcher_version}/terraform-switcher_${terraform_switcher_version}_linux_amd64.tar.gz" && \
    sed -i "/_linux_amd64.tar.gz/!d" "terraform-switcher_${terraform_switcher_version}_checksums.txt" && \
    sha256sum -c "terraform-switcher_${terraform_switcher_version}_checksums.txt" && \
    tar -xvf "terraform-switcher_${terraform_switcher_version}_linux_amd64.tar.gz" -C /usr/local/bin tfswitch && \
    rm -rf "terraform-switcher_${terraform_switcher_version}_linux_amd64.tar.gz"

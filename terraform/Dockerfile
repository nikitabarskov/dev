FROM docker.io/library/ubuntu:22.04@sha256:b6b83d3c331794420340093eb706a6f152d9c1fa51b262d9bf34594887c2c7ac as ubuntu
FROM ghcr.io/terraform-linters/tflint:v0.38.1@sha256:56672d76a007c0250cf9f29805d3c8914a9c228bc77352f7af314a3e6fd5aa02 as tflint


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

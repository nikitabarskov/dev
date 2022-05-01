FROM docker.io/library/ubuntu:focal@sha256:47f14534bda344d9fe6ffd6effb95eefe579f4be0d508b7445cf77f61a0e5724 as ubuntu
RUN apt update && apt install --yes --no-install-recommends curl jq ca-certificates

FROM ubuntu as tfswitch

WORKDIR /srv/src

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=secret,id=github_oauth_token \
    GITHUB_OAUTH_TOKEN=$(cat /run/secrets/github_oauth_token) \
    ASSETS=$(curl -H "Accept: application/vnd.github.v3+json" -u "${GITHUB_OAUTH_TOKEN}:x-oauth-basic" "https://api.github.com/repos/warrensbox/terraform-switcher/releases/latest" | jq --raw-output ".assets[]") && \
    TERRAFORM_SWITCHER_FILE_NAME=$(echo "${ASSETS}" | jq --raw-output "select(.name | contains(\"linux_amd64\")) | .name") && \
    TERRAFORM_SWITCHER_URL=$(echo "${ASSETS}" | jq --raw-output "select(.name | contains(\"linux_amd64\")) | .browser_download_url") && \
    TERRAFORM_SWITCHER_CHECKSUMS_FILE_NAME=$(echo "${ASSETS}" | jq --raw-output "select(.name | contains(\"checksums\")) | .name") && \
    TERRAFORM_SWITCHER_CHECKSUMS_URL=$(echo "${ASSETS}" | jq --raw-output "select(.name | contains(\"checksums\")) | .browser_download_url") && \
    curl -LO "${TERRAFORM_SWITCHER_URL}" && \
    curl -LO "${TERRAFORM_SWITCHER_CHECKSUMS_URL}" && \
    sed -i "/${TERRAFORM_SWITCHER_FILE_NAME}/!d" "${TERRAFORM_SWITCHER_CHECKSUMS_FILE_NAME}" && \
    sha256sum -c "${TERRAFORM_SWITCHER_CHECKSUMS_FILE_NAME}" && \
    tar -xvf "${TERRAFORM_SWITCHER_FILE_NAME}" -C /usr/local/bin tfswitch && \
    rm -rf "${TERRAFORM_SWITCHER_FILE_NAME}" "${TERRAFORM_SWITCHER_CHECKSUMS_FILE_NAME}"

FROM ubuntu as terraform

RUN addgroup -g 1001 -S terraform
RUN adduser -S terraform -u 1001

COPY --from=tfswitch --chown=terraform:terraform /usr/local/bin/tfswitch /usr/local/bin/tfswitch

USER terraform

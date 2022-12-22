FROM docker.io/library/node:18.12.1-slim@sha256:70bf84739156657c85440e6a55a3d77a7cac668f9c4c3c44005bc29bdc529db7 as node

ENV NEXT_TELEMETRY_DISABLED 1

FROM node as devtools

ENV TASK_VERSION="3.19.0"

RUN apt-get update && \
    apt-get install --no-install-recommends --yes ca-certificates curl tar

RUN curl -fsSL https://github.com/go-task/task/releases/download/v${TASK_VERSION}/task_linux_amd64.tar.gz | tar -xz -C /usr/local/bin task && chmod +x /usr/local/bin/task

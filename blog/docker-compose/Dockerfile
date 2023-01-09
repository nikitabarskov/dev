FROM docker.io/library/ubuntu:22.04@sha256:27cb6e6ccef575a4698b66f5de06c7ecd61589132d5a91d098f7f3f9285415a9 as ubuntu
FROM docker.io/library/node:18.12.1-slim@sha256:70bf84739156657c85440e6a55a3d77a7cac668f9c4c3c44005bc29bdc529db7 as node

FROM ubuntu as tools

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
    ca-certificates \
    curl \
    tar \
    busybox

FROM tools as task

ENV TASK_VERSION="3.19.0"

RUN curl -fsSL https://github.com/go-task/task/releases/download/v${TASK_VERSION}/task_linux_amd64.tar.gz | \
    tar -xz -C /tmp task
    
FROM tools as fonts

ENV INTER_VERSION="3.19"

RUN mkdir -p /tmp/inter & \
    curl -fsSL https://github.com/rsms/inter/releases/download/v${INTER_VERSION}/Inter-${INTER_VERSION}.zip | \
    busybox unzip -q -d /tmp - && \
    find /tmp -name "*.ttf" -exec cp "{}" /tmp/inter \; && \
    find /tmp -name "*.otf" -exec cp "{}" /tmp/inter \;

FROM tools as pandoc

ENV PANDOC_VERSION="2.19.2"

RUN curl -fsSL https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz | \
    tar -xz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION} /tmp/pandoc

ENV NEXT_TELEMETRY_DISABLED 1

FROM node as devtools

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
    fontconfig

COPY --from=task /tmp/task /usr/local/bin
RUN chmod +x /usr/local/bin/task

COPY --from=pandoc /tmp/pandoc /usr/local/bin
RUN chmod +x /usr/local/bin/pandoc

RUN mkdir -p /root/.local/share/fonts

COPY --from=fonts /tmp/inter /root/.local/share/fonts

RUN fc-cache -f -v

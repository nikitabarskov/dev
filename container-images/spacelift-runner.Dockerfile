FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:eb9d8a0127d22c88ba82353d6aa0ffa12ee1c4d7e7b6a2dba42611dde244a81e AS spacelift
FROM docker.io/1password/op:2@sha256:2aafc9794ab8d4062d0ac46c18760dc18c9c1dfe2e888ee61c3fa1ad340b5c28 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

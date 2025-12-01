# Base Image
FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:0fb1ee72dafaab59ec23a436652f86a27f3f3eacd606bd74ca4120ba4c160fd9 AS spacelift
FROM docker.io/1password/op:2@sha256:57d7d6a2bb2b74b2cf8111f6afb2973c74772198f82ea30359a53faae9fff5b1 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

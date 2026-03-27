# Base Image
FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:fd6ea50fb358a3ef617af84281c215dc9e798b1ea250e82466a0aa7da55e8fd3 AS spacelift
FROM docker.io/1password/op:2@sha256:57d7d6a2bb2b74b2cf8111f6afb2973c74772198f82ea30359a53faae9fff5b1 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

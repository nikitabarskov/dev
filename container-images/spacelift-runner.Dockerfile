# Base Image
FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:d168b996044c393e20c835900863f5f9502a2d98c2459193802478e0ab9ff2b3 AS spacelift
FROM docker.io/1password/op:2@sha256:57d7d6a2bb2b74b2cf8111f6afb2973c74772198f82ea30359a53faae9fff5b1 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

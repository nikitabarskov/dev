# Base Image
FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:d168b996044c393e20c835900863f5f9502a2d98c2459193802478e0ab9ff2b3 AS spacelift
FROM docker.io/1password/op:2@sha256:4ac3658f1e91a27ec9503f2134d4b2b77769b36d35b2e370ac89b5976573a17b AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

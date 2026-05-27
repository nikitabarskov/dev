# Base Image
FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:d168b996044c393e20c835900863f5f9502a2d98c2459193802478e0ab9ff2b3 AS spacelift
FROM docker.io/1password/op:2@sha256:2aafc9794ab8d4062d0ac46c18760dc18c9c1dfe2e888ee61c3fa1ad340b5c28 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

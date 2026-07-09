FROM public.ecr.aws/spacelift/runner-terraform:latest@sha256:a80bdc58574496b4c7dc4ea2ce8546c95bdccbf3e925053a0ae0f533c8347961 AS spacelift
FROM docker.io/1password/op:2@sha256:08503f72b054f2673537d42b5f016e377c351a0f07336f7d7519ba5234c697c3 AS op

FROM spacelift AS main

COPY --from=op /usr/local/bin/op /usr/local/bin/op

WORKDIR /tmp

USER spacelift

FROM docker.io/library/node:22-alpine3.19@sha256:487dc5d5122d578e13f2231aa4ac0f63068becd921099c4c677c850df93bede8 AS node
RUN corepack enable pnpm

FROM gcr.io/distroless/nodejs20-debian12:nonroot@sha256:61a4107f54a696ea04d6ac7b1a38d0093d21e155c47856e407f137437646b727 AS distroless

ENV NEXT_TELEMETRY_DISABLED 1

FROM node AS dependencies

WORKDIR /srv/src

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile


FROM node AS src

WORKDIR /srv/src

COPY --from=dependencies /srv/src/node_modules ./node_modules
COPY . .

FROM src as build

WORKDIR /srv/src
RUN pnpm next build

FROM distroless AS app

ENV NODE_ENV production

WORKDIR /srv/app

COPY --from=build /srv/src/public ./public
COPY --from=build /srv/src/.next/standalone ./
COPY --from=build /srv/src/.next/static ./.next/static

USER nonroot

EXPOSE 3000

ENV PORT 3000

CMD [ "server.js" ]

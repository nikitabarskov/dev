FROM node:lts-alpine@sha256:28bed508446db2ee028d08e76fb47b935defa26a84986ca050d2596ea67fd506 as base

ENV NEXT_TELEMETRY_DISABLED 1

FROM base as dependencies

WORKDIR /srv/src

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile


FROM base as src

WORKDIR /srv/src

COPY --from=dependencies /srv/src/node_modules ./node_modules
COPY . .

FROM src as build

WORKDIR /srv/src
RUN yarn next build

FROM base as app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

WORKDIR /srv/app

COPY --from=build /srv/src/next.config.js ./next.config.js
COPY --from=build /srv/src/public ./public

COPY --from=build --chown=nextjs:nodejs /srv/src/.next/standalone ./
COPY --from=build --chown=nextjs:nodejs /srv/src/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]

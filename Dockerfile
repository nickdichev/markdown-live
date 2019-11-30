FROM elixir:1.9.4-alpine AS build

WORKDIR /app

ADD config/config.exs config/
ADD config/prod.exs config/
ADD config/prod.secret.exs config/

RUN apk add --update git build-base nodejs yarn python npm

ENV MIX_ENV=prod
ADD mix.exs mix.lock ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile

ADD assets assets/
RUN cd assets      && \
    npm install    && \
    npm run deploy

RUN mix phx.digest

ADD priv priv/
ADD lib lib/
ADD rel rel/

RUN mix compile && \
    mix release

#######################################
FROM alpine:3.10

RUN apk add --update bash openssl

WORKDIR /app
COPY --from=build /app/_build/prod/rel/markdown_live ./
RUN chown -R nobody: /app
USER nobody

CMD ["/app/bin/markdown_live", "start"]
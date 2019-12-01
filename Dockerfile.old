FROM bitwalker/alpine-elixir-phoenix:1.8.1 as build

ENV MIX_ENV=prod

# Grab elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Grab npm deps
ADD assets/ assets/
RUN cd assets     && \
    npm install   && \
    node node_modules/webpack/bin/webpack.js --mode production

# Add build deps
ADD lib lib/
ADD rel rel/

# Add config 
ADD config/config.exs config/
ADD config/prod.exs config/
ADD config/prod.secret.exs /var/

# Run frontend build, compile, and digest assets
RUN cd assets                     && \
    webpack --mode production     && \
    cd -                          && \
    mix do release, phx.digest

# Export the release for the next build stage
RUN APP_NAME="markdown_live"                                  && \
    RELEASE_DIR=`ls -d _build/prod/rel/$APP_NAME/releases/*/` && \
    mkdir /export                                             && \
    tar -xf "$RELEASE_DIR/$APP_NAME.tar.gz" -C /export

#######################################

FROM bitwalker/alpine-elixir:1.8.1

# Copy in the exported release
COPY --from=build /export .

# Copy in the static asset cache manifest 
# TODO don't use a hardcoded version here...
COPY --from=build /opt/app/priv/ /opt/app/lib/markdown_live-0.1.0/priv/

# Add the default example
ADD docker/default.md /config/

# Set some of the expected environment variables
# COOKIE needs to be passed in at run-time,
# preferrably through a secret manager
ENV DEFAULT_MD "/config/default.md"
ENV PORT 4000

# Run as a non-root user
USER default

ENTRYPOINT ["/opt/app/bin/markdown_live"]
CMD ["foreground"]
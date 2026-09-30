FROM ghcr.io/jdx/mise:2026.9.11-debian

RUN apt-get update \
    && apt-get install --yes --no-install-recommends libatomic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/asyncapi

COPY mise.toml ./mise.toml

RUN mise trust \
    && mise install node pnpm \
    && mise install "npm:@asyncapi/cli" \
    && mise exec -- pnpm add @asyncapi/markdown-template@2.0.0 --dangerously-allow-all-builds \
    && ln -s "$(mise where node)/bin/node" /usr/local/bin/node \
    && ln -s "$(mise where 'npm:@asyncapi/cli')/node_modules/.bin/asyncapi" /usr/local/bin/asyncapi \
    && mise cache clear

ENTRYPOINT ["asyncapi"]

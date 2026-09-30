FROM ghcr.io/jdx/mise:2026.9.11-debian

WORKDIR /opt/asyncapi

COPY mise.toml ./mise.toml

RUN mise trust \
    && mise install node pnpm \
    && mise install "npm:@asyncapi/cli" \
    && mise exec -- pnpm add @asyncapi/markdown-template@2.0.0 --dangerously-allow-all-builds \
    && mise cache clear

ENTRYPOINT ["mise", "exec", "--"]

FROM asyncapi/cli@sha256:a5b8a30db2db7b572e1a391b3a84f4785e37c055f8be2b38966ef6529dc2d063

# Keep the generator template inside the image.  Supplying a package name to
# `asyncapi generate fromTemplate` causes the CLI to download it at runtime;
# this container is intentionally self-contained instead.
RUN npm install --global --omit=dev @asyncapi/markdown-template@2.0.0 \
    && npm cache clean --force

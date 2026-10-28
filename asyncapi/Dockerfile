FROM node:26-bookworm-slim

WORKDIR /opt/asyncapi

RUN npm install --global pnpm@11.28.0

COPY package.json ./package.json

RUN pnpm install --prod --dangerously-allow-all-builds

ENV PATH="/opt/asyncapi/node_modules/.bin:${PATH}"

ENTRYPOINT ["asyncapi"]

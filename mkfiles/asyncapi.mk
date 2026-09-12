ASYNCAPI_DOCUMENT := asyncapi/jobdeck/job/v1/execution-request.yaml
ASYNCAPI_IMAGE := asyncapi/cli@sha256:a5b8a30db2db7b572e1a391b3a84f4785e37c055f8be2b38966ef6529dc2d063
ASYNCAPI_CLI := docker run --rm --user $$(id -u):$$(id -g) --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(ASYNCAPI_IMAGE)
ASYNCAPI_HTML_TEMPLATE := @asyncapi/html-template@3.5.0
ASYNCAPI_HTML_OUTPUT := artifacts/asyncapi
ASYNCAPI_MARKDOWN_TEMPLATE := @asyncapi/markdown-template@2.0.0
ASYNCAPI_MARKDOWN_OUTPUT := docs/asyncapi
ASYNCAPI_MARKDOWN_FILE := $(ASYNCAPI_MARKDOWN_OUTPUT)/execution-request.md

.PHONY: asyncapi-proto-check
asyncapi-proto-check:
	@test -f proto/jobdeck/job/v1/execution.proto
	@rg --quiet '^message ExecutionRequested \{' proto/jobdeck/job/v1/execution.proto

.PHONY: asyncapi-validate
asyncapi-validate:
	@$(ASYNCAPI_CLI) validate $(ASYNCAPI_DOCUMENT)

.PHONY: asyncapi-check
asyncapi-check: asyncapi-proto-check asyncapi-validate

.PHONY: asyncapi-html
asyncapi-html: asyncapi-check
	@container_id=$$(docker create --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(ASYNCAPI_IMAGE) generate fromTemplate $(ASYNCAPI_DOCUMENT) $(ASYNCAPI_HTML_TEMPLATE) --output /tmp/asyncapi --force-write --no-interactive); \
	trap 'docker rm -f "$$container_id" >/dev/null 2>&1 || true' EXIT; \
	docker start -a "$$container_id"; \
	mkdir -p $(ASYNCAPI_HTML_OUTPUT); \
	docker cp "$$container_id:/tmp/asyncapi/." $(ASYNCAPI_HTML_OUTPUT)

.PHONY: asyncapi-markdown
asyncapi-markdown: asyncapi-check
	@container_id=$$(docker create --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(ASYNCAPI_IMAGE) generate fromTemplate $(ASYNCAPI_DOCUMENT) $(ASYNCAPI_MARKDOWN_TEMPLATE) --param outFilename=execution-request.md --output /tmp/asyncapi-markdown --force-write --no-interactive); \
	trap 'docker rm -f "$$container_id" >/dev/null 2>&1 || true' EXIT; \
	docker start -a "$$container_id"; \
	mkdir -p $(ASYNCAPI_MARKDOWN_OUTPUT); \
	docker cp "$$container_id:/tmp/asyncapi-markdown/execution-request.md" $(ASYNCAPI_MARKDOWN_FILE); \
	perl -0pi -e 's/\n{2,}\z/\n/' $(ASYNCAPI_MARKDOWN_FILE)

.PHONY: asyncapi-markdown-check
asyncapi-markdown-check: asyncapi-markdown
	@test -z "$$(git status --porcelain -- $(ASYNCAPI_MARKDOWN_FILE))"

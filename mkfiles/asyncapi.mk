ASYNCAPI_IMAGE ?= asyncapi/cli@sha256:a5b8a30db2db7b572e1a391b3a84f4785e37c055f8be2b38966ef6529dc2d063
ASYNCAPI_LOCAL_IMAGE ?= jobdeck-asyncapi:local
ASYNCAPI_CLI := docker run --rm --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(ASYNCAPI_IMAGE)
ASYNCAPI_DOCUMENTS := $(shell find asyncapi -type f \( -name '*.yaml' -o -name '*.yml' \) | sort)
ASYNCAPI_MARKDOWN_TEMPLATE ?= @asyncapi/markdown-template@2.0.0

.PHONY: asyncapi-image
asyncapi-image:
	docker build --tag $(ASYNCAPI_LOCAL_IMAGE) asyncapi

.PHONY: asyncapi-validate
asyncapi-validate:
	@for document in $(ASYNCAPI_DOCUMENTS); do \
		$(ASYNCAPI_CLI) validate "$$document" || exit $$?; \
	done

.PHONY: asyncapi-check
asyncapi-check: asyncapi-validate

.PHONY: asyncapi-generate
asyncapi-generate: asyncapi-markdown

.PHONY: asyncapi-markdown
asyncapi-markdown: asyncapi-check
	@for document in $(ASYNCAPI_DOCUMENTS); do \
		output="docs/$${document%.*}.md"; \
		output_dir="$$(dirname "$$output")"; \
		output_file="$$(basename "$$output")"; \
		archive="$$(mktemp)"; \
		mkdir -p "$$output_dir"; \
		docker run --rm --env ASYNCAPI_DOCUMENT="$$document" --env ASYNCAPI_OUTPUT_FILE="$$output_file" --volume "$(CURDIR):/workspace:ro" --workdir /workspace --entrypoint /bin/sh $(ASYNCAPI_IMAGE) -ec 'asyncapi generate fromTemplate "$$ASYNCAPI_DOCUMENT" $(ASYNCAPI_MARKDOWN_TEMPLATE) --param outFilename="$$ASYNCAPI_OUTPUT_FILE" --output /tmp/asyncapi-markdown --force-write --no-interactive >&2 && tar -C /tmp/asyncapi-markdown -cf - "$$ASYNCAPI_OUTPUT_FILE"' > "$$archive" || { status=$$?; rm -f "$$archive"; exit $$status; }; \
		tar -C "$$output_dir" -xf "$$archive" || { status=$$?; rm -f "$$archive"; exit $$status; }; \
		rm -f "$$archive"; \
		perl -0pi -e 's/\n{2,}\z/\n/' "$$output" || exit $$?; \
	done

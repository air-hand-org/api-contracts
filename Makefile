include mkfiles/*.mk

.PHONY: generate
generate: buf-generate openapi-generate jsonschema-generate

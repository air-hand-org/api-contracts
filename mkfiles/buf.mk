BUF_TARGETS := $(shell find proto -type f -name buf.gen.yaml -exec dirname {} \; | sort -u)

.PHONY: buf-generate
buf-generate:
	@buf build \
	&& for gen in $(BUF_TARGETS); do \
		buf generate --template "$${gen}/buf.gen.yaml" --path "$${gen}" --output "packages/$${gen#proto/}" \
		&& node scripts/export-proto-dependencies.mjs "$${gen}" "packages/$${gen#proto/}/third_party" \
		|| exit $$?; \
	done

.PHONY: buf-lint
buf-lint:
	@buf format --diff --exit-code && buf lint

.PHONY: buf-fmt
buf-fmt:
	@buf format -w

.PHONY: buf-breaking
buf-breaking:
	@buf breaking --against '.git#ref=refs/remotes/origin/main'

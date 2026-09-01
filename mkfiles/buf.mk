.PHONY: buf-generate
buf-generate:
	@buf build \
	&& buf generate --template buf.gen.yaml --path proto/jobdeck/auth -o packages/jobdeck-auth \
	&& buf generate --template buf.gen.yaml --path proto/jobdeck/job -o packages/jobdeck-job

.PHONY: buf-lint
buf-lint:
	@buf format --diff --exit-code && buf lint

.PHONY: buf-fmt
buf-fmt:
	@buf format -w

.PHONY: buf-breaking
buf-breaking:
	@buf breaking --against '.git#ref=refs/remotes/origin/main'

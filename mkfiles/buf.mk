.PHONY: buf-generate
buf-generate:
	@buf build \
	&& buf generate --template buf.gen.yaml --path jobdeck/auth -o packages/jobdeck-auth \
	&& buf generate --template buf.gen.yaml --path jobdeck/job -o packages/jobdeck-job

.PHONY: buf-lint
buf-lint:
	@buf format --diff --exit-code && buf lint

.PHONY: buf-fmt
buf-fmt:
	@buf format -w

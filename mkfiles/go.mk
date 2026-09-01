.PHONY: go-tidy
go-tidy:
	@find packages -name go.mod -print0 | while IFS= read -r -d '' mod; do \
		dir=$$(dirname "$$mod"); \
		(cd "$$dir" && go mod tidy); \
	done

.PHONY: go-build
go-build:
	@find packages -name go.mod -print0 | while IFS= read -r -d '' mod; do \
		dir=$$(dirname "$$mod"); \
		(cd "$$dir" && go build ./...); \
	done

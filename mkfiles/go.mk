GO_MODULES := $(shell find packages -name go.mod -exec dirname {} \; | sort)

.PHONY: go-tidy
go-tidy:
	@for mod in $(GO_MODULES); do \
		(cd "$$mod" && GOWORK=off go mod tidy) || exit $$?; \
	done

.PHONY: go-build
go-build:
	@for mod in $(GO_MODULES); do \
		(cd "$$mod" && GOWORK=off go build ./...) || exit $$?; \
	done

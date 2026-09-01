CS_SLNX := ApiContracts.slnx
CS_PROJECTS := $(shell find packages -name *.csproj | sort)

.PHONY: cs-generate
cs-generate:
	@for prj in $(CS_PROJECTS); do \
		dotnet sln $(CS_SLNX) add "$$prj" --in-root; \
	done

.PHONY: cs-build
cs-build: cs-generate
	@dotnet build $(CS_SLNX) --configuration Release

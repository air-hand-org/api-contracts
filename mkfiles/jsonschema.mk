.PHONY: jsonschema-generate
jsonschema-generate:
	@mise exec -- node scripts/generate-jsonschema.mjs jsonschema/quicktype.config.json

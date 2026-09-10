OPENAPI_CONFIGS := $(shell find openapi -type f -name '*.openapitools.yaml' | sort)
OPENAPI_OUTPUT_DIRS := $(shell awk '/^outputDir:/{print $$2}' $(OPENAPI_CONFIGS))

.PHONY: openapi-clean
openapi-clean:
	@for output_dir in $(OPENAPI_OUTPUT_DIRS); do \
		case "$$output_dir" in \
			packages/*) rm -rf -- "$$output_dir" ;; \
			*) echo "refusing to clean unexpected OpenAPI output directory: $$output_dir" >&2; exit 1 ;; \
		esac; \
	done

.PHONY: openapi-generate
openapi-generate: openapi-clean
	@for config in $(OPENAPI_CONFIGS); do \
		output_dir=$$(awk '/^outputDir:/{print $$2}' "$$config"); \
		ignore_file="$${config%.openapitools.yaml}.ignore"; \
		if [ -f "$$ignore_file" ]; then \
			# Copy before generation because openapi-clean removes the generated ignore file. \
			mkdir -p "$$output_dir"; \
			cp "$$ignore_file" "$$output_dir/.openapi-generator-ignore"; \
		fi; \
		mise exec -- openapi-generator-cli generate -c "$$config" || exit $$?; \
	done

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
		ignore_list_file=$$(awk '/^ignoreListFile:/{print $$2}' "$$config"); \
		if [ -n "$$ignore_list_file" ]; then \
			ignore_list=$$(awk 'NF && $$1 !~ /^#/' "$$ignore_list_file" | paste -sd, -); \
			mise exec -- openapi-generator-cli generate -c "$$config" --openapi-generator-ignore-list "$$ignore_list" || exit $$?; \
		else \
			mise exec -- openapi-generator-cli generate -c "$$config" || exit $$?; \
		fi; \
	done

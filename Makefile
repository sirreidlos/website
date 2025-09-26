PROJECT_DIRS := $(dir $(wildcard */Cargo.toml))

.PHONY: all $(PROJECT_DIRS)

all: $(PROJECT_DIRS)

$(PROJECT_DIRS):
	@echo "Building project in $@"
	wasm-pack build --target web --out-dir ../assets/$(notdir $(patsubst %/,%,$@))/pkg $@
	find assets -type f -name ".gitignore" -delete
	find assets -type f -name "package.json" -delete
	find assets -type f -name "README.md" -delete
	

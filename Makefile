PROJECT_DIRS := $(dir $(wildcard */Cargo.toml))

.PHONY: all $(PROJECT_DIRS)

all: $(PROJECT_DIRS)

$(PROJECT_DIRS):
	@echo "Building project in $@"
	wasm-pack build --target web --out-dir ../assets/$(notdir $(patsubst %/,%,$@))/pkg $@
	ls assets/$(notdir $(patsubst %/,%,$@))/pkg

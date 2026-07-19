PROFILE ?= developer

.PHONY: all build environment-check shell clean

all: build

build:
	@echo "Building MCC OS ISO (Profile: $(PROFILE))..."
	@echo "Note: ISO build logic will be implemented in Milestone 2."

environment-check:
	@bash scripts/environment-check.sh

shell:
	@echo "Starting development shell..."
	@docker build -t mcc-os-dev -f .devcontainer/Dockerfile .
	@docker run -it -v $(PWD):/workspace mcc-os-dev /bin/bash

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf build-output

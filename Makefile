PROFILE ?= developer

.PHONY: all build environment-check shell clean config

all: build

config:
	@echo "Configuring live-build tree..."
	@lb config

build:
	@echo "Building MCC OS ISO (Profile: $(PROFILE))..."
	@if ! docker info > /dev/null 2>&1; then \
		echo "ERROR: Docker daemon is not running. Please start Docker to build the ISO."; \
		exit 1; \
	fi
	@docker build -t mcc-os-dev -f .devcontainer/Dockerfile .
	@echo "Running lb config inside container..."
	@docker run --rm --privileged -v $(PWD):/workspace mcc-os-dev bash -c "lb config && lb build"
	@echo "Build complete. Check the workspace for the generated ISO."

environment-check:
	@bash scripts/environment-check.sh

shell:
	@echo "Starting development shell..."
	@docker build -t mcc-os-dev -f .devcontainer/Dockerfile .
	@docker run -it --privileged -v $(PWD):/workspace mcc-os-dev /bin/bash

clean:
	@echo "Cleaning build artifacts..."
	@if [ -d ".build" ]; then lb clean; fi
	@rm -rf build-output
	@rm -f *.iso

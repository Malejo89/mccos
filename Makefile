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
	@docker run --rm --privileged -v $(PWD):/workspace -v /build mcc-os-dev bash -c "cp -a /workspace/* /build/ && cd /build && sudo lb config && sudo lb build && cp *.iso /workspace/ || true"
	@if ls live-image-arm64.hybrid.iso 1> /dev/null 2>&1; then \
		mv live-image-arm64.hybrid.iso /Users/malejo/Downloads/mccos-arm64.iso; \
		echo "Build complete. ISO moved to /Users/malejo/Downloads/mccos-arm64.iso"; \
	else \
		echo "Build complete but ISO not found."; \
	fi

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

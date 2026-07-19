#!/bin/bash
set -e

echo "Running MCC OS Environment Check..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "ERROR: docker could not be found. Please install Docker."
    exit 1
fi
echo "✓ Docker is installed."

# Verify Docker is running
if ! docker info &> /dev/null; then
    echo "ERROR: Docker daemon is not running."
    exit 1
fi
echo "✓ Docker daemon is running."

# Build the development image locally to verify the Dockerfile
echo "Building the Debian builder image (mcc-os-dev)..."
docker build -t mcc-os-dev -f .devcontainer/Dockerfile . > /dev/null

# Test if the required tools are present inside the image
echo "Verifying required tools inside the container..."
docker run --rm mcc-os-dev bash -c "
    command -v lb > /dev/null || { echo 'ERROR: live-build missing'; exit 1; }
    command -v debootstrap > /dev/null || { echo 'ERROR: debootstrap missing'; exit 1; }
    command -v mksquashfs > /dev/null || { echo 'ERROR: squashfs-tools missing'; exit 1; }
    command -v xorriso > /dev/null || { echo 'ERROR: xorriso missing'; exit 1; }
    echo '✓ All required packaging tools (live-build, debootstrap, squashfs-tools, xorriso) are installed inside the container.'
"

echo "Environment check PASSED."
exit 0

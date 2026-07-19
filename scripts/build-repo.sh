#!/bin/bash
set -e

echo "Building MCC OS APT Repository..."

# Ensure we are in the project root
cd "$(dirname "$0")/.."

REPO_DIR="repo"
PACKAGES_DIR="packages"

# Ensure reprepro is installed
if ! command -v reprepro &> /dev/null; then
    echo "Error: reprepro is not installed. Please install it first."
    exit 1
fi

echo "Adding built packages to the repository..."

# Find all .deb files in the packages directory (assuming they are built there)
# In a real CI/CD pipeline, these would be collected in an artifacts folder.
find "$PACKAGES_DIR" -name "*.deb" -type f | while read -r deb_file; do
    echo "Including $deb_file..."
    reprepro -b "$REPO_DIR" includedeb stable "$deb_file"
done

echo "Repository build complete."
echo "You can serve the 'repo' directory using a web server like Nginx or Apache."

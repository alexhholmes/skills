#!/bin/bash
set -euo pipefail

PACKAGE="$1"

# Query PyPI API for package info
URL="https://pypi.org/pypi/${PACKAGE}/json"
RESPONSE=$(curl -sf "$URL" 2>/dev/null || echo "")

if [ -z "$RESPONSE" ]; then
    echo "Error: Package '$PACKAGE' not found on PyPI" >&2
    exit 1
fi

# Extract latest version from JSON response
VERSION=$(echo "$RESPONSE" | grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
    echo "Error: Could not parse version from response" >&2
    exit 1
fi

echo "$VERSION"

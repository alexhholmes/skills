#!/bin/bash
set -euo pipefail

PACKAGE="$1"

# Query Go proxy for latest version
URL="https://proxy.golang.org/${PACKAGE}/@latest"
RESPONSE=$(curl -sf "$URL" 2>/dev/null || echo "")

if [ -z "$RESPONSE" ]; then
    echo "Error: Package '$PACKAGE' not found or unreachable" >&2
    exit 1
fi

# Extract version from JSON response
VERSION=$(echo "$RESPONSE" | grep -o '"Version":"[^"]*"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
    echo "Error: Could not parse version from response" >&2
    exit 1
fi

echo "$VERSION"

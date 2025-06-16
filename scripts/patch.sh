#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

set -euo pipefail

# Validate and parse required environment variables
: "${TAG_NAME:?You must set the TAG_NAME environment variable (e.g., main, v1.2.3)}"

# Files to download (relative paths)
FILES=(
  "docker-compose-generator/crypto-definitions.json"
  "docker-compose-generator/docker-fragments/zcash.yml"
)

# Base URL for fetching raw files from GitHub
BASE_URL="https://raw.githubusercontent.com/btcpay-zcash/btcpayserver-docker/${TAG_NAME}"

# Download and replace each file
for FILE in "${FILES[@]}"; do
  DEST_DIR=$(dirname "$FILE")

  echo "Patching $FILE..."
  mkdir -p "$DEST_DIR"
  curl -fsSL "${BASE_URL}/${FILE}" -o "${FILE}"
done

echo "✅ Files patched successfully from btcpay-zcash/btcpayserver-docker@${TAG_NAME}"

} # this ensures the entire script is downloaded #

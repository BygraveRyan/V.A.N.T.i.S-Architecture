#!/bin/bash

# V.A.N.T.i.S. Publish Mirror Script
# This script extracts the public "Engine" from the private "Core"
# and pushes it to the public portfolio repository.

set -e

echo "🚀 Initiating V.A.N.T.i.S. Portfolio Deployment..."

# Define paths
SOURCE_DIR=$(pwd)
TEMP_DIR=$(mktemp -d -t vantis-mirror-XXXXXX)
PUBLIC_REPO="https://github.com/BygraveRyan/V.A.N.T.i.S-Architecture.git"

echo "📂 Staging public architecture files in temporary directory: $TEMP_DIR"

# 1. Staging Public Files (Whitelisting only)
# We specifically rsync only the directories and files that constitute the "Engine"
rsync -av --relative \
  .gemini/ \
  .github/ \
  vault/00_SYSTEM/ \
  vault/02_KNOWLEDGE/Galaxy/ \
  CHANGELOG.md \
  README.md \
  BOOT_IMAGE.md \
  GEMINI.md \
  AGENTS.md \
  RULES.md \
  VAULT_MAP.md \
  "$TEMP_DIR/"

# 2. Git Initialization and Deployment
cd "$TEMP_DIR"

echo "⚙️ Initializing Git mirror..."
git init --initial-branch=main
git add .
git commit -m "Deploy V.A.N.T.i.S. Architecture: $(date +'%Y-%m-%d %H:%M:%S')"

echo "🌐 Pushing to public portfolio ($PUBLIC_REPO)..."
# Force push to overwrite the mirror with the exact current state of the allowed files
git push --force "$PUBLIC_REPO" main

# 3. Cleanup
echo "🧹 Cleaning up temporary deployment files..."
rm -rf "$TEMP_DIR"

echo "✅ Portfolio deployment complete!"

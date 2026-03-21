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
  vault/06_MACHINE/00_MACHINE_LAYER_PROTOCOL.md \
  CHANGELOG.md \
  README.md \
  BOOT_IMAGE.md \
  GEMINI.md \
  AGENTS.md \
  RULES.md \
  VAULT_MAP.md \
  "$SOURCE_DIR/." "$TEMP_DIR/"

# 2. Git Initialization and Deployment
cd "$TEMP_DIR"

echo "⚙️ Initializing Git mirror..."
git init --initial-branch=main
git remote add origin "$PUBLIC_REPO"
git fetch origin main || true

# Use the current private branch name for the mirror to maintain naming consistency
PRIVATE_BRANCH=$(git -C "$SOURCE_DIR" branch --show-current)
DEPLOY_BRANCH="$PRIVATE_BRANCH"
git checkout -b "$DEPLOY_BRANCH"

git add .
git commit -m "feat(architecture): deploy V.A.N.T.i.S. engine sync" -m "Automated architectural synchronization from Private Core."

echo "🌐 Pushing to public portfolio branch ($DEPLOY_BRANCH)..."
git push origin "$DEPLOY_BRANCH"

echo "📝 Opening Pull Request on public mirror..."
gh pr create --repo "$PUBLIC_REPO" \
  --title "feat(architecture): system-wide engine synchronization ($(date +'%Y-%m-%d'))" \
  --body "## WHY
Automated architectural synchronization from the V.A.N.T.i.S. Private Core.

## HOW
- Whitelisted export of core system rules, protocols, and skills.
- Synchronized the latest Machine Layer protocol updates.
- Updated repository governance and branch protection standards.

## IMPACT
Ensures the public portfolio accurately reflects the current state of the V.A.N.T.i.S. engine while preserving private knowledge boundaries." \
  --base main --head "$DEPLOY_BRANCH"

# 3. Cleanup
echo "🧹 Cleaning up temporary deployment files..."
rm -rf "$TEMP_DIR"

echo "✅ Portfolio deployment complete!"

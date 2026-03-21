#!/bin/bash

# V.A.N.T.i.S. Publish Mirror Script
# This script extracts the public "Engine" from the private "Core"
# and pushes it to the public portfolio repository using a PR-driven workflow.

set -e

echo "🚀 Initiating V.A.N.T.i.S. Portfolio Deployment..."

# Define paths
SOURCE_DIR=$(pwd)
# Ensure a unique temp directory every time
TEMP_DIR="/tmp/vantis-mirror-$(date +%s)-$RANDOM"
PUBLIC_REPO="https://github.com/BygraveRyan/V.A.N.T.i.S-Architecture.git"

# 1. Git Synchronization
echo "⚙️ Cloning public mirror to temporary directory: $TEMP_DIR"
git clone --depth 1 "$PUBLIC_REPO" "$TEMP_DIR"

# 2. Stage Public Files (Whitelisting only)
echo "📂 Syncing whitelisted engine files..."
# Use relative paths to maintain structure. We exclude .git from rsync to keep the clone's metadata.
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
  "$TEMP_DIR/"

cd "$TEMP_DIR"

# Use the current private branch name for the mirror to maintain naming consistency
# We check the branch from the SOURCE_DIR
PRIVATE_BRANCH=$(git -C "$SOURCE_DIR" branch --show-current)
DEPLOY_BRANCH="$PRIVATE_BRANCH"

echo "🌿 Preparing deployment branch: $DEPLOY_BRANCH"
# If branch exists on remote, we might want to track it or overwrite it. 
# For mirror purposes, we'll try to create it.
git checkout -b "$DEPLOY_BRANCH" 2>/dev/null || git checkout "$DEPLOY_BRANCH"

git add .

# Only commit and push if there are changes
if git diff --cached --quiet; then
  echo "✅ Public mirror is already up to date. No changes to push."
else
  git commit -m "feat(architecture): deploy V.A.N.T.i.S. engine sync" -m "Automated architectural synchronization from Private Core."
  
  echo "🌐 Pushing to public portfolio branch ($DEPLOY_BRANCH)..."
  # Force push to the feature branch to ensure it matches the current state
  git push --force origin "$DEPLOY_BRANCH"

  echo "📝 Opening Pull Request on public mirror..."
  # Use --fill to use commit message for title/body, or provide custom
  gh pr create --repo "$PUBLIC_REPO" \
    --title "feat(architecture): system-wide engine synchronization ($(date +'%Y-%m-%d'))" \
    --body "## WHY
Automated architectural synchronization from the V.A.N.T.i.S. Private Core.

## HOW
- Whitelisted export of core system rules, protocols, and skills.
- Synchronized the latest Machine Layer protocol updates.
- Updated repository governance and branch protection standards.
- System version bumped to v1.1.

## IMPACT
Ensures the public portfolio accurately reflects the current state of the V.A.N.T.i.S. engine while preserving private knowledge boundaries." \
    --base main --head "$DEPLOY_BRANCH" || echo "⚠️ PR already exists or failed to create. Check GitHub."
fi

# 3. Cleanup
echo "🧹 Cleaning up temporary deployment files..."
cd "$SOURCE_DIR"
rm -rf "$TEMP_DIR"

echo "✅ Portfolio deployment complete!"

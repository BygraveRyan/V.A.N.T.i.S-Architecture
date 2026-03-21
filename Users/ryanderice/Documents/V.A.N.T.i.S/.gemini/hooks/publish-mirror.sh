#!/bin/bash

# V.A.N.T.i.S. Publish Mirror Script
# This script extracts the public "Engine" from the private "Core"
# and pushes it to the public portfolio repository.

set -e

echo "🚀 Initiating V.A.N.T.i.S. Portfolio Deployment..."

# 0. Fetch Private PR Metadata
echo "🔍 Fetching PR metadata from Private Core..."
PRIVATE_PR_JSON=$(gh pr view --json title,body 2>/dev/null || echo "")

if [ -n "$PRIVATE_PR_JSON" ] && [ "$PRIVATE_PR_JSON" != "null" ]; then
  PR_TITLE=$(echo "$PRIVATE_PR_JSON" | jq -r '.title')
  PR_BODY=$(echo "$PRIVATE_PR_JSON" | jq -r '.body')
  echo "✅ Found private PR: $PR_TITLE"
else
  PR_TITLE="feat(architecture): system-wide engine synchronization ($(date +'%Y-%m-%d'))"
  PR_BODY="## WHY
Automated architectural synchronization from the V.A.N.T.i.S. Private Core.

## HOW
- Whitelisted export of core system rules, protocols, and skills.
- Synchronized the latest Machine Layer protocol updates.
- Updated repository governance and branch protection standards.

## IMPACT
Ensures the public portfolio accurately reflects the current state of the V.A.N.T.i.S. engine while preserving private knowledge boundaries."
  echo "⚠️ No private PR found or error fetching. Using generic metadata."
fi

# Define paths
SOURCE_DIR=$(pwd)
TEMP_DIR=$(mktemp -d -t vantis-mirror-XXXXXX)
PUBLIC_REPO="https://github.com/BygraveRyan/V.A.N.T.i.S-Architecture.git"

echo "📂 Staging public architecture files in temporary directory: $TEMP_DIR"

# 1. Prepare Temporary Directory
cd "$TEMP_DIR"

echo "⚙️ Initializing Git mirror from history..."
git clone --depth 1 "$PUBLIC_REPO" .

# Use the current private branch name for the mirror to maintain naming consistency
PRIVATE_BRANCH=$(git -C "$SOURCE_DIR" branch --show-current)
DEPLOY_BRANCH="$PRIVATE_BRANCH"

# Check if branch exists on remote
if git ls-remote --exit-code --heads origin "$DEPLOY_BRANCH" > /dev/null 2>&1; then
  echo "🌿 Existing mirror branch found. Fetching and resetting to main HEAD..."
  git fetch origin "$DEPLOY_BRANCH"
  git checkout -B "$DEPLOY_BRANCH" FETCH_HEAD
  git reset --hard origin/main
else
  echo "🌿 Creating new mirror branch from main HEAD..."
  git checkout -b "$DEPLOY_BRANCH"
fi

# 2. Synchronizing Whitelisted Files
echo "🔄 Synchronizing whitelisted files into mirror history..."
rsync -av --relative \
  --exclude='.git/' \
  -C "$SOURCE_DIR/./.gemini/" \
  -C "$SOURCE_DIR/./.github/" \
  -C "$SOURCE_DIR/./vault/00_SYSTEM/" \
  -C "$SOURCE_DIR/./vault/06_MACHINE/00_MACHINE_LAYER_PROTOCOL.md" \
  -C "$SOURCE_DIR/./CHANGELOG.md" \
  -C "$SOURCE_DIR/./README.md" \
  -C "$SOURCE_DIR/./BOOT_IMAGE.md" \
  -C "$SOURCE_DIR/./GEMINI.md" \
  -C "$SOURCE_DIR/./AGENTS.md" \
  -C "$SOURCE_DIR/./RULES.md" \
  -C "$SOURCE_DIR/./VAULT_MAP.md" \
  .

git add .
# Only commit if there are changes
if ! git diff --cached --quiet; then
  git commit -m "feat(architecture): deploy V.A.N.T.i.S. engine sync" -m "Automated architectural synchronization from Private Core."
  echo "🌐 Pushing to public portfolio branch ($DEPLOY_BRANCH)..."
  git push origin "$DEPLOY_BRANCH" --force
else
  echo "✅ No changes detected. Skipping commit/push."
fi

echo "📝 Synchronizing Pull Request on public mirror..."
if gh pr view "$DEPLOY_BRANCH" --repo "$PUBLIC_REPO" > /dev/null 2>&1; then
  echo "🔄 PR already exists on mirror. Updating title and body..."
  gh pr edit "$DEPLOY_BRANCH" --repo "$PUBLIC_REPO" --title "$PR_TITLE" --body "$PR_BODY"
else
  echo "✨ Creating new PR on mirror..."
  gh pr create --repo "$PUBLIC_REPO" \
    --title "$PR_TITLE" \
    --body "$PR_BODY" \
    --base main --head "$DEPLOY_BRANCH"
fi

# 3. Cleanup
echo "🧹 Cleaning up temporary deployment files..."
rm -rf "$TEMP_DIR"

echo "✅ Portfolio deployment complete!"

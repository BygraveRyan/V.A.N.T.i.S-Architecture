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

# Whitelist of files to sync (Architecture only)
WHITELIST=(
  ".gemini/"
  ".github/"
  ".claude/"
  ".codex/"
  "03_SYSTEM/"
  "CHANGELOG.md"
  "README.md"
  "BOOT_IMAGE.md"
  "GEMINI.md"
  "CLAUDE.md"
  "CODEX.md"
  "AGENTS.md"
  "RULES.md"
  "VAULT_MAP.md"
  "LICENSE"
  "CONTRIBUTING.md"
)

# 1. Git Initialization (In clean directory)
cd "$TEMP_DIR"
echo "⚙️ Initializing Git mirror in clean directory..."
git init --initial-branch=main
git remote add origin "$PUBLIC_REPO"
git fetch origin

# Identify current private branch
PRIVATE_BRANCH=$(git -C "$SOURCE_DIR" branch --show-current)
# Never deploy directly to public main — use a named sync branch
if [ "$PRIVATE_BRANCH" = "main" ]; then
  DEPLOY_BRANCH="sync/main-$(date +%Y-%m-%d)"
else
  DEPLOY_BRANCH="$PRIVATE_BRANCH"
fi

# Create/Checkout the deployment branch (Always re-base on public main for clean PRs)
echo "🌿 Preparing $DEPLOY_BRANCH based on public main..."
if git show-ref --verify --quiet refs/heads/"$DEPLOY_BRANCH"; then
    git branch -D "$DEPLOY_BRANCH"
fi
git checkout -b "$DEPLOY_BRANCH" origin/main

# 2. Clean and Sync
echo "🧹 Cleaning existing files to ensure a fresh snapshot..."
# Remove everything except .git
find . -maxdepth 1 ! -name ".git" ! -name "." -exec rm -rf {} +

echo "📂 Staging public architecture files from $SOURCE_DIR..."
for ITEM in "${WHITELIST[@]}"; do
  if [ -e "$SOURCE_DIR/$ITEM" ]; then
    # Create directory structure if needed
    mkdir -p "$(dirname "$ITEM")"
    # Copy file or directory recursively
    cp -R "$SOURCE_DIR/$ITEM" "$ITEM"
  fi
done

# Remove junk files that should never reach the public mirror
find . -name ".DS_Store" -delete
find . -path "./.gemini/tmp" -prune -o -type f -print | grep -q "." || true
rm -rf .gemini/tmp

# Validation: Check for absolute path leak
if find . -path "*/Users/*" | grep -q "."; then
    echo "❌ ERROR: Absolute path leak detected in staging area! Deployment aborted."
    find . -path "*/Users/*"
    exit 1
fi

# 3. PR Metadata & Sync
# Fetch PR details from private core
PRIVATE_PR_JSON=$(gh pr view "$PRIVATE_BRANCH" --repo "https://github.com/BygraveRyan/V.A.N.T.i.S.git" --json title,body,number 2>/dev/null || echo "{}")
TITLE=$(echo "$PRIVATE_PR_JSON" | jq -r '.title // "feat(architecture): system-wide engine synchronization"')
BODY=$(echo "$PRIVATE_PR_JSON" | jq -r '.body // "Automated architectural synchronization from Private Core."')

# Sanitize body
PR_BODY_PUBLIC=$(echo "$BODY" | sed 's|vault/01_HUMAN|REDACTED_PERSONAL|g' | sed 's|logs/[0-9-]*/|logs/REDACTED/|g')
PR_TITLE_PUBLIC="Engine Sync: $TITLE"

# Commit and Deployment
git add .
# Only commit if there are changes
if ! git diff-index --quiet HEAD --; then
    git commit -m "feat(engine): mirror sync from private core ($PRIVATE_BRANCH)" -m "$PR_BODY_PUBLIC"
    echo "🌐 Pushing to public portfolio branch ($DEPLOY_BRANCH)..."
    git push origin "$DEPLOY_BRANCH" --force
else
    echo "ℹ️ No architectural changes detected. Skipping commit/push."
fi

echo "📝 Managing Pull Request on public mirror..."
if gh pr view "$DEPLOY_BRANCH" --repo "$PUBLIC_REPO" >/dev/null 2>&1; then
    echo "🔄 Updating existing PR..."
    gh pr edit "$DEPLOY_BRANCH" --repo "$PUBLIC_REPO" \
      --title "$PR_TITLE_PUBLIC" \
      --body "$PR_BODY_PUBLIC"
    gh pr view "$DEPLOY_BRANCH" --repo "$PUBLIC_REPO" --json url -q '.url'
else
    echo "🆕 Creating new PR..."
    gh pr create --repo "$PUBLIC_REPO" \
      --title "$PR_TITLE_PUBLIC" \
      --body "$PR_BODY_PUBLIC" \
      --base main --head "$DEPLOY_BRANCH"
fi

# 4. Cleanup
echo "🧹 Cleaning up temporary deployment files..."
rm -rf "$TEMP_DIR"

echo "✅ Portfolio deployment complete!"

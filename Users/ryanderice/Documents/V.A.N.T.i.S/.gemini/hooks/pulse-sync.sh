#!/bin/bash

# V.A.N.T.i.S. Pulse Sync Hook
# This script performs a low-friction, background backup to the Private Core 'main' branch.

set -e

echo "💓 Initiating V.A.N.T.i.S. Pulse Sync..."

# Ensure we are on the main branch for the background sync
# Note: If we are on a feature branch, this will be skipped to avoid cross-branch contamination
CURRENT_BRANCH=$(git branch --show-current)

if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "⚠️  Pulse Sync skipped: Currently on feature branch '$CURRENT_BRANCH'."
  echo "💡 Pulse Sync only targets the 'main' branch for background backup."
  exit 0
fi

git add .

# Only commit if there are changes to avoid empty commit noise
if git diff --cached --quiet; then
  echo "✅ No changes detected. Pulse Sync complete."
else
  git commit -m "chore(sync): $(date +'%Y-%m-%d %H:%M:%S') vault pulse sync"
  git push origin main
  echo "✅ Pulse Sync successful! Vault backup pushed to Private Core."
fi

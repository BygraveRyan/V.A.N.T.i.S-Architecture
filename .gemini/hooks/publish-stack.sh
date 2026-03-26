#!/usr/bin/env bash
# V.A.N.T.i.S. Stack Publisher
# Publishes multiple private branches to the public mirror in chronological order.
# Each branch gets its own PR on the public mirror, building on the previous.
#
# Usage:   bash .gemini/hooks/publish-stack.sh <branch1> [branch2] [branch3] ...
# Example: bash .gemini/hooks/publish-stack.sh feat/claude-architecture feat/tokenless-audit-engine

set -e

BRANCHES=("$@")

if [ ${#BRANCHES[@]} -eq 0 ]; then
  echo "❌ No branches specified."
  echo "   Usage: bash .gemini/hooks/publish-stack.sh <branch1> [branch2] ..."
  exit 1
fi

SOURCE_DIR=$(pwd)
PUBLIC_REPO="https://github.com/BygraveRyan/V.A.N.T.i.S-Architecture.git"
PUBLIC_REPO_GH="BygraveRyan/V.A.N.T.i.S-Architecture"
PRIVATE_REPO_GH="BygraveRyan/V.A.N.T.i.S"

WHITELIST=(
  ".gemini/"
  ".github/"
  "03_SYSTEM/Protocols/"
  "02_MACHINE/00_MACHINE_LAYER_PROTOCOL.md"
  "CHANGELOG.md"
  "README.md"
  "BOOT_IMAGE.md"
  "GEMINI.md"
  "AGENTS.md"
  "RULES.md"
  "VAULT_MAP.md"
)

echo "🚀 V.A.N.T.i.S. Stack Publisher"
echo "   Branches to publish: ${BRANCHES[*]}"
echo ""

# Init public mirror in a temp dir
MIRROR_DIR=$(mktemp -d -t vantis-stack-XXXXXX)
echo "⚙️  Cloning public mirror..."
cd "$MIRROR_DIR"
git init --initial-branch=main
git remote add origin "$PUBLIC_REPO"
git fetch origin
git checkout -b _stack_base origin/main

# GIT_BASE tracks the local branch name in the mirror temp repo
# PR_BASE tracks the name to use as PR target on the public remote (always "main" for first)
GIT_BASE="_stack_base"
PR_BASE="main"
PUBLISHED_COUNT=0

for PRIVATE_BRANCH in "${BRANCHES[@]}"; do
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📦  Processing: $PRIVATE_BRANCH"

  # --- 1. Get a clean snapshot of this branch ---
  # Prune any stale worktrees (e.g. from a previous failed run) before adding
  git -C "$SOURCE_DIR" worktree prune 2>/dev/null || true

  CURRENT_BRANCH=$(git -C "$SOURCE_DIR" branch --show-current)
  WORKTREE_OWNED=false
  WORKTREE_DIR=""

  if [ "$PRIVATE_BRANCH" = "$CURRENT_BRANCH" ]; then
    # Already on this branch — use SOURCE_DIR directly, no worktree needed
    echo "   📌 Current branch — reading directly from working directory."
    WORKTREE_DIR="$SOURCE_DIR"
  else
    WORKTREE_DIR=$(mktemp -d -t vantis-wt-XXXXXX)
    WORKTREE_OWNED=true
    if ! git -C "$SOURCE_DIR" worktree add "$WORKTREE_DIR" "$PRIVATE_BRANCH" 2>&1; then
      echo "   ❌ Could not check out '$PRIVATE_BRANCH'. Skipping."
      rm -rf "$WORKTREE_DIR"
      continue
    fi
  fi

  # --- 2. Create public branch from previous in the stack ---
  if git show-ref --verify --quiet refs/heads/"$PRIVATE_BRANCH"; then
    git branch -D "$PRIVATE_BRANCH"
  fi
  git checkout -b "$PRIVATE_BRANCH" "$GIT_BASE"

  # --- 3. Wipe and repopulate with whitelisted files only ---
  find . -maxdepth 1 ! -name ".git" ! -name "." -exec rm -rf {} +

  echo "   📂 Staging whitelisted files from branch snapshot..."
  for ITEM in "${WHITELIST[@]}"; do
    if [ -e "$WORKTREE_DIR/$ITEM" ]; then
      mkdir -p "$(dirname "$ITEM")"
      cp -R "$WORKTREE_DIR/$ITEM" "$ITEM"
    fi
  done

  # --- 4. Path leak safety check ---
  if find . -path "*/Users/*" | grep -q .; then
    echo "   ❌ Absolute path leak detected. Aborting $PRIVATE_BRANCH."
    find . -path "*/Users/*"
    git checkout _stack_base
    git branch -D "$PRIVATE_BRANCH" 2>/dev/null || true
    if [ "$WORKTREE_OWNED" = true ]; then
      git -C "$SOURCE_DIR" worktree remove "$WORKTREE_DIR" --force
      rm -rf "$WORKTREE_DIR"
    fi
    continue
  fi

  # --- 5. Pull PR metadata from private core ---
  PRIVATE_PR_JSON=$(gh pr list \
    --repo "$PRIVATE_REPO_GH" \
    --head "$PRIVATE_BRANCH" \
    --state all \
    --json title,body,number \
    --limit 1 2>/dev/null || echo "[]")

  PR_TITLE=$(echo "$PRIVATE_PR_JSON" | jq -r '.[0].title // empty' 2>/dev/null)
  PR_BODY=$(echo "$PRIVATE_PR_JSON" | jq -r '.[0].body // empty' 2>/dev/null)

  # Fallbacks if no PR found
  [ -z "$PR_TITLE" ] && PR_TITLE="feat(architecture): engine synchronization ($PRIVATE_BRANCH)"
  [ -z "$PR_BODY" ] && PR_BODY="Automated architectural synchronization from Private Core."

  # Sanitise: redact personal paths and log references
  PR_BODY_PUBLIC=$(echo "$PR_BODY" \
    | sed 's/vault\/01_HUMAN/Personal/vault\/REDACTED_PERSONAL/g' \
    | sed 's|logs/[0-9-]*/|logs/REDACTED/|g')
  PR_TITLE_PUBLIC="Engine Sync: $PR_TITLE"

  # --- 6. Commit and push ---
  git add .
  if git diff-index --quiet HEAD --; then
    echo "   ℹ️  No whitelisted changes vs previous branch. Skipping."
    git checkout _stack_base
    if [ "$WORKTREE_OWNED" = true ]; then
      git -C "$SOURCE_DIR" worktree remove "$WORKTREE_DIR" --force
      rm -rf "$WORKTREE_DIR"
    fi
    continue
  fi

  git commit \
    -m "feat(engine): mirror sync — $PRIVATE_BRANCH" \
    -m "$PR_BODY_PUBLIC"

  echo "   🌐 Pushing to public mirror..."
  git push origin "$PRIVATE_BRANCH" --force

  # --- 7. Create or update PR on public mirror ---
  if gh pr view "$PRIVATE_BRANCH" --repo "$PUBLIC_REPO_GH" >/dev/null 2>&1; then
    echo "   🔄 Updating existing PR on public mirror..."
    gh pr edit "$PRIVATE_BRANCH" \
      --repo "$PUBLIC_REPO_GH" \
      --title "$PR_TITLE_PUBLIC" \
      --body "$PR_BODY_PUBLIC"
  else
    echo "   🆕 Creating PR: $PRIVATE_BRANCH → $PR_BASE"
    gh pr create \
      --repo "$PUBLIC_REPO_GH" \
      --title "$PR_TITLE_PUBLIC" \
      --body "$PR_BODY_PUBLIC" \
      --base "$PR_BASE" \
      --head "$PRIVATE_BRANCH"
  fi

  # Advance both bases for the next iteration
  GIT_BASE="$PRIVATE_BRANCH"
  PR_BASE="$PRIVATE_BRANCH"
  PUBLISHED_COUNT=$((PUBLISHED_COUNT + 1))
  echo "   ✅ Published."
  echo ""

  # --- 8. Clean up worktree (only if we created it) ---
  if [ "$WORKTREE_OWNED" = true ]; then
    git -C "$SOURCE_DIR" worktree remove "$WORKTREE_DIR" --force
    rm -rf "$WORKTREE_DIR"
  fi
done

# Final cleanup
rm -rf "$MIRROR_DIR"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Stack publish complete. $PUBLISHED_COUNT branch(es) published to public mirror."
echo "   Public repo: https://github.com/$PUBLIC_REPO_GH"

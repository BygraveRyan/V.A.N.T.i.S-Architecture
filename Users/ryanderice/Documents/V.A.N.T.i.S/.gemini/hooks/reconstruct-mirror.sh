#!/bin/bash
set -e

# ==========================================
# Phase 2: The Public Mirror "Wipe"
# ==========================================
echo "🧹 Wiping existing public mirror..."
gh repo delete BygraveRyan/V.A.N.T.i.S-Architecture --yes || true
echo "🏗️ Recreating empty public mirror..."
gh repo create BygraveRyan/V.A.N.T.i.S-Architecture --public --description "Vectorised Astral Navigation & Thought Intelligence System (Portfolio Engine)"

TEMP_DIR=$(mktemp -d -t vantis-reconstruct-XXXXXX)
cd "$TEMP_DIR"

echo "⚙️ Initializing base repository in $TEMP_DIR"
git init --initial-branch=main
echo "# V.A.N.T.i.S. Architecture Portfolio" > README.md
git add README.md
git commit -m "Initial commit"
git remote add origin https://github.com/BygraveRyan/V.A.N.T.i.S-Architecture.git
git push -u origin main

SOURCE_DIR="$OLDPWD"

# Helper function to create PR
create_pr() {
  local branch=$1
  local message=$2
  local body=$3
  echo "🚀 Reconstructing Era: $branch"
  git checkout -b "$branch" main
  git commit -m "$message"
  git push -u origin "$branch"
  gh pr create --repo BygraveRyan/V.A.N.T.i.S-Architecture --title "$message" --body "$body" --base main --head "$branch"
}

# ==========================================
# Phase 3: The Reconstruction Sequence
# ==========================================

# PR 1: Core Intelligence
mkdir -p vault/00_SYSTEM
cp "$SOURCE_DIR/GEMINI.md" .
cp "$SOURCE_DIR/AGENTS.md" .
cp "$SOURCE_DIR/RULES.md" .
cp "$SOURCE_DIR/VAULT_MAP.md" .
cp "$SOURCE_DIR/CHANGELOG.md" .
git add .
create_pr "feat/core-protocols" "feat(core): establish intelligence layer and core protocols" "## 📖 The Story\n\n### WHY - What problem are we solving?\nV.A.N.T.i.S. was born from the friction of a high-stakes GCP Data Engineering project. I needed a persistent system to manage workflows instead of relying on transient chat sessions.\n\n### HOW - What did we actually change?\nEstablished the root Intelligence Layer configuration and defined core agent personas (Inbox Processor, Knowledge Architect).\n\n### IMPACT - What is the result?\nThe system has a baseline identity, operational rules, and a defined vault map for knowledge routing."


# PR 2: Security & Boundaries
git checkout main
mkdir -p vault/00_SYSTEM/Archive
cp "$SOURCE_DIR/vault/00_SYSTEM/AGENT_PERMISSIONS.md" vault/00_SYSTEM/ || true
cp "$SOURCE_DIR/vault/00_SYSTEM/Archive/LOGGING_PROTOCOL.md" vault/00_SYSTEM/Archive/ || true
git add .
create_pr "feat/security-boundaries" "feat(security): enforce ai boundaries and logging layer" "## 📖 The Story\n\n### WHY - What problem are we solving?\nIdentified a critical system risk: AI was writing directly to the knowledge graph and actions were untraceable, leading to 'Model Collapse.'\n\n### HOW - What did we actually change?\nImplemented strict agent permissions revoking AI write-access to the 02_KNOWLEDGE/Galaxy. Mandated a 4-step execution loop (Plan -> Act -> Validate -> Log).\n\n### IMPACT - What is the result?\nZero knowledge contamination. 100% auditability achieved."

# PR 3: Governance
git checkout main
mkdir -p .github
cp -r "$SOURCE_DIR/.github/" .github/
git add .
create_pr "feat/governance-templates" "feat(governance): implement github templates and standardization" "## 📖 The Story\n\n### WHY - What problem are we solving?\nPreparing the architecture for professional, version-controlled expansion and a potential 'Multi-Universal' upgrade.\n\n### HOW - What did we actually change?\nAdded strict PR and commit templates enforcing the 'Why/How/Impact' standard and log-linking.\n\n### IMPACT - What is the result?\nEnforces the 'VANTIS Standard' on all future commits, ensuring high-fidelity traceability for recruiters and collaborators."

# PR 4: The Metamorphosis
git checkout main
mkdir -p .gemini
cp -r "$SOURCE_DIR/.gemini/skills" .gemini/ || true
cp -r "$SOURCE_DIR/.gemini/commands" .gemini/ || true
cp "$SOURCE_DIR/.gemini/SKILLS_INDEX.md" .gemini/ || true
cp "$SOURCE_DIR/.gemini/settings.json" .gemini/ || true
cp "$SOURCE_DIR/vault/00_SYSTEM/METADATA_SCHEMA.md" vault/00_SYSTEM/ || true
git add .
create_pr "feat/agentic-skills" "feat(engine): transition to native skills and github ops" "## 📖 The Story\n\n### WHY - What problem are we solving?\nMarkdown protocols were too slow for agentic execution. The root directory was cluttered, causing cognitive friction for the AI.\n\n### HOW - What did we actually change?\nExecuted 'The Metamorphosis': converted flat protocols into lazy-loaded .gemini/skills/ (audit-logger, inbox-processor) and consolidated system templates into 00_SYSTEM/.\n\n### IMPACT - What is the result?\nMassive reduction in AI cognitive load. The system is now a reactive, skill-first engine."

# PR 5: Private Core Deployment
git checkout main
mkdir -p .gemini/hooks
cp "$SOURCE_DIR/.gemini/hooks/publish-mirror.sh" .gemini/hooks/ || true
cp "$SOURCE_DIR/README.md" . || true
git add .
create_pr "feat/dual-repo-architecture" "feat(architecture): deploy private-core to public-mirror pipeline" "## 📖 The Story\n\n### WHY - What problem are we solving?\nNeeded cross-device sync for private personal data without exposing it on a public portfolio.\n\n### HOW - What did we actually change?\nEngineered a whitelisted rsync deployment script that extracts only the Engine and Galaxy, triggered via a custom /gh:publish CLI command.\n\n### IMPACT - What is the result?\n'Zero-risk' portfolio automation. Private data stays private, architecture stays public."

echo "✅ Portfolio Reconstruction Complete!"

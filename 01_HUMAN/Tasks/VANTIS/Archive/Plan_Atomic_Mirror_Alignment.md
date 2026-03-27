# Plan: Atomic Mirror Alignment (Private & Public PR Synchronization)

## 🎯 Objective
Split the morning's architectural changes into two distinct, high-signal Pull Requests (PRs) that exist on both the Private "Core" repository and the Public "Architecture" Engine. This ensures a 1:1 "Professional History" while redacting sensitive personal paths.

---

## 🛠️ Key Files & Context
- **Governance Branch (`feat/deterministic-governance-v1`)**:
    - `.github/` (Git Message, PR Template, Governance, Commit Template)
    - `RULES.md`
    - `01_HUMAN/Tasks/` (Massive task vault reorganization)
    - `logs/2026-03-21/` & `logs/2026-03-22/` (Governance audit logs)

- **Deployment Branch (`feat/robust-deployment-sync`)**:
    - `.gemini/hooks/publish-mirror.sh` (The new robust sync engine)
    - `.gemini/hooks/extract-pr-body.sh` (The log-to-PR extractor)
    - `logs/2026-03-22/2026-03-22_143000_IntelligenceLayer_Robust-Engine-Sync-Fix.md` (Deployment audit log)

---

## 🚀 Implementation Plan

### Phase 1: Isolate & Finalize Governance (Private PR #6)
1.  [x] **Backup**: Temporarily move the new `publish-mirror.sh` and `extract-pr-body.sh` to a safe staging area outside the current branch.
2.  [x] **Reset**: Revert the `publish-mirror.sh` and `extract-pr-body.sh` in the `feat/deterministic-governance-v1` branch to match their state in `main`.
3.  [x] **Commit**: Group all remaining Governance and Task vault changes into a clean commit.
4.  [x] **Private Sync**: Force-push to Private PR #6.
5.  [x] **Public Sync**: Run the `publish` command from this branch $\rightarrow$ This creates a clean **Public PR #9** (Governance only).

### Phase 2: Create & Mirror Deployment (Private PR #10)
1.  [x] **Branch**: Create a new branch `feat/robust-deployment-sync` from `main`.
2.  [x] **Restore**: Apply the high-performance `publish-mirror.sh` and `extract-pr-body.sh` scripts from the backup.
3.  [x] **Commit**: Group these as "Deployment Engine: Robust Sync & Redaction."
4.  [x] **Private Launch**: Create Private PR #10 with a detailed "Why/How/Impact" story.
5.  [x] **Public Mirror**: Run the `publish` command from this branch $\rightarrow$ This creates a clean **Public PR #10** (Deployment only).

---

## 🧪 Verification & Testing
1.  [x] **Repo Structure**: Verify that `V.A.N.T.i.S-Architecture` (Public) no longer has nested `Users/ryanderice/...` paths.
2.  [x] **Path Scrubbing**: Audit the Public PR descriptions for any accidental leaks of `01_HUMAN/Personal` or local machine paths.
3.  [x] **PR Parity**: Confirm both repositories have matched PR titles and descriptions, creating a professional development history.

---

## 🔐 Migration & Safety
- **State Protection**: The current branch `feat/deterministic-governance-v1` will be "cleaned" before syncing, ensuring no temporary files leak into the public governance PR.
- **Rollback**: If the `publish` command fails at any point, the scripts are backed up in `.gemini/tmp/deployment_backup/`.

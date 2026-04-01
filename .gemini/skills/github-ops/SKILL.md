---
name: github-ops
description: Provides GitHub CLI integration for managing PRs, issues, Actions runs, and repository governance within V.A.N.T.i.S.
---

# SKILL: GitHub Operations
Version: 1.0.1

Purpose
Provide native GitHub integration using the GitHub CLI (`gh`) to manage issues, pull requests, actions, and repository security with deep workspace visibility.

---

# When To Use
Activate this skill when:
• Managing pull requests (`/gh:pr`).
• Responding to failed GitHub Actions (`/gh:run`).
• Organizing repository issues and project boards (`/gh:issue`).
• Managing repository secrets or governance.

---

# Core Capabilities

Step 1 — Environment Awareness
Verify `gh auth status` and current repository context before executing commands.

Step 2 — Structured Interaction
Always use `--json` flags when querying `gh` to provide the Intelligence Layer with parseable data.
Example: `gh pr list --json number,title,author,updatedAt`

Step 3 — Actionable Intelligence
Transform CLI output into VANTIS assets (Logs, Task updates, or Galaxy references).

Step 4 — Traceability
Ensure all `gh` commands are recorded in the session audit log for full accountability.

---

# Command Interface (Internal)
- **PR Management**: `gh pr list`, `gh pr view`, `gh pr checkout`, `gh pr diff`.
- **Action Runs**: `gh run list`, `gh run view`, `gh run rerun`.
- **Issue Tracking**: `gh issue list`, `gh issue view`, `gh issue create`.
- **Secret Management**: `gh secret list`, `gh secret set`.

---

# Security Rules
• **Token Masking**: NEVER log or print cleartext tokens, even if returned by a command.
• **Secret Rotation**: Use `gh secret set` only when explicitly instructed by a verified human request.
• **Scope Limitation**: Operate only within the authorized scopes (gist, read:org, repo, workflow).

---

# Output Rules
• **Format**: Prefer Markdown tables for human-readable summaries in logs.
• **Data**: Use JSON for internal agentic processing when chaining commands.
• **Status**: Always report the exit code and stderr of `gh` commands if they fail.

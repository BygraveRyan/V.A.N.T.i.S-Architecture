# Task: Proposed Automations Backlog

## Overview
A collection of high-impact automation ideas identified during the 2026-04-01 session to enhance system efficiency, agent parity, and knowledge compounding.

## 1. Intelligence & Efficiency
- [ ] **Routing Table Expansion**: Refine the `ROUTING_TABLE.md` (or equivalent in `VAULT_MAP.md`) to include more specific task-based file mappings (e.g., "Market Research", "Task Audit").
- [ ] **Context Budget Monitoring**: Automate the tracking of context usage per session type to suggest the most cost-effective model (Haiku vs. Sonnet vs. Opus).

## 2. Agent Parity & Resilience
- [ ] **Claude SessionStart Hook**: Ensure Claude auto-runs `repo-map.sh` and `/resume` logic at the start of every session for immediate orientation.
- [ ] **PreCompact Hook Snapshot**: Implement a hook that triggers just before context compaction to save a high-fidelity state snapshot, preventing mid-session information loss.

## 3. Knowledge Lifecycle
- [ ] **Continuous Learning Stop Hook**: A post-session evaluation step that identifies new patterns or bug fixes and automatically drafts/proposes new Skills for `.gemini/skills/`.
- [ ] **Automated Metadata Linter**: A hook that validates Metadata v1.5 compliance (frontmatter, tags, IDs) whenever files are created or modified in the `02_MACHINE/` layer.

## 4. Workflow Synchronization
- [ ] **Auto Git Sync (EOD)**: Update the `/eod` command or add a Stop Hook to automatically `git add`, `git commit` (with generated message), and `git push` vault changes.
- [ ] **Session Review Notifications**: Automate the delivery of session reviews or daily logs to external platforms (Email, Discord, or Slack) upon session closure.

## 5. System Health
- [ ] **Enhanced `/diagnose`**: Add automated checks for "Context Debt" (history length) and "Protocol Adherence" (e.g., verifying ASV Reflex execution).

---
*Created: 2026-04-01 | Agent: Gemini*

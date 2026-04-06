---
title: Implement VANTIS Cleanup Command (/cleanup)
status: todo
priority: medium
agent: Gemini
created: 2026-04-01
updated: 2026-04-01
---

# TASK: Implement VANTIS Cleanup Command (/cleanup)

## Background & Motivation
As the V.A.N.T.i.S. roadmap grows, manual synchronization between individual task files, the `VANTIS_Upgrade_Dashboard.md`, and the `04_ARCHIVES/` folder is becoming a source of friction and potential "governance drift."

## Scope & Impact
- Create `.gemini/commands/cleanup.toml` (Command definition).
- Create `.gemini/hooks/v_cleanup.sh` (Execution logic).
- Automated status audit and dashboard synchronization.
- Automated archival of completed roadmap tasks.

## Implementation Steps
- [ ] Draft the shell script logic for `v_cleanup.sh`.
- [ ] Define the command structure in `cleanup.toml`.
- [ ] Test the command on a dummy completed task.
- [ ] Update `GEMINI.md` to include `/cleanup` in the governance suite.

## Verification
- Run `/cleanup` and verify a `status: completed` task is moved to `04_ARCHIVES/`.
- Verify the `VANTIS_Upgrade_Dashboard.md` reflects the change in the correct date section.

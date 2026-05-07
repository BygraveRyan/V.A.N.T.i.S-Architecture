---
id: task-expand-diagnose-command
type: task
status: todo
priority: high
created: 2026-03-21
updated: 2026-03-21
---

# TASK: Expand `diagnose` Command (System Health & Cleanup)

## Objective
Upgrade the `diagnose` command into a comprehensive "System Health Check" that identifies and fixes protocol drift, metadata errors, and file-system clutter.

## Core Features
- **Protocol Audit**: Check core files for the presence of `Version: X.Y.Z` and other mandatory metadata.
- **Vault Cleanup**: Identify and propose removal of transient files in `private workspace/Inbox/` or `02_MACHINE/`.
- **Link Integrity**: Scan the `Galaxy` for broken internal wikilinks or orphaned nodes.
- **Audit Chain Check**: Verify that the latest GitHub commits have corresponding audit logs in `logs/`.

## Next Steps
- [ ] Define "Healthy State" criteria for V.A.N.T.i.S. (Registry).
- [ ] Propose new command logic for `.gemini/commands/diagnose.toml`.
- [ ] Design the "Auto-Remediation" workflow (Inquiry vs. Directive).

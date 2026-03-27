---
id: task-refactor-eod-command
type: task
status: todo
priority: medium
created: 2026-03-21
updated: 2026-03-21
---

# TASK: Refactor `/eod` Master Audit Command

## Objective
Redesign the `/eod` command to focus strictly on high-signal synthesis and state reporting, removing automated file movements or Git operations that cause synchronization conflicts.

## Requirements
- **Decouple Action from Audit**: Ensure the command is an "Inquiry" (Synthesis) and not a "Directive" (Execution).
- **Output Refinement**: Update the prompt in `.gemini/commands/eod.toml` to produce a more streamlined, actionable summary.
- **Manual Archiving Protocol**: Establish a clear rule for when and how completed tasks are moved to `Archive/`.

## Next Steps
- [ ] Review current `eod.toml` output structure.
- [ ] Propose new "State Snapshot" format for the audit log.
- [ ] Test the command without automated Git hooks.

---
room: Protocols
parent: /03_SYSTEM/context.md
layer: 2
---

# Protocols Room

> **Purpose**: Governance layer — canonical rules, schemas, and operational mandates all agents must obey.

## Scope
- **Contains**: `governance-gate.md`, `METADATA_SCHEMA.md`, `Universals/Rules/SHARED_RULES.md`, all versioned protocol files
- **Does not contain**: Session state, daily outputs, or transient artifacts

## Agent Rules
- Read: All agents (SHARED_RULES.md required at session start)
- Write: **BLOCKED** — requires ASV REFLEX + human approval for any edit
- Key mandate: Every edit to this folder MUST run `node .gemini/hooks/version-incrementer.js <file_path>` immediately after

## Naming Convention
Protocols carry semantic versioning in frontmatter (`Version: X.Y.Z`). The version-incrementer auto-handles patch bumps.

## Skills / Commands
- `.gemini/hooks/version-incrementer.js` — ASV REFLEX hook, mandatory after any protocol edit
- `governance-gate.md` — active gate policy; consult before any subagent write action

## Related Rooms
- `→ 03_SYSTEM/ADRs/` — decision records that reference these protocols
- `→ logs/` — all governance evaluations logged here

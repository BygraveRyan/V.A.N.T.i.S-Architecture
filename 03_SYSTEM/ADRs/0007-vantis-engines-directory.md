# ADR-0007: VANTIS_ENGINES CANONICAL DIRECTORY

**Date**: 2026-04-20
**Status**: APPROVED
**Agents**: Claude Code (Sonnet 4.6)
**Context**: Three execution engine repos were scattered across `~/Documents/revenue-engine/`, `~/Documents/CONTENT_ENGINE/`, and `~/Documents/Playground/ns-outreach-engine/`. Playground is for experimental projects (Data Driven Dispatch, PvZ, etc) — not production tooling. No single location existed where an agent could open a folder and immediately understand the full engine inventory.

---

## [DECISION] CREATE ~/Documents/VANTIS_ENGINES/

A dedicated `~/Documents/VANTIS_ENGINES/` directory is established as the canonical home for all V.A.N.T.i.S. execution engines.

---

## [DISTINCTION] Why Not VANTIS_LIBRARIES?

`~/Documents/VANTIS_LIBRARIES/` (ADR-0004) already exists for a different purpose:
- **VANTIS_LIBRARIES** = large read-only reference repositories, harvested for concepts, never actively run
- **VANTIS_ENGINES** = operational execution environments with scripts, pipelines, outputs, and API integrations

These are fundamentally different. Merging them would obscure purpose and create context confusion for agents.

---

## [MIGRATION] Repos Moved

| From | To |
| :--- | :--- |
| `~/Documents/revenue-engine/` | `~/Documents/VANTIS_ENGINES/revenue-engine/` |
| `~/Documents/CONTENT_ENGINE/` | `~/Documents/VANTIS_ENGINES/content-engine/` |
| `~/Documents/Playground/ns-outreach-engine/` | `~/Documents/VANTIS_ENGINES/ns-outreach-engine/` |

Note: `CONTENT_ENGINE` was lowercased to `content-engine` on move, matching sibling repo naming convention.

---

## [CONVENTION] Adding Future Engines

All new execution engines must be created inside `~/Documents/VANTIS_ENGINES/`. See the checklist in `EXECUTION_ENGINES.md § [ADDING A NEW ENGINE]`.

---

## [IMPACT] Files Updated

- `~/Documents/VANTIS_ENGINES/CLAUDE.md` — created (agent orientation for all engines)
- `VAULT_MAP.md` — added VANTIS_ENGINES section, updated engine paths
- `03_SYSTEM/Protocols/Universals/Rules/EXECUTION_ENGINES.md` — updated paths, added NS_OUTREACH_ENGINE section, added new engine template
- `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` — updated engine table
- `CONTENT_ENGINE/INTEGRATION.md` — updated execution repo path
- `.claude/commands/ns-batch.md` — updated repo path

---

*V.A.N.T.i.S. Architecture Decision Record | Signal v1.3*

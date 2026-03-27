---
title: P12 — Modular Rules & Orchestration (Decomposition Plan)
status: Plan Complete — Awaiting User Approval
priority: HIGH
agent: Opus (planning) → Gemini/Architect (execution)
branch: feat/subagent-definitions
planned_date: 2026-03-27
last_updated: 2026-03-27
---

# P12 — Modular Rules Decomposition Plan

## Context

CLAUDE.md, GEMINI.md, and AGENTS.md contain ~95 lines of duplicated content (Architecture Map, Global Mandates, Skill Trigger Matrix, Resumption Protocol, Interoperability, Development Lifecycle). When a shared rule changes, 2-3 files need manual sync. This burns context tokens and risks drift. P12 extracts the shared content into a single canonical file and slims the adapters down to agent-specific content + a compact mandate fallback.

**Guiding constraint:** VANTIS is a 2-agent system. Don't create 6 files where 1 will do. Don't sacrifice reliability for aesthetics.

---

## What Changes

### NEW: `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` (~50 lines)

One file containing all previously-duplicated operational rules:

| Section | Source | Lines saved |
|---|---|---|
| Global Agent Mandates (full 6 rules) | AGENTS.md lines 101-109 | Canonical version, not a copy |
| Skill Trigger Matrix | CLAUDE.md/GEMINI.md lines 56-65 | ~9 lines removed from each adapter |
| Resumption & Handover Protocol | CLAUDE.md/GEMINI.md lines 27-35 | ~8 lines each, merged (covers symlink + sort-by-filename) |
| Interoperability Protocol | CLAUDE.md/GEMINI.md lines 48-52 + AGENTS.md lines 34-42 | ~5 lines each |
| Development Lifecycle (5-step loop) | CLAUDE.md/GEMINI.md lines 100-105/85-90 | ~5 lines each |

### MODIFIED: `CLAUDE.md` (~109 → ~55 lines)

**Keeps:**
- System Role ("Execution Plane") — unique
- Claude Command Reference table — unique
- Claude-specific resumption note (1 line: "sort by filename descending")

**Adds:**
- Compact Mandate Summary (~10 lines) — compressed 6-rule fallback so Claude can operate even if SHARED_RULES.md isn't read
- MUST READ directive pointing to SHARED_RULES.md

**Removes:**
- Architecture Map (already in VAULT_MAP.md)
- Directory Structure (subset of VAULT_MAP.md)
- Full Global Mandates (replaced by compact summary + reference)
- Skill Trigger Matrix, Interoperability, Lifecycle (moved to SHARED_RULES.md)

### MODIFIED: `GEMINI.md` (~94 → ~45 lines)

**Keeps:**
- System Role ("Control Plane") — unique
- Model Selection Guide — unique
- Gemini-specific resumption note (1 line: "read symlink, fallback to sort")

**Adds:** Same compact summary + MUST READ directive as CLAUDE.md

**Removes:** Same sections as CLAUDE.md

### MODIFIED: `AGENTS.md` (~260 → ~245 lines)

**Removes:**
- Architecture Map (lines 20-31) → 1-line reference to VAULT_MAP.md
- Cross-Agent Collaboration (lines 34-42) → 1-line reference to SHARED_RULES.md

**Keeps everything else** — agent definitions, Skills vs Subagents, Council Tool Scopes, Global Mandates (as governance source of truth). AGENTS.md remains the canonical governance document.

### MODIFIED: `VAULT_MAP.md`

Add `SHARED_RULES.md` to 3 routing table rows:
- Orientation / Resume
- Protocol Modification
- Architecture Change

### MODIFIED: `03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md`

Add 1 Tier 2 entry for SHARED_RULES.md.

---

## What Does NOT Change

- **RULES.md** — philosophical guardrails (Rules 1-12), distinct from operational mandates
- **Agent definitions in AGENTS.md** — all 6 agent profiles untouched
- **Skills vs Subagents / Council Tool Scopes** — untouched
- **No behavioral changes** — same rules, same enforcement, new home

---

## Deferred: Council_Orchestration_Protocol.md

The P12 task lists this, but the Council of Universals isn't actively used in orchestrated sessions yet. Creating an orchestration protocol now would be speculative. **Create it when you run your first real multi-role council session** and discover what coordination is actually needed.

---

## The Compact Mandate Summary (inline fallback)

Both adapters get this ~10-line block. It's a compressed safety net, not a full copy:

```markdown
# OPERATING MANDATES (Summary)
> Canonical source: `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` — MUST READ at session start.

1. LOG REFLEX: Every vault modification → audit log in `logs/YYYY-MM-DD/`.
2. NO GALAXY WRITES: Synthesis lands in `02_MACHINE/`. Never write to `01_HUMAN/Knowledge/Galaxy`.
3. METADATA v1.5: Knowledge nodes follow `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4. ASV REFLEX: Run `node .gemini/hooks/version-incrementer.js <file_path>` on `03_SYSTEM/Protocols/` changes.
5. PLAN MODE: Multi-file/system changes require plan → approval → feature branch.
6. SKILL TRIGGERS: Consult Skill Trigger Matrix in SHARED_RULES.md before execution.
```

**Why keep this inline:** The adapter is the ONLY file guaranteed loaded every session. If an agent skips the MUST READ (medium risk), it still has the 6 critical rules. The full details (skill routing table, lifecycle steps, handover procedure) require reading SHARED_RULES.md.

---

## Risks

| Risk | Mitigation |
|---|---|
| Agent skips MUST READ directive | Compact summary provides critical rules inline. Skill trigger details are the main loss — lower-stakes. |
| Compact summary drifts from SHARED_RULES.md | Comment in SHARED_RULES.md: "update compact summaries in adapters when changing mandates." ASV version bump signals review. |
| Architecture Map removal disorients agents | VAULT_MAP.md routing table already directs agents there. Non-architecture tasks don't need it. |
| SHARED_RULES.md grows into a monolith | Currently ~50 lines. Split signal: if it passes ~100 lines. |

---

## Implementation Order

1. Create `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md`
2. Slim `CLAUDE.md` (remove duplicated sections, add compact summary + MUST READ)
3. Slim `GEMINI.md` (same treatment)
4. Update `AGENTS.md` (remove Architecture Map + Cross-Agent Collaboration, add references)
5. Update `VAULT_MAP.md` routing table
6. Update `CORE_SYSTEM_REGISTRY.md`
7. Run ASV reflex on all `03_SYSTEM/Protocols/` files touched
8. Validation: confirm adapters are self-sufficient for a "Project Work" task

---

## Verification

- Read the slimmed CLAUDE.md end-to-end — confirm it has everything a Claude session needs without reading additional files
- Read SHARED_RULES.md — confirm it has the full canonical version of all 5 extracted sections
- Grep for any remaining duplication across the 3 files
- Confirm VAULT_MAP routing table references the new file
- Run ASV on new/modified Protocol files

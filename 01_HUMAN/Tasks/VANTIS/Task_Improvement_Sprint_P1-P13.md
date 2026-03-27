---
title: V.A.N.T.i.S. Improvement Sprint — P1 to P13+ (Phase 4 Extended)
status: Phase 3 Complete | Phase 4 In Progress
source: 02_MACHINE/Reports/2026-03-26_VANTIS_Improvement_Report.md
research_assets: 02_MACHINE/Research/everything-claude-code/
branch: feat/subagent-definitions
last_updated: 2026-03-27
agent_last: Claude (Execution Plane)
---

# V.A.N.T.i.S. Improvement Sprint — P1 to P13+

## Strategic Motivation

Three ingested sources identified 4 critical gaps and 5 medium-term enhancements. Access to the `everything-claude-code` (ECC) repository on 2026-03-27 has provided a high-fidelity template for Phase 4: **The Self-Improving System.** Claude's full review of the ECC repo on 2026-03-27 expanded the roadmap to 7 Phase 4 items.

---

## Agent Assignment Key

| Agent | Use When |
| :--- | :--- |
| **Gemini** | Mechanical execution — hook config, file edits, script adaptation, git ops |
| **Sonnet** | Moderate reasoning — skill authoring, structural design, content creation |
| **Opus** | High-stakes architectural judgment — decomposition plans, cross-system decisions |

---

## Progress Tracker

### ✅ Phase 1–3 Completed (2026-03-27)

| ID | Item | Component | Notes |
| :---: | :--- | :--- | :--- |
| **P1** | Routing Table in `VAULT_MAP.md` | `VAULT_MAP.md` v1.5 | 9-row task-based routing table added |
| **P2** | Claude `SessionStart` hook | `.claude/settings.local.json` | `repo-map.sh` wired — parity with Gemini |
| **P3** | PreCompact Hook | `.gemini/hooks/precompact-snapshot.sh` | Hook script and wiring for Claude + Gemini |
| **P4** | Hook syntax audit | `.claude/settings.local.json` | `Write\|Edit\|NotebookEdit` confirmed valid |
| **P5** | Formalise Skills vs Subagents | `AGENTS.md` | Section added with Council tool scope table |
| **P6** | `03_SYSTEM/Protocols/Universals/` scaffold | 4 placeholder files | Architect, Strategist, Researcher, Guardian |
| **P7** | Model Selection Guide | `GEMINI.md` | 8-row table routing tasks |
| **P8** | Author Council Role Context | `03_SYSTEM/Protocols/Universals/` | 4 roles fully authored v1.1.0 |
| **P9** | Subagent Definitions | `.claude/agents/`, `.gemini/agents/` | 8 definitions created v1.0.1 |
| **P11** | Council Shell Aliases | `03_SYSTEM/Protocols/Universals/aliases.sh` | Shell aliases for role invocation added |
| **Hook Parity** | Gemini Engine Hooks | `.gemini/settings.json` | AfterTool, PreCompress, SessionEnd parity |
| **ECC Research** | ECC repo cloned | `02_MACHINE/Research/everything-claude-code/` | Full repo available for reference |
| **Phase 4 Review** | Full ECC audit by Claude | Session state v5.0 | Subagent scopes validated, roadmap expanded |

---

## 🔲 Phase 4 — In Progress

### ~~P14 — Strategic Compaction~~
**Agent: Gemini** | Priority: HIGH | Effort: Low
*Source: `02_MACHINE/Research/everything-claude-code/skills/strategic-compact/` + `scripts/hooks/suggest-compact.js`*

- [x] Adapt `suggest-compact.sh` — store at `.gemini/hooks/suggest-compact.sh`
- [x] Wire to `.claude/settings.local.json` PreToolUse (matcher: `Edit|Write`)
- [x] Wire equivalent to `.gemini/settings.json`
- [x] Threshold: 50 tool calls; reminder every 25 after that
- [x] **Note**: No `CLAUDE_PLUGIN_ROOT` — use absolute or repo-relative paths

---

### ~~P12 — Modular Rules & Orchestration~~
**Agent: Opus (planning) → Gemini/Architect subagent (execution)** | Priority: HIGH | Effort: High
*Requires Plan Mode approval before any file is touched*

- [x] **Opus planning phase**: Read `CLAUDE.md`, `GEMINI.md`, `AGENTS.md` — draft decomposition map (which rules → which files, how adapter files reference Universals, Claude/Gemini symmetry plan)
- [x] **User approves decomposition plan**
- [x] Create `03_SYSTEM/Protocols/Universals/Rules/` with modular rule files (`SHARED_RULES.md`)
- [x] Slim down `CLAUDE.md` and `GEMINI.md` to adapter files referencing Universals
- [x] ASV reflex on all `03_SYSTEM/Protocols/` file modifications
- [ ] **Deferred**: Create `03_SYSTEM/Protocols/Council_Orchestration_Protocol.md` (Wait until first real council session)
- **Support tool**: Use `skills/rules-distill/` from ECC to scan protocols and extract cross-cutting principles

---

### ~~P9 Fix — Subagent Tool Scope Corrections~~
**Agent: Gemini** | Priority: MEDIUM | Effort: Low

- [x] **Researcher** (`.claude/agents/researcher.md`): Add `Glob` and `Grep` to tool list
- [x] **Strategist** (`.claude/agents/strategist.md`): Add `Glob` and `Grep` to tool list
- [x] **Architect** (`.claude/agents/architect.md`): Scope `Bash(rm *)` → `Bash(rm 03_SYSTEM/Protocols/*)` + `Bash(rm .claude/*)`; add `Glob` and `Grep`
- [x] Mirror all changes to `.gemini/` subagent equivalents
- [x] Bump version in each edited file

---

### ~~P15 — Cost Tracker Hook *(New — sourced from ECC)*~~
**Agent: Gemini** | Priority: MEDIUM | Effort: Trivial
*Source: `02_MACHINE/Research/everything-claude-code/scripts/hooks/cost-tracker.js`*

- [x] Copy/adapt `cost-tracker.js` to `.gemini/hooks/cost-tracker.js`
- [x] Wire to `.claude/settings.local.json` Stop hook
- [x] Wire to `.gemini/settings.json` Stop equivalent
- [x] Metrics output: `~/.claude/metrics/costs.jsonl`
- [x] **Why**: Real-time visibility into per-session token cost — informs future agent selection decisions

---

### ~~P16 — Architecture Decision Records (ADR) System *(New — sourced from ECC)*~~
**Agent: Sonnet** | Priority: MEDIUM | Effort: Medium
*Source: `02_MACHINE/Research/everything-claude-code/skills/architecture-decision-records/`*

- [x] Create `02_MACHINE/ADRs/` with `README.md` index and `template.md`
- [x] Author V.A.N.T.i.S.-adapted ADR skill at `.gemini/skills/architecture-decision-records.md` (path: `02_MACHINE/ADRs/`, not `docs/adr/`)
- [x] Write first ADR: `0001-phase4-p10-deferral.md` — document the decision to defer full instinct infrastructure in favour of P10 Lite
- **Why**: Captures the "why" behind major architectural decisions for future agents

---

### ~~P10 Lite — EOD Pattern Extraction *(Revised from original P10)*~~
**Agent: Gemini** | Priority: MEDIUM | Effort: Low
*Source: ECC `skills/continuous-learning/` (v1) + `commands/learn.md`*

- [x] Add "Pattern Extraction" phase to the end of `.claude/commands/eod.md` (and Gemini equivalent)
- [x] Phase logic: review today's session logs for non-obvious behaviors not already in `CLAUDE.md`, `AGENTS.md`, or memory system → propose new skill or memory entry → **require user approval before writing**
- [x] Output staging: `02_MACHINE/Synthesis/` for candidates; `.claude/commands/` if a new skill is confirmed
- [x] **Why this beats full P10 v2**: No hooks, no Python CLI, no background observer, no API cost. Uses the transcript EOD already reads.

> **Original P10 (full instinct infrastructure) deferred to Phase 5.** Revisit when V.A.N.T.i.S. is actively used for software project development (Car Shopping App, GCP Pipeline) where project-scoped coding instincts provide real value.

---

### ~~P17 — Context Budget Skill *(New — sourced from ECC)*~~
**Agent: Gemini** | Priority: LOW | Effort: Low
*Source: `02_MACHINE/Research/everything-claude-code/skills/context-budget/`*

- [x] Adapt `skills/context-budget/SKILL.md` for V.A.N.T.i.S. paths (`.claude/agents/`, `03_SYSTEM/Protocols/`, `.gemini/skills/`, `CLAUDE.md`)
- [x] Add as `.claude/commands/context-budget.md` and `.gemini/skills/context-budget.md`
- [x] **Usage**: Periodic — run after adding agents/skills or when sessions feel sluggish

---

---

### ~~P18 — Split `/eod` into EOD + `/handover` Command *(New — Architecture)*~~
**Agent: Gemini** | Priority: MEDIUM | Effort: Low
*Insight: `/eod` currently serves as both end-of-day audit and mid-session handover mechanism — these are distinct use cases that warrant separate commands.*

- [x] **`/eod`** — keep as strict once-a-day command: full audit, daily log to `02_MACHINE/Daily/`, P10 Lite pattern extraction phase, session state update. Run only when done for the day.
- [x] **`/handover`** — new lightweight command: updates session state with current status + next steps only. No audit, no log, no pattern extraction. Run any time an agent hand-off occurs mid-day.
- [x] Both commands update `02_MACHINE/State/session-state_YYYY-MM-DD.md` — `/eod` comprehensively, `/handover` minimally.
- [x] `/handover` is the "write" counterpart to `/resume` (the "read"). Document this pairing in `CLAUDE.md` and `GEMINI.md`.
- [x] Mirror both commands to `.gemini/skills/` equivalents.
- [x] **Reference**: ECC `commands/save-session.md` as a pattern for the lightweight `/handover` implementation.

---

## 🗓️ Quarterly Maintenance Practice (Not Phase 4 — Future)

- **Skill Stocktake** (`skills/skill-stocktake/`): Audit V.A.N.T.i.S. skills/commands for quality, freshness, and overlap after significant additions.

---

## 🔍 Additional ECC Research Vectors (Future Sprints)

- **Article Writing / Content Engine**: Potential for `LinkedIn_Operations` project.
- **Iterative Retrieval**: Patterns for subagents to "dig deeper" before returning results.
- **~~P13 — Hookify & Self-Expansion~~**: Evaluated. `hookify@claude-plugins-official` recommended for conversational hook creation in Claude sessions. No Gemini equivalent exists yet. *(Status: Evaluated)*

---

## Implementation Notes

- **Symmetry rule**: Every hook added to `.claude/settings.local.json` must have a Gemini equivalent in `.gemini/settings.json` unless Claude-specific by nature.
- **P12 constraint**: Do NOT proceed to execution without a written, user-approved decomposition plan.
- **Path rule**: Never use `CLAUDE_PLUGIN_ROOT` — all ECC adaptations must use absolute or V.A.N.T.i.S.-relative paths.

---
*Last updated: 2026-03-27 | Claude (Execution Plane)*

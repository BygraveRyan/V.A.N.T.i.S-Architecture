---
title: V.A.N.T.i.S. Improvement Report — Source Synthesis
date: 2026-03-26
agent: Claude
status: staged-for-review
sources:
  - NotebookLM: Folder-Based AI Workspace Architecture
  - The Shortform Guide to Everything Claude Code
  - The Longform Guide to Everything Claude Code
---

# V.A.N.T.i.S. Improvement Report
## Source Synthesis: Folder Architecture + Claude Code Best Practices

**Date:** 2026-03-26
**Prepared by:** Claude (Execution Plane)
**Status:** Staged for human review → `02_MACHINE/Reports/`

---

## Executive Summary

Three ingested sources were cross-referenced against the current V.A.N.T.i.S. architecture. The analysis identifies **4 critical gaps**, **5 medium-term enhancements**, and **13 prioritised actions** — all converging on a single overarching finding:

> **The Routing Table is the missing foundation.** It is both the highest-impact individual improvement and the architectural prerequisite for Phase 3 (Council of Universals) to work coherently.

Additionally, all three sources independently validate the Council of Universals direction. The concept is not speculative — the implementation primitives all exist today.

---

## Sources Reviewed

| ID | Source | Core Contribution |
| :--- | :--- | :--- |
| S1 | NotebookLM: Folder-Based AI Workspace Architecture | Three-layer hierarchy; Routing Table as critical component; token efficiency via selective reading |
| S2 | The Shortform Guide to Everything Claude Code | Subagents vs skills distinction; correct hook syntax; rules folder; LSP plugins |
| S3 | The Longform Guide to Everything Claude Code | PreCompact hook; SessionStart context loading; continuous learning Stop hook; model selection; dynamic system prompt injection |

---

## Section 1 — Critical Gaps

### GAP 1.1 — Missing Routing Table *(Severity: Critical)*

**Source:** S1 — described as "the most critical component" of folder-based AI architecture.

**What it is:** A markdown table that maps each task type to the exact files an agent should read, and explicitly lists files to skip. This is the mechanism that makes the three-layer hierarchy functional rather than nominal.

**What V.A.N.T.i.S. has today:** A directory map (CLAUDE.md, GEMINI.md) pointing agents to everything. No per-task routing. Agents make heuristic decisions about what to read.

**Impact of absence:**
- Token waste every session — agents load irrelevant files by default
- Inconsistent agent behaviour depending on which files happen to be in working memory
- No enforcement of the selective reading principle the three-layer hierarchy depends on

**Proposed implementation:**
```markdown
| Task Type         | Read                                          | Skip                              |
| :---              | :---                                          | :---                              |
| Architecture      | CLAUDE.md, AGENTS.md, 03_SYSTEM/Protocols/    | 01_HUMAN/Personal/, logs/         |
| Knowledge Ingestion | 01_HUMAN/Inbox/, METADATA_SCHEMA.md          | 02_MACHINE/State/, .claude/       |
| EOD Audit         | 02_MACHINE/State/, logs/TODAY/, SIGNAL_PROTOCOL.md | 01_HUMAN/Knowledge/Galaxy/  |
| PR/Git Ops        | .claude/settings.local.json, AGENTS.md        | 01_HUMAN/, 03_SYSTEM/Protocols/   |
| Research/Inbox    | 01_HUMAN/Inbox/, METADATA_SCHEMA.md, Galaxy/  | 02_MACHINE/State/, logs/          |
```

**Proposed location:** `VAULT_MAP.md` (already exists at root — extend it to include routing logic) or a new `ROUTING_TABLE.md` cross-referenced from both `CLAUDE.md` and `GEMINI.md`.

---

### GAP 1.2 — Claude Code Has No SessionStart Hook *(Severity: Critical)*

**Source:** S3 (PreCompact + SessionStart section)

**What it is:** A hook that fires at the start of every Claude session and auto-loads context — Gemini already has this via `repo-map.sh`. Claude does not.

**What V.A.N.T.i.S. has today:** The `/resume` command manually loads session state. This works but requires the human (or agent) to remember to run it. Gemini auto-orients; Claude begins cold.

**Impact of absence:**
- Every Claude session starts without orientation unless `/resume` is manually run
- The dual-agent architecture is asymmetrically reliable — Gemini can self-resume, Claude cannot
- Creates a structural dependency on human intervention for every Claude session start

**Proposed fix:**
Add a `SessionStart` hook to `.claude/settings.local.json` that runs a shell script equivalent to `repo-map.sh` — auto-injecting the latest session state file path and a directory snapshot.

```json
"SessionStart": [
  {
    "matcher": ".*",
    "hooks": [
      {
        "type": "command",
        "command": "bash .gemini/hooks/repo-map.sh"
      }
    ]
  }
]
```

---

### GAP 1.3 — No PreCompact Hook *(Severity: Critical)*

**Source:** S3 — "hooks most people don't know about"

**What it is:** A hook that fires immediately *before* Claude's context window is compacted. This is a unique moment where the full session context is still intact and can be checkpointed.

**What V.A.N.T.i.S. has today:** A Stop hook that runs `compile-audit-log.sh` at session *end*. This is different — Stop fires when Claude finishes, PreCompact fires mid-session when the context limit approaches. A long working session can trigger PreCompact multiple times before Stop ever fires.

**Impact of absence:**
- Silent, destructive context loss mid-session with no state preservation
- Work accumulates in context, gets partially lost when compaction fires, and the audit log only captures the final state
- No differentiation between "session still active but compacted" vs "session ended"

**Proposed fix:** A `PreCompact` hook that snapshots the current working state to `02_MACHINE/State/precompact-snapshot_YYYY-MM-DD_HHMMSS.md`.

---

### GAP 1.4 — Subagents and Skills Are Conflated *(Severity: High)*

**Source:** S2 — explicit distinction between `~/.claude/skills/` and `~/.claude/agents/`

**What it is:** Claude Code has two distinct constructs:
- **Skills** — prompt-level behavioural instructions, agent-agnostic markdown (V.A.N.T.i.S. uses these correctly in `.gemini/skills/`)
- **Subagents** — Claude-native workers with scoped tool permissions, spawnable as independent processes via `.claude/agents/`

**What V.A.N.T.i.S. has today:** Only skills. The Phase 3 Council of Universals roles (Architect, Strategist, Researcher, Guardian) are conceptually described but have no implementation path. Building them as skills would underuse Claude's native subagent capability.

**Impact:** Phase 3 cannot be implemented correctly without this distinction. Each Council role maps to a subagent with a defined tool scope:

| Council Role | Tool Scope |
| :--- | :--- |
| Architect | Read/Write access to system files, no web search |
| Strategist | Read-only + web search, no vault writes |
| Researcher | Web search + Galaxy read, no execution |
| Guardian | Audit log read, hook inspection, no writes outside logs/ |

---

## Section 2 — Medium-Term Enhancements

### ENH 2.1 — Continuous Learning Stop Hook

**Source:** S3

The current Stop hook compiles a tokenless audit log (`compile-audit-log.sh`). An enhancement pattern exists where the Stop hook also triggers a brief agent evaluation: *"Did anything non-trivial happen this session that warrants a new skill entry?"*

If yes, the agent authors a skill file and saves it to `.gemini/skills/`. This turns every completed session into a potential knowledge compounding event.

**Why Stop hook (not UserPromptSubmit):** UserPromptSubmit runs on every single message — adds latency to every prompt. Stop runs once at session end — lightweight, non-intrusive.

**Complexity:** Medium — requires agent participation at hook time, not pure shell execution. Best implemented as a Tier 2 audit step in the `/eod` command first, then optionally automated.

---

### ENH 2.2 — Hook Syntax Audit

**Source:** S2

The confirmed correct matcher syntax for Claude Code hooks is:
```
tool == "Bash" && tool_input.command matches "(npm|pnpm|yarn)"
```

V.A.N.T.i.S. currently uses `"Write|Edit|NotebookEdit"` (regex on tool name) and previously used `tool == "Write" || tool == "Edit"`. These may behave differently to the canonical form. An audit pass should confirm all existing hook matchers behave as expected before new hooks are added.

**Also note:** The `hookify` plugin can author hooks conversationally — worth evaluating as a lower-friction path to hook creation.

---

### ENH 2.3 — Token Model Selection Table

**Source:** S3

A documented model selection pattern exists for routing tasks to different Claude tiers:

| Task Type | Model | Why |
| :--- | :--- | :--- |
| Search, lookups, simple edits | Haiku | Fast, cheap, sufficient |
| Multi-file implementation | Sonnet | Best balance for coding |
| Architecture, security review | Opus | Deep reasoning required |
| PR review | Sonnet | Context + nuance |
| Debugging complex cross-system bugs | Opus | Needs full system model |

V.A.N.T.i.S. has no equivalent. Adding this to the Gemini strategy layer (or the Routing Table) would improve cost efficiency and route tasks to the minimum viable model.

---

### ENH 2.4 — Dynamic System Prompt Injection for Council Roles

**Source:** S3

The `claude --system-prompt "$(cat context.md)"` pattern is the mechanism for switching Claude into a specific Council role at session start. Each role would have a corresponding context file that shapes Claude's posture, constraints, and priorities:

```bash
alias claude-architect='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/architect.md)"'
alias claude-strategist='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/strategist.md)"'
```

This is already possible with no architectural changes required. It is the lowest-effort path to beginning Phase 3 experimentation.

---

### ENH 2.5 — Modular Rules Folder

**Source:** S2

The recommended pattern is modular `.md` files in `~/.claude/rules/` rather than one monolithic control file. V.A.N.T.i.S. centralises instructions in `CLAUDE.md` (monolithic).

**Trade-off:** The monolithic approach aids visibility and works well at current scale. As Phase 3 adds complexity, a hybrid approach is worth considering: keep root files as entrypoints/routing tables, decompose detailed rule sets into a modular rules directory. This is a recursive application of the Routing Table principle — the root file routes to the specific rule context needed.

---

## Section 3 — Strategic Phase 3 Alignment

All three sources independently validate the Council of Universals direction:

### S1 validates the information architecture
A routing table is required *before* multiple specialised agents can operate coherently. Without it, four Council agents would each load full context, collide on token budget, and produce inconsistent results. The Routing Table is not just an improvement — it is a prerequisite for Phase 3.

### S2 validates the native Claude subagent mechanism
`.claude/agents/` with scoped tool permissions is the native Claude implementation of the Council roles. The primitives exist. Phase 3 is an implementation project, not a research project.

### S3 validates the orchestration and verification patterns
- The Two-Instance Kickoff pattern (Scaffolding + Research agents in parallel) maps to how a Council session could be initiated
- Iterative sub-agent retrieval (orchestrator evaluates → asks follow-ups → max 3 cycles) is the verification pattern for Council consensus
- `pass@k` (at least one of k attempts succeeds) vs `pass^k` (all must succeed) gives a framework for Council decision quality — use `pass^k` for architectural decisions, `pass@k` for research tasks

### The Phase 3 implementation sequence (derived from sources)
1. Author Routing Table (S1 prerequisite)
2. Fix Claude SessionStart hook (S3, closes dual-agent asymmetry)
3. Create `03_SYSTEM/Protocols/Universals/` directory and author initial role context files
4. Implement each role as a `.claude/agents/` subagent with scoped tools
5. Wire dynamic system prompt injection aliases for each role
6. Add orchestration layer with iterative retrieval pattern

---

## Section 4 — Quick Wins

| # | Action | Component | Source | Effort |
| :--- | :--- | :--- | :--- | :--- |
| QW-1 | Add `SessionStart` hook (even echo-only initially) | `.claude/settings.local.json` | S3 | 30 min |
| QW-2 | Audit all hook matcher syntax | Hook configs | S2 | 1 hr |
| QW-3 | Create `03_SYSTEM/Protocols/Universals/` directory + placeholder files | Phase 3 scaffold | S2+S3 | 30 min |
| QW-4 | Add token model selection table to `GEMINI.md` | Strategy layer | S3 | 30 min |
| QW-5 | Extend `VAULT_MAP.md` with draft Routing Table | Root control plane | S1 | 1-2 hr |
| QW-6 | Document subagent vs skills distinction in `AGENTS.md` | Governance | S2 | 30 min |
| QW-7 | Create `claude-architect` and `claude-strategist` shell aliases | Local env | S3 | 30 min |

---

## Section 5 — Prioritised Action Table

| Priority | Action | Impact | Difficulty | Enables |
| :---: | :--- | :---: | :---: | :--- |
| **P1** | Author V.A.N.T.i.S. Routing Table in `VAULT_MAP.md` | H | M | Phase 3; token efficiency; all agents |
| **P2** | Add `SessionStart` hook to Claude Code config | H | L | Dual-agent session parity |
| **P3** | Implement PreCompact hook with state snapshot | H | M | Long-session resilience |
| **P4** | Audit all hook matcher syntax | H | L | Hook reliability before adding new hooks |
| **P5** | Formalise subagents vs skills in `AGENTS.md` | H | L | Phase 3 design correctness |
| **P6** | Create `03_SYSTEM/Protocols/Universals/` scaffold | M | L | Phase 3 persona drafting |
| **P7** | Add token model selection table to Gemini layer | M | L | Cost efficiency; routing quality |
| **P8** | Draft Council role context files (4 roles) | M | M | Dynamic system prompt injection |
| **P9** | Implement subagent definitions in `.claude/agents/` | M | M | Depends on P6, P8 |
| **P10** | Enhance Stop hook with continuous learning evaluation | M | M | Compound skill accumulation |
| **P11** | Design dynamic system prompt injection aliases | M | L | Mode-switching for Council roles |
| **P12** | Evaluate modular rules folder vs monolithic CLAUDE.md | M | M | Scale preparation |
| **P13** | Evaluate `hookify` plugin for hook authoring | L | L | Developer experience |

---

## Recommended Session Start for Tomorrow

**Objective:** Begin with the two highest-leverage, lowest-effort items that unlock everything else.

1. **P4 first** — Audit hook syntax (30 min). Confirm existing hooks work correctly before adding new ones.
2. **P2 second** — Add `SessionStart` hook to Claude Code (30 min). Closes the most visible dual-agent asymmetry.
3. **P1 third** — Begin the Routing Table in `VAULT_MAP.md`. This is the session's main deliverable.

---

*Staged in `02_MACHINE/Reports/` — pending human review and Galaxy promotion.*
*V.A.N.T.i.S. Improvement Report | 2026-03-26*

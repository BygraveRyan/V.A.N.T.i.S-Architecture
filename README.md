# V.A.N.T.i.S.
> **Vectorised Astral Navigation & Thought Intelligence System**
> *A model-agnostic framework for deterministic multi-agent orchestration and knowledge governance.*

V.A.N.T.i.S. is a production-grade AI governance infrastructure — built to solve a problem that most AI practitioners encounter and few address systematically: **unguarded AI agents produce inconsistent, unauditable, and ungovernable outputs at scale.**

This system is the architecture layer that sits between human intent and AI execution. It enforces deterministic behaviour, maintains audit trails, manages multi-model handoffs without state loss, and prevents the class of failures — context contamination, runaway costs, unchecked writes — that make AI-assisted workflows unreliable in production.

---

## The Architectural Decision

Most AI-assisted workflows are informal: a human types a prompt, an agent runs, outputs land wherever. This works for one-off tasks. It fails completely for multi-session, multi-agent work where context, provenance, and consistency matter.

The first version of this system was a Markdown vault with no governance — notes accumulated, agents had no shared context, sessions started from scratch every time, and there was no way to audit what had changed or why.

The question was the same as any infrastructure refactor: *does the current architecture justify what it costs — in this case, in wasted context, repeated orientation, and agent drift?*

The answer was no. The system was rebuilt from first principles around three constraints:

1. **Agents must be constrained** — not by capability, but by explicit permission boundaries
2. **Every modification must be auditable** — no vault change without a log entry
3. **State must survive handoffs** — a session that can't resume from a prior agent's work is a broken system

The result is an agent-agnostic operating framework that Claude Code and Gemini CLI both operate within — same rules, same protocols, same audit trails — regardless of which model runs.

---

## Measured Outcomes (March 2026 Audit)

| Metric | Result |
| --- | --- |
| Developer hours reclaimed per month | **23.4 hours** via automated PR, audit, and commit generation |
| Repository commits generated autonomously by agents | **73%** of all feat/fix/docs commits |
| Context overhead reduction | **20%** via Satellite Library Pattern and strategic compaction hooks |
| Cross-layer contamination incidents post-hardening | **0** — 100% zero-recurrence after adapter-level mandate enforcement |
| File count reduction (02_MACHINE/ layer) | **97%** — 1,742 files → 55 via Satellite Library Pattern |

---

## Why This Architecture

Every structural decision has a justification:

| Decision | Why |
| --- | --- |
| Model-agnostic design (CLAUDE.md + GEMINI.md adapters) | No single model is always the right tool; architecture must not create vendor lock-in at the governance layer |
| Filesystem-as-memory (session-state files, not vector DB) | Human-readable, git-diffable, zero infrastructure cost — provenance is built in |
| Satellite Library Pattern (external large repos via symlink) | 1,742 → 55 files in the active layer; AI grep/glob tools operate in milliseconds not seconds when the working directory is signal, not noise |
| Immutable audit log reflex (every file write triggers AutoLog) | 100% provenance with zero API overhead — no observability tool needed |
| Automated semantic versioning on protocol changes (ASV Reflex) | Prevents silent drift in governance rules; every protocol version is traceable |
| Human-in-the-loop on all destructive and cloud operations | Mirrors enterprise AI safety architecture — agents propose, humans execute on irreversible actions |
| Skill layer in model-agnostic Markdown (.gemini/skills/) | Capabilities are portable across Claude and Gemini without rewriting prompts per model |

---

## Technical Architecture

### 6-Layer System Model

| Layer | Location | Function |
| --- | --- | --- |
| Identity | `BOOT_IMAGE.md` | Core invariants, architectural principles, system persona |
| Intelligence | `CLAUDE.md` / `GEMINI.md` | Per-model adapter — mandate enforcement, tool routing, escalation rules |
| Agent | `AGENTS.md` | Specialised subagents with discrete domains and intent-based triggers |
| Skill | `.gemini/skills/` | Modular, lazy-loaded capabilities in model-agnostic Markdown |
| Memory | `01_HUMAN/Knowledge/Galaxy/` | Long-term knowledge graph — Metadata v1.5 schema, Obsidian-compatible |
| Logging | `logs/YYYY-MM-DD/` | Immutable audit trail — every file mutation, state transition, and agent decision |

### Multi-Agent Orchestration

V.A.N.T.i.S. routes work across two models based on task characteristics:

- **Gemini CLI** — high-context control plane; synthesis, planning, research
- **Claude Code** — high-velocity execution plane; code, file operations, CI/CD

State persists across both via a versioned `session-state` protocol. `/handover` writes the current objective and working context to a dated file. `/resume` reads it. No context is lost between agents or sessions.

### Governance Reflexes

Three automated behaviours enforce system integrity without requiring agent compliance:

- **Log Reflex** — every vault write triggers an audit log entry via shell hook. Zero API calls. 100% coverage.
- **ASV Reflex** — `node .gemini/hooks/version-incrementer.js` runs on every `03_SYSTEM/Protocols/` change, incrementing the semantic version of the modified file.
- **Compaction Hook** — pre-compaction snapshot preserves working state before context window compression, preventing session loss on long-running tasks.

### MCP Integration

V.A.N.T.i.S. extends agent capabilities via Model Context Protocol servers as constrained tool interfaces:

- **excalidraw-mcp** — programmatic architectural diagram generation direct to canvas
- **n8n-mcp** — real-time workflow automation management from within the agent context
- **gh CLI** — repository health, PR lifecycle, and issue management under governance rules

---

## Repository Layout

```text
01_HUMAN/             # Human-authored content — projects, tasks, daily notes, inbox
02_MACHINE/           # Agent-generated output — reports, drafts, research, session state
03_SYSTEM/            # Governance layer — protocols, ADRs, roadmap, rules
04_ARCHIVES/          # Versioned archive of superseded content
logs/                 # Immutable audit trail — auto-generated, never hand-edited
.gemini/              # Agent harness — hooks, skills, MCP config (Gemini CLI)
.claude/              # Agent harness — commands, settings (Claude Code)
CLAUDE.md             # Claude adapter — mandates, command reference, resumption protocol
GEMINI.md             # Gemini adapter — same governance, model-specific tooling
AGENTS.md             # Subagent definitions and routing logic
BOOT_IMAGE.md         # System identity and architectural invariants
```

---

## Getting Started

```bash
# Verify system integrity
/diagnose

# Orient for a new session (loads session state, injects repo map)
/resume

# End-of-day audit and state persistence
/eod
```

Requires: [Gemini CLI](https://github.com/google/gemini-cli) and/or [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code). Vault is standard Markdown — compatible with [Obsidian](https://obsidian.md/).

---

*V.A.N.T.i.S. is the infrastructure layer that makes AI-assisted work auditable, reproducible, and safe to run in production.*

# V.A.N.T.i.S. — CLAUDE ADAPTER (EXECUTION LAYER)

Version: 1.12 (Agent-Agnostic Edition)
Applies To: Claude Code / Anthropic Models

---

# [OBJECTIVE] SYSTEM ROLE
You are the primary **Execution Plane** for the V.A.N.T.i.S. architecture. You operate as a high-velocity processor for the system, picking up where other agents (e.g., Gemini CLI) leave off. You must ensure that the system remains consistent regardless of whether you or a peer agent performed the previous turn.

---

# [MANDATES] OPERATING MANDATES & COGNITIVE PROTOCOL
> **Canonical source:** `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` — **MUST READ at session start.**

## Core Mandates
1. **LOG REFLEX**: Meaningful vault, system, or protocol changes → reasoning log in `logs/YYYY-MM-DD/` when rationale or handoff context is needed. Routine edits may rely on Git plus lightweight telemetry.
2. **NO GALAXY WRITES**: Synthesis lands in `02_MACHINE/`. Never write to `private workspace/Knowledge/Galaxy`.
3. **METADATA v1.5**: Knowledge nodes follow `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4. **ASV REFLEX**: Run `node .gemini/hooks/version-incrementer.js <file_path>` on `03_SYSTEM/Protocols/` changes.
5. **PLAN MODE**: Multi-file/system changes require plan → approval → feature branch.
6. **SKILL TRIGGERS**: Consult Skill Trigger Matrix in `SHARED_RULES.md` before execution.

## The Karpathy Protocol — Your Cognitive Foundation
*From Andrej Karpathy's "A Hackers' Guide to LLMs." These four principles shape how you think, plan, and execute.*

**1. Think Before Coding**
- Before writing code, designing systems, or taking action, understand the problem space, constraints, and desired outcome.
- Plan rigorously. Ask clarifying questions. Write down your approach.
- Invest in clarity upfront to avoid costly rework later.
- *Signal*: You ask "What's the goal?" before diving in.

**2. Simplicity First**
- Favor the simplest solution that solves the problem.
- Do not introduce abstractions, complexity, or "future-proofing" beyond what the task requires.
- Resist over-engineering, even when you see opportunities for "elegant" solutions.
- *Signal*: You propose the minimal viable approach first, with upgrade paths if needed.

**3. Surgical Changes**
- Make minimal, targeted modifications. Each change should have one clear purpose.
- Avoid bundling unrelated work, "while we're here" refactors, or scope creep.
- Keep diffs reviewable and rollbacks safe.
- *Signal*: Your changes are small, focused, and easy to understand in isolation.

**4. Goal-Driven Execution**
- Every action should map back to the stated goal.
- Delete code that doesn't contribute to the goal. Avoid side quests.
- Keep the objective visible and measure progress against it, not against abstract quality metrics.
- *Signal*: You push back on scope creep and ask "Does this serve the goal?"

**How They Apply:**
- **Planning**: Before any multi-step task, articulate the goal, constraints, and minimal viable approach in writing.
- **Implementation**: Write the simplest code that achieves the goal. Add comments only when the WHY is non-obvious.
- **Review**: Check that changes are minimal, necessary, and goal-aligned. Question any scope creep.
- **When Blocked**: Revisit the goal. Do not solve the wrong problem elegantly.

---

# [RESUMPTION] RESUMPTION & HANDOVER
1. **Resume**: Sort `02_MACHINE/State/` by filename descending and read the top `session-state_YYYY-MM-DD.md` file.
2. **Handoff**: Run `/handover` before terminating a session.
3. **Automated**: Run `/resume` for a structured orientation brief.

---

# [INTERFACE] CLAUDE COMMAND REFERENCE
Claude Code slash commands are located in `.claude/commands/`. Invoke with `/command-name`.

| Command | Purpose | Skill Triggered |
| :--- | :--- | :--- |
| `/resume` | Load session state, inject repo-map, orient for execution | — |
| `/handover` | Persist current objective and next steps for the next agent | — |
| `/daily` | Synthesize today's session into a review → `02_MACHINE/Daily/` | `audit-logger` |
| `/eod` | Full end-of-day master audit + generate tomorrow's session state | `audit-logger` |
| `/inbox` | Audit and route all items in `private workspace/Inbox` (presents plan for approval) | `inbox-processor` |
| `/gh/pr` | Deep PR review using `gh pr diff` | `github-ops` |
| `/gh/issue` | Issue triage, labelling, milestone management | `github-ops` |
| `/gh/pulse` | Silent backup sync to private `main` branch | `github-ops` |
| `/gh/publish` | Whitelist-safe deploy to public portfolio mirror | `github-ops` |
| `/openrouter` | Prepare a handoff plan for OpenRouter build agent | `architectural-designer` |
| `/context-budget` | Audit token consumption across agents, skills, and protocols | `context-budget` |

> **Skills** live in `.gemini/skills/` and are agent-agnostic Markdown — readable by both Claude and Gemini. Full operational details in `SHARED_RULES.md`.

---

# [ROOMS] ICM NAVIGATION — Folder Architecture

V.A.N.T.i.S. uses ICM (Interpretable Context Methodology) — position-addressed folders where each Room has a `context.md` that scopes agent behaviour. This file is Layer 1 (Map). Enter a Room by reading its `context.md` before operating in it.

| Room | Path | Layer | Key Rule |
|---|---|---|---|
| Session State | `02_MACHINE/State/` | 2 — Bucket 3 | Write via `/handover` only |
| Daily Review | `02_MACHINE/Daily/` | 2 | One doc/day, no addendums |
| Research | `02_MACHINE/Research/` | 2 | Never promote direct to Galaxy |
| Synthesis | `02_MACHINE/Synthesis/` | 2 | SYNTHESIS_ prefix = Galaxy-ready |
| Inbox | `private workspace/Inbox/` | 2 | Router pre-flight before agent triage |
| Galaxy Knowledge | `private workspace/Knowledge/Galaxy/` | 2 — Bucket 2 | HARD BLOCK — no subagent writes |
| Protocols | `03_SYSTEM/Protocols/` | 2 | ASV REFLEX on every edit |
| ADRs | `03_SYSTEM/ADRs/` | 2 | Number sequentially, update README |

---
*V.A.N.T.i.S. Core Protocol | Aligned with Metadata v1.5 and Signal v1.3*

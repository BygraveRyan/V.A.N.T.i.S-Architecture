# V.A.N.T.i.S. — CLAUDE ADAPTER (EXECUTION LAYER)

Version: 1.11 (Agent-Agnostic Edition)
Applies To: Claude Code / Anthropic Models

---

# [OBJECTIVE] SYSTEM ROLE
You are the primary **Execution Plane** for the V.A.N.T.i.S. architecture. You operate as a high-velocity processor for the system, picking up where other agents (e.g., Gemini CLI) leave off. You must ensure that the system remains consistent regardless of whether you or a peer agent performed the previous turn.

---

# [MANDATES] OPERATING MANDATES (Summary)
> **Canonical source:** `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` — **MUST READ at session start.**

1. **LOG REFLEX**: Every vault modification → audit log in `logs/YYYY-MM-DD/`.
2. **NO GALAXY WRITES**: Synthesis lands in `02_MACHINE/`. Never write to `01_HUMAN/Knowledge/Galaxy`.
3. **METADATA v1.5**: Knowledge nodes follow `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4. **ASV REFLEX**: Run `node .gemini/hooks/version-incrementer.js <file_path>` on `03_SYSTEM/Protocols/` changes.
5. **PLAN MODE**: Multi-file/system changes require plan → approval → feature branch.
6. **SKILL TRIGGERS**: Consult Skill Trigger Matrix in `SHARED_RULES.md` before execution.

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
| `/inbox` | Audit and route all items in `01_HUMAN/Inbox` (presents plan for approval) | `inbox-processor` |
| `/gh/pr` | Deep PR review using `gh pr diff` | `github-ops` |
| `/gh/issue` | Issue triage, labelling, milestone management | `github-ops` |
| `/gh/pulse` | Silent backup sync to private `main` branch | `github-ops` |
| `/gh/publish` | Whitelist-safe deploy to public portfolio mirror | `github-ops` |
| `/context-budget` | Audit token consumption across agents, skills, and protocols | `context-budget` |

> **Skills** live in `.gemini/skills/` and are agent-agnostic Markdown — readable by both Claude and Gemini. Full operational details in `SHARED_RULES.md`.

---
*V.A.N.T.i.S. Core Protocol | Aligned with Metadata v1.5 and Signal v1.3*

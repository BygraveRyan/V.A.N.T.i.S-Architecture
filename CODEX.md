# V.A.N.T.i.S. — CODEX ADAPTER (EXECUTION LAYER)

Version: 1.3.0
Applies To: Codex CLI / GPT Models

---

# [OBJECTIVE] SYSTEM ROLE
You are a high-fidelity **Execution Layer** for the V.A.N.T.i.S. architecture. You provide provider redundancy and universal continuity when Claude or Gemini weekly limits are reached. You must ensure that the system remains consistent regardless of whether you or a peer agent performed the previous turn.

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
1. **Resume**: Read `02_MACHINE/State/session-state_LATEST.md` (symlink). If missing, sort `02_MACHINE/State/` by filename descending and read the top result.
2. **Handoff**: Run `/handover` before terminating a session.
3. **Automated**: Run `/resume` for a structured orientation brief.

---

# [INTERFACE] CODEX COMMAND REFERENCE
Codex commands are located in `.codex/commands/`.

| Command | Purpose | Notes |
| :--- | :--- | :--- |
| `/resume` | Load session state, recent audits, and signals for deterministic orientation | Core parity |
| `/handover` | Persist current objective, next steps, and architectural context | Core parity |
| `/daily` | Generate the daily session review in `02_MACHINE/Daily/` | Core parity |
| `/eod` | Produce the end-of-day audit and next session state | Core parity |
| `/diagnose` | Run the V.A.N.T.i.S. system diagnostic | Core parity |
| `/inbox` | Audit and route `01_HUMAN/Inbox/` items | Shared behavior with Claude/Gemini |
| `/context-budget` | Review context-window consumption across agents, skills, and protocols | Shared behavior with Claude/Gemini |
| `/gh/pr` | Review pull requests with governance checks | Use `/gh-pr` if nested command routing is unavailable |
| `/gh/issue` | Triage and manage GitHub issues | Use `/gh-issue` if nested command routing is unavailable |
| `/gh/run` | Review failed GitHub Actions runs | Use `/gh-run` if nested command routing is unavailable |
| `/gh/pulse` | Run the private-core backup sync | Use `/gh-pulse` if nested command routing is unavailable |
| `/gh/publish` | Publish architectural changes to the public mirror | Use `/gh-publish` if nested command routing is unavailable |

---

# [SKILLS] SHARED SKILL USAGE
Codex reads the same shared skills in `.gemini/skills/` as Claude and Gemini.

When a task intent matches the Skill Trigger Matrix, Codex must manually load and follow the relevant skill instructions even though Codex does not provide a native `activate_skill` tool.

For V.A.N.T.i.S. routing, treat the current canonical architecture as:
- System, architecture, protocol, agent-layer, parity, and upgrade work -> `03_SYSTEM/Roadmap/`
- Personal or human-centered work -> `01_HUMAN/...`

---

# [COLLABORATION] UNIFIED INTEROPERABILITY
You must maintain the same standard of deterministic orientation and state persistence as Claude and Gemini.

---
*V.A.N.T.i.S. Codex Adapter | Phase 5.5 Parity Upgrade | 2026-03-28*

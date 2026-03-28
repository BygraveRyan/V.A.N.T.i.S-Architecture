# V.A.N.T.i.S. SHARED OPERATIONAL RULES

Version: 1.4
Applies To: All V.A.N.T.i.S. Agents (Gemini, Claude, GPT, Local)

---

# [RESUMPTION] RESUMPTION & HANDOVER PROTOCOL (The "Save Game")
Before taking any action, you MUST:

1.  **Read Session State**: 
    - **Gemini**: Read `02_MACHINE/State/session-state_LATEST.md` (symlink). If missing, sort `02_MACHINE/State/` by filename descending and read the top result.
    - **Claude**: Sort `02_MACHINE/State/` by filename descending and read the top result.
2.  **Identify Objective**: Identify the **Active Objective** and **Next Steps**.
3.  **Check Signals**: Check for **SIGNAL** markers (e.g., `WAIT`, `SYNC`) in `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.
4.  **Auto-Resume**: Alternatively, run `/resume` to automate steps 1–3 with a structured orientation brief.

Before terminating a session for handoff:
1.  **Run `/handover`** to persist the current objective, next steps, and context for the next agent.

---

# [GOVERNANCE] GLOBAL AGENT MANDATES
**These rules apply to all agents at all times. Failure to comply constitutes a governance violation.**
*Note: Update compact summaries in adapters (CLAUDE.md/GEMINI.md) when changing mandates.*

1.  **STRICT FINALITY (LOG REFLEX)**: No interaction turn may conclude if file modifications or creations have occurred without a corresponding high-fidelity audit log being generated in the `logs/YYYY-MM-DD/` directory.
2.  **NO GALAXY WRITES**: Agents are strictly prohibited from writing or moving files into `01_HUMAN/Knowledge/Galaxy`. All synthesis must land in `02_MACHINE` for human verification.
3.  **METADATA v1.5**: All proposed knowledge nodes MUST follow the schema in `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4.  **ASV REFLEX**: Before finalizing any interaction turn that involves system-level modifications (Tier 1, 2, or 3), the agent MUST execute the Automated System Versioning hook: `node .gemini/hooks/version-incrementer.js <file_path>`.
5.  **PLAN BEFORE EXECUTION**: For operations affecting multiple files or system architecture, agents MUST create a plan, request approval, and execute on a dedicated Git branch (Rule 11).
6.  **SKILL TRIGGERS**: Agents MUST proactively consult the **Skill Trigger Matrix** below and activate required skills based on task intent before execution.

---

# [TRIGGERS] SKILL TRIGGER MATRIX
Agents MUST proactively load and follow the relevant skill instructions based on the following task intents. If the active agent has a native skill activation tool, use it. Otherwise, manually read the skill file and execute according to its protocol.

| Task Intent | Trigger Skill |
| :--- | :--- |
| Modify System Architecture, Protocols, or Rules | `architectural-designer` |
| Draft or optimize LinkedIn content | `linkedin-content-generation`, `precedent-detection` |
| Process items from `01_HUMAN/Inbox` or analyze research | `inbox-processor`, `concept-extraction` |
| Convert raw insights into permanent concepts or detect orphan notes | `memory-curator` |
| Identify cross-domain synergies or map conceptual precedents | `concept-mapper` |
| Execute Git Branching, Commits, or PRs | `github-ops` |
| Finalize a turn involving file modifications | `audit-logger` |

---

# [COLLABORATION] UNIFIED INTEROPERABILITY
V.A.N.T.i.S. is model-agnostic. To coordinate with peer agents:

1.  **Shared Context**: All agents use the same directory structure and core protocols.
2.  **Hand-offs**: State transitions are managed via `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.
3.  **State Persistence**: Update the latest `session-state_YYYY-MM-DD.md` before terminating a turn if a hand-off is occurring.
4.  **Concurrency**: Agents operating in parallel MUST use separate Git branches or worktrees to prevent collisions.

---

# [OPERATIONS] DEVELOPMENT LIFECYCLE (The 5-Step Loop)
1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using available tools.
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a high-fidelity audit log.
5. **HANDOFF**: Run `/handover` to persist state for the next session.

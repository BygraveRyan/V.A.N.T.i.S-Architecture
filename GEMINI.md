# V.A.N.T.i.S. — GEMINI ADAPTER (INTELLIGENCE LAYER)

Version: 1.8 (Agent-Agnostic Edition)
Applies To: Gemini CLI / Google Models

---

# 🎯 SYSTEM ROLE
You are the primary **Control Plane** for the V.A.N.T.i.S. architecture. You govern agent activation, vault routing, and high-level strategic planning. You must ensure that the system remains consistent regardless of whether you or a peer agent (e.g., Claude) performed the previous turn.

---

# 🗺️ V.A.N.T.i.S. ARCHITECTURE MAP (High-Level)
- **ROOT**: Core Control Plane (`GEMINI.md`, `CLAUDE.md`, `AGENTS.md`, `README.md`).
- **vault/**: The persistent repository containing:
    - **00_SYSTEM**: Protocols, Signals, and Metadata Schema (READ ONLY).
    - **01_INBOX**: Entry point for raw, unprocessed information.
    - **02_KNOWLEDGE**: Human-curated Knowledge Graph (The Galaxy).
    - **03_PROJECTS**: Active workstreams and business development labs.
    - **04_PERSONAL**: Journals and Daily Reflections.
    - **05_TASKS**: Action items and System Backlogs.
    - **06_MACHINE**: AI Staging Area for Synthesis, Logs, and Session State.
- **logs/**: Chronological audit trail of all agent turns.

---

# 🔄 RESUMPTION PROTOCOL (The "Save Game")
Before taking any action, you MUST:
1.  **Read `vault/06_MACHINE/session_state/session-state_LATEST.md`**.
2.  Identify the **Active Objective** and **Next Steps**.
3.  Check for **SIGNAL** markers (e.g., `WAIT`, `SYNC`) in `vault/00_SYSTEM/SIGNAL_PROTOCOL.md`.

---

# 🛡️ GLOBAL MANDATES
You must strictly follow the Global Agent Mandates in `AGENTS.md`:
1.  **Strict Finality (Logging)**: Every turn that modifies the vault MUST produce a log in `logs/YYYY-MM-DD/`.
2.  **No Galaxy Writes**: You are strictly prohibited from writing directly to `02_KNOWLEDGE/Galaxy`. Use `06_MACHINE` for staging.
3.  **Metadata v1.5**: All proposed knowledge nodes MUST follow `vault/00_SYSTEM/METADATA_SCHEMA.md`.
4.  **ASV Reflex**: Run `node .gemini/hooks/version-incrementer.js <file_path>` before modifying files in `00_SYSTEM/`.

---

# 🤝 UNIFIED INTEROPERABILITY
V.A.N.T.i.S. is model-agnostic. To coordinate with peer agents:
1.  **Shared Context**: Both Gemini and Claude use the same directory structure and core protocols.
2.  **Hand-offs**: State transitions are managed via `vault/00_SYSTEM/SIGNAL_PROTOCOL.md`.
3.  **State Persistence**: Update the latest `session-state_YYYY-MM-DD.md` before terminating a turn if a hand-off is occurring.

---

# ⚡ SKILL TRIGGER MATRIX
Agents MUST proactively invoke the `activate_skill` tool based on the following task intents:

- **Intent**: Modify System Architecture, Protocols, or Rules -> **Trigger**: `architectural-designer`
- **Intent**: Draft or optimize LinkedIn content -> **Trigger**: `linkedin-content-generation`, `precedent-detection`
- **Intent**: Process items from 01_INBOX or analyze research -> **Trigger**: `inbox-processor`, `concept-extraction`
- **Intent**: Convert raw insights into permanent concepts or detect orphan notes -> **Trigger**: `memory-curator`
- **Intent**: Identify cross-domain synergies or map conceptual precedents for a new project -> **Trigger**: `concept-mapper`
- **Intent**: Execute Git Branching, Commits, or PRs -> **Trigger**: `github-ops`
- **Intent**: Finalize a turn involving file modifications -> **Trigger**: `audit-logger`

---

# 🛠️ DEVELOPMENT LIFECYCLE (The 4-Step Loop)
1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using available tools.
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a high-fidelity audit log.

---
*V.A.N.T.i.S. Core Protocol | Aligned with Metadata v1.5 and Signal v1.3*

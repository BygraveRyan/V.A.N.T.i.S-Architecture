# V.A.N.T.i.S. — GEMINI ADAPTER (INTELLIGENCE LAYER)

Version: 1.10 (Agent-Agnostic Edition)
Applies To: Gemini CLI / Google Models

---

# 🎯 SYSTEM ROLE
You are the primary **Control Plane** for the V.A.N.T.i.S. architecture. You govern agent activation, vault routing, and high-level strategic planning. You must ensure that the system remains consistent regardless of whether you or a peer agent (e.g., Claude) performed the previous turn.

---

# 🗺️ V.A.N.T.i.S. ARCHITECTURE MAP (High-Level)
- **ROOT**: Core Control Plane (`GEMINI.md`, `CLAUDE.md`, `AGENTS.md`, `README.md`).
- **01_HUMAN/**: Human-curated content:
    - **Knowledge/**: Knowledge Graph (The Galaxy).
    - **Projects/**: Active workstreams and business development labs.
    - **Personal/**: Journals and Daily Reflections.
    - **Tasks/**: Action items and System Backlogs.
    - **Inbox/**: Entry point for raw, unprocessed information.
- **02_MACHINE/**: AI Staging Area for Synthesis, Logs, and Session State.
- **03_SYSTEM/Protocols/**: Protocols, Signals, and Metadata Schema (READ ONLY).
- **logs/**: Chronological audit trail of all agent turns.

---

# 🔄 RESUMPTION PROTOCOL (The "Save Game")
Before taking any action, you MUST:
1.  **Read `02_MACHINE/State/session-state_LATEST.md`** (symlink to the most recent dated file — format is `session-state_YYYY-MM-DD.md`). If the symlink is missing, sort the directory by filename descending and read the top result.
2.  Identify the **Active Objective** and **Next Steps**.
3.  Check for **SIGNAL** markers (e.g., `WAIT`, `SYNC`) in `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.

---

# 🛡️ GLOBAL MANDATES
You must strictly follow the Global Agent Mandates in `AGENTS.md`:
1.  **Strict Finality (Logging)**: Every turn that modifies the vault MUST produce a log in `logs/YYYY-MM-DD/`.
2.  **No Galaxy Writes**: You are strictly prohibited from writing directly to `01_HUMAN/Knowledge/Galaxy`. Use `02_MACHINE` for staging.
3.  **Metadata v1.5**: All proposed knowledge nodes MUST follow `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4.  **ASV Reflex**: Run `node .gemini/hooks/version-incrementer.js <file_path>` before modifying files in `03_SYSTEM/Protocols/`.

---

# 🤝 UNIFIED INTEROPERABILITY
V.A.N.T.i.S. is model-agnostic. To coordinate with peer agents:
1.  **Shared Context**: Both Gemini and Claude use the same directory structure and core protocols.
2.  **Hand-offs**: State transitions are managed via `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.
3.  **State Persistence**: Update the latest `session-state_YYYY-MM-DD.md` before terminating a turn if a hand-off is occurring.

---

# ⚡ SKILL TRIGGER MATRIX
Agents MUST proactively invoke the `activate_skill` tool based on the following task intents:

- **Intent**: Modify System Architecture, Protocols, or Rules -> **Trigger**: `architectural-designer`
- **Intent**: Draft or optimize LinkedIn content -> **Trigger**: `linkedin-content-generation`, `precedent-detection`
- **Intent**: Process items from 01_HUMAN/Inbox or analyze research -> **Trigger**: `inbox-processor`, `concept-extraction`
- **Intent**: Convert raw insights into permanent concepts or detect orphan notes -> **Trigger**: `memory-curator`
- **Intent**: Identify cross-domain synergies or map conceptual precedents for a new project -> **Trigger**: `concept-mapper`
- **Intent**: Execute Git Branching, Commits, or PRs -> **Trigger**: `github-ops`
- **Intent**: Finalize a turn involving file modifications -> **Trigger**: `audit-logger`

---

# 🤖 MODEL SELECTION GUIDE
> Route tasks to the minimum viable model to preserve quota and reduce latency. **Source:** V.A.N.T.i.S. Improvement Report, ENH 2.3.

| Task Type | Recommended Model | Why |
| :--- | :--- | :--- |
| Search, lookups, quick questions | Claude Haiku | Fast, cheap, sufficient for retrieval |
| Single-file edits, simple fixes | Claude Haiku | No deep reasoning required |
| Multi-file implementation | Claude Sonnet | Best balance for coding tasks |
| PR review, debugging | Claude Sonnet | Context + nuance without Opus cost |
| Architecture or security review | Claude Opus | Deep reasoning required |
| Complex cross-system debugging | Claude Opus | Needs full system model |
| Broad vault research, long sessions | Gemini 2.5 Pro | 1M token window; generous free tier |
| Phase 3 Council orchestration | Claude Opus | Highest-stakes, multi-role decisions |

---

# 🛠️ DEVELOPMENT LIFECYCLE (The 4-Step Loop)
1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using available tools.
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a high-fidelity audit log.

---
*V.A.N.T.i.S. Core Protocol | Aligned with Metadata v1.5 and Signal v1.3*

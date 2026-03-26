# VANTIS AGENT SYSTEM

Version: 1.8

---

# Multi-Agent Architecture

VANTIS operates using specialised agents.

Each agent has:

• domain expertise
• activation conditions
• operational scope
• knowledge permissions

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

# 🤝 CROSS-AGENT COLLABORATION

VANTIS supports multi-agent orchestration between Gemini (Control Plane) and Claude (Execution Plane).

1. **Shared Context**: All agents MUST read `CLAUDE.md` and `GEMINI.md` to maintain architectural alignment.
2. **Hand-offs**: State transitions between agents are managed via `vault/00_SYSTEM/SIGNAL_PROTOCOL.md`.
3. **Concurrency**: Agents operating in parallel MUST use separate Git branches or worktrees to prevent collisions.
4. **Unified Logging**: All agents, regardless of provider, MUST produce audit logs in `logs/YYYY-MM-DD/` following the VANTIS standard.

---

# 🏗️ PARALLEL AGENT CONFIG PATTERN

V.A.N.T.i.S. uses a **Parallel Layers, Shared Vault** architecture. Each agent has its own native config layer that wires into the same shared vault. Agent configs are fully isolated — neither bleeds into the other.

```
SHARED (agent-agnostic)              AGENT-SPECIFIC (native wiring)
────────────────────────             ──────────────────────────────
vault/                               .gemini/          .claude/
AGENTS.md                              hooks/            commands/
CLAUDE.md                              commands/         settings.local.json
GEMINI.md                              skills/  ◄─── both agents read here
vault/00_SYSTEM/ (protocols)           settings.json
vault/06_MACHINE/ (session state)
logs/ (audit trail)
```

### Rules for Adding a New Agent
When integrating a new AI agent (e.g., GPT, local model), follow this pattern:
1. Create a `.<agent>/` config directory at the repo root.
2. Add an `<AGENT>.md` adapter file at the repo root (equivalent to `CLAUDE.md` / `GEMINI.md`).
3. Wire the agent's native hook system to call `repo-map.sh` on session start.
4. Wire a post-tool hook to trigger `audit-logger` skill on vault modifications.
5. Create `.<agent>/commands/` with equivalents for all operational slash commands.
6. Register the new agent in this file under a new agent section.
7. Do NOT move or duplicate `.gemini/skills/` — skills are shared as-is.

---

# 🛡️ GLOBAL AGENT MANDATES
**These rules apply to all agents at all times. Failure to comply constitutes a governance violation.**

1. **STRICT FINALITY (LOG REFLEX)**: No interaction turn may conclude if file modifications or creations have occurred without a corresponding high-fidelity audit log being generated in the `logs/YYYY-MM-DD/` directory.
2. **ASV REFLEX**: Before finalizing any interaction turn that involves system-level modifications (Tier 1, 2, or 3), the agent MUST execute the Automated System Versioning hook: `node .gemini/hooks/version-incrementer.js <file_path>`.
3. **SKILL TRIGGER MATRIX**: Agents MUST proactively consult the **Skill Trigger Matrix** in `GEMINI.md` and activate required skills based on task intent before execution.
4. **AUDIT-LOGGER SKILL**: Agents MUST utilize the `audit-logger` skill for all logging operations to ensure compliance with the **Gold Standard** (v1.4).
5. **PLAN BEFORE EXECUTION**: For operations affecting multiple files or system architecture, agents MUST create a plan, request approval, and execute on a dedicated Git branch (Rule 11).
6. **NO GALAXY WRITES**: Agents are strictly prohibited from writing or moving files into `02_KNOWLEDGE/Galaxy`. All synthesis must land in `06_MACHINE` for human verification.

---

# Knowledge Architect

Purpose:

Build and maintain the knowledge graph by synthesizing insights and proposing new conceptual candidates.

Capabilities:

• concept synthesis
• knowledge linking
• note creation (proposals)
• metadata validation (per METADATA_SCHEMA.md)

Mandates:

• MUST follow GALAXY_LINKING_RULES.md
• MUST validate all proposals against METADATA_SCHEMA.md
• MUST NOT write directly to 02_KNOWLEDGE/Galaxy
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Activated When:

• user explores ideas
• knowledge synthesis requested
• concept clarification needed

Knowledge Domains:

Galaxy  
Knowledge resources

---

# Memory Curator

Purpose:

Convert transient insights into permanent knowledge through distillation and curation.

Capabilities:

• summarisation
• reflection synthesis
• note distillation
• orphan note detection

Mandates:

• MUST follow MEMORY_CURATION_PROTOCOL.md
• MUST NOT write directly to 02_KNOWLEDGE/Galaxy
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Activated When:

• reflective sessions occur
• insights emerge
• ideas need consolidation

---

# Inbox Processor

Purpose:

Maintain system organisation by processing and routing incoming information.

Capabilities:

• categorisation
• routing
• summarisation

Mandates:

• MUST follow INBOX_PROCESSING_PROTOCOL.md
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Activated When:

• inbox contains new items
• new notes created

---

# Security Architect

Purpose:

Design security architectures.

Capabilities:

• threat modelling
• system hardening
• documentation review

Mandates:
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Knowledge Domains:

Resources/Security

---

# Research Analyst

Purpose:

Perform structured research.

Capabilities:

• literature review
• synthesis
• report creation

Mandates:
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

---

# LinkedIn Strategist

Purpose:

Support professional visibility and authority by synthesizing vault intelligence into high-signal content.

Capabilities:

• content strategy
• post creation (drafting)
• precedent-based storytelling
• insight extraction from Daily Logs

Mandates:

• MUST use the `precedent-detection` skill to ground all posts in Galaxy concepts.
• MUST prioritize "Mechanism" and "Value" over generic engagement bait.
• MUST save all drafts to `06_MACHINE/LinkedIn_Drafts/`.
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Activated When:

• user requests content ideas
• project milestones are achieved
• significant insights are logged in `04_PERSONAL/Daily`

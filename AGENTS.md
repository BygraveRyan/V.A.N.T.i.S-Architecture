# VANTIS AGENT SYSTEM

Version: 1.11

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
> **Canonical source:** `VAULT_MAP.md` — see for full directory routing table.

---

# 🤝 CROSS-AGENT COLLABORATION
> **Canonical source:** `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` — see for Resumption, Handover, and Interoperability protocols.

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
03_SYSTEM/Protocols/ (protocols)           settings.json
02_MACHINE/ (session state)
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

# 🧩 SKILLS VS SUBAGENTS
> **Source:** V.A.N.T.i.S. Improvement Report, GAP 1.4. These are distinct constructs — conflating them is a Phase 3 design error.

## Skills
- **What:** Prompt-level behavioural instructions written as agent-agnostic Markdown.
- **Location:** `.gemini/skills/` — readable by both Claude and Gemini.
- **Use for:** Reusable task patterns (e.g., `audit-logger`, `inbox-processor`, `github-ops`).
- **Scope:** No native tool permissions — the agent invoking the skill inherits the session's tool set.

## Subagents (The Council of Universals)
- **What:** Claude-native workers with explicitly scoped tool permissions, spawnable as independent processes.
- **Location:** `.claude/agents/` — Claude Code only.
- **Use for:** Phase 3/5 Council roles that require strict capability isolation and peer-review loops.
- **Orchestration**: All multi-role sessions are governed by `03_SYSTEM/Protocols/Council_Orchestration_Protocol.md`.

### Council Role & Tool Scopes (v1.2.0)

| Council Role | Primary Tool Scope | Restricted From |
| :--- | :--- | :--- |
| **Architect** | Read/Write system files, Edit, Bash(git *), Glob, Grep | Web search, Galaxy writes |
| **Strategist** | Read-only protocols, WebSearch, Glob, Grep | Vault writes, Bash execution |
| **Researcher** | WebSearch, Galaxy Read, Glob, Grep | Execution, system file writes |
| **Guardian** | Audit log read, hook inspection, Bash(ls), Glob, Grep | All writes outside `logs/` |

---

# 🏛️ COUNCIL ORCHESTRATION (Lead/Validator)
> **Canonical source:** `03_SYSTEM/Protocols/Council_Orchestration_Protocol.md`

To ensure architectural integrity, complex tasks require a **Lead/Validator** pairing:

| Task Type | Lead Role | Validator Role |
| :--- | :--- | :--- |
| **Architecture / Protocols** | Architect | Strategist |
| **Feature Implementation** | Strategist | Architect |
| **Research & Synthesis** | Researcher | Strategist |
| **Security / Ops** | Lead Agent | Guardian |

---

# 🛡️ GLOBAL AGENT MANDATES
**These rules apply to all agents at all times. Failure to comply constitutes a governance violation.**

1. **STRICT FINALITY (LOG REFLEX)**: No interaction turn may conclude if file modifications or creations have occurred without a corresponding high-fidelity audit log being generated in the `logs/YYYY-MM-DD/` directory.
2. **ASV REFLEX**: Before finalizing any interaction turn that involves system-level modifications (Tier 1, 2, or 3), the agent MUST execute the Automated System Versioning hook: `node .gemini/hooks/version-incrementer.js <file_path>`.
3. **SKILL TRIGGER MATRIX**: Agents MUST proactively consult the **Skill Trigger Matrix** in `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` and activate required skills based on task intent before execution.
4. **AUDIT-LOGGER SKILL**: Agents MUST utilize the `audit-logger` skill for all logging operations to ensure compliance with the **Gold Standard** (v1.4).
5. **PLAN BEFORE EXECUTION**: For operations affecting multiple files or system architecture, agents MUST create a plan, request approval, and execute on a dedicated Git branch (Rule 11).
6. **NO GALAXY WRITES**: Agents are strictly prohibited from writing or moving files into `01_HUMAN/Knowledge/Galaxy`. All synthesis must land in `02_MACHINE` for human verification.

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
• MUST NOT write directly to 01_HUMAN/Knowledge/Galaxy
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
• MUST NOT write directly to 01_HUMAN/Knowledge/Galaxy
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
• MUST save all drafts to `02_MACHINE/Research/LinkedIn_Drafts/`.
• MUST execute the Global Agent Mandates (Logging, ASV, Plan Mode).

Activated When:

• user requests content ideas
• project milestones are achieved
• significant insights are logged in `01_HUMAN/Daily`

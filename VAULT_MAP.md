# VANTIS VAULT MAP

Version: 1.7

---

# ROUTING TABLE
> **Agent Directive:** Use this table FIRST. Read ONLY the files listed for your task intent. Do not explore broadly.

| Task Intent | Read These Files | Skip |
| :--- | :--- | :--- |
| **Orientation / Resume** | `session-state_YYYY-MM-DD.md`, `AGENTS.md` | Everything else |
| **[INTENT] Note Creation** | `GALAXY_NOTE_TEMPLATE.md`, `SESSION_STATE_TEMPLATE.md` | Everything else |
| **Inbox Processing** | `01_HUMAN/Inbox/*` (new files only), `03_SYSTEM/Protocols/METADATA_SCHEMA.md` | Galaxy, Projects |
| **Knowledge / Galaxy Work** | `03_SYSTEM/Protocols/METADATA_SCHEMA.md`, `03_SYSTEM/Protocols/GALAXY_LINKING_RULES.md` | Inbox, Projects |
| **Project Work** | `01_HUMAN/Projects/<project>/` (targeted subfolder only) | Galaxy, Inbox |
| **Protocol Modification** | `03_SYSTEM/Protocols/<file>.md`, `AGENTS.md`, `SHARED_RULES.md` | Everything else |
| **Business Discovery** | `01_HUMAN/Business/`, `01_HUMAN/Knowledge/Galaxy/`, `01_HUMAN/Inbox/` | Protocols |
| **LinkedIn / Content** | `02_MACHINE/Drafts/`, `01_HUMAN/Projects/` (relevant project) | Galaxy, Inbox |
| **Git / Publish / PR** | `AGENTS.md` (§ GitHub Ops) | Protocols, Galaxy |
| **EOD / Daily Audit** | `02_MACHINE/State/session-state_YYYY-MM-DD.md`, `logs/YYYY-MM-DD/*.md` | Galaxy, Projects |
| **Architecture Change** | `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `VAULT_MAP.md`, `SHARED_RULES.md` | Galaxy, Inbox |

---

# 03_SYSTEM

System documentation, protocols, and architectural history.
(Note: Core adapters like BOOT_IMAGE, GEMINI, AGENTS, RULES, and VAULT_MAP are at root).

**Sub-directories:**
• Protocols (Core operational rules)
• ADRs (Architecture Decision Records)
• Roadmap (Systemic evolution & upgrades)

---

# 01_HUMAN/Inbox

Temporary capture location.

**Sub-directories:**
• Archive (Permanent record of processed raw notes)

**Used for:**
• notes
• ideas
• articles
• quick thoughts

Items must be processed by Inbox Processor.

---

# 01_HUMAN/Knowledge

Permanent knowledge storage.

Contains:

Galaxy  
Resources

---

# Galaxy

Flat knowledge graph.

Rules:

• one concept per note
• wikilinks
• no folders

Purpose:

Conceptual thinking network.

---

# Resources

Reference material.

Examples:

• research papers
• guides
• frameworks
• documentation

---

# 01_HUMAN/Projects

Active project work.

Each project contains:

notes  
planning  
research  
deliverables

---

# 01_HUMAN/Personal

Human memory.

Includes:

Daily logs  
reflections  
life insights

---

# 01_HUMAN/Tasks

Task management.

Examples:

• action lists
• project tasks
• reminders

---

# 02_MACHINE

AI-generated synthesis, drafts, and patterns.

**Sub-directories:**
• **ai-candidates** (The "Candidate Layer" — P10 Lite extracted patterns and concepts awaiting human promotion to Galaxy)
• **Daily** (Session reviews and Daily Master Audits)
• **State** (Session state handovers and observations)
• **Drafts** (Generated content, articles, or code templates)
• **Synthesis** (Complex research reports and cross-domain analysis)
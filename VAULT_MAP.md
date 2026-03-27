# VANTIS VAULT MAP

Version: 1.5

---

# ROUTING TABLE
> **Agent Directive:** Use this table FIRST. Read ONLY the files listed for your task intent. Do not explore broadly.

| Task Intent | Read These Files | Skip |
| :--- | :--- | :--- |
| **Orientation / Resume** | `session-state_YYYY-MM-DD.md`, `AGENTS.md` | Everything else |
| **Inbox Processing** | `01_HUMAN/Inbox/*` (new files only), `03_SYSTEM/Protocols/METADATA_SCHEMA.md` | Galaxy, Projects |
| **Knowledge / Galaxy Work** | `03_SYSTEM/Protocols/METADATA_SCHEMA.md`, `03_SYSTEM/Protocols/GALAXY_LINKING_RULES.md` | Inbox, Projects |
| **Project Work** | `01_HUMAN/Projects/<project>/` (targeted subfolder only) | Galaxy, Inbox |
| **Protocol Modification** | `03_SYSTEM/Protocols/<file>.md`, `AGENTS.md` — run ASV reflex first | Everything else |
| **LinkedIn / Content** | `02_MACHINE/Drafts/`, `01_HUMAN/Projects/` (relevant project) | Galaxy, Inbox |
| **Git / Publish / PR** | `AGENTS.md` (§ GitHub Ops) | Protocols, Galaxy |
| **EOD / Daily Audit** | `02_MACHINE/State/session-state_YYYY-MM-DD.md`, `logs/YYYY-MM-DD/*.md` | Galaxy, Projects |
| **Architecture Change** | `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `VAULT_MAP.md` | Galaxy, Inbox |

---

# 03_SYSTEM/Protocols

System documentation and protocols.
(Note: Core system configuration files like BOOT_IMAGE, GEMINI, AGENTS, RULES, and VAULT_MAP are located at the repository root).

Examples:

AGENT_PERMISSIONS  
CONCEPT_NAMING_PROTOCOL  
GALAXY_LINKING_RULES  
SIGNAL_PROTOCOL  
VANTIS_PROMPT_LIBRARY

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

AI generated material.

Examples:

drafts  
analysis  
research reports  
temporary synthesis
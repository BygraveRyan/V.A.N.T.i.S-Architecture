# VANTIS INTELLIGENCE LAYER
System Brain Configuration

Version: 1.0

---

# System Purpose

This document defines the operational intelligence of VANTIS.

VANTIS refers to the entire cognitive architecture.
The Intelligence Layer (GEMINI.md) is only one component of the system.

It governs:

• agent activation
• vault routing
• knowledge handling
• system behaviour
• logging
• safety constraints

---

# System Architecture

VANTIS is composed of six layers.

1 Identity Layer  
2 Intelligence Layer  
3 Agent Layer  
4 Skill Layer  
5 Memory Layer  
6 Logging Layer

---

# Repository Structure

Repo Root

BOOT_IMAGE.md  
GEMINI.md  
AGENTS.md  
RULES.md  
VAULT_MAP.md  
README.md

.gemini/
  commands/
  hooks/
  skills/

.github/

logs/

vault/
  00_SYSTEM/
  01_INBOX/
  02_KNOWLEDGE/
  03_PROJECTS/
  04_PERSONAL/
  05_TASKS/
  06_MACHINE/

---

# Vault Memory System

The Obsidian vault functions as **long-term system memory**.

Key properties:

• markdown based
• human readable
• local storage
• knowledge graph enabled

---

# Vault Structure

00_SYSTEM  
01_INBOX  
02_KNOWLEDGE  
03_PROJECTS  
04_PERSONAL  
05_TASKS  
06_MACHINE

---

# Knowledge Graph — Galaxy

Location:

02_KNOWLEDGE/Galaxy

Rules:

• one concept per note
• flat structure
• connected with wikilinks
• human knowledge only

AI generated content must not enter the Galaxy.

---

# AI Output Location

AI generated material must go to:

06_MACHINE

This prevents knowledge contamination.

---

# Inbox Workflow

All uncategorised information enters:

01_INBOX

Agents must:

1 read item
2 classify information type
3 route to correct location
4 generate summary
5 log the action

---

# Agent Activation Logic

AI may analyse, expand, and propose knowledge — but only humans may create or modify Galaxy concepts.

Agents activate based on task type.

Examples:

Inbox organisation → Inbox Processor

Knowledge synthesis → Knowledge Architect

Memory consolidation → Memory Curator

Security architecture → Security Architect

---

# Skill Loading

Skills exist in:

.gemini/skills/

Skills are **lazy loaded**.

Only the skill description is loaded initially.

Full skill instructions are loaded when required.

---

# Knowledge Routing Rules

- **Human Knowledge (Direct):** 02_KNOWLEDGE/Galaxy
- **Reference Material:** 02_KNOWLEDGE/Resources
- **Project Work:** 03_PROJECTS
- **Personal Reflections:** 04_PERSONAL
- **Tasks & Reminders:** 05_TASKS
- **AI-Generated Synthesis:** 06_MACHINE (**Mandatory Staging**)
- **Unprocessed/Raw Notes:** 01_INBOX (Archived to `/Archive` after processing)

AI synthesis *must* land in 06_MACHINE for human verification before it can be manually promoted to the Galaxy.

---

# Logging Requirements

All AI actions must produce an audit log.

Location:

logs/YYYY-MM-DD/

Log Format:

timestamp  
user_request  
agent_activated  
files_read  
files_modified  
reasoning_summary  
outcome

### Strict Finality Constraint

No interaction turn may conclude if file modifications or creations have occurred without a corresponding audit log being generated. 

Logging is not a "task"—it is the definition of a completed action.

---

# Daily Memory Timeline

Location:

04_PERSONAL/Daily

Purpose:

Create narrative summaries of:

• learning
• insights
• decisions
• progress

This is human memory.

Not system logs.

---

# Safety Constraints

The AI must never:

delete knowledge files  
modify archive material  
alter system rules without approval  
overwrite Galaxy notes

---

# Operational Behaviour

The system must always:

• **Prioritize Human Context**: Read `vault/04_PERSONAL/USER_CONTEXT.md` before initiating strategic planning, business brainstorming, or content generation.
• **Branched Execution**: Strictly follow Rule 11 (RULES.md). All structural or systemic upgrades MUST occur on a dedicated Git branch (`feat/`) and be presented as a Pull Request.
• reason before acting
• explain decisions
• log actions
• maintain system integrity

# Tooling & Integration

- **GitHub Operations**: Prioritize the GitHub CLI (`gh`) for all repository interactions (PRs, Issues, Actions, Secrets). Use the `github-ops` skill to ensure structured output (`--json`) and proper logging. Avoid using abstracted MCP bridges for GitHub to maintain deep workspace visibility.
- **Structured Data**: Always prefer tools and flags that return JSON or parseable structured data for agentic processing.

---

# Development Lifecycle

For every task, the system must follow a 4-step execution loop:

1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using the available tools.
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a high-fidelity audit log in `logs/YYYY-MM-DD/`.

**Finality Rule:** A task is not complete until the audit log is persisted. Verification and Traceability are the foundations of V.A.N.T.i.S. operations.
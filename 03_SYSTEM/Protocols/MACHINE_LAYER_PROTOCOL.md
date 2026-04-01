# V.A.N.T.i.S. MACHINE LAYER PROTOCOL

Version: 1.6
Applies To: All V.A.N.T.i.S. Agents
Location: `02_MACHINE/`
**Layer Number:** 06
**Status:** Active Execution Sandbox

---

## 🎯 DEFINITION & PURPOSE
The `02_MACHINE` folder is the **AI Engine Room**. It is the strictly enforced sandbox where all AI-generated synthesis, drafts, conceptual proposals, and system reviews are staged.

This layer serves as the critical buffer between **Transient AI Output** and **Permanent Human Knowledge**.

---

## 🚧 STRICT AGENT GUARDRAILS

### 1. Mandatory Staging
All AI agents must direct their output files, drafts, and initial concepts to this directory (or its subfolders). 

### 2. The Verification Boundary
Agents are **STRICTLY PROHIBITED** from moving files from `02_MACHINE` directly into `[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy`. The promotion of intelligence from Machine to Galaxy requires explicit Human Verification.

### 3. File Hygiene
Information in this directory should be considered transient and malleable. Files here are subject to AI overwrites, refactoring, and deletion. If a file is finalized and valuable, it must be moved to an appropriate Human layer (e.g., `[REDACTED_PERSONAL_VAULT]/Projects` or `[REDACTED_PERSONAL_VAULT]/Knowledge`).

---

## 📂 SUB-DIRECTORIES (Standard Schema)
- `AI-Daily-Review/`: Automated end-of-session system state and audit logs.
- `Business_Synthesis/`: The primary staging area for "Clogs-to-Cash" reports and strategic business discovery.
- `Concept_Candidates/`: High-signal intelligence extracted from external sources, awaiting promotion.
- `LinkedIn_Drafts/`: Content generated for the user's professional portfolio.
- `Reddit_Syntheses/`: Raw research extraction from social signals.
- `session_state/`: Real-time operational continuity tracking files.

---

## 🧠 PHILOSOPHY
> "The Machine proposes, but the Human disposes." 

By confining raw output to `02_MACHINE`, V.A.N.T.i.S. maintains the pristine integrity of the user's "Second Brain" while granting the AI maximum freedom to think, draft, and propose without risk of contamination.

---

## 💾 LOG REFLEX PROTOCOL (v1.5)

The **Satellite Library Pattern** is now the standard for external research.

### 1. External Satellite Libraries
Massive external research repositories (1,000+ files or >50MB) MUST NOT be stored directly in `02_MACHINE/`. Instead:
- Move the data to the external `~/Documents/VANTIS_LIBRARIES/` directory.
- Create a symbolic link in `02_MACHINE/Research/` pointing to the external path.
- Ensure the symlink is `.gitignore`'d.

### 2. Log Reflex Protocol
The **Log Reflex** is the automated system mechanism that ensures 100% audit trail compliance with minimal token overhead.

### 1. The Trigger
A Log Reflex MUST be initiated:
- After every turn involving file creation, modification, or deletion.
- Upon completion of a task or session.

### 2. The Context Ledger
The agent maintains an internal "Session Ledger" tracking:
- `files_read`
- `files_modified`
- `skills_used`
- `reasoning_delta` (the core logic shift for the turn).

### 3. Automated Assembly
The `audit-logger` skill transforms the Ledger into a standardized Markdown log in `logs/YYYY-MM-DD/`. 
- **Deterministic Fields:** Timestamp, Agent, Files, Delta.
- **Synthesized Fields:** Reasoning Summary, Outcome & Impact.

### 4. System Versioning (ASV)
Before the log is finalized, `node .gemini/hooks/version-incrementer.js` MUST be run on all modified core system files (`RULES.md`, `GEMINI.md`, etc.).


# V.A.N.T.i.S. MACHINE LAYER PROTOCOL

**Location:** `vault/06_MACHINE/`
**Layer Number:** 06
**Status:** Active Execution Sandbox

---

## 🎯 DEFINITION & PURPOSE
The `06_MACHINE` folder is the **AI Engine Room**. It is the strictly enforced sandbox where all AI-generated synthesis, drafts, conceptual proposals, and system reviews are staged.

This layer serves as the critical buffer between **Transient AI Output** and **Permanent Human Knowledge**.

---

## 🚧 STRICT AGENT GUARDRAILS

### 1. Mandatory Staging
All AI agents must direct their output files, drafts, and initial concepts to this directory (or its subfolders). 

### 2. The Verification Boundary
Agents are **STRICTLY PROHIBITED** from moving files from `06_MACHINE` directly into `02_KNOWLEDGE/Galaxy`. The promotion of intelligence from Machine to Galaxy requires explicit Human Verification.

### 3. File Hygiene
Information in this directory should be considered transient and malleable. Files here are subject to AI overwrites, refactoring, and deletion. If a file is finalized and valuable, it must be moved to an appropriate Human layer (e.g., `03_PROJECTS` or `02_KNOWLEDGE`).

---

## 📂 SUB-DIRECTORIES (Standard Schema)
- `AI-Daily-Review/`: Automated end-of-session system state and audit logs.
- `Concept_Candidates/`: High-signal intelligence extracted from external sources, awaiting promotion.
- `LinkedIn_Drafts/`: Content generated for the user's professional portfolio.
- `Reddit_Syntheses/`: Raw research extraction from social signals.
- `session_state/`: Real-time operational continuity tracking files.

---

## 🧠 PHILOSOPHY
> "The Machine proposes, but the Human disposes." 

By confining raw output to `06_MACHINE`, V.A.N.T.i.S. maintains the pristine integrity of the user's "Second Brain" while granting the AI maximum freedom to think, draft, and propose without risk of contamination.

---

## 💾 LOG REFLEX PROTOCOL (v1.4)
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


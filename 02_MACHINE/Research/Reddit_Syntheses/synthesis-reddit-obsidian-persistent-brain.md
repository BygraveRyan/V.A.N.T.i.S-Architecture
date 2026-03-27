# AI Synthesis: Obsidian as a Persistent Brain (Claude Code)

**Original Source:** `01_HUMAN/Knowledge/Resources/Sources/Reddit/Reddit-Obsidian_Persistent_Brain_Claude_Code.md`
**Timestamp:** 2026-03-19T11:55:00Z

---

## Executive Summary
This post details a high-efficiency solo development system using **Obsidian as the "Project Brain"** for **Claude Code**. The core innovation is using structured markdown files to provide persistent context across AI sessions, overcoming the "statelessness" of new LLM conversations.

---

## Core Strategies & High-Signal Concepts

### 1. Departmental Vault Structure
The user structured their project like a company with functional departments:
- `01_RnD/`: Technical architecture and research.
- `02_Product/`: Decisions and roadmap.
- `03_Marketing/`: Content strategy and assets.
- **VANTIS Application:** This confirms the value of our `03_SYSTEM/Protocols`, `01_HUMAN/Knowledge`, and `01_HUMAN/Projects` separation.

### 2. Session Handoff Protocol
A critical mechanism for maintaining AI continuity:
- **`/resume` Command:** Reads an "Execution Plan" + the latest "Handoff Note" to determine state and next tasks.
- **`/wrap-up` Command:** Updates the plan, modifies relevant department files, and writes a new Handoff Note for the next session.
- **VANTIS Application:** We should consider a `concept-session-handoff-protocol` for VANTIS to handle session-to-session memory.

### 3. Dependency-Driven Parallel Execution
- The "Execution Plan" uses dependency graphs.
- This allows spawning multiple Claude agents simultaneously (one for backend, one for frontend) because each agent knows the "state" from the shared Obsidian brain.

### 4. Remotion for Demo Generation
- Use of **Remotion** (React-based video generation) to automate marketing assets during the build weekend.

---

## Proposed Concepts for Galaxy Promotion
- `concept-ai-persistent-context-layer`: The architectural pattern of using a local file system as an external AI memory.
- `concept-agent-handoff-logic`: The structured metadata and summary required to bridge AI sessions.
- `concept-departmental-knowledge-silos`: Organizing project information by business function for cleaner AI retrieval.

## Actionable VANTIS Tasks
- [ ] Research implemention of a `/resume` and `/wrap-up` equivalent in VANTIS (potentially using `.gemini/commands/` or `.gemini/hooks/`).
- [ ] Evaluate `Remotion` for generating VANTIS project demos.

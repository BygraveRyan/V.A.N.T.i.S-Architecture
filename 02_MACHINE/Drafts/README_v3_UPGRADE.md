# V.A.N.T.i.S.
> **Vectorised Astral Navigation & Thought Intelligence System**
> *Production-Grade Cognitive Infrastructure for AI-Native Engineering*

V.A.N.T.i.S. is a professional-grade, local-first AI workspace architecture. It bridges the gap between structured human knowledge (Obsidian) and autonomous agentic execution (Gemini/Claude CLI), transforming a standard markdown vault into a persistent, compounding intelligence center that eliminates context fragmentation and chat-limit friction.

---

## 🏗️ 6-Layer Cognitive Architecture
V.A.N.T.i.S. operates on a strictly enforced, repo-primary layered model to ensure system integrity and prevent cognitive drift:

1.  **Identity Layer (`BOOT_IMAGE.md`)**: Defines the core persona, ethical guardrails, and fundamental mission.
2.  **Intelligence Layer (`GEMINI.md` / `CLAUDE.md`)**: The central nervous system; governs high-level routing, tool prioritization, and inter-agent coordination.
3.  **Agent Layer (`AGENTS.md`)**: Specialized, domain-expert personas (Knowledge Architect, Memory Curator, Inbox Processor) with strictly scoped tool permissions and knowledge domains.
4.  **Skill Layer (`.gemini/skills/`)**: Modular, lazy-loaded technical capabilities (GitHub Ops, Concept Extraction, Audit Logger) that provide the "how-to" for agentic execution.
5.  **Memory Layer (`vault/`)**: A human-curated knowledge graph (The Galaxy) following the **METADATA_SCHEMA v1.5** for high-velocity scaling and semantic linking.
6.  **Logging Layer (`logs/`)**: A high-fidelity, immutable audit trail. Enforces the **'Log Reflex'**—no turn may conclude without a structured log documenting reasoning, modifications, and system signals.

---

## 🚀 Operational Workflow (Command Layer)
V.A.N.T.i.S. moves beyond "chatting" into deterministic state-management through a custom suite of operational commands:

*   **`--resume` (Orientation)**: Fires the `repo-map.sh` hook to rehydrate agent context from the latest `session-state_YYYY-MM-DD.md`. Ensures zero context loss between sessions.
*   **`--inbox` (Routing)**: Triggers the **Inbox Processor** to clarify and route raw notes to Projects, Tasks, or the Galaxy according to the `INBOX_PROCESSING_PROTOCOL`.
*   **`--daily` (Synthesis)**: Generates a high-signal session review, capturing architectural shifts and knowledge captured during the current session.
*   **`--eod` (Finality)**: Performs the **Master Audit**. Aggregates all session logs, updates task dashboards, and serializes the system state for a deterministic handoff.

---

## 🛠️ Agentic Execution & Governance
The system functions as an integrated team member, capable of autonomous technical operations and system-wide maintenance:

### 🌐 Native GitHub Governance
*   **`gh/pr` & `gh/issue`**: Deeply integrated with the GitHub CLI. V.A.N.T.i.S. performs technical PR reviews, manages its own issue board, and self-corrects failed CI/CD pipelines.
*   **`gh/run`**: Monitors and fixes failed GitHub Actions via native log analysis.

### 🛡️ System Integrity & Security
*   **`pulse` (Background Sync)**: Executes silent, encrypted backups to the private core `main` branch.
*   **`publish` (Mirroring)**: Sanitizes and mirrors the V.A.N.T.i.S. engine to a public portfolio repository, removing all sensitive logs and internal signals.
*   **ASV (Automated System Versioning)**: A native hook that auto-increments protocol and skill versions upon modification, maintaining a rigorous version history of the engine itself.

---

## 🧠 Advanced Cognitive Features
What distinguishes V.A.N.T.i.S. from standard AI repositories is its commitment to architectural rigor and long-term knowledge stability:

*   **Model-Agnostic Handover (The Dual-Agent Edge)**: V.A.N.T.i.S. is provider-agnostic. Through state serialization, a session can begin in Gemini for deep research and conclude in Claude for surgical implementation with zero context loss.
*   **Anti-Hallucination Guardrails (The Human-Machine Pivot)**: Enforces a strict staging-to-promotion workflow. AI outputs never enter the primary knowledge graph (The Galaxy) directly; they are staged in `02_MACHINE` for human verification, ensuring the "Source of Truth" remains untainted by model drift.
*   **Recursive Skill Engine (Continuous Learning)**: The system treats "Edge Cases" encountered during execution as triggers for new Skill authorship. V.A.N.T.i.S. doesn't just work; it documents its own technical precedents to improve future reasoning.
*   **Cognitive Dashboard (The Obsidian UI)**: While the engine lives in the CLI, the observability lives in Obsidian. A custom **System Intelligence Center** (Dataview-powered) provides a real-time visual map of active objectives, knowledge velocity, and system health.

---

## 🏗️ Philosophy: Mechanism-to-Value
V.A.N.T.i.S. rejects the ephemeral nature of standard AI chat in favor of **State Serialization**. 

By grounding the AI in a local-first, version-controlled architecture, the system achieves **Compounding Intelligence**. Every interaction strengthens the knowledge graph, every error informs a new skill, and every session begins with the full weight of the vault’s history behind it.

**V.A.N.T.i.S. is not a tool; it is a cognitive extension for the AI-native engineer.**

---
*V.A.N.T.i.S. Core Engine | Architecture v1.10 | Metadata v1.5*

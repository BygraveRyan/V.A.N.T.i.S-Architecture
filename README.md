# V.A.N.T.i.S.
> **Vectorised Astral Navigation & Thought Intelligence System**

V.A.N.T.i.S. is a professional-grade AI-native workspace architecture. It bridges the gap between structured human knowledge (Obsidian) and autonomous agentic execution (Gemini CLI), transforming a personal vault into a high-signal intelligence center.

---

## 🏗️ The 6-Layer Architecture
V.A.N.T.i.S. operates on a strictly enforced layered model to ensure system integrity and prevent cognitive drift:

1.  **Identity Layer** (`BOOT_IMAGE.md`): Defines the core persona and fundamental mission.
2.  **Intelligence Layer** (`GEMINI.md`): The central nervous system; governs rules, routing, and tool prioritization.
3.  **Agent Layer** (`AGENTS.md`): Specialized personas (Knowledge Architect, Inbox Processor, etc.) with specific domain expertise.
4.  **Skill Layer** (`.gemini/skills/`): Modular, lazy-loaded capabilities (GitHub Ops, Concept Extraction) that provide technical "how-to."
5.  **Memory Layer** (`vault/`): Long-term system memory stored in a human-readable Markdown graph (The Galaxy).
6.  **Logging Layer** (`logs/`): A high-fidelity, immutable audit trail of every system action and decision.

---

## 🧠 Philosophy: Mechanism-to-Value
V.A.N.T.i.S. rejects "chatter" in favor of **signal**. Every interaction must follow a strict lifecycle:
- **RESEARCH**: Map the workspace and validate assumptions.
- **STRATEGY**: Propose a grounded technical path.
- **EXECUTION**: Apply surgical, idiomatic changes.
- **VALIDATION**: Verify correctness through tests and system logs.

---

## 🚀 Key Capabilities

### 📂 The Galaxy (Knowledge Graph)
A human-curated, AI-augmented knowledge graph. While agents can propose "Concept Candidates," only humans can promote insights to the Galaxy, ensuring the core knowledge base remains untainted by AI hallucinations.

### 🤖 Native GitHub Governance
Deeply integrated with the `gh` CLI. V.A.N.T.i.S. doesn't just "talk" to GitHub; it manages repository health, performs technical PR reviews, and self-corrects failed CI/CD pipelines via native shell operations.

### 📥 Inbox Discipline
A zero-friction capture system. Raw thoughts are ingested, clarified, and routed to Projects, Tasks, or the Galaxy through an automated processing pipeline.

---

## 🛠️ Stack & Setup

V.A.N.T.i.S. is designed for power users who want to bridge local-first knowledge with autonomous AI execution.

### 1. Prerequisite: Gemini CLI
The system's "Intelligence Layer" is powered by the **[Gemini CLI](https://github.com/google/gemini-cli)**.
- Follow the official installation guide to set up the CLI.
- Ensure you have a valid Google AI Studio API key configured.

### 2. Knowledge Base: Obsidian
The "Memory Layer" is a standard Markdown vault compatible with **[Obsidian](https://obsidian.md/)**.
- Clone this repository into your local machine.
- Open the folder as an Obsidian Vault.
- **Recommended Plugins**:
    - `Templater`: For dynamic concept scaffolding.
    - `Dataview`: For real-time task and project indexing.

### 3. V.A.N.T.i.S. Configuration
Once the CLI and Vault are ready:
1. Initialize the system by running the setup check:
   ```bash
   # Verify system protocols
   /diagnose
   ```
2. Link your GitHub identity for native ops:
   ```bash
   gh auth login
   ```

---
*V.A.N.T.i.S. is not just a tool; it is a cognitive extension for the AI-native engineer.*

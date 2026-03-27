# AI Synthesis: Data Modeling with Claude (Data Engineering)

**Original Source:** `01_HUMAN/Knowledge/Resources/Sources/Reddit/Reddit-Claude_Data_Engineering_Modeling.md`
**Timestamp:** 2026-03-19T12:40:00Z

---

## Executive Summary
This post/discussion explores how Data Engineers use Claude Code and Cowork for complex tasks like design, refactoring star schemas, and updating dbt projects. The consensus is that AI performs exceptionally well when provided with **structured architectural context** and **local tooling** to inspect data outputs.

---

## Core Strategies & High-Signal Concepts

### 1. "Teaching" the AI with Markdown
- **Strategy:** Put business context, modeling patterns, and standards into `README.md`, `AGENTS.md`, and `cursor rules` files.
- **Insight:** Claude is "capable but forgetful." A style guide and explicitly documented "source vs model" definitions prevent generic errors.
- **VANTIS Application:** This validates our use of `GEMINI.md`, `RULES.md`, and `VAULT_MAP.md` as the "Teaching Layer" for our agent.

### 2. Data Validation via ZSH Aliases
- **Strategy:** Created a zsh alias to download a model's output to a local CSV (e.g., `select * limit 10000 -> exports/model.csv`).
- **Insight:** Allowing the AI to "examine outputs" via local files makes it possible to one-shot difficult business logic changes.
- **VANTIS Application:** We should create a VANTIS skill or hook that exports BigQuery/SQL query results to `02_MACHINE/` so the AI can verify its own modeling work.

### 3. Granular Task Decomposition
- **Strategy:** Avoid "rebuild this whole lineage" prompts. Break tasks into separate bits (max 10 models).
- **Insight:** Models are not yet at the stage where they can figure out a massive data project from a single open-ended request.

### 4. Custom Slash Commands for DE
Useful commands mentioned:
- `/refactor`: Break large models into modular pieces.
- `/dbt-document`: Auto-generate `.yml` documentation for models.
- `/understand`: Search a model and its dependencies to orient in a new thread.
- `/build`: Create a new model based on staging specs.

---

## Proposed Concepts for Galaxy Promotion
- `concept-ai-taught-engineering`: The methodology of using markdown files to encode project-specific conventions for AI agents.
- `concept-local-output-validation`: Bridging the gap between code generation and data verification by providing AI with local data snapshots.
- `concept-data-modeling-lineage-refactoring`: Using large context windows to redesign complex data flows incrementally.

## Actionable VANTIS Tasks
- [ ] Add a "Data Style Guide" section to the VANTIS core rules.
- [ ] Research implemention of a `/sql-verify` command that exports query results to the vault for AI inspection.
- [ ] Draft a `concept-ai-taught-engineering` note for the Galaxy.

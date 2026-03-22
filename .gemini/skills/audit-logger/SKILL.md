# SKILL: Audit Logger

Purpose
Ensure high-fidelity audit trails of every decision, file modification, and reasoning step taken by VANTIS agents.

---

# When To Use
Activate this skill:
• Every time a file is modified, moved, or created.
• At the end of every task or session.
• When an agent makes a significant decision or architectural choice.
• To fulfill the mandatory V.A.N.T.i.S. logging requirement.

---

# Logging Process

Step 0 — Automated System Versioning (ASV)
Before generating the audit log, agents MUST run the versioning check:
• Identify all modified/created files in the current turn.
• For each file, execute: `node .gemini/hooks/version-incrementer.js <file_path>`.
• This ensures that any Tier 1, 2, or 3 system files have their `Version: X.Y.Z` metadata incremented correctly before the audit log records the state.

Step 1 — Identify Metadata
• Determine the **Agent Name** (e.g., `IntelligenceLayer`, `InboxProcessor`).
• Create a **Task Descriptor** (brief, hyphenated, e.g., `Convert-Protocol-To-Skill`).
• Generate a **Timestamp** (format: `YYYY-MM-DD_HHMMSS`).

Step 2 — Generate Filename
Follow the standard: `YYYY-MM-DD_HHMMSS_AgentName_TaskDescriptor.md`.
Store in: `logs/YYYY-MM-DD/`.

Step 3 — Construct YAML Frontmatter
Include the following fields:
- `timestamp`: ISO-8601 format.
- `agent`: Full agent name.
- `task`: Descriptive task name.
- `status`: `success` or `failure`.
- `human_reviewed`: `false` (default).
- `related_logs`: List of relevant previous log filenames.
- `skills_used`: List of skills employed in the task.
- `delta`: High-signal summary of vault changes (e.g., "+1 Skill, -1 Protocol").
- `affected_files`: List of paths to modified/created files.
- `log_version`: `1.0`.

Step 4 — Populate Core Sections
- **User Request**: The original prompt or trigger.
- **Reasoning Summary**: Concise explanation of the logic and protocols used.
- **Files Read**: All files accessed during the task.
- **Files Modified / Created**: Precise list of changes.
- **Outcome & Impact**: Summary of the final state and achievement.

---

# Output Rules
Logs must be stored in daily folders within `logs/`.
Example: `logs/2026-03-20/2026-03-20_150000_IntelligenceLayer_Update-Skills.md`.

---

# Behaviour Rules
• **No Silent Actions**: Every file change requires a log entry.
• **Immutability**: Never edit or delete existing logs.
• **Privacy**: Never log credentials, API keys, or sensitive personal data.
• **Surgical Reads**: Use `grep_search` on YAML fields when analyzing logs for context.

---
id: vantis-resume-command
type: task
status: complete
updated: 2026-03-21
related_concepts:
  - concept-agent-handoff-logic
  - concept-ai-persistent-context-layer
---

# TASK: Implement `/resume` Slash Command

## Objective
Create a custom Gemini CLI command that allows the agent to immediately re-orient itself at the start of a new session by reading the latest state artifacts.

## Requirements
- **Location:** `.gemini/commands/resume.toml`
- **Trigger:** `/resume`
- **Logic:**
    1. Find the most recent `Session_Review.md` in `02_MACHINE/Daily/`.
    2. Read the `Next Actions` and `Decision Points`.
    3. Find and read the last 3-5 audit logs from the previous session.
    4. Provide a "State Summary" to the user to confirm orientation.

## Reasoning
This command implements the "Agent Handoff Logic" identified in today's Reddit ingestion, solving "First Turn Amnesia."

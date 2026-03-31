---
title: "V.A.N.T.i.S. Diagnostic Upgrade (Hybrid Approach)"
status: "in-progress"
created: 2026-03-30
tags: ["system", "diagnostics", "performance"]
---

# Plan: V.A.N.T.i.S. Diagnostic Upgrade (Hybrid Approach)

## Objective
Enhance the `/diagnose` command to provide a comprehensive health check covering performance, integrity, and protocol adherence.

## Key Files & Context
- `.gemini/hooks/v_diagnose.sh`: The core shell script for fast infrastructure checks.
- `.gemini/commands/diagnose.toml`: The command definition for the Gemini CLI.
- `02_MACHINE/State/session-state_LATEST.md`: The symlink for session resumption.
- `03_SYSTEM/Protocols/`: The source of truth for V.A.N.T.i.S. rules.
status: "completed"
...
## Implementation Steps

### 1. Upgrade `v_diagnose.sh` (Infrastructure Pass)
- [x] **Performance:** Add directory size checks (`du -sh`) for `02_MACHINE/` and `logs/`.
- [x] **Integrity:** Add a check to verify that `02_MACHINE/State/session-state_LATEST.md` is a valid symlink and points to the newest file.
- [x] **Protocol:** Add a `git status --porcelain` check for uncommitted changes in `03_SYSTEM/Protocols/`.
- [x] **Output:** Standardize output with clear [PASS/FAIL/WARN] markers for the parse.

### 2. Enhance `diagnose.toml` (Intelligence Pass)
- [x] **Step 1 (Command):** Execute the upgraded `v_diagnose.sh`.
- [x] **Step 2 (Prompt):** Add a step for the agent to:
    - Review the shell script's output.
    - Check the current session's "Context Debt" (history length/token usage).
    - Scan the most recent synthesis file for Metadata v1.5 compliance.
    - Summarize the "Operational Health Score."

### 3. (Optional) Tool Latency Hook
- [x] Investigate if `v_observe.sh` can be used to track tool execution times for future "slowdown" diagnosis. (Integrated into hybrid plan)

## Verification & Testing
- [ ] Run `/diagnose` and ensure the shell output is correctly parsed by the agent.
- [ ] Simulate a broken symlink and verify it is caught.
- [ ] Simulate an uncommitted protocol change and verify the "ASV Reflex" warning.
- [ ] Verify that Metadata v1.5 checks identify "naked" files (missing frontmatter).

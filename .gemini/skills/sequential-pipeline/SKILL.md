---
name: sequential-pipeline
description: Move work through specialist stages with validation at each handoff.
---

# SKILL: Sequential Pipeline
Version: 2.0.0

Purpose
Move work through specialist stages with validation at each handoff.

---

# When To Use
- **Trigger**: Work naturally breaks into ordered stages.
- **Requirement**: Later steps depend on earlier outputs, and different roles have different incentives.

---

# Do Not Use When
- Stages are independent and parallelizable (use Fan-Out instead).
- One pass is enough for the entire task.
- The handoffs are artificial or add unnecessary friction.

---

# Core Protocol (Execution Rules)

## Step 1 — Definition
1. Define all stages and their specific exit criteria before starting.

## Step 2 — Context Gating
1. Each stage receives only the minimum required context to perform its specific task.

## Step 3 — Validation Handoff
1. Each stage MUST validate the output of the previous stage before proceeding.
2. If validation fails, the work is returned to the previous stage with explicit, actionable defects.

## Step 4 — Completion
1. Continue the cycle until all stage criteria are passed and the final output is verified.

---

# Output Schema
```json
{
  "stage_name": "...",
  "delivered_output": "...",
  "validation_status": "pass|fail",
  "defects": ["..."],
  "handoff_notes": ["..."],
  "confidence": 0.0
}
```

---

# Quality Bar
- Exit criteria must be objective and measurable.
- No bypassing validation steps.
- Each handoff must improve the quality or depth of the work-product.

---

# 🛡️ AUDIT HOOK
Every Sequential Pipeline session MUST result in a handoff log in `02_MACHINE/Synthesis/` documenting each stage, the validation status, any defects returned, and the final delivery notes.

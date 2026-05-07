---
name: evaluator-judge
description: Score an output against a rubric and decide whether it should pass, fail, iterate, or escalate.
---

# SKILL: Evaluator-Judge
Version: 2.0.0

Purpose
Score an output against a rubric and decide whether it should pass, fail, iterate, or escalate.

---

# When To Use
- **Trigger**: You need objective quality control.
- **Requirement**: You are chaining multiple skills and need a "gatekeeper" to decide if the output is ready for the next stage or for decision-making.

---

# Core Protocol (Execution Rules)

## Step 1 — Input Review
1. Read the target output (the work-product to be evaluated).
2. Read the rubric (the success criteria or instructions).

## Step 2 — Scoring
1. Score each criterion from 1-5 based on the evidence in the output.
2. Criteria include: Accuracy, Completeness, Clarity, Risk Handling, and Instruction Following.

## Step 3 — Defect Identification
1. Identify the most critical defects that prevent a "Pass" score.

## Step 4 — Adjudication
1. Decide on one of three paths:
   - **Pass**: Output is ready for use/delivery.
   - **Revise**: Output requires specific improvements (list them).
   - **Escalate**: Output is fundamentally flawed or requires human intervention.

## Step 5 — Routing
1. Suggest the `next_best_skill` to continue the workflow.

---

# Output Schema
```json
{
  "scores": {
    "accuracy": 0,
    "completeness": 0,
    "clarity": 0,
    "risk_handling": 0,
    "instruction_following": 0
  },
  "major_defects": ["..."],
  "decision": "pass|revise|escalate",
  "next_best_skill": "...",
  "confidence": 0.0
}
```

---

# Quality Bar
- Scoring must be evidence-based (point to specific parts of the output).
- Major defects must be actionable.
- The decision must align with the scores (e.g., a "Pass" cannot have a score of 1 in a major category).

---

# 🛡️ AUDIT HOOK
Every Evaluator-Judge session MUST result in an evaluation report in `02_MACHINE/Reports/` and an audit log documenting the scores, defects, and the routing decision.

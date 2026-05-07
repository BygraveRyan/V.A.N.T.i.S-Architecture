---
name: fan-out
description: Split a broad task into parallel independent sub-questions, gather findings separately, then prepare clean inputs for synthesis.
---

# SKILL: Fan-Out Research
Version: 2.0.0

Purpose
Split a broad task into parallel independent sub-questions, gather findings separately, then prepare clean inputs for synthesis.

---

# When To Use
- **Trigger**: The task has 3 or more independent angles.
- **Requirement**: Speed matters or one agent would otherwise accumulate too much noisy context.
- **Constraint**: SHOULD be used when the estimated research task would consume >20,000 tokens in the primary context.

---

# Do Not Use When
- The task depends on sequential reasoning.
- Later subtasks require earlier answers.
- The problem is small enough for one agent.

---

# Core Protocol (Execution Rules)

## Step 1 — Decompose
1. Decompose the task into 3-7 non-overlapping (MECE) sub-questions.
2. Define the primary research objective clearly.

## Step 2 — Parallel Invocation
1. Assign one sub-question per researcher using `invoke_agent`.
2. **Model Mandate**: sub-agents MUST use the **Haiku** model to minimize cost.
3. Force each researcher to stay strictly within their defined scope.

## Step 3 — Collection
1. Each researcher returns facts, uncertainties, and unresolved questions following the structured schema.

## Step 4 — Synthesis (Fan-In)
1. Merge structured findings into synthesis input.
2. Synthesizer resolves conflicts, removes duplicates, and produces one final answer.
3. Explicitly reconcile any contradictions found in researcher outputs.

---

# Schemas

## Researcher Output Schema
```json
{
  "sub_question": "...",
  "findings": ["..."],
  "evidence": ["..."],
  "uncertainties": ["..."],
  "confidence": 0.0
}
```

## Synthesizer Output Schema
```json
{
  "final_answer": "...",
  "merged_insights": ["..."],
  "conflicts": ["..."],
  "gaps": ["..."],
  "confidence": 0.0,
  "recommended_next_skill": null
}
```

---

# Quality Bar
- Sub-questions must be mutually distinct (No-Overlap).
- No repeated research across workers.
- Synthesis must explicitly reconcile contradictions.

---

# 🛡️ AUDIT HOOK
Every Fan-Out session MUST result in a research synthesis file in `02_MACHINE/Research/` and an audit log entry documenting the sub-agents used, confidence scores, and total findings.

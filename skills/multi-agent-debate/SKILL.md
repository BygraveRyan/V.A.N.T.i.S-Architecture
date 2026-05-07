---
name: stochastic-consensus
description: Generate multiple independent solutions, identify recurring conclusions, and preserve useful outliers.
---

# SKILL: Stochastic Consensus
Version: 2.0.0

Purpose
Generate multiple independent solutions, identify recurring conclusions, and preserve useful outliers.

---

# When To Use
- **Trigger**: The task is ambiguous, strategic, or creative.
- **Requirement**: Robustness against single-run failure or when multiple plausible answers may exist.

---

# Do Not Use When
- A deterministic answer is available.
- The task is simple extraction or formatting.
- Time or token budget is very tight.

---

# Core Protocol (Execution Rules)

## Step 1 — Parallel Generation
1. Run 5-10 independent attempts using `invoke_agent` or parallel model calls.
2. Slightly vary perspective, framing, or constraints across attempts (e.g., "Think like an Architect", "Think like a Security Lead").
3. **Critical**: Prevent agents from seeing each other's outputs initially to avoid groupthink.

## Step 2 — Aggregation
1. Aggregate outputs by recurring claims, proposed actions, and reasoning patterns.
2. Separate majority conclusions from minority outliers.

## Step 3 — Synthesis
1. Finalize the decision by weighing consensus vs. robust outliers.
2. Preserve outliers only if they are plausible and useful (i.e., they expose blind spots or present high-upside alternatives).

---

# Output Schema
```json
{
  "consensus_points": ["..."],
  "outlier_points": ["..."],
  "disagreements": ["..."],
  "decision": "...",
  "confidence": 0.0,
  "recommended_next_skill": null
}
```

---

# Quality Bar
- Consensus is the most robust recurring conclusion, not just common wording.
- Outliers must be labeled as speculative or high-upside.
- Do not suppress minority answers if they expose blind spots.

---

# 🛡️ AUDIT HOOK
Every Stochastic Consensus session MUST result in a synthesis file in `02_MACHINE/Synthesis/` and an audit log documenting the number of runs, consensus points, and any significant outliers preserved.

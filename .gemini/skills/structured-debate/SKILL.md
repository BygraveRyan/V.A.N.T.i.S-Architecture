---
name: structured-debate
description: Stress-test important claims through bounded adversarial critique before selecting a final position.
---

# SKILL: Structured Debate
Version: 2.0.0

Purpose
Stress-test important claims through bounded adversarial critique before selecting a final position.

---

# When To Use
- **Trigger**: A decision involves significant trade-offs or high risk.
- **Requirement**: You need to expose weak assumptions or test strategic/architectural choices.

---

# Do Not Use When
- The answer is factual and easily verifiable.
- The task is routine summarization.
- Extra rounds would add noise, not insight.

---

# Core Protocol (Execution Rules)

## Step 1 — Question Definition
1. Define the exact, binary or high-stakes question being debated.

## Step 2 — Role Assignment
1. Assign fixed roles to sub-agents using `invoke_agent`:
   - **Proposer**: Argues for the primary claim/solution.
   - **Critic**: Actively seeks to invalidate assumptions and identify risks (Adversarial).
   - **Verifier**: Audits evidence and validates claims against existing facts/vault state.

## Step 3 — Adversarial Rounds
1. Run 2-3 rounds maximum.
2. In each round, require each agent to attack assumptions and logic, not style or formatting.

## Step 4 — Adjudication
1. After rounds complete, a **Judge** persona selects the best-supported answer.
2. The Judge MUST name exactly why the winning answer won and address the main critiques raised.

---

# Output Schema
```json
{
  "question": "...",
  "positions": [
    {"role": "proposer", "claim": "..."},
    {"role": "critic", "claim": "..."},
    {"role": "verifier", "claim": "..."}
  ],
  "key_challenges": ["..."],
  "winning_position": "...",
  "reason_for_selection": "...",
  "confidence": 0.0,
  "recommended_next_skill": null
}
```

---

# Quality Bar
- Critique must focus on assumptions, evidence, feasibility, and risk.
- No repetitive restatement of previous rounds.
- Debate ends with final adjudication, not open-ended discussion.

---

# 🛡️ AUDIT HOOK
Every Structured Debate session MUST result in a transcript/synthesis file in `02_MACHINE/Synthesis/` and an audit log documenting the roles used, the key challenges identified, and the final adjudication rationale.

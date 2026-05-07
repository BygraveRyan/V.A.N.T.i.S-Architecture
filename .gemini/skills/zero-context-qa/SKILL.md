---
name: zero-context-qa
description: Spawns a fresh sub-agent with zero prior context to review a specific file or diff. Ensures unbiased feedback based strictly on the current code/content state.
---

# SKILL: Zero-Context QA
Version: 1.0.0

Purpose
Ensure absolute objectivity in code reviews and content verification by eliminating "context momentum" and confirmation bias.

---

# When To Use
- **Trigger**: Final verification of a core protocol change, a complex script, or a high-stakes business offer.
- **Requirement**: MUST be used for Tier 1 or Tier 2 protocol changes before merge.

---

# Core Protocol

## Step 1 — Isolation
1. Identify the specific file or Git diff to be reviewed.
2. Ensure NO previous conversation history, project plans, or architectural discussions are passed to the reviewer.

## Step 2 — Reviewer Invocation
1. Use `invoke_agent` to spawn a fresh sub-agent (The "Blank Slate").
2. **Model Mandate**: Use **Sonnet** or **Opus** for high reasoning.
3. **Instruction**: "Review the following code/content strictly based on its own merits and established system standards. Do not assume any prior intent."

## Step 3 — Critique & Iterate
1. Review the QA agent's findings.
2. If critical errors are found, fix them in the primary session and RE-RUN the Zero-Context QA until PASS.

---

# 🛡️ AUDIT HOOK
The QA Report MUST be saved in `logs/` or the PR body to document the independent verification.

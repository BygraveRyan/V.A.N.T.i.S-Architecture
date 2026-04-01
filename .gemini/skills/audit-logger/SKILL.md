---
name: audit-logger
description: Ensures high-fidelity audit trails via automated tokenless logging (Tier 1) and model-authored reasoning logs for significant architectural changes (Tier 2).
---

# SKILL: Audit Logger (v1.5)
Version: 1.0.1

Purpose
Ensure high-fidelity audit trails. Operates in two tiers: **Automated (tokenless)** for all sessions, and **Reasoning (model-authored)** for significant architectural decisions only.

---

# Audit Tiers

## Tier 1 — Automated (Tokenless) — DEFAULT
**Mechanism**: Claude Code `PostToolUse` + `Stop` command hooks.
- `session-ledger.sh` captures every file modification in real-time to `.gemini/tmp/session-ledger.jsonl`.
- `compile-audit-log.sh` compiles the ledger + `git diff --stat` into a structured log at session end.
- **Zero model tokens consumed.** Runs silently on every session.
- Output: `logs/YYYY-MM-DD/YYYY-MM-DD_HHMMSS_AutoLog_Session-Audit.md`

## Tier 2 — Reasoning Log (Model-Authored) — SIGNIFICANT CHANGES ONLY
Invoke this skill manually when:
- Executing a multi-file architectural change (feat/ branch)
- Completing a task from `[REDACTED_PERSONAL_VAULT]/Tasks/VANTIS/`
- Any turn where the **WHY** behind a change is non-obvious from the git diff alone

---

# When to Invoke This Skill (Tier 2)

- **Trigger**: Finalizing a turn involving vault modifications that warrant reasoning context.
- Tier 1 already handles mechanical logging. Tier 2 adds the narrative layer when it matters.

---

# Tier 2 Logging Process

Step 0 — ASV Reflex
Run: `node .gemini/hooks/version-incrementer.js <file_path>` for all Tier 1–3 system files modified.

Step 1 — Context Ledger
```json
{
  "agent": "Claude",
  "task": "Hyphenated-Task-Name",
  "files_read": ["file1.md"],
  "files_modified": ["file1.md"],
  "skills_used": ["skill-name"],
  "reasoning_delta": "Why this change happened.",
  "outcome_impact": "What is better now."
}
```

Step 2 — Filename
`logs/YYYY-MM-DD/YYYY-MM-DD_HHMMSS_Claude_TaskDescriptor.md`

Step 3 — Sections
- User Request, Reasoning Summary, Files Read, Files Modified (table with ASV status), Outcome + Signals.

---

# Deterministic Rules
1. **Tier 1 is always on** — never disable the tokenless hooks.
2. **Tier 2 is additive** — it supplements, never replaces, Tier 1.
3. **Immutability** — never edit or delete existing logs.
4. **No Silent Actions** — if Tier 1 misses something (e.g., Gemini session), write a Tier 2 log.

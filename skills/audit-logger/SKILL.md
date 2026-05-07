---
name: audit-logger
description: Ensures durable audit trails via lightweight hook telemetry and selective model-authored reasoning logs when rationale, risks, or handoff context matter.
---

# SKILL: Audit Logger (v1.7)
Version: 1.2.1

Purpose
Ensure durable audit trails without redundant Git-derived session logs. Operates in two layers: **Lightweight telemetry** for all sessions, and **Reasoning logs** for changes that need intent, risk, or continuity context.

---

# Audit Tiers

## Layer 1 — Lightweight Telemetry — DEFAULT
**Mechanism**: Shared hook telemetry wired through each provider's native config.
- `session-ledger.sh` captures every file modification in real-time to `.gemini/tmp/session-ledger.jsonl`.
- `cost-tracker.js` records lightweight usage/cost telemetry at session end.
- Git remains the source of truth for file-level history and diffs.
- **Zero model tokens consumed.** Runs silently on every session.

## Layer 2 — Reasoning Log (Model-Authored) — SELECTIVE
Invoke this skill manually when:
- Executing a multi-file architectural change (feat/ branch)
- Completing a V.A.N.T.i.S. system task from `03_SYSTEM/Roadmap/`
- Completing a personal or human-centered task from `private workspace/...`
- Any turn where the **WHY** behind a change is non-obvious from the git diff alone
- Any turn that needs durable handoff context, explicit risks, or decision rationale

---

# When to Invoke This Skill (Layer 2)

- **Trigger**: Finalizing a turn involving meaningful changes that warrant reasoning context.
- Layer 1 already handles telemetry. Layer 2 adds the narrative layer when it matters.
- Do **not** create a reasoning log just because files changed. If Git history plus session-ledger telemetry fully explains the work, skip it.

---

# Layer 2 Logging Process

Step 0 — ASV Reflex
Run: `node .gemini/hooks/version-incrementer.js <file_path>` for all Tier 1–3 system files modified.

Step 1 — Context Ledger
```json
{
  "agent": "<Active provider + model>",
  "task": "Hyphenated-Task-Name",
  "files_read": ["file1.md"],
  "files_modified": ["file1.md"],
  "skills_used": ["skill-name"],
  "reasoning_delta": "Why this change happened.",
  "outcome_impact": "What is better now."
}
```

Step 2 — Filename
`logs/YYYY-MM-DD/YYYY-MM-DD_HHMMSS_<Agent>_TaskDescriptor.md`

Step 3 — Sections
- User Request, Reasoning Summary, Files Read, Files Modified (table with ASV status), Outcome + Signals.

---

# Deterministic Rules
1. **Layer 1 is always on** — keep lightweight telemetry hooks enabled.
2. **Layer 2 is selective** — use it when rationale, risks, or continuity context would otherwise be lost.
3. **Immutability** — never edit or delete existing logs.
4. **No Silent Decisions** — if lightweight telemetry misses a meaningful change or the rationale would be unclear to the next operator, write a reasoning log.

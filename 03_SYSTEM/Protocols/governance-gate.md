---
name: governance-gate
Version: 1.2.0
schema_version: 1.5
status: disabled
parent_authority: SHARED_RULES.md
applies_to: all-subagents
created: 2026-05-01
---

# Governance Gate — Autonomous Action & Write Sandbox Policy

> Authority: V.A.N.T.i.S. SHARED_RULES.md v1.18
> Trigger: Any subagent (Hermes, Honcho, or delegated research agent) attempts a write, external system call, or autonomous action.

---

## LAYER 1 — Human Approval Gate (External Systems)

**Rule:** No subagent may touch an external system (API, CRM, outreach platform, email, calendar, webhook) without explicit human approval in the current session.

**Enforcement:** Orchestrating agent (Claude/Gemini) surfaces the proposed action with a one-line description and waits for `/approve` or `/deny` before execution. No autonomous fire-and-forget.

**Audit requirement:** Every approved or denied action is logged to `logs/YYYY-MM-DD/governance-gate-actions.md` with timestamp, agent, action, and approval status.

---

## LAYER 2 — Subagent Write Permissions (File System)

**Default posture: READ-ONLY.**

Subagents may read any vault file. Writes are restricted by target path:

| Path | Permission | Notes |
|---|---|---|
| `02_MACHINE/Synthesis/` | WRITE (with approval) | Synthesized outputs land here only |
| `02_MACHINE/State/` | WRITE (with approval) | Session state addendums only |
| `02_MACHINE/Daily/` | WRITE (with approval) | Daily review outputs only |
| `01_HUMAN/` (any path) | BLOCKED | Human-curated layer; orchestrator writes only |
| `01_HUMAN/Knowledge/Galaxy` | HARD BLOCK | NO GALAXY WRITES — abort and log |
| `03_SYSTEM/Protocols/` | BLOCKED | Requires ASV REFLEX + human approval |
| `logs/` | WRITE (always) | Audit log writes are never blocked |

**Hard Block behaviour:** If a subagent targets `01_HUMAN/Knowledge/Galaxy` for a write, the agent MUST:
1. Abort the write immediately.
2. Append a blocked-action entry to `logs/YYYY-MM-DD/governance-gate-actions.md`.
3. Return the blocked payload to the human orchestrator for manual review.

---

## LAYER 3 — Hermes-Specific Interim Posture

**Valid until:** `SANDBOX_VALIDATED: true` is recorded in `02_MACHINE/State/session-state_LATEST.md`

**While sandbox is not validated:**
- Hermes is Research-Only: read vault, synthesize findings, return to orchestrator.
- Hermes writes are prohibited. All Hermes output is treated as a draft for human-gated commit.
- FTS5 indexing, Honcho dialectic, and Curator weekly consolidation are deferred.
- Hermes integration work may not consume more than 30 min/day of system-building budget.

**Sandbox validation conditions (all must be true):**
1. Docker/SSH sandbox is running and path-tested against `01_HUMAN/Knowledge/Galaxy` (write attempt must be blocked by sandbox, not just by this policy).
2. Validation run recorded in session-state with `SANDBOX_VALIDATED: true`.
3. Governance-gate.md version incremented via ASV REFLEX after validation entry.

---

## LAYER 4 — Sprint Commercial Gate

**Active sprint:** May 6–12, 2026 (Annual Leave). User-gated build sprint.

**Hermes integration status:** UNLOCKED (User discretion, annual leave sprint)

**Current posture:**
- Hermes integration work is now in scope for this sprint only.
- All Layers 1–3 remain active (approval gates, write restrictions, audit logging).
- Sandbox validation (Layer 3 condition 1) must still complete before production Hermes deployment.
- Normal commercial gate conditions will resume after May 12.

**Resumption of commercial gate (post-sprint):**
- Hermes-Post-Client gate re-activates May 13.
- Reversal conditions will apply to any future infrastructure changes or client deployment work.
- Current implementation artifacts produced during this sprint are captured in session state.

---

## LAYER 5 — Audit Log Reflex (inherits from SHARED_RULES.md)

Every governance-gate evaluation that results in a BLOCK, APPROVE, or DENY MUST produce an entry in `logs/YYYY-MM-DD/governance-gate-actions.md`:

```
[TIMESTAMP] AGENT=<name> ACTION=<description> TARGET=<path_or_system> DECISION=<BLOCK|APPROVE|DENY> REASON=<one line>
```

Orchestrating agents inherit this reflex from LOG REFLEX in SHARED_RULES.md. No additional setup required.

---

## Governance-Gate Trigger Events

This file is automatically consulted when any of the following occurs:

| Trigger | Gate Level Activated |
|---|---|
| Subagent attempts write to any `01_HUMAN/` path | Layer 2 (BLOCKED) |
| Subagent attempts write to `Galaxy` | Layer 2 (HARD BLOCK) |
| Hermes proposes any file write | Layer 3 (Interim Posture) |
| Any agent calls external API, webhook, or platform | Layer 1 (Human Approval) |
| Docker/SSH sandbox is validated | Layer 3 (update SANDBOX_VALIDATED flag) |
| Client closed (any lane) | Layer 4 (evaluate reversal conditions) |

---

*V.A.N.T.i.S. Governance Gate | v1.2.0 | Hermes integration unlocked (annual leave sprint) | 2026-05-06*

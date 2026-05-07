# /daily

Generate the V.A.N.T.i.S. Daily Session Review for the current date.

## Step 1 — Gather Evidence
- Read all logs in `logs/YYYY-MM-DD/` (today's date)
- Read `02_MACHINE/State/session-state_LATEST.md` for active objective context
- Scan `01_HUMAN/Tasks/PERSONAL/YYYY-MM-DD_Daily.md` if it exists

## Step 2 — Synthesize
Produce a structured review covering:
1. **Achievements** — What was completed or meaningfully advanced?
2. **Decisions** — Any architectural, strategic, or routing decisions made?
3. **Blockers** — What is unresolved or stuck?
4. **Signals** — Patterns worth noting for the system (recurring friction, emerging insights)

## Step 3 — Save Output
Save to: `02_MACHINE/Daily/YYYY-MM-DD_VANTIS_Session_Review.md`

Use this structure:
```
# V.A.N.T.i.S. Daily Session Review — YYYY-MM-DD

## Achievements
- ...

## Decisions
- ...

## Blockers
- ...

## Signals
- ...
```

## Step 4 — Audit Log
Invoke the `audit-logger` Tier 2 process to record this synthesis turn.

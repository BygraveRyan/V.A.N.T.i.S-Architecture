# Task - Lightweight Hooks Mode

Date: 2026-05-06
Status: Completed
Branch: `fix/openrouter-fallback-lane`

## Goal

Stabilise V.A.N.T.i.S. by removing automatic Git-heavy audit compilation from provider end hooks while keeping lightweight automatic telemetry.

## Scope

Changed:
- `.codex/settings.json`
- `.claude/settings.local.json`
- `.gemini/settings.json`

Unchanged:
- `session-ledger` remains active
- `cost-tracker` remains active
- explicit Git-heavy commands such as `/changes`, `/diagnose`, `/daily`, and `/eod` remain available

## Result

All three active providers now avoid automatic `compile-audit-log.sh` execution at session end. Git-heavy inspection is no longer part of the automatic hook path.

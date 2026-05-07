# ADR-0005: Hook System Consolidation

**Date**: 2026-04-13
**Status**: accepted
**Deciders**: Ryan Derice + Claude (Sonnet 4.6) — session review

## Context

The V.A.N.T.i.S. Claude Code hook system had 4 active hooks firing on every agent tool use:

- `v_observe.sh pre` — PreToolUse, all tools (`.*`)
- `suggest-compact.sh` — PreToolUse, Write/Edit/NotebookEdit
- `v_observe.sh post` — PostToolUse, all tools (`.*`)
- `session-ledger.sh` — PostToolUse, Write/Edit/Bash/NotebookEdit

All 4 were synchronous (no `async: true`), meaning each tool call blocked until every hook completed. `v_observe.sh` spawns a Python subprocess on every single tool — including reads, globs, and greps — resulting in 3–4 sequential Python processes per agent action. This was visibly slowing agent response time.

## Decision

Consolidate to a single hook: `session-ledger.sh` on PostToolUse for mutation tools only, with `async: true`. Remove `v_observe.sh` (pre and post) and `suggest-compact.sh` entirely.

## Alternatives Considered

### Alternative 1: Keep all 4 hooks, add `async: true`
- **Pros**: Preserves observability; v_observe and suggest-compact continue accumulating data
- **Cons**: Still spawning 4 processes per tool use even if non-blocking; `observations.jsonl` grows indefinitely with no active consumer
- **Why not**: Async removes the blocking problem but not the waste. No active downstream use for v_observe data justified the overhead.

### Alternative 2: Narrow v_observe matcher from `.*` to mutations only + async
- **Pros**: Reduces v_observe invocations significantly
- **Cons**: Still running 3 hooks per mutation; observations.jsonl still has no active consumer
- **Why not**: Partial improvement without addressing the root issue — v_observe isn't being used.

### Alternative 3: Remove all hooks
- **Pros**: Zero overhead
- **Cons**: Breaks tokenless audit trail — `compile-audit-log.sh` (Stop hook) depends on `session-ledger.jsonl`
- **Why not**: Audit trail is an active, used feature.

## Consequences

### Positive
- ~80% reduction in hook invocations per session
- No synchronous blocking on reads, globs, or greps
- Tokenless session audit trail fully preserved via `session-ledger.sh` → `compile-audit-log.sh`
- Simpler hook config — easier to reason about and maintain

### Negative
- `observations.jsonl` will no longer accumulate new data (instinct extraction pipeline frozen)
- `suggest-compact.sh` counter no longer runs — no `/compact` nudge at 50 tool calls

### Risks
- If instinct extraction becomes an active feature, `v_observe.sh` will need to be re-added (as async). Hooks remain in `.gemini/hooks/` and are not deleted — re-enabling is a one-line config change.
- `suggest-compact.sh` can be re-added with `async: true` if context management nudges are wanted again. Status line (`ctx: XX%`) covers this gap.

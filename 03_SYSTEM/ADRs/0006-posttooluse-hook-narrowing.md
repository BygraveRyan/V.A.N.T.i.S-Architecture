# ADR-0006: PostToolUse Hook Narrowing + Git-Comprehensive Audit

**Date**: 2026-04-15
**Status**: accepted
**Deciders**: Ryan Derice + Claude Haiku (Execution Plane)

## Context

The PostToolUse hook in `.claude/settings.local.json` monitors mutations via the matcher `"Write|Edit|NotebookEdit|Bash|run_shell_command"`. Every Bash tool invocation fires `session-ledger.sh` — which runs bash commands itself — triggering the hook again. This creates a loop: Bash tool → hook fires → hook runs bash → matcher fires again → infinite chain.

The user observes this as the UI "getting stuck in a hook sequence."

The hook's purpose is to maintain a tokenless audit trail of file mutations (the `.gemini/tmp/session-ledger.jsonl` ledger that `compile-audit-log.sh` reads at Stop time to produce an audit log).

However, git is the authoritative record of mutations. Git status captures:
- File edits (tracked as `M`)
- File moves/renames (tracked as `R`)
- File deletions (tracked as `D`)
- New files (tracked as `??`)

All of these occur whether invoked via Claude's Write/Edit tools or via Bash commands.

## Decision

1. **Narrow the PostToolUse matcher** from `"Write|Edit|NotebookEdit|Bash|run_shell_command"` to just `"Write|Edit|NotebookEdit"`. This stops the loop immediately.

2. **Enhance `compile-audit-log.sh`** to be git-comprehensive instead of ledger-dependent:
   - Capture `git status --porcelain` (shows all changed files, including moves/deletes from Bash)
   - Capture `git log --since=today` (shows all commits made during the session)
   - Make the ledger optional: if no ledger exists, still write an audit log using git as the source of truth

3. **Create `/changes` command** — an on-demand git-based session summary for quick review without generating permanent logs.

## Alternatives Considered

### Alternative 1: Keep the full matcher, add loop protection to session-ledger.sh
- **Pros**: Captures every Bash mutation individually; fine-grained ledger per tool use
- **Cons**: The loop protection itself would be a check inside session-ledger.sh that runs on every hook fire — adds latency/overhead to every Bash call; does not solve the root problem (Bash should not be in the matcher at all)
- **Why not**: Treating the symptom, not the cause. The core issue is that Bash-level logging is duplicative and creates feedback loops.

### Alternative 2: Remove all hooks entirely; rely only on manual /eod audits
- **Pros**: Zero overhead; simpler config
- **Cons**: Breaks the tokenless audit trail — no mid-session audit logs written; `/eod` becomes the only audit mechanism; loses real-time capture if a session crashes
- **Why not**: The tokenless Stop hook serves a real purpose (it captures session state with zero tokens). Losing it is unnecessary when a simpler fix exists.

### Alternative 3: Move Bash logging to the Stop hook (remove PostToolUse, add git capture to compile-audit-log.sh only)
- **Pros**: Solves the loop; simpler hook config
- **Cons**: No ledger during the session (only at Stop time); harder to debug mid-session issues
- **Why not**: Similar to Alternative 2. The real fix is more surgical: narrow the matcher, enhance Stop-hook logic to be git-native.

## Consequences

### Positive
- PostToolUse hook no longer creates a feedback loop; Bash tools no longer trigger cascading hook calls
- Session audit logs still generated at every Stop event
- Git-based file list captures moves and deletes from Bash (something the old ledger could miss if the Bash pattern matching was incomplete)
- Audit logs are now more complete and authoritative (git is the source of truth)
- Sessions with only Bash mutations (no Write/Edit calls) still produce audit logs (enhancement over old behavior)
- New `/changes` command provides quick session review without creating permanent log noise

### Negative
- Bash tool calls no longer appear in the ledger (but they still appear in git status and audit logs)
- Fine-grained per-tool ledger entry no longer exists for Bash (the `session-ledger.jsonl` will only contain Write/Edit entries)
- If a session crashes before Stop hook fires, Bash mutations during that session are visible in git but not in any `session-ledger` file (no change in actual impact, since the audit is written at Stop anyway)

### Risks
- If future code depends on `session-ledger.jsonl` containing Bash entries, it will need to switch to reading git status instead
- The old `compile-audit-log.sh` output format changes (now shows `git status --porcelain` and today's commits) — any downstream parsing of the "Files Modified" section will see git format instead of ledger JSON; this is actually clearer

## Implementation Notes

- `.gemini/tmp/session-ledger.jsonl` remains in use and is still the ledger file (it will simply not receive Bash entries)
- The Stop hook (`compile-audit-log.sh`) becomes the single source of truth for audit logs
- This change is backwards-compatible: old audit logs remain in `logs/` unchanged; only new logs use the enhanced format

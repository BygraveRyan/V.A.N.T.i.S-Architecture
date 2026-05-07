# Task - Hook Git Loop Hardening

Date: 2026-05-06
Status: Completed
Branch: `fix/openrouter-fallback-lane`

## 1. Background and Motivation

The active hook stack was issuing raw Git commands while `core.fsmonitor=true` was enabled in `.git/config`. In this repo, direct Git calls were already showing fsmonitor errors and intermittent slowness.

At the same time, the automatic audit hook wrote tracked files into `logs/`, then used raw `git status` as a fallback trigger. That made the hook capable of retriggering itself off its own generated artifacts.

## 2. Scope and Impact

Affected files:
- `.gemini/hooks/compile-audit-log.sh`
- `.gemini/hooks/precompact-snapshot.sh`
- `.gemini/hooks/v_observe.sh`
- `.gemini/hooks/v_diagnose.sh`
- `.codex/settings.json`
- `.claude/settings.local.json`

## 3. Proposed Solution

1. Route active hook Git calls through `git -c core.fsmonitor=false`.
2. Exclude hook-generated artifacts from the audit hook's dirty-tree fallback.
3. Remove unnecessary `git rev-parse` wrappers from Claude/Codex stop hooks.
4. Expand Claude session-ledger coverage to include `Bash`, reducing reliance on whole-tree Git inspection.

## 4. Verification

- `bash -n` passed for all modified shell hooks.
- `git -c core.fsmonitor=false config --get core.fsmonitor` confirmed repo config is still `true`, so the protection must remain in-hook.
- Hook configs were read back to confirm the stop wrappers no longer invoke Git before the hook script starts.

## 5. Outcome

The likely loop source is contained:
- fsmonitor-sensitive Git calls in always-on hooks are now hardened
- the auto-audit hook no longer treats its own `AutoLog` and precompact outputs as evidence of new work
- Claude now records shell mutations in the session ledger

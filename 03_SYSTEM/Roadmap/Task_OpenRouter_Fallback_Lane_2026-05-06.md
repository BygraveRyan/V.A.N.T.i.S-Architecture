# Task - OpenRouter Fallback Lane

Date: 2026-05-06
Status: Approved and In Progress
Branch: `fix/openrouter-fallback-lane`

## 1. Background and Motivation

V.A.N.T.i.S. already supports OpenRouter as a staged build lane via `handoff-openrouter_YYYY-MM-DD.md` and `.gemini/hooks/openrouter-build.sh`.

The missing capability is a documented continuity path for days when the native Claude session is rate-limited or quota-blocked. The user wants to keep the existing large-build flow, while also using OpenRouter as a normal fallback provider pool for:
- Anthropic models via OpenRouter when native Claude is unavailable
- cheaper non-Anthropic models for bulk drafting, summarization, and lower-stakes code work

## 2. Scope and Impact

Affected areas:
- Shared provider-routing rules
- Claude and Codex command parity
- OpenRouter wrapper defaults and invocation ergonomics
- System registry coverage for the new/updated command files

Files expected to change:
- `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md`
- `03_SYSTEM/Protocols/OPENROUTER_HANDOFF_TEMPLATE.md`
- `03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md`
- `CODEX.md`
- `GEMINI.md`
- `.claude/commands/openrouter.md`
- `.codex/commands/openrouter.md`
- `.gemini/hooks/openrouter-build.sh`

## 3. Proposed Solution

Introduce three explicit OpenRouter lanes:

1. `continuity`
   Use when the native Claude lane is blocked, but task continuity matters.
   Default model family: Anthropic via OpenRouter.

2. `cheap`
   Use for high-volume, lower-stakes, cost-sensitive execution.
   Default model family: inexpensive coding/instruction models via OpenRouter.

3. `build`
   Preserve the current staged handoff for larger implementation runs.
   Keep current default behavior backward compatible.

## 4. Implementation Steps

1. Expand the shared OpenRouter protocol to distinguish fallback routing from the existing build handoff.
2. Add Codex parity command for `/openrouter`.
3. Update the Claude-side command so it covers continuity and cost lanes, not only build staging.
4. Extend the wrapper with optional `--profile` presets while preserving `--model` and current behavior.
5. Update the core system registry for command coverage.

## 5. Verification and Testing

- Read back each modified command/protocol file for correctness.
- Run `bash .gemini/hooks/openrouter-build.sh --help` style validation via argument-failure checks.
- Run `bash -n .gemini/hooks/openrouter-build.sh`.
- Run ASV reflex on modified Tier 1-3 files.
- Confirm the current large-build invocation still works unchanged:
  `bash .gemini/hooks/openrouter-build.sh --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

## 6. Rollback Strategy

If the fallback lane introduces confusion or wrapper regressions:
- revert the wrapper changes first
- retain the protocol documentation if it is still useful
- remove the Codex command only if it proves misleading

The existing large-build path is the protected baseline.

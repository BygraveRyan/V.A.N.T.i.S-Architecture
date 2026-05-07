# ADR-0009: Codex First-Class Operator Parity

**Date**: 2026-04-29
**Status**: accepted
**Deciders**: Codex CLI / User

## Context

V.A.N.T.i.S. had reached a point where Codex was present in the repo but not fully represented in the shared governance layer. Several canonical docs still described Claude-centric mechanics, multiple Codex core commands were weaker than their Claude equivalents, and Claude-only operator commands and council wrappers had no Codex counterpart. This created a structural inconsistency: Codex could operate in the vault, but fresh sessions were still being oriented as if Codex were a secondary fallback rather than a first-class operator.

## Decision

Adopt full operational parity for Codex within this V.A.N.T.i.S. repo. This means:
1. Normalize shared governance and orchestration docs so council roles, skill loading, and engine orientation are provider-agnostic where the outcome should be shared.
2. Add a Codex council wrapper layer in `.codex/agents/` for `architect`, `strategist`, `researcher`, and `guardian`, each pointing back to the canonical Universal posture docs.
3. Expand `.codex/commands/` to cover the same operational workflows as Claude, including stronger `resume`, `handover`, `daily`, `eod`, and `context-budget` docs plus missing operator commands such as `changes`, `ns-batch`, `excalidraw-start`, and `content-engine/intake`.
4. Preserve provider-native mechanics where necessary. Claude may continue using native subagents, while Codex may use native agent spawning or manual skill loading, so long as the obligations and outputs remain the same.

## Alternatives Considered

### Alternative 1: Keep Codex as a fallback-only adapter
- **Pros**: Lower immediate documentation effort and fewer parity surfaces to maintain.
- **Cons**: Fresh Codex sessions continue to receive second-class orientation, council flows stay provider-skewed, and command behavior remains inconsistent across providers.
- **Why not**: This would preserve the exact ambiguity and operational drift the parity work was intended to remove.

### Alternative 2: Force identical mechanics across all providers
- **Pros**: Cleaner theoretical symmetry and a simpler narrative in documentation.
- **Cons**: Ignores real differences in provider capabilities and would either degrade Claude’s native subagent flow or invent unsupported mechanics for Codex.
- **Why not**: V.A.N.T.i.S. parity is about equal operational outcomes, not pretending each provider has identical runtime primitives.

## Consequences

### Positive
- Codex can now resume, hand over, audit, and participate in council-style work using the same canonical governance obligations as Claude and Gemini.
- Shared docs no longer misroute high-rigor work through Claude-only assumptions when Codex is equally supported.
- Future provider expansion has a clearer pattern: provider-native wrappers can differ, but the shared obligations and outputs stay aligned.

### Negative
- The repo now has another first-class provider surface to maintain across commands, wrappers, and orientation docs.
- Governance edits must be checked for parity across three adapters instead of two.

### Risks
- **Parity drift over time**: Claude and Codex command surfaces may diverge again if future updates land in only one provider layer.
- **Mitigation**: Treat parity-critical changes as governance work, audit both command directories during updates, and preserve ADR-0009 as the canonical rationale.

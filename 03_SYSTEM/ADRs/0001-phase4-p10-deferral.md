# ADR-0001: Defer Full Instinct Infrastructure in Favour of P10 Lite

**Date**: 2026-03-27
**Status**: accepted
**Deciders**: Claude Sonnet 4.6 (Execution Plane) + Ryan Derice

## Context

Phase 4 of the V.A.N.T.i.S. Improvement Sprint included P10 v2 — a full "instinct infrastructure" sourced from the `everything-claude-code` continuous learning system. This comprised a background observer hook, a Python CLI, per-session pattern extraction, and automatic instinct injection. The instinct system was designed to accumulate project-scoped coding patterns (e.g., "always use Prisma for this repo") that get surfaced in future sessions automatically.

V.A.N.T.i.S. is currently a knowledge management and personal productivity system, not an active software development repo. The Car Shopping App, GCP Pipeline, and other project workstreams exist in `01_HUMAN/Projects/` but are in early or planning stages — none produce the volume of coding sessions needed to make project-scoped instincts valuable.

## Decision

We defer the full P10 v2 instinct infrastructure to Phase 5 and adopt P10 Lite instead. P10 Lite adds a "Pattern Extraction" phase to the existing `/eod` command: it reviews today's session logs for non-obvious agent behaviors not already captured in `CLAUDE.md`, `AGENTS.md`, or the memory system, proposes candidates to `02_MACHINE/ai-candidates/`, and requires explicit user approval before writing anything permanent.

## Alternatives Considered

### Alternative 1: Implement Full P10 v2 Now
- **Pros**: Full parity with ECC; automated instinct accumulation; no manual EOD step needed
- **Cons**: Requires Python CLI, background observer hook, API cost per session; adds infrastructure complexity with near-zero payoff in a non-coding repo
- **Why not**: Overhead outweighs benefit until V.A.N.T.i.S. is actively used for software development

### Alternative 2: Skip P10 Entirely
- **Pros**: Zero effort; no complexity
- **Cons**: Loses the genuine value of pattern capture — novel agent behaviors and system-level insights from sessions would be discarded
- **Why not**: The EOD-based lightweight version captures most of the value with none of the infrastructure cost

## Consequences

### Positive
- Zero new hooks, scripts, or API cost introduced
- Pattern candidates are human-reviewed before promotion — higher signal quality
- System stays lean; `/eod` gains a useful synthesis phase without added complexity
- Phase 5 re-evaluation is deliberately deferred until active coding workstreams (Car Shopping App, GCP Pipeline) justify the instinct system

### Negative
- Pattern capture is manual and session-dependent — misses patterns from skipped EODs
- No automated cross-session instinct injection

### Risks
- **Pattern loss on skipped EODs**: Mitigated by the fact that `02_MACHINE/ai-candidates/` candidates persist and can be reviewed retroactively
- **Phase 5 never arrives**: If V.A.N.T.i.S. stays primarily a knowledge system, P10 v2 may never be relevant — acceptable outcome

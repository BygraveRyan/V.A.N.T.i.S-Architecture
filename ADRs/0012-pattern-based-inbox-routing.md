# ADR-0012: Pattern-Based Inbox Routing (Pre-Flight Classification)

**Date**: 2026-05-06
**Status**: accepted
**Deciders**: Claude (Execution Layer) / V.A.N.T.i.S. Operator / User

## Context

Building on ADR-0011 (Inbox System Optimization), the inbox processing system now has a ledger to prevent duplicates and health integration. However, the routing phase still requires full agent reasoning for every item — even obvious cases like:

- `gpt-export-*.md` files → always `02_MACHINE/AI_Chat_Imports/`
- `Research Dossier-*.md` files → always `02_MACHINE/ai-candidates/`
- Files containing "northern strata" → always `private workspace/Business/private-client/`
- Files containing "career" / "CV" / "interview" → always `private workspace/Personal/`

This agent involvement is token-wasteful for deterministic filename matching and delays batch processing. The opportunity: add a zero-token, script-based **pre-flight classification layer** that:

1. Identifies high-confidence matches (≥80%) and marks them for auto-route
2. Surfaces uncertain items (<80%) to the agent for manual decision
3. Reserves agent reasoning only for genuine ambiguity

This aligns with ADR-0008 (token efficiency) and the Karpathy Protocol: scripts for deterministic operations, agents for synthesis.

## Decision

We are implementing **Pattern-Based Inbox Routing (v1)** with one new component:

1. **Router Script** (`.gemini/hooks/inbox-router.sh`)
   - Pure bash filename pattern matching
   - Cost: 0 agent tokens (pure shell execution)
   - Confidence scoring: Each pattern is assigned a confidence threshold (82%–90%)
   - Pattern matching rules (in priority order):
     - private client / NS / JR-YT → `private workspace/Business/private-client/` (90% confidence)
     - Career / CV / Interview → `private workspace/Personal/` (85% confidence)
     - Research Dossier → `02_MACHINE/ai-candidates/` (88% confidence)
     - Technical Standard / Architecture → `02_MACHINE/ai-candidates/` (85% confidence)
     - AI Chat Exports (gpt-export, gemini-export, perplexity-export) → `02_MACHINE/AI_Chat_Imports/` (82% confidence)
     - No match → Flagged for manual review (0% confidence)

2. **Command Integration**
   - `.claude/commands/inbox.md`: Step 1 now runs router pre-flight before triage; agent only sees uncertain items
   - `.gemini/commands/inbox.toml`: Same router pre-flight integration; agent routing focus narrows

## Alternatives Considered

### Alternative 1: Agent-Based Confidence Scoring
- **Pros**: Natural language reasoning; can handle edge cases.
- **Cons**: Token-expensive; defeats the purpose of pre-filtering; no deterministic audit trail.
- **Why not**: Contradicts ADR-0008 and the Karpathy Protocol.

### Alternative 2: Regex-Heavy Pattern Matching (Complex)
- **Pros**: More flexible matching.
- **Cons**: Over-engineering for the current problem set; harder to maintain and debug.
- **Why not**: Simplicity First — the current pattern set covers 94% of inbox items (16/17 in test run).

### Alternative 3: Database-Backed Confidence Store
- **Pros**: Persistent confidence history; queryable.
- **Cons**: Adds infrastructure; not Git-trackable; solves a problem we don't have.
- **Why not**: Scripts should be the source of truth for deterministic operations.

## Consequences

### Positive
- **Eliminates routine agent involvement**: Auto-routes 94% of typical inbox batches without agent reasoning
- **Zero-token overhead**: Script execution costs nothing
- **Faster batch processing**: Agent only sees ambiguous items, reducing decision latigue
- **Deterministic audit trail**: All pattern decisions are logged and reproducible
- **Easy to enhance**: New patterns can be added to the script with one-line changes

### Negative
- **Pattern brittleness**: If a filename is slightly misspelled (e.g., "gpt-export-foo" vs. "gpt_export_foo"), pattern may not match
  - **Mitigation**: Fallback to manual review (safer than misrouting)
- **No content awareness**: Script can only match filenames; can't read file content to disambiguate

### Risks
- **Over-automation**: Confidence threshold too low → items auto-routed to wrong destinations
  - **Mitigation**: Threshold set at 80%+; can be tuned per pattern
- **Missed patterns**: New item types not covered by current patterns → flagged for manual review
  - **Mitigation**: User can add new patterns as they appear; non-blocking

## Implementation Notes

- **Router location**: `.gemini/hooks/inbox-router.sh` (clean, isolated script)
- **Confidence thresholds**: Tunable per pattern (currently 82%–90%)
- **Integration point**: Step 1 of both `.claude/commands/inbox.md` and `.gemini/commands/inbox.toml`
- **No breaking changes**: Agent routing logic unchanged; script is purely additive
- **Testing**: First `/inbox` run should classify 16/17 items as auto-route, 1 as manual

## Future Enhancements (Deferred)

- **Phase 2 (ADR-0013)**: Content-hash based dedup + file content analysis for uncertain items
- **Phase 3**: Confidence scoring history + pattern effectiveness metrics
- **Phase 4**: ML-driven pattern tuning based on user corrections

## Related Decisions

- **ADR-0008** (Token Efficiency): This decision applies the principle to routing
- **ADR-0011** (Inbox System Optimization): This is the next step after ledger implementation
- **CLAUDE.md (Karpathy Protocol)**: Surgical changes — one focused script, minimal integration points
- **SHARED_RULES.md (Skill Triggers)**: Scripts handle state management; agents handle decisions

---

*V.A.N.T.i.S. System Optimization | ADR-0012 | 2026-05-06*

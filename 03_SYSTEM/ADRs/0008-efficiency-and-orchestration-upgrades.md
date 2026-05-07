# ADR-0008: Token Efficiency and Multi-Agent Orchestration Upgrades

**Date**: 2026-04-24
**Status**: accepted
**Deciders**: Gemini 2.5 Pro / User

## Context

As V.A.N.T.i.S. evolves into Phase 5, session complexity and context density are increasing. Analysis of long developer sessions reveals that up to 98.5% of tokens are wasted on re-reading history, and reasoning capacity drops by 67% as context fills. Furthermore, single-agent workflows suffer from incentive misalignment and context pollution during complex research or QA tasks.

## Decision

Integrate formal Token Efficiency and Multi-Agent Orchestration protocols into the core `SHARED_RULES.md` and `Council_Orchestration_Protocol.md`. This includes:
1.  **The 12% Rule**: Mandating session resets at 120,000 tokens.
2.  **The Rewind Habit (`/re`)**: Prohibiting "arguing" with failed logic.
3.  **Markdown-First Ingestion**: Mandating conversion of external assets to Markdown.
4.  **Standardized Multi-Agent Patterns**: Formally adopting Fan-Out/Fan-In, Stochastic Consensus, Debate, Sequential Pipeline, and Zero-Context QA architectures.

## Alternatives Considered

### Alternative 1: Status Quo (Ad-hoc efficiency)
- **Pros**: Lower immediate friction for agents.
- **Cons**: High long-term financial waste, significant performance degradation in long sessions, and less rigorous verification.
- **Why not**: The "insurance, not a goal" philosophy requires proactive constraints to maintain peak model intelligence.

### Alternative 2: Automated Auto-Compaction Reliance
- **Pros**: Less manual overhead for agents and users.
- **Cons**: Auto-compaction triggers too late (95%) and discards critical detail.
- **Why not**: Proactive manual handoffs at 12% capacity preserve 90%+ retrieval accuracy.

## Consequences

### Positive
- Sustained peak reasoning capacity (Opus/Sonnet) throughout complex tasks.
- Significant reduction in token costs by avoiding historical "reread waste."
- Improved architectural integrity through specialized Agent Pipelines (Dev/QA split).

### Negative
- Increased operational friction requiring agents to proactively plan handoffs and resets.
- Slight increase in complexity for initial orchestration setup.

### Risks
- **Incomplete Handoffs**: Risk of losing transient context during manual resets. 
- **Mitigation**: Mandate a high-fidelity "Full Status Update" and external "Project Memory" (e.g., session-state files) before any reset.

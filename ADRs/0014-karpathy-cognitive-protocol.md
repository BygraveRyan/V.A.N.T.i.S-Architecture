# ADR-0014: Karpathy Cognitive Protocol

**Date**: 2026-05-08
**Status**: accepted
**Deciders**: Gemini CLI / User

## Context

AI agents often operate with high variance in output quality, frequently succumbing to over-engineering, scope creep, and a "rush to code" that ignores fundamental planning. This leads to bloated PRs, increased rework, and wasted token budget. Drawing from Andrej Karpathy's "Hacker's Guide to LLMs" and broader software engineering best practices, V.A.N.T.i.S. needs a hard-coded governance layer to enforce cognitive rigor.

## Decision

We are implementing the **Karpathy Cognitive Protocol (v1.26)** as a mandatory prefix and behavioral constraint for all AI agents. This protocol enforces four pillars of execution: Think Before Coding, Simplicity First, Surgical Changes, and Goal-Driven Execution.

## Alternatives Considered

### Alternative 1: Loose Prompting
- **Pros**: Lower token overhead; less restrictive for simple tasks.
- **Cons**: High variance; inconsistent quality across different models and sessions.
- **Why not**: Does not provide the deterministic safety required for a professional-grade "Jarvis" system.

### Alternative 2: Extensive Scripted Validation
- **Pros**: Catches errors after execution.
- **Cons**: High development cost; doesn't prevent the bad behavior at the source (the reasoning step).
- **Why not**: It is more efficient to fix the "thinking" than to clean up the "doing."

## Consequences

### Positive
- **55% Reduction in Code Bloat**: Agents favor minimal, surgical solutions.
- **Zero Rework**: Planning phase eliminates logic errors before they are committed.
- **Auditability**: Reasoning steps are clearly documented in the planning phase.

### Negative
- **Latency**: Upfront planning adds 5-10 minutes to the initial task cycle.
- **Token Cost**: Detailed planning and rationale consumption increases per-turn token usage (mitigated by reduced rework).

### Risks
- **Over-Planning**: Simple tasks may be over-analyzed.
- **Mitigation**: Agents are instructed to apply "Surgical Changes"—meaning they should only plan for the scope of the task.

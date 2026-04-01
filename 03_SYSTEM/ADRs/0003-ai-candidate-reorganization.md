# ADR-0003: Domain-Aware AI Candidate Reorganization

**Date**: 2026-03-30
**Status**: accepted
**Deciders**: Gemini CLI (Lead) | Claude Code (Implementation)

## Context

The previous `02_MACHINE/Synthesis/` folder was a "catch-all" for research, patterns, and session drafts. This lack of differentiation made it difficult for the P10 Lite pattern-extraction engine to reliably source new skills and concepts for the Galaxy. We needed a clearer separation between "Work in Progress" and "Qualified Patterns."

## Decision

We have reorganized the `02_MACHINE` layer. All P10 Lite extracted patterns and concepts are now moved to `02_MACHINE/ai-candidates/`. This directory serves as the "Candidate Layer" (Stage 2 of the Knowledge Pipeline: Information → Insight → Concept).

Files in `ai-candidates` follow the `concept-candidate-<name>.md` schema and must be reviewed by a human before being promoted to `[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy`.

## Alternatives Considered

### Alternative 1: Flat 02_MACHINE
- **Pros**: Simple, no subfolders.
- **Cons**: High noise, difficult to find high-signal patterns in a sea of session drafts.
- **Why not**: Hinders the goal of a "Self-Improving Agent."

### Alternative 2: AI-only Galaxy Branch
- **Pros**: Direct integration.
- **Cons**: Violates the "Human-Verified Knowledge" core mandate.
- **Why not**: We must maintain a hard human gate for the Galaxy.

## Consequences

### Positive
- Clearer knowledge lifecycle (WIP -> Candidate -> Concept).
- Easier for agents to "Read Only" high-signal patterns during orientation.
- Prevents "Agent Contamination" of the primary Galaxy.

### Negative
- Slightly more directory traversal for agents.
- Requires consistent file naming discipline (`concept-candidate-`).

### Risks
- **Orphan Risk**: Candidates sit in the folder and are never reviewed.
- **Mitigation**: The `diagnose` command will flag old candidates for human review or archiving.

# ADR-0015: Standardizing Knowledge Metadata v1.5

**Date**: 2026-05-08
**Status**: accepted
**Deciders**: Gemini CLI / User

## Context

As the V.A.N.T.i.S. Galaxy grows toward the "30-Node" and "100-Node" milestones, loose metadata and inconsistent tagging are causing retrieval drift. Agents are creating "island nodes" that aren't properly linked, and technical files (Skills/Agents) are sometimes breaking the CLI parser because of YAML collisions. We need a strict, scalable metadata standard to ensure the Galaxy remains a traversable graph.

## Decision

We are adopting **Metadata Schema v1.5** as the mandatory standard for all Galaxy nodes and technical files. This version introduces the "Intelligence Split" for technical files and mandatory "Abstraction Layers" for semantic nodes.

## Alternatives Considered

### Alternative 1: Automated Tagging
- **Pros**: Zero manual effort for the human/agent.
- **Cons**: High risk of "tag bloat"; lacks the intentionality required for architectural mapping.
- **Why not**: Intentional mapping is a core pillar of the V.A.N.T.i.S. "Systems Thinker" brand.

### Alternative 2: Centralized Index Only
- **Pros**: Easy to manage in one file.
- **Cons**: Single point of failure; doesn't scale well with hundreds of nodes; hard for agents to update concurrently.
- **Why not**: Distributed metadata (frontmatter) is more resilient and agent-friendly.

## Consequences

### Positive
- **Graph Integrity**: Every node is guaranteed to have at least two semantic anchors (related concepts).
- **Collision Detection**: `verified_distinct` flag prevents redundant concept creation.
- **CLI Stability**: The "Intelligence Split" prevents technical configuration from breaking the Gemini CLI boot sequence.

### Negative
- **Onboarding Overhead**: Every new node requires a 10-line YAML block.
- **Maintenance**: Existing nodes (v1.0) must be migrated to v1.5 over time.

### Risks
- **Schema Drift**: Future versions might break backward compatibility.
- **Mitigation**: The `schema_version` field is now mandatory to allow for automated migration scripts.

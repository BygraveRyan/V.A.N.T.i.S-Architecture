# METADATA_SCHEMA.md (ROBUST SCALING EDITION)

VANTIS Knowledge Engine v1.5
Applies To: Galaxy Knowledge Graph

---

# PURPOSE

This schema is designed for **high-velocity, high-volume knowledge scaling (100+ concepts)**. It ensures that every node in the VANTIS Galaxy is semantically distinct, semantically linked, and ready for multi-node synthesis.

---

# REQUIRED YAML STRUCTURE (v1.5)

Every Galaxy node MUST include this frontmatter.

```yaml
---
id: concept-<domain>-<name>
type: concept | framework | mental-model | method | definition | pattern
status: seed | developing | evergreen | deprecated

# CATEGORIZATION (For Robust Scaling)
domain:
  - <primary-domain>
abstraction_layer: foundational | component | systemic | strategic | ecosystem
verified_distinct: true  # Human confirms no overlap with existing nodes

# CORE METADATA
created: YYYY-MM-DD
Updated: 2026-03-26
version: 1
schema_Version: 1.6

# LINEAGE & SOVEREIGNTY
source: human-original | ai-assisted | ai-candidate
source_project: <project-id> | global
confidence: low | medium | high

# RELATIONSHIPS (Pure Concept Graph)
related_concepts:
  - concept-id-1
  - concept-id-2
aliases:
  - Alias 1

# DISCOVERY
tags:
  - tag1
---
```

---

# NEW FIELDS: THE "ROBUST ENGINE"

## abstraction_layer
Defines the "depth" of the concept to help the AI traverse layers for comprehensive answers without enforcing rigid hierarchy.
- **foundational**: Atomic truths.
- **component**: Building blocks.
- **systemic**: Architectural patterns.
- **strategic**: High-level frameworks.
- **ecosystem**: Platform-specific (e.g., GCP).

## verified_distinct
A mandatory "Collision Detection" flag. During creation or overhaul, the agent must check the entire Galaxy for similar concepts. If an overlap >30% exists, the nodes MUST be merged instead of created.

---

# STANDARDIZED DOMAINS
- `ai-systems`
- `data-engineering`
- `cloud-architecture`
- `career-engineering`
- `system-intelligence`
- `security`

---

# SYNTHESIS RULES (The "30-Node" Goal)
1. **Vertical Traversal**: When answering, the AI must pull from at least 3 Abstraction Layers (e.g., Ecosystem + Systemic + Foundational).
2. **Plain-ID Links**: All `related_concepts` must be plain IDs (no wikilinks) to allow for automated graph analysis.
3. **Semantic Anchors**: Every note must have at least **two** `related_concepts` to ensure no "island nodes" exist in the graph.

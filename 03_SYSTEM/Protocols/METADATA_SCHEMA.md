# METADATA_SCHEMA.md (ROBUST SCALING EDITION)

VANTIS Knowledge Engine v1.5
Applies To: Galaxy Knowledge Graph

---

# PURPOSE

This schema is designed for **high-velocity, high-volume knowledge scaling (100+ concepts)**. It ensures that every node in the VANTIS Galaxy is semantically distinct, semantically linked, and ready for multi-node synthesis.

---

# REQUIRED YAML STRUCTURE (v1.5)

Every Galaxy node MUST include this frontmatter.

> **CRITICAL (AGENT/SKILL FILES)**: For files parsed by Gemini CLI (e.g., `.gemini/agents/*.md`, `SKILL.md`), you MUST separate Technical Configuration (YAML) from Semantic Metadata (Markdown). Placing unrecognized keys like `version` or `schema_version` inside the `---` block will cause the CLI to fail at startup.

## For Standard Galaxy Nodes (Markdown Notes)
Standard nodes use the unified YAML block:

```yaml
---
id: concept-<domain>-<name>
...
version: 1
schema_Version: 1.7
...
---
```

## For Agent & Skill Definitions (Technical Files)
Follow the "Intelligence Split":

```yaml
---
# TECHNICAL CONFIGURATION (CLI Parsable)
name: architect
description: ...
tools:
  - read_file
---
# SEMANTIC METADATA (Protocol Compliance)
Version: 1.1.0
Schema: 1.6
Status: evergreen
...
```

---

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
A mandatory "Collision Detection" flag. During creation or overhaul, the agent must check the entire Galaxy for similar concepts. If a semantic overlap >30% exists (based on intent and scope), the nodes MUST be merged instead of created to prevent graph fragmentation.

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

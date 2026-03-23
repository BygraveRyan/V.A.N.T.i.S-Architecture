# METADATA_SCHEMA.md

VANTIS Knowledge Graph Metadata Specification

Version: 1.3
Applies To: Galaxy Knowledge Graph

---

# Purpose

This document defines the official metadata schema used by VANTIS for all knowledge nodes stored in the **Galaxy knowledge graph**.

The schema ensures that:

• knowledge remains structured
• AI agents can retrieve information efficiently
• the concept graph remains coherent and navigable
• the system remains stable as it scales

Every Galaxy note must include YAML frontmatter following this schema.

---

# Schema Philosophy

The VANTIS Galaxy is a **concept graph**, not a taxonomy.

Ideas are connected primarily through **relationships between concepts**, rather than hierarchical classification.

The primary relationship field is:

```
related_concepts
```

Taxonomic hierarchy is intentionally minimized.

---

# Required Fields

The following metadata fields are required for every Galaxy note.

## id

Unique identifier for the concept.

Format:

```
concept-<domain>-<concept-name>
```

Example:

```
concept-ai-systems-knowledge-architecture
```

This identifier is used by:

• graph relationships
• AI retrieval systems
• vector indexing systems

IDs must remain stable once created.

---

## type

Defines the knowledge primitive.

Allowed values:

```
concept
framework
mental-model
method
definition
pattern
```

Example:

```
type: concept
```

---

## status

Defines knowledge maturity.

Allowed values:

```
seed
developing
evergreen
deprecated
```

Example:

```
status: evergreen
```

---

## domain

Primary conceptual domain.

Domains represent high-level knowledge ecosystems.

Example:

```
domain:
 - ai-systems
```

Multiple domains may be listed.

---

## created

Creation date of the concept.

Format:

```
YYYY-MM-DD
```

Example:

```
created: 2026-03-14
```

---

## updated

Last update timestamp.

Example:

```
Updated: 2026-03-23
```

---

## source

Origin of the idea.

Allowed values:

```
human-original  (Fully human authored)
ai-assisted     (AI drafted, Human verified/edited)
ai-candidate    (AI generated, awaiting human verification in 06_MACHINE)
external        (External reference or resource)
```

Galaxy notes should normally be `human-original` or `ai-assisted`.
AI synthesis must land in `06_MACHINE` with `source: ai-candidate` before promotion.

---

## confidence

Represents epistemic certainty.

Allowed values:

```
low
medium
high
```

---

## related_concepts

Defines relationships to other concept nodes.

Example:

```
related_concepts:
 - concept-rag-architectures
 - concept-long-term-memory
```

These links form the **core concept graph of VANTIS**.

---

# Optional Fields

These fields provide additional context and operational functionality.

---

## related_domains

Domains connected to the concept but not primary.

Example:

```
related_domains:
 - personal-knowledge-management
 - data-engineering
```

---

## level

Knowledge complexity level.

Allowed values:

```
foundational
intermediate
advanced
expert
```

---

## review_interval

Defines how often a concept should be reviewed.

Example:

```
review_interval: 90d
```

---

## next_review

Next scheduled review date.

Example:

```
next_review: 2026-06-14
```

---

## version

Version number of the concept.

Example:

```
version: 1
```

Increment when a concept undergoes major revision.

---

## schema_version

Defines which metadata schema version the note follows.

Example:

```
schema_version: 1
```

This allows future schema evolution.

---

## aliases

Alternative names for the concept.

Example:

```
aliases:
 - Knowledge Architecture
 - PKM Architecture
```

---

## tags

Flexible discovery keywords.

Example:

```
tags:
 - knowledge-architecture
 - ai-systems
```

Tags assist with retrieval but do not define structure.

---

## embedding_version

Vector embedding version used for indexing.

Example:

```
embedding_version: v1
```

---

## last_indexed

Timestamp when the note was last indexed by the vector retrieval system.

Example:

```
last_indexed: 2026-03-14T21:30:00Z
```

---

# Concept Graph Rules

The Galaxy operates as a **network of ideas**.

To maintain graph quality, the following rules apply.

---

## Minimum Concept Links

Each concept should link to **at least two related concepts** when possible.

Example:

```
related_concepts:
 - concept-rag-architectures
 - concept-long-term-memory
```

This ensures the graph remains interconnected.

---

## Edge Case Rule

If no meaningful concept links exist, the note may temporarily contain fewer than two links.

However:

• the system must **never fabricate links**
• connections must always reflect genuine conceptual relationships

---

# Knowledge Integrity Rule

AI-generated content must never be inserted directly into the Galaxy.

Galaxy notes represent **human knowledge**.

AI synthesis must be stored in:

```
06_MACHINE
```

Only validated human insights should enter the knowledge graph.

---

# Example Galaxy Note

```
---
id: concept-ai-systems-knowledge-architecture
type: concept
status: evergreen

domain:
 - ai-systems

related_domains:
 - personal-knowledge-management
 - data-engineering

level: advanced

created: 2026-03-14
updated: 2026-03-14

review_interval: 90d
next_review: 2026-06-14

version: 1
schema_version: 1

source: human
confidence: high

related_concepts:
 - concept-rag-architectures
 - concept-long-term-memory

aliases:
 - Knowledge Architecture
 - PKM Architecture

tags:
 - knowledge-architecture
 - ai-systems

embedding_version: v1
last_indexed: 2026-03-14T21:30:00Z
---
```

---

# Schema Evolution

If the metadata structure changes in the future:

• increment `schema_version`
• update this document
• migrate notes accordingly

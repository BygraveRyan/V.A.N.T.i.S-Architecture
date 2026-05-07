
Version: 1.1
Applies To: private workspace/Knowledge/Galaxy
System: VANTIS

---

# PURPOSE

The Galaxy is the concept graph of VANTIS.

It is not a folder hierarchy or a topic taxonomy.
Instead, it functions as a network of ideas where each concept connects to other concepts through meaningful relationships.

The objective is to create a thinking network enabling:
- idea discovery
- cross‑domain reasoning
- conceptual synthesis
- AI‑assisted research navigation

The Galaxy should evolve into a map of intelligence rather than a note collection.

---

# CORE PRINCIPLE

Ideas connect to ideas — not folders.

Each note represents a single concept node in a graph.
Connections between nodes form the knowledge structure.

---

# STRUCTURE RULES

## 1 — One Concept Per Note

Each Galaxy note must represent one atomic idea.

Examples:
- concept-rag-architectures
- concept-vector-databases
- concept-transformer-attention
- concept-knowledge-graphs

Avoid compound notes such as:
- AI Overview
- Machine Learning Notes
- Data Engineering Concepts

Large topics must be decomposed into multiple linked concept nodes.

---

## 2 — Flat Folder Structure

The Galaxy must remain completely flat.

Location:
private workspace/Knowledge/Galaxy

Subfolders are not allowed.

Example:

private workspace/Knowledge/Galaxy/
    concept-rag-architectures.md
    concept-vector-databases.md
    concept-knowledge-graphs.md

---

## 3 — Wikilink Connection Standard

Concept relationships must use Obsidian wikilinks.

Example:
`[[concept-rag-architectures]]`
`[[concept-vector-databases]]`
`[[concept-long-term-memory]]`

Links must point to existing or planned concept nodes.

---

# LINKING PHILOSOPHY

The purpose of linking is to express relationships between ideas.

Links should answer:
How does this idea connect to other ideas?

---

# PRIMARY LINK TYPE

## related_concepts

The main relationship inside the Galaxy is:

related_concepts

Example:

related_concepts:
 - concept-vector-databases
 - concept-embeddings
 - concept-semantic-search

These concepts share direct conceptual relationships.

---

# SECONDARY RELATIONSHIPS

## domain

The primary domain of the concept.

Example:

domain:
 - ai-systems

## related_domains

Example:

related_domains:
 - data-engineering
 - information-retrieval

This allows cross-discipline exploration.

---

# LINK DENSITY RULE

Each concept note should ideally contain:

2–5 related_concepts

However VANTIS must never fabricate links.
Integrity is more important than graph density.

---

# VALID LINK TYPES

Valid conceptual relationships include:

Mechanism
transformers → attention

Dependency
rag → vector databases

Extension
knowledge graphs → graph rag

Comparison
rag architectures → fine tuning

Conceptual family
embeddings → semantic search

---

# INVALID LINKS

Avoid linking purely because concepts share a category.

Bad example:
AI → machine learning

Avoid forcing links just to increase graph density.

---

# LINK CREATION PROCESS

Step 1 — Identify the core concept of the note.

Step 2 — Identify ideas required to understand it.

Step 3 — Identify ideas that extend or challenge it.

Step 4 — Add the strongest 2–5 conceptual links.

---

# GRAPH EVOLUTION RULE

The Galaxy is a living knowledge network.

Links should evolve as:
- research develops
- understanding improves
- new relationships emerge

---

# ORPHAN NOTE DETECTION

A concept note is considered orphaned when it has:
- no outgoing links
- no incoming links

The Memory Curator agent should detect orphan notes and suggest potential connections.

Agents must never automatically fabricate links.

---

# HUMAN KNOWLEDGE INTEGRITY RULE

The Galaxy is reserved for human‑synthesized knowledge only.

AI generated material must never be written directly to the Galaxy.

AI outputs belong in:

02_MACHINE

Humans may later refine ideas and convert them into permanent concept notes.

---

# FINAL PRINCIPLE

The Galaxy is not meant to store information.

It is meant to map understanding.

Every concept should answer:

How does this idea connect to the rest of the universe?

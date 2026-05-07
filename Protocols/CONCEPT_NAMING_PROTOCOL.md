# VANTIS Concept Naming Protocol

Version: 1.1
Applies To: private workspace/Knowledge/Galaxy

---

# Purpose

This protocol defines the naming conventions for all **Galaxy concept nodes** within the VANTIS knowledge graph.

Consistent naming ensures:

* conceptual clarity
* reliable wikilinking
* reduced duplication
* stable knowledge graph growth
* improved AI reasoning over the vault

Without disciplined naming, knowledge graphs quickly become inconsistent and difficult to navigate.

---

# Core Naming Format

All Galaxy concept notes must follow the format:

```
concept-<concept-name>
```

Examples:

```
concept-embedding
concept-vector-database
concept-semantic-search
concept-rag-architecture
concept-similarity-metric
```

The `concept-` prefix signals that the note represents a **concept node** within the Galaxy.

---

# Naming Principles

Every concept name must follow four key principles.

### 1 — Atomic

Each concept must represent **one single idea**.

Good:

```
concept-embedding
concept-vector-database
```

Bad:

```
concept-ai-overview
concept-machine-learning-notes
```

These represent collections of ideas rather than atomic concepts.

---

### 2 — Descriptive

The concept name should clearly communicate the idea being represented.

Good:

```
concept-semantic-search
concept-attention-mechanism
```

Avoid vague terms:

```
concept-ai-method
concept-data-technique
```

---

### 3 — Stable

Concept names should remain valid for many years.

Avoid naming concepts after temporary trends or tools.

Bad:

```
concept-openai-embedding-model
concept-gpt-search-method
```

Better:

```
concept-text-embedding
concept-vector-search
```

---

### 4 — Linkable

Concept names should be short and easy to reference using wikilinks.

Example:

```
[[concept-embedding]]
[[concept-vector-database]]
[[concept-semantic-search]]
```

---

# Use Nouns, Not Sentences

Concepts represent **ideas**, not explanations.

Correct:

```
concept-embedding
concept-vector-database
concept-attention-mechanism
```

Avoid:

```
concept-how-embeddings-work
concept-why-vector-search-matters
concept-using-transformers
```

Explanations belong inside the concept note, not in the name.

---

# Use Singular Forms

Concept names should be written in **singular form**.

Correct:

```
concept-vector-database
concept-embedding
concept-knowledge-graph
```

Avoid:

```
concept-vector-databases
concept-embeddings
concept-knowledge-graphs
```

Singular names represent the **abstract concept itself**, not a collection.

---

# Avoid Overly Broad Concepts

Avoid concepts that represent entire fields or domains.

Bad examples:

```
concept-artificial-intelligence
concept-machine-learning
concept-data-engineering
```

Instead create more

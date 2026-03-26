# MEMORY_CURATION_PROTOCOL

Version: 1.0
Applies To: 01_HUMAN/Knowledge/Galaxy

---

# PURPOSE

Memory Curation converts **raw information into permanent knowledge** inside the VANTIS system.

This process ensures the Galaxy remains:

* high quality
* concept-driven
* interconnected

The goal of curation is **not to store information**.

The goal is to store **understanding**.

The Galaxy should represent ideas that remain useful **for years**, not temporary notes.

---

# CURATION PIPELINE

All knowledge entering VANTIS should pass through three stages:

```
Information → Insight → Concept
```

Each stage progressively refines knowledge.

---

# STAGE 1 — INFORMATION

Information is **raw material**.

Examples include:

* article highlights
* research notes
* meeting notes
* AI-generated summaries
* quick thoughts
* book highlights

Typical storage locations:

```
01_HUMAN/Inbox
02_MACHINE
```

At this stage the information is **unstructured and temporary**.

No attempt should be made to permanently store information here.

---

# STAGE 2 — INSIGHT

Insights represent **interpretations of information**.

They are early attempts to extract meaning.

Example insight:

```
RAG systems perform significantly better when combined with vector databases and semantic embeddings.
```

Insights may appear in:

```
02_MACHINE
01_HUMAN/Projects
```

Insights are still **contextual** and may relate to a specific situation or research session.

Not all insights should become permanent knowledge.

---

# STAGE 3 — CONCEPT

Concepts represent **reusable knowledge**.

They are the fundamental units of the Galaxy.

Example:

```
concept-rag-architectures
concept-vector-databases
concept-transformer-attention
```

Concepts explain **how something works**, not just what happened.

Only **conceptual knowledge** should enter the Galaxy.

---

# CONCEPT CREATION CRITERIA

Before creating a Galaxy concept note, evaluate the idea using the following questions.

### 1 — Is the idea reusable?

Will the idea still be useful in the future?

Temporary knowledge should not enter the Galaxy.

---

### 2 — Is the idea generalizable?

Does the idea apply beyond a single event or situation?

If the idea only applies to a specific project or meeting, it belongs elsewhere.

---

### 3 — Is the idea conceptual?

Galaxy notes must explain **principles or mechanisms**.

Not just facts or summaries.

---

# EXAMPLES

Examples of content that **should NOT enter the Galaxy**:

```
Notes from an article about RAG
Meeting notes
Temporary research summaries
Project planning notes
```

Examples of **valid Galaxy concepts**:

```
concept-rag-architectures
concept-vector-databases
concept-transformer-attention
concept-knowledge-graphs
```

These represent **core ideas**, not situational information.

---

# CURATION PROCESS

Memory curation should follow this workflow.

### Step 1 — Identify reusable knowledge

Review Inbox or Output notes.

Look for insights that represent **general principles or ideas**.

---

### Step 2 — Create a concept note

Create a new file in:

```
01_HUMAN/Knowledge/Galaxy
```

Use the structure defined in:

```
GALAXY_NOTE_TEMPLATE.md
```

---

### Step 3 — Add conceptual links

Every concept should connect to related ideas.

Example:

```
related_concepts:
 - concept-vector-databases
 - concept-embeddings
 - concept-semantic-search
```

Connections form the **knowledge graph** of VANTIS.

---

### Step 4 — Update metadata

Ensure the YAML metadata includes:

* domain
* related_domains
* related_concepts
* review interval
* confidence level

Metadata enables future **retrieval and indexing systems**.

---

# AGENT RESPONSIBILITY

Primary agent responsible for curation:

```
Memory Curator
```

Responsibilities include:

* maintaining Galaxy quality
* ensuring correct concept structure
* identifying orphan notes
* suggesting new conceptual connections

Agents may suggest links but must **never fabricate knowledge**.

Human oversight is required for final concept creation.

---

# ORPHAN CONCEPT DETECTION

A concept becomes an orphan when it has:

* no outgoing links
* no incoming links

Orphan notes weaken the knowledge graph.

The Memory Curator should periodically detect orphan concepts and suggest potential connections.

Links must always represent **real conceptual relationships**.

---

# REVIEW PROCESS

Concept notes should be reviewed periodically to ensure accuracy.

Default review interval:

```
90 days
```

During review the curator should evaluate:

* whether the concept remains accurate
* whether stronger conceptual links exist
* whether the concept should be expanded or refined

Concept evolution is a normal part of maintaining a knowledge graph.

---

# HUMAN KNOWLEDGE INTEGRITY RULE

The Galaxy must remain a repository of **human-synthesized knowledge**.

AI-generated material should never be written directly to the Galaxy.

AI outputs must be stored in:

```
02_MACHINE
```

Humans may later refine these outputs and convert them into permanent concept notes.

This prevents **AI noise contamination**.

---

# FINAL PRINCIPLE

The Galaxy should contain **ideas worth remembering for years**.

If a piece of knowledge will not remain useful in the future, it should not enter the Galaxy.

The purpose of the Galaxy is to create a **map of understanding**, not a storage archive.

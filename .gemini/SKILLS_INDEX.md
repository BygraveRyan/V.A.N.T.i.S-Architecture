# V.A.N.T.i.S. Skills Index

Purpose

This file provides a discoverable index of all Gemini skills available within the V.A.N.T.i.S. system.

Skills are modular behavior extensions that provide specialized capabilities for V.A.N.T.i.S. agents.

Skills are stored in:

.gemini/skills/

and are loaded using a **lazy loading mechanism**.

Only the skill description is initially visible to the model.
The full instructions are loaded only when the skill is activated.

---

# Available Skills

## concept-extraction
**Location:** `.gemini/skills/concept-extraction/`
**Purpose:** Extract reusable conceptual knowledge from research material and propose **concept candidates** for the V.A.N.T.i.S. Galaxy knowledge graph.
**Capabilities:** Identify reusable ideas from research, transform information into conceptual insights, propose concept candidates, suggest conceptual relationships.
**Output Location:** `06_OUTPUT`
**Rules:** This skill must never create or modify Galaxy notes. It only proposes concept candidates for human review.

---

## precedent-detection
**Location:** `.gemini/skills/precedent-detection/`
**Purpose:** Detect and surface previously encountered concepts from the Galaxy that are structurally, functionally, or conceptually similar to a new idea.
**Capabilities:** Keyword, mechanism, and conceptual matching. Accelerated reasoning and knowledge reuse.
**Rules:** Returns a maximum of 1–3 concepts. Must include a clear explanation of each relationship. Read-only behavior.

---

## linkedin-content-generation
**Location:** `.gemini/skills/linkedin-content-generation/`
**Purpose:** Synthesize project progress, conceptual precedents, and personal insights into high-authority LinkedIn content.
**Capabilities:** Scan recent activity (`logs/`, `03_PROJECTS/`, `04_PERSONAL/Daily/`, `02_KNOWLEDGE/Galaxy/`) and use the **Mechanism-to-Value** framework to draft posts.
**Output Location:** `06_OUTPUT/LinkedIn_Drafts/`
**Rules:** Avoid "AI-sounding" buzzwords. Maintain a direct, senior-engineer tone. Teach the audience at least one conceptual framework per post.

---

## concept-mapper
**Location:** `.gemini/skills/concept-mapper/`
**Purpose:** Perform agentic "Similarity Scans" to identify conceptual relationships between project work and the knowledge graph.
**Capabilities:** Principle extraction, semantic sweep across the entire vault, and connection synthesis (Precedent vs. Sibling vs. Dependency).
**Output Location:** `06_OUTPUT/similarity-scans/`
**Rules:** Prioritize "Mechanism" over "Topic." Human review is mandatory before adding connections to the Galaxy.

---

## audit-logger
**Location:** `.gemini/skills/audit-logger/`
**Purpose:** Ensure high-fidelity audit trails of every decision, file modification, and reasoning step taken by V.A.N.T.i.S. agents.
**Capabilities:** Automated log generation, YAML metadata construction, and systematic task tracing.
**Output Location:** `logs/YYYY-MM-DD/`
**Rules:** No silent actions. Immutability enforced. Surgical reads for context.

---

## inbox-processor
**Location:** `.gemini/skills/inbox-processor/`
**Purpose:** Transform raw, unstructured information in the Inbox into organized knowledge, tasks, or project assets.
**Capabilities:** Inbox scanning, clarification/extraction, and automated routing based on V.A.N.T.i.S. protocols.
**Output Location:** `02_KNOWLEDGE`, `03_PROJECTS`, `04_PERSONAL`, `05_TASKS`, `06_OUTPUT`.
**Rules:** AI staging for generated content. Archival of raw input mandatory.

---

## memory-curator
**Location:** `.gemini/skills/memory-curator/`
**Purpose:** Convert raw information into permanent, high-quality, interconnected knowledge within the V.A.N.T.i.S. Galaxy.
**Capabilities:** Concept candidate drafting, conceptual relationship mapping, and "orphan note" detection.
**Output Location:** `06_OUTPUT`
**Rules:** AI-to-Galaxy barrier enforced. Prioritize "Mechanism" over "Topic." Human verification mandatory.

---

# Skill Design Principles

All V.A.N.T.i.S. skills must follow these rules:

1. Skills extend agent capabilities but do not override system rules.
2. Skills must never modify the Galaxy knowledge graph directly.
3. Skills must respect the V.A.N.T.i.S. knowledge pipeline:
   **Information → Insight → Concept**
4. Skills must output AI-generated material to `06_OUTPUT`.
5. Human review is required before any knowledge enters the Galaxy.

---

# System Philosophy

Skills enhance V.A.N.T.i.S. intelligence but do not replace human reasoning. The Galaxy knowledge graph represents **human understanding**, not AI-generated summaries.

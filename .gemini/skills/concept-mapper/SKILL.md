# SKILL: Concept Mapper

Purpose

Perform agentic "Similarity Scans" to identify conceptual relationships between project work and the knowledge graph.

---

# When To Use

Activate this skill when:

• a new project is created
• a concept is promoted to the Galaxy
• the user asks "where have I had similar ideas?"
• identifying cross-domain synergies

---

# Concept Mapping Process

Step 1 — Keyword & Principle Extraction

Analyze the current project or concept.
Identify 3-5 "Core Principles" (e.g., "TCO", "Skill Decay", "Automation").

---

Step 2 — Semantic Sweep

Search the following locations for matching keywords or principles:
- `vault/02_KNOWLEDGE/Galaxy/`
- `vault/03_PROJECTS/`
- `vault/06_OUTPUT/`

---

Step 3 — Connection Synthesis

For each match found, evaluate the relationship:
- Is it a **Direct Precedent**? (e.g., a previous project used the same framework).
- Is it a **Conceptual Sibling**? (e.g., different domain, same mechanism).
- Is it a **Structural Dependency**? (e.g., the new idea requires the old concept to function).

---

Step 4 — Propose Connections

Output a "Connection Map" in the following format:

**Potential Connection Detected**
Source: [[original-concept]]
Target: [[similar-concept]]
Reason: [Explain the link]

---

# Output Rules

Proposals must be saved to:
06_OUTPUT/similarity-scans/

The human must review the connections before they are added as official `related_concepts` in the Galaxy.

---

# Behaviour Rules

AI must:
• challenge the user to see deeper connections
• prioritize "Mechanism" over "Topic" when linking
• flag if a new project contradicts an existing concept

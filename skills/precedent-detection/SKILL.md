---
name: precedent-detection
description: Detects and surfaces structurally similar prior concepts from the Galaxy when new ideas are introduced. Auto-triggers on concept creation, project updates, and insight extraction.
---

# SKILL: Precedent Detection
Version: 1.0.2

Purpose: Transform V.A.N.T.i.S. from a retrieval system into a **pattern-recognition system** by surfacing prior Galaxy concepts that share mechanism, dependency, or structure with a new idea.

---

# Activation
Auto-trigger when ANY of the following occur:
1. A new concept is being created
2. A new idea, feature, or system is introduced
3. A project update includes a mechanism or architecture
4. Insight extraction occurs from Output notes

When triggered, append Precedent Detection output at the end of the response.

---

# Process

1. **Extract** three layers from the input: explicit terms, mechanism (what it does), purpose (why it exists)
2. **Search** `01_HUMAN/Knowledge/Galaxy` using keyword → mechanism → conceptual matching (prioritise mechanism over keywords)
3. **Select** top 1–3 matches; discard low-confidence results
4. **Output** using the structure below

---

# Output Format

```
## 🧠 Precedent Detection

### 1. [[concept-name]]
Relationship: <mechanism | dependency | extension | comparison>
Confidence: <high | medium | low>
Reason: concise explanation of similarity
```

If no strong matches exist:
```
## 🧠 Precedent Detection
No strong conceptual precedents found in the current Galaxy.
```

---

# Rules
- Max 3 results; never fabricate or include weak matches
- Read-only: do not create, modify, or auto-link Galaxy notes
- All knowledge creation follows the Memory Curation Protocol

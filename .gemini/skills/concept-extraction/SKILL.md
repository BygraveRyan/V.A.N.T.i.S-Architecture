# SKILL: Concept Extraction
Version: 1.1.2

Purpose
Extract reusable conceptual knowledge from research material and propose **concept candidates** for the V.A.N.T.i.S. Galaxy.

---

# When To Use
- **Trigger**: Intent to process [REDACTED_PERSONAL_VAULT]/Inbox or analyze research/documentation.
- **Requirement**: Trigger when processing `[REDACTED_PERSONAL_VAULT]/Inbox` or analyzing research/documentation material.

---

# Concept Extraction Process

## Step 1 — Analyze the material
Identify key ideas focusing on mechanisms, principles, and conceptual relationships.

## Step 2 — Extract Reusable Concepts
Identify 3–5 reusable ideas that remain useful beyond the specific research context.

## Step 3 — Propose Concept Candidates
Use the standard `GALAXY_NOTE_TEMPLATE.md` structure with `source: ai-candidate`.

---

# 🛡️ PROTOCOL COMPLIANCE (v1.7)

## Output & Lineage (v1.4)
- All candidates MUST be saved to `02_MACHINE/ai-candidates/`.
- All candidates MUST use `source: ai-candidate` metadata.

## Audit Reflex
- Every successful extraction MUST conclude with the execution of the `audit-logger` skill to generate a **Gold Standard Audit Log**.

## ASV Reflex
- Any modifications to this skill's logic MUST be followed by: `node .gemini/hooks/version-incrementer.js .gemini/skills/concept-extraction/SKILL.md`.

---

# Behaviour Rules
- Identify mechanisms, ignore implementation details.
- Propose conceptual links using `related_concepts`.
- **AI MUST NOT** write directly to the Galaxy.

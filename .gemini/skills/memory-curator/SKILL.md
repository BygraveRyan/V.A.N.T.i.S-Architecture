# SKILL: Memory Curator
Version: 1.1.1

Purpose
Convert raw information into permanent, high-quality, interconnected knowledge within the V.A.N.T.i.S. Galaxy.

---

# When To Use
- **Trigger**: Intent to convert raw insights into permanent concepts or detect orphan notes.
- **Requirement**: Consult the **Skill Trigger Matrix** in `GEMINI.md`.

---

# Curation Pipeline

## Step 1 — Filter for "Concept" Quality
Evaluate information using the **Information → Insight → Concept** framework.
- Is it reusable (useful for 2+ years)?
- Is it generalizable (applies beyond one situation)?
- Is it mechanical (explains **how** or **why**)?

## Step 2 — Draft Concept Candidate
Create a `concept-candidate-*` file in `02_MACHINE/ai-candidates/`.
- Use the standard `GALAXY_NOTE_TEMPLATE.md` structure.
- Focus on mechanisms and principles, not just facts.

## Step 3 — Synthesize Connections
Identify relationships to existing concepts in the Galaxy using the **Direct Precedent**, **Conceptual Sibling**, or **Structural Dependency** categories.

---

# 🛡️ PROTOCOL COMPLIANCE (v1.7)

## Knowledge Lineage (v1.4)
- All proposals MUST use `source: ai-candidate`.
- Follow the formal promotion path: `Synthesis (ai-candidate)` -> `Review (ai-assisted)` -> `Promotion (Galaxy)`.

## Audit Reflex
- Every successful curation session MUST conclude with the execution of the `audit-logger` skill to generate a **Gold Standard Audit Log**.

## ASV Reflex
- Any modifications to this skill's logic MUST be followed by: `node .gemini/hooks/version-incrementer.js .gemini/skills/memory-curator/SKILL.md`.

---

# Behaviour Rules
- Link based on **Mechanism** over Topic.
- Prevent "AI noise" from entering the Galaxy.
- Human review is mandatory for all promotions.

# SKILL: Concept Extraction
Version: 1.2.1

Purpose
Extract reusable conceptual knowledge from research material and propose **concept candidates** while actively identifying contradictions and dialectical relationships with existing knowledge.

---

# When To Use
- **Trigger**: Intent to process 01_HUMAN/Inbox or analyze research/documentation.
- **Requirement**: Trigger when processing `01_HUMAN/Inbox` or analyzing research/documentation material.

---

# Concept Extraction Process

## Step 1 — Insight Mining
Identify key ideas focusing on mechanisms, principles, and conceptual relationships.

## Step 2 — Dialectical Scan (Collision Check)
For each key insight, perform a "Polarity Search" in the vault:
• **Search Pattern**: "Contradicts <insight>", "Opposite of <mechanism>", "Competing Theory for <concept>".
• **Flagging**: If a contradiction is found, note it in the candidate's metadata (`contradicts: [[NodeName]]`).
• **Synthesis Proposal**: If the contradiction is significant, propose a separate "Synthesis Node" to explore the trade-offs.

## Step 3 — Extract Reusable Concepts
Identify 3–5 reusable ideas that remain useful beyond the specific research context. Ensure they are phrased as **Mechanisms** (how/why) rather than just facts.

## Step 4 — Propose Concept Candidates
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

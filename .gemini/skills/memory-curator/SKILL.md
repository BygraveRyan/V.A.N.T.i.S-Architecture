# SKILL: Memory Curator

Purpose
Convert raw information into permanent, high-quality, interconnected knowledge within the V.A.N.T.i.S. Galaxy.

---

# When To Use
Activate this skill when:
• Reviewing `06_OUTPUT` or `01_INBOX` for reusable conceptual knowledge.
• Proposing new notes for the `02_KNOWLEDGE/Galaxy/` directory.
• Identifying and repairing "orphan" concepts (notes with no links).
• Performing periodic reviews of existing Galaxy concepts.

---

# Curation Pipeline

Step 1 — Filter for "Concept" Quality
Evaluate information using the **Information → Insight → Concept** framework.
• Is it reusable (useful for years)?
• Is it generalizable (applies beyond one situation)?
• Is it mechanical (explains *how* or *why*)?

Step 2 — Draft Concept Candidate
Create a `concept-candidate-*` file in `06_OUTPUT`.
• Use the standard `GALAXY_NOTE_TEMPLATE.md` structure.
• Focus on principles and mechanisms, not just facts.

Step 3 — Synthesize Connections
Identify relationships to existing concepts in the Galaxy.
• Define `related_concepts` (Direct Precedent, Sibling, or Dependency).
• Avoid "Topic" linking; prioritize "Mechanism" linking.

Step 4 — Human Review Staging
Present the candidate to the user. **AI must never write directly to the Galaxy.**

---

# Behaviour Rules
• **Knowledge Integrity**: Prevent "AI noise" from entering the Galaxy.
• **Orphan Detection**: Periodically scan for notes without links and suggest connections.
• **Mechanism Over Topic**: Link based on how things work, not just shared keywords.
• **Immortal Knowledge**: Only curate ideas worth remembering for 2+ years.

---

# Output Rules
All proposals and candidates MUST be stored in `06_OUTPUT` for human verification.

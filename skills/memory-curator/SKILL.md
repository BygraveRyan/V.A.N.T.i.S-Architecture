# SKILL: Memory Curator
Version: 1.2.1

Purpose
Convert raw information into permanent, high-quality, interconnected knowledge within the V.A.N.T.i.S. Galaxy, ensuring the system's "Knowledge Health" is maintained over time.

---

# When To Use
- **Trigger**: Intent to convert raw insights into permanent concepts, detect orphan notes, or perform a "Health Check" on the machine layer.
- **Requirement**: Trigger when converting raw insights into permanent concepts or detecting orphan/stale notes.

---

# Curation & Maintenance Pipeline

## Step 1 — Filter for "Concept" Quality
Evaluate information using the **Information → Insight → Concept** framework.
- Is it reusable (useful for 2+ years)?
- Is it generalizable (applies beyond one situation)?
- Is it mechanical (explains **how** or **why**)?

## Step 2 — Draft Concept Candidate
Create a `concept-candidate-*` file in `02_MACHINE/ai-candidates/`.
- Use the standard `GALAXY_NOTE_TEMPLATE.md` structure.
- Focus on mechanisms and principles, not just facts.

## Step 3 — Synthesize Connections (Network Propagation)
Identify relationships to existing concepts in the Galaxy or `02_MACHINE/`.
- **Direct Precedent**: Previous project used the same mechanism.
- **Conceptual Sibling**: Different domain, same underlying principle.
- **Structural Dependency**: New idea requires the old concept to function.

## Step 4 — Knowledge Lint (Gardening)
Periodically (or when triggered via `/lint-knowledge`), audit the vault for structural health:
• **Orphans**: Find nodes with 0 inbound links. Propose links to relevant parents or hubs.
• **Stale Nodes**: Find nodes without `updated` dates in the last 60 days. Perform a web search or vault search for new supporting/refuting evidence.
• **Mechanism Gaps**: Find high-level principles that lack "Example" or "How-To" child nodes. Propose drafting these.

## Step 5 — Inquiry-to-Asset Protocol
At the conclusion of a deep chat synthesis (especially those > 500 words or containing framework comparisons):
• **Evaluate**: Is this synthesis a reusable knowledge asset?
• **File**: Propose saving the synthesis to `02_MACHINE/Synthesis/Nodes/SYNTH-<YYYY-MM-DD>-<Topic>.md`.
• **Metadata**: Include `source: chat-synthesis` and standard metadata.

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

# SKILL: Concept Mapper
Version: 1.2.1

Purpose
Perform agentic "Similarity Scans" to identify conceptual relationships, precedents, and semantic synergies between new insights and the existing knowledge graph.

---

# When To Use
- **Trigger**: Intent to identify cross-domain synergies, map conceptual precedents, or perform a **Fan-out** sweep during inbox processing.
- **Requirement**: Trigger when identifying cross-domain synergies or mapping conceptual precedents.

---

# Concept Mapping Process

## Step 1 — Keyword & Principle Extraction
Analyze the current project or insight. Identify 3-5 "Core Mechanisms" (e.g., "Deterministic Resumption", "Log Reflex").

## Step 2 — Semantic Sweep
Search the following locations for matching keywords, mechanisms, or contradictory theories:
- `01_HUMAN/Knowledge/Galaxy/`
- `02_MACHINE/ai-candidates/`
- `02_MACHINE/Synthesis/Nodes/`

## Step 3 — Connection Synthesis
For each match found, evaluate the relationship:
- **Direct Precedent**: Previous project used the same mechanism.
- **Conceptual Sibling**: Different domain, same underlying principle.
- **Structural Dependency**: New idea requires the old concept to function.
- **Dialectical Collision**: New idea contradicts the existing node.

## Step 4 — Fan-out Propagation
When called by `inbox-processor`:
• Identify the top 3-5 most relevant existing nodes.
• Generate a `## [YYYY-MM-DD] Compounding Insight` or `## [YYYY-MM-DD] Contradiction` markdown block for each.
• Propose these as surgical updates to the identified files.

---

# 🛡️ PROTOCOL COMPLIANCE (v1.7)

## Output & Lineage
- All connection proposals MUST be saved to `02_MACHINE/ai-candidates/`.
- Proposals MUST include `source: ai-candidate` metadata.
- Follow the **Knowledge Lineage & Promotion (v1.4)** path for any new concept candidates identified during the scan.

## Audit Reflex
- Every successful scan MUST conclude with the execution of the `audit-logger` skill to generate a **Gold Standard Audit Log**.

## ASV Reflex
- Any modifications to this skill's logic MUST be followed by: `node .gemini/hooks/version-incrementer.js .gemini/skills/concept-mapper/SKILL.md`.

---

# Behaviour Rules
- Prioritize **Mechanism** over Topic when linking.
- Challenge the user to see deeper structural connections.
- Flag if a new project contradicts an existing Galaxy concept.

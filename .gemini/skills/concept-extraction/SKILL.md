# SKILL: Concept Extraction

Purpose

Extract reusable conceptual knowledge from research material.

This skill converts raw information into **concept candidates** that may later become Galaxy knowledge nodes.

The skill follows the VANTIS knowledge lifecycle:

Information → Insight → Concept

---

# When To Use

Activate this skill when:

• analysing research material
• reading articles or documentation
• reviewing AI-generated analysis
• processing project research notes
• identifying reusable knowledge

---

# Concept Extraction Process

Step 1 — Analyse the material

Identify the key ideas contained within the text.

Focus on:

• mechanisms
• principles
• system behaviours
• conceptual relationships

Ignore:

• project-specific details
• temporary notes
• implementation instructions

---

Step 2 — Extract Reusable Concepts

Identify **3–5 reusable ideas** that represent general principles.

These ideas should remain useful beyond the specific context of the material.

---

Step 3 — Propose Concept Candidates

Use the Concept Proposal Format.

Concept Candidate
Name: concept-<concept-name>

Explanation
Explain the idea clearly.

Why It Matters
Describe why the concept is useful.

Example
Provide a practical example.

Possible Related Concepts
List conceptual links using:

[[concept-name]]

Confidence
low | medium | high

---

# Output Rules

Concept candidates must **never be written directly to the Galaxy**.

All outputs must be saved to:

06_OUTPUT/Concept_Candidates/

The human user must review the concept candidate before creating a Galaxy concept node.

---

# Behaviour Rules

AI responsibilities:

• identify reusable knowledge
• explain conceptual ideas
• suggest possible concept links

AI must never:

• create Galaxy notes
• modify existing Galaxy nodes
• fabricate conceptual relationships

The Galaxy represents **human understanding**.

# SKILL: LinkedIn Content Generation

Purpose

Synthesize project progress, conceptual precedents, and personal insights into high-authority LinkedIn content.

---

# When To Use

Activate this skill when:

• drafting posts for professional visibility
• converting project milestones into "Build In Public" updates
• summarizing a new Galaxy concept for a social audience
• the user asks "what should I post about?"

---

# Content Synthesis Process

Step 1 — Intelligence Gathering

Scan the following for recent activity:
- `logs/` (recent tasks completed)
- `03_PROJECTS/` (milestones achieved)
- `04_PERSONAL/Daily/` (human insights)
- `02_KNOWLEDGE/Galaxy/` (newly promoted concepts)

---

Step 2 — Precedent Grounding

Use the **`precedent-detection` skill** to identify the core Galaxy concepts behind the work.
Example: If the work was on the Car App, the precedent is [[concept-finance-total-cost-of-ownership]].

---

Step 3 — Narrative Construction

Draft the post using the **"Mechanism-to-Value"** framework:
1. **The Hook**: A specific problem or observation (from your Daily logs).
2. **The Mechanism**: How you solved it or the concept behind it (from the Galaxy).
3. **The Result**: The impact or ROI (from the Project seeds).
4. **The CTA**: A thought-provoking question for the audience.

---

# Output Rules

Drafts must be saved to:
`06_OUTPUT/LinkedIn_Drafts/YYYY-MM-DD_Topic_Draft.md`

Each draft should include:
- A "Source Insight" reference
- A list of "Linked Concepts" from the Galaxy

---

# Behaviour Rules

AI must:
• avoid "AI-sounding" buzzwords (e.g., "In the rapidly evolving landscape...")
• maintain a direct, senior-engineer tone
• ensure every post teaches the audience at least one conceptual framework

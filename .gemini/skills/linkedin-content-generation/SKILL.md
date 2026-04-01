---
name: linkedin-content-generation
description: Synthesizes project progress and Galaxy concepts into high-authority LinkedIn content using the VANTIS narrative framework. Triggers on draft requests or "what should I post?" prompts.
---

# SKILL: LinkedIn Content Generation
Version: 1.0.1

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
- `[REDACTED_PERSONAL_VAULT]/Projects/` (milestones achieved)
- `[REDACTED_PERSONAL_VAULT]/Daily/` (human insights)
- `[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy/` (newly promoted concepts)

Step 2 — Historical Precedent Analysis

Before drafting, read the latest 3 posts from `[REDACTED_PERSONAL_VAULT]/Projects/LinkedIn_Operations/History/`.
Analyse the tone, flow, and layout of high-performing posts (specifically [[2026-03-18_LinkedIn_Post_VANTIS_Reveal]]).

Step 3 — Narrative Construction (The "VANTIS" Framework)

Draft the post using the following flow:
1. **The Hook**: A specific, relatable problem or observation (from Daily logs).
2. **The Action**: What you built or implemented to solve it.
3. **The Goal**: The higher-level purpose behind the build.
4. **The Contrast**: Old way (Chaos/Amnesia) vs. New way (V.A.N.T.i.S.).
5. **The Breakdown**: A numbered or bulleted list of the technical components.
6. **The CTA**: A direct question to the audience.

---

# Output Rules

Drafts must be saved to:
`02_MACHINE/Research/LinkedIn_Drafts/YYYY-MM-DD_Topic_Draft.md`

Lifecycle Management:
- **Drafts**: Live in `02_MACHINE/Research/LinkedIn_Drafts/`.
- **Published**: Move to `[REDACTED_PERSONAL_VAULT]/Projects/LinkedIn_Operations/History/` to preserve knowledge integrity.

Each draft should include:
- A "Source Insight" reference
- A list of "Linked Concepts" from the Galaxy

---

# Behaviour Rules

AI must:
• avoid "AI-sounding" buzzwords (e.g., "In the rapidly evolving landscape...")
• maintain a direct, senior-engineer tone
• ensure every post teaches the audience at least one conceptual framework

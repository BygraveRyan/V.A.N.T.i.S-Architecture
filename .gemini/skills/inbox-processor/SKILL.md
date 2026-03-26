# SKILL: Inbox Processor

Purpose
Transform raw, unstructured information in the Inbox into organized knowledge, tasks, or project assets.

---

# When To Use
Activate this skill when:
• `01_HUMAN/Inbox` contains new or unprocessed files.
• Performing a daily or weekly system sweep.
• The user explicitly asks to "clear the inbox" or "process notes."

---

# Processing Pipeline

Step 1 — Capture & Scan
Monitor `01_HUMAN/Inbox` for new content (ideas, research, meeting notes, etc.).

Step 2 — Clarify & Extract
Analyze each item to determine its value.
• Rewrite unclear notes.
• Extract key insights.
• Identify if it's reusable conceptual knowledge, a project task, or personal reflection.

Step 3 — Route
Move or transform the content to its appropriate destination:
- **Galaxy** (`01_HUMAN/Knowledge/Galaxy/`): Reusable concepts (via `concept-extraction` first).
- **Projects** (`01_HUMAN/Projects/`): Specific ongoing work.
- **Personal** (`01_HUMAN/Personal/`): Reflections and life management.
- **Tasks** (`01_HUMAN/Tasks/`): Actionable items.
- **Output** (`02_MACHINE/`): AI-generated synthesis (mandatory staging).
    - Concept Candidates -> `02_MACHINE/Synthesis/`
    - Reddit Syntheses -> `02_MACHINE/Research/Reddit_Syntheses/`
    - LinkedIn Drafts -> `02_MACHINE/Research/LinkedIn_Drafts/`
    - Session Reviews -> `02_MACHINE/Daily/`

Step 4 — Archive
Move the original raw note to `01_HUMAN/Inbox/Archive/` after processing.

---

# Routing Rules
• **AI Staging**: AI-generated content MUST go to `02_MACHINE` first for human review.
• **Galaxy Promotion**: Only humans can promote concepts to the Galaxy.
• **Health Check**: Maintain Inbox size between 0–20 items.

---

# Behaviour Rules
• Prioritize speed of capture; apply structure during processing.
• Ensure every processed item has an archived original.
• Use the `concept-extraction` skill when routing to the Galaxy to ensure insights are properly formatted.

# SKILL: Inbox Processor

Purpose
Transform raw, unstructured information in the Inbox into organized knowledge, tasks, or project assets.

---

# When To Use
Activate this skill when:
• `01_INBOX` contains new or unprocessed files.
• Performing a daily or weekly system sweep.
• The user explicitly asks to "clear the inbox" or "process notes."

---

# Processing Pipeline

Step 1 — Capture & Scan
Monitor `01_INBOX` for new content (ideas, research, meeting notes, etc.).

Step 2 — Clarify & Extract
Analyze each item to determine its value.
• Rewrite unclear notes.
• Extract key insights.
• Identify if it's reusable conceptual knowledge, a project task, or personal reflection.

Step 3 — Route
Move or transform the content to its appropriate destination:
- **Galaxy** (`02_KNOWLEDGE/Galaxy/`): Reusable concepts (via `concept-extraction` first).
- **Projects** (`03_PROJECTS/`): Specific ongoing work.
- **Personal** (`04_PERSONAL/`): Reflections and life management.
- **Tasks** (`05_TASKS/`): Actionable items.
- **Output** (`06_MACHINE/`): AI-generated synthesis (mandatory staging).
    - Concept Candidates -> `vault/06_MACHINE/Concept_Candidates/`
    - Reddit Syntheses -> `vault/06_MACHINE/Reddit_Syntheses/`
    - LinkedIn Drafts -> `vault/06_MACHINE/LinkedIn_Drafts/`
    - Session Reviews -> `vault/06_MACHINE/AI-Daily-Review/`

Step 4 — Archive
Move the original raw note to `vault/01_INBOX/Archive/` after processing.

---

# Routing Rules
• **AI Staging**: AI-generated content MUST go to `06_MACHINE` first for human review.
• **Galaxy Promotion**: Only humans can promote concepts to the Galaxy.
• **Health Check**: Maintain Inbox size between 0–20 items.

---

# Behaviour Rules
• Prioritize speed of capture; apply structure during processing.
• Ensure every processed item has an archived original.
• Use the `concept-extraction` skill when routing to the Galaxy to ensure insights are properly formatted.

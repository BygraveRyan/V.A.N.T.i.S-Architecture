---
name: inbox-processor
description: Routes and transforms raw items in private workspace/Inbox into knowledge, tasks, or project assets. Handles daily/weekly sweeps and explicit inbox-clear requests.
---

# SKILL: Inbox Processor
Version: 1.1.1

Purpose
Transform raw, unstructured information in the Inbox into organized knowledge, tasks, or project assets, ensuring every new insight compounds the existing knowledge graph.

---

# When To Use
Activate this skill when:
• `private workspace/Inbox` contains new or unprocessed files.
• Performing a daily or weekly system sweep.
• The user explicitly asks to "clear the inbox" or "process notes."

---

# Processing Pipeline

Step 1 — Capture & Scan
Monitor `private workspace/Inbox` for new content (ideas, research, meeting notes, etc.).

Step 2 — Clarify & Extract
Analyze each item to determine its value.
• Rewrite unclear notes.
• Extract key insights using the `concept-extraction` skill.
• Identify if it's reusable conceptual knowledge, a project task, or personal reflection.

Step 3 — Route
Move or transform the content to its appropriate destination:
- **Galaxy** (`private workspace/Knowledge/Galaxy/`): Reusable concepts (via `concept-extraction` first).
- **Projects** (`private workspace/Projects/`): Specific ongoing work.
- **Personal** (`private workspace/Personal/`): Reflections and life management.
- **Tasks** (`private workspace/Tasks/`): Actionable items.
- **Output** (`02_MACHINE/`): AI-generated synthesis (mandatory staging).
    - Concept Candidates -> `02_MACHINE/ai-candidates/`
    - Reddit Syntheses -> `02_MACHINE/Research/Reddit_Syntheses/`
    - LinkedIn Drafts -> `02_MACHINE/Research/LinkedIn_Drafts/`
    - Session Reviews -> `02_MACHINE/Daily/`

Step 4 — Compounding Integration (Fan-out)
After routing, ensure the new insight strengthens the network:
• **Semantic Sweep**: Use `concept-mapper` to identify 3-5 existing nodes in `02_MACHINE/` or `private workspace/Knowledge/Galaxy/` that are semantically related to the new insight.
• **Network Update**: For each related node, append a `## [YYYY-MM-DD] Compounding Insight` section with a one-sentence summary of the new evidence or a contradiction flag.
• **Cross-Link**: Ensure reciprocal links between the new asset and the identified existing nodes.

Step 5 — Archive
Move the original raw note to `private workspace/Inbox/Archive/` after processing.

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

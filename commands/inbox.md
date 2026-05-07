Audit the `private workspace/Inbox/` for new items. Invoke the `inbox-processor` skill.

## Step 1 — Scan
List all files in `private workspace/Inbox/` (excluding `Archive/`). If empty, report and stop.

## Step 2 — Triage each item
For each file, determine its type:
- **Research / insight** -> extract concepts via `concept-extraction` skill, stage to `02_MACHINE/ai-candidates/`
- **Project work** -> route to `private workspace/Projects/<relevant-project>/`
- **Personal reflection** -> route to `private workspace/Personal/`
- **Actionable task** -> route to `private workspace/Tasks/`
- **LinkedIn / social content** -> stage draft to `02_MACHINE/Research/LinkedIn_Drafts/`
- **Reddit synthesis** -> stage to `02_MACHINE/Research/Reddit_Syntheses/`

Present the routing plan to the user for approval before executing.

## Step 3 — Execute (on approval)
Move or transform each item to its approved destination. AI-generated output MUST land in `02_MACHINE/` first and never directly in the Galaxy.

## Step 4 — Archive
Move the original raw file to `private workspace/Inbox/Archive/` after processing.

## Step 5 — Audit Log
Invoke `audit-logger` skill (Tier 2) to record what was processed and where it was routed.

Health check: Flag if Inbox exceeds 20 items.

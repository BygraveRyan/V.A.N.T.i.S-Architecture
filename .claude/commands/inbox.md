Audit the `[REDACTED_PERSONAL_VAULT]/Inbox/` for new items. Invokes the `inbox-processor` skill.

## Step 1 — Scan
List all files in `[REDACTED_PERSONAL_VAULT]/Inbox/` (excluding `Archive/`). If empty, report and stop.

## Step 2 — Triage each item
For each file, determine its type:
- **Research / insight** → extract concepts via `concept-extraction` skill, stage to `02_MACHINE/ai-candidates/`
- **Project work** → route to `[REDACTED_PERSONAL_VAULT]/Projects/<relevant-project>/`
- **Personal reflection** → route to `[REDACTED_PERSONAL_VAULT]/Personal/`
- **Actionable task** → route to `[REDACTED_PERSONAL_VAULT]/Tasks/`
- **LinkedIn / social content** → stage draft to `02_MACHINE/Research/LinkedIn_Drafts/`
- **Reddit synthesis** → stage to `02_MACHINE/Research/Reddit_Syntheses/`

**Present the routing plan to the user for approval before executing.**

## Step 3 — Execute (on approval)
Move or transform each item to its approved destination. AI-generated output MUST land in `02_MACHINE/` first — never directly in the Galaxy.

## Step 4 — Archive
Move the original raw file to `[REDACTED_PERSONAL_VAULT]/Inbox/Archive/` after processing.

## Step 5 — Audit Log
Invoke `audit-logger` skill (Tier 2) to record what was processed and where it was routed.

---

**Health check**: Flag if Inbox exceeds 20 items — system hygiene risk.

Advanced issue management and project board integration using GitHub CLI.

## Step 1 — List Open Issues
Run: `gh issue list --limit 10 --json number,title,author,labels,updatedAt`

## Step 2 — Load Issue Context
If an issue number is provided as $ARGUMENTS:
`gh issue view $ARGUMENTS`

If no argument provided, list issues and ask which to work on.

## Step 3 — Analyse
1. Understand the scope and requirements of the issue.
2. Identify missing labels, milestones, or project board links.
3. Cross-reference with `[REDACTED_PERSONAL_VAULT]/Tasks/VANTIS/` — is there a corresponding task file?

## Step 4 — Triage Plan
Suggest specific updates:
- Labels to add/remove
- Milestone assignment
- Related task file in vault (create one if needed)
- Priority relative to `VANTIS_Upgrade_Dashboard.md`

## Step 5 — Execute (on approval)
- `gh issue edit $ARGUMENTS --add-label "..."`
- `gh issue edit $ARGUMENTS --milestone "..."`
- `gh issue comment $ARGUMENTS --body "..."`
- `gh issue close $ARGUMENTS` (only if explicitly instructed)

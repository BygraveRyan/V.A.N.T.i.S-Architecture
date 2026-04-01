Enhanced PR review using GitHub CLI.

## Step 1 — List Active PRs
Run: `gh pr list --json number,title,author,updatedAt --limit 5`

## Step 2 — Load PR Context
If a PR number is provided as $ARGUMENTS, run:
`gh pr diff $ARGUMENTS`
`gh pr view $ARGUMENTS --json title,body,state,reviews`

If no argument provided, ask which PR to review.

## Step 3 — Deep Review
Analyse the diff and perform a structured review:
1. **Scope Check**: Does the PR do what the title/body claims?
2. **Governance Check**: Does it comply with V.A.N.T.i.S. mandates? (No Galaxy writes, audit log present, ASV run on system files?)
3. **Logic & Risk**: Any logic gaps, security risks, or style inconsistencies?
4. **Linked Artifacts**: Is there a corresponding audit log in `logs/`? Is the task in `[REDACTED_PERSONAL_VAULT]/Tasks/` updated?

## Step 4 — Draft Review
Produce one of:
- Approval statement with summary
- Review comments with specific line suggestions

## Step 5 — Execute (on approval)
- `gh pr review $ARGUMENTS --approve -b "[summary]"`
- `gh pr review $ARGUMENTS --comment -b "[comment]"`
- `gh pr review $ARGUMENTS --request-changes -b "[feedback]"`

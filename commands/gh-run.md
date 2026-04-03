Monitor and fix failed GitHub Actions.

## Step 1 — List Recent Workflow Runs
Run: `gh run list --limit 5 --json status,conclusion,name,headBranch,createdAt`

## Step 2 — Load Run Context
If a run id is provided as `$ARGUMENTS`, run:
`gh run view $ARGUMENTS --log`

If no argument is provided, ask which run to inspect.

## Step 3 — Analyse
1. Identify why the workflow failed, if applicable.
2. Pinpoint the specific step or error in the logs.
3. Propose the fix and the command needed to rerun the workflow.

## Step 4 — Execute (on approval)
- `gh run rerun $ARGUMENTS`
- `gh run watch $ARGUMENTS`

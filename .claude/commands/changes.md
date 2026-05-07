Produce an on-demand session diff summary. Do not write any files — output to chat only.

## Step 1 — Run git commands

Run these three sequentially:

1. `git status --short`
2. `git log --since="$(date +%Y-%m-%d) 00:00:00" --oneline`
3. `git diff --stat HEAD`

## Step 2 — Present as a readable summary

### Session Changes — [TODAY'S DATE]

**Today's Commits**
[commits from command 2, or "None yet today"]

**Uncommitted Changes**
[git status --short output, or "Working tree clean"]

**Uncommitted Diffstat**
[git diff --stat HEAD output, or "No diff"]

Keep it concise. No interpretation unless the user asks a follow-up.

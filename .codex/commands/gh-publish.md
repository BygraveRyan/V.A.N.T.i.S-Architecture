Publish private architecture to the public portfolio mirror.

## Two Modes

**Single branch** (no arguments) — snapshot current branch:
`bash .gemini/hooks/publish-mirror.sh`

**Stack** (ordered branch list) — publish multiple branches as sequential PRs:
`bash .gemini/hooks/publish-stack.sh <branch1> <branch2> ...`

Example: `bash .gemini/hooks/publish-stack.sh feat/claude-architecture feat/tokenless-audit-engine`

## Which to use
- Use **single** for a one-off publish of the current branch state.
- Use **stack** when you have multiple PRs queued on private core that should appear as separate PRs on the public mirror in chronological order.

## Post-execution
Report PR URLs created or updated on the public mirror and any warnings.

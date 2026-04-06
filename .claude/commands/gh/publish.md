Publish private architecture to the public portfolio mirror.

## Two Modes

**Single branch** (no arguments) — snapshot current branch:
```
bash .gemini/hooks/publish-mirror.sh
```

**Stack** (ordered branch list) — publish multiple branches as sequential PRs:
```
bash .gemini/hooks/publish-stack.sh <branch1> <branch2> ...
```
Example: `bash .gemini/hooks/publish-stack.sh feat/claude-architecture feat/tokenless-audit-engine`

## Which to use
- Use **single** for a one-off publish of the current branch state.
- Use **stack** when you have multiple PRs queued on private core that should appear as separate PRs on the public mirror in chronological order.

## Post-execution
Report PR URLs created/updated on the public mirror and any warnings.

---

> ⚠️ WORKFLOW ORDER: Run this command from the **feature branch BEFORE merging** the private PR.
> The script fetches PR title/body using the current branch name — if run from `main` after merging,
> the private PR cannot be found and the public mirror PR will receive a generic fallback description.
>
> Correct order:
> 1. Feature branch work complete
> 2. Run `/gh:publish` (from feature branch) → creates public mirror PR
> 3. Merge private PR into main
> 4. Merge public mirror PR into main

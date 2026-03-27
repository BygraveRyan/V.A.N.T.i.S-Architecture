Deploy the latest architectural changes to the Public Mirror portfolio.
Run `bash .gemini/hooks/publish-mirror.sh`.
Confirm that only whitelisted "Engine" files are included.

> ⚠️ WORKFLOW NOTE: This command MUST be run from the feature branch BEFORE merging
> the private PR. The script fetches PR title/body using the current branch name —
> if run from `main` after merging, the private PR cannot be found and the public
> mirror PR will receive a generic fallback description.
>
> Correct order:
> 1. Feature branch work complete
> 2. Run `/gh:publish` (from feature branch) → creates public mirror PR
> 3. Merge private PR into main
> 4. Merge public mirror PR into main

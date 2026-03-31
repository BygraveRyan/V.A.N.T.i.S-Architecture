# Task: Auto Git Push on /eod

## Objective
Add an automatic git commit + push to the `/eod` command so vault changes are synced to the private core without a separate manual step.

## Behaviour Required
After the EOD audit file and session state are written, the command should:
1. Stage all relevant EOD files (Daily audit, session state, logs)
2. Commit using the git message already generated in the audit
3. Push to `origin main`

## Implementation Options
- **Option A**: Append `bash .gemini/hooks/pulse-sync.sh` call to the end of the `/eod` skill
- **Option B**: Add a dedicated `Stop` hook that runs after `/eod` completes (via `settings.local.json`)
- **Option A is preferred** — keeps the push scoped to EOD only, not every session end

## Files to Update
- `.gemini/skills/eod.md` — append push step at the end of the skill instructions
- Or `.claude/commands/eod.md` if the Claude-side command is separate

## Acceptance Criteria
- Running `/eod` results in a committed + pushed vault state with no extra commands needed
- Push only includes EOD-relevant files, not unrelated working changes

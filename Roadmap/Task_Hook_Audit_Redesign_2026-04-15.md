# Task: Hook System Audit Redesign — Fix PostToolUse Loop

## Objective

Eliminate the PostToolUse hook feedback loop that occurs when Bash tools trigger `session-ledger.sh` (which runs bash and re-triggers the hook). Redesign logging to be git-authoritative instead of ledger-dependent, and provide an on-demand `/changes` command for quick session review.

## Context

- **Problem**: PostToolUse matcher is `"Write|Edit|NotebookEdit|Bash|run_shell_command"`. When Claude runs a Bash tool, the hook fires, calls `session-ledger.sh`, which runs bash internally, triggering the matcher again → loop
- **Why it matters**: Creates UI stuttering/"stuck in hook sequence" experience after every Bash command
- **Root cause**: Bash should not be in the matcher. Git is authoritative and already captures all file mutations (moves, deletes, edits)
- **Solution**: Narrow matcher to Write/Edit/NotebookEdit only; enhance Stop hook to use git for comprehensive audit; add on-demand `/changes` command

**ADR**: `03_SYSTEM/ADRs/0006-posttooluse-hook-narrowing.md` (accepted)

---

## Implementation Steps

### Step 1: Narrow PostToolUse Matcher

**File**: `.claude/settings.local.json` (lines 158–169)

```diff
- "matcher": "Write|Edit|NotebookEdit|Bash|run_shell_command",
+ "matcher": "Write|Edit|NotebookEdit",
```

This is the immediate fix. Everything else in the hook config block stays unchanged. The `async: true` flag remains.

**Verification**: Run a Bash command, check `.gemini/tmp/session-ledger.jsonl` — zero new entries. Run a Write/Edit, one entry should appear.

---

### Step 2: Enhance compile-audit-log.sh (4 edits)

#### 2a — Replace early-exit guard (lines 16–18)

Allow git-only sessions to still produce audit logs:

```bash
HAS_LEDGER=false
if [ -f "$LEDGER" ] && [ -s "$LEDGER" ]; then
  HAS_LEDGER=true
fi

# Only skip if ledger is empty AND git working tree is clean
if [ "$HAS_LEDGER" = false ] && [ -z "$(git status --porcelain 2>/dev/null)" ]; then
  exit 0
fi
```

#### 2b — Make file list block conditional (lines 28–49)

Replace entire block to only extract from ledger if it exists; provide fallback message if not:

```bash
# --- Build file list from ledger (if present) ---
FILES_LIST="_(No Write/Edit tool calls this session. See git status below for all changes.)_"
FIRST_TS="unknown"
LAST_TS="unknown"
ENTRY_COUNT="0"
FILE_COUNT="0"
AGENT_NAME=""

if [ "$HAS_LEDGER" = true ]; then
  # [Original jq/grep block here — unchanged]
  if command -v jq >/dev/null 2>&1; then
    FILES_MODIFIED=$(jq -r '.file' "$LEDGER" | sort -u)
    FIRST_TS=$(head -1 "$LEDGER" | jq -r '.timestamp')
    LAST_TS=$(tail -1 "$LEDGER" | jq -r '.timestamp')
    ENTRY_COUNT=$(wc -l < "$LEDGER" | tr -d ' ')
    FILE_COUNT=$(jq -r '.file' "$LEDGER" | sort -u | wc -l | tr -d ' ')
    AGENT_NAME=$(jq -r '.agent // empty' "$LEDGER" | grep -v '^$' | sort -u | paste -sd "," - | sed 's/,/ \& /g')
  else
    FILES_MODIFIED=$(grep -o '"file":"[^"]*"' "$LEDGER" | sed 's/"file":"//;s/"//' | sort -u)
    FIRST_TS=$(head -1 "$LEDGER" | grep -o '"timestamp":"[^"]*"' | sed 's/"timestamp":"//;s/"//')
    LAST_TS=$(tail -1 "$LEDGER" | grep -o '"timestamp":"[^"]*"' | sed 's/"timestamp":"//;s/"//')
    ENTRY_COUNT=$(wc -l < "$LEDGER" | tr -d ' ')
    FILE_COUNT=$(echo "$FILES_MODIFIED" | grep -c .)
    AGENT_NAME=$(grep -o '"agent":"[^"]*"' "$LEDGER" | sed 's/"agent":"//;s/"//' | sort -u | paste -sd "," - | sed 's/,/ \& /g')
  fi
  FILES_LIST=$(echo "$FILES_MODIFIED" | sed 's/^/- /')
fi

if [ -z "$AGENT_NAME" ]; then
  AGENT_NAME="Unknown Agent"
fi
```

#### 2c — Expand git context section (replace lines 51–57)

Add `git status --porcelain` and `git log --since=today`:

```bash
# --- Git context ---
GIT_STAT=$(git diff --stat HEAD 2>/dev/null)
if [ -z "$GIT_STAT" ]; then
  GIT_STAT="No uncommitted changes at session end."
fi

LAST_COMMIT=$(git log -1 --pretty=format:"%h — %s" 2>/dev/null || echo "No commits yet")

GIT_STATUS=$(git status --porcelain 2>/dev/null)
if [ -z "$GIT_STATUS" ]; then
  GIT_STATUS="Working tree clean."
fi

TODAY=$(date +%Y-%m-%d)
GIT_TODAY_LOG=$(git log --since="${TODAY} 00:00:00" --until="${TODAY} 23:59:59" --oneline 2>/dev/null)
if [ -z "$GIT_TODAY_LOG" ]; then
  GIT_TODAY_LOG="No commits made today."
fi
```

#### 2d — Update markdown heredoc (lines 78–84)

Replace the "## Git State at Session End" block:

```markdown
## Git State at Session End

**Last Commit:** $LAST_COMMIT

### All Changed Files (git status)
\`\`\`
$GIT_STATUS
\`\`\`

### Uncommitted Diff (--stat HEAD)
\`\`\`
$GIT_STAT
\`\`\`

### Commits Made Today
\`\`\`
$GIT_TODAY_LOG
\`\`\`
```

**Verification**: End a session with Bash-only mutations (rm, mv). Check `logs/YYYY-MM-DD/` for audit log. Verify it shows moved/deleted files in `git status` section.

---

### Step 3: Create /changes Command

**New file**: `.claude/commands/changes.md`

```markdown
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
```

**Verification**: Run `/changes` — should output a clean summary to chat with no file writes.

---

## Acceptance Criteria

- [ ] PostToolUse hook matcher narrowed to Write/Edit/NotebookEdit (no Bash)
- [ ] Running a Bash command does NOT trigger session-ledger.jsonl entries
- [ ] Running Write/Edit commands DOES trigger ledger entries (1 entry per call)
- [ ] Sessions with only Bash mutations (no Write/Edit) still produce audit logs
- [ ] Audit logs include `git status --porcelain` (shows moves as `R`, deletes as `D`)
- [ ] Audit logs include `git log --since=today --oneline`
- [ ] `/changes` command exists and runs without writing files
- [ ] No more "stuck in hook sequence" symptoms after Bash commands

---

## Files to Modify

- `.claude/settings.local.json` — Line 160, narrow matcher
- `.gemini/hooks/compile-audit-log.sh` — Lines 16–18, 28–49, 51–57, 78–84 (4 edits)
- `.claude/commands/changes.md` — Create new file

---

## Related

- **ADR**: `03_SYSTEM/ADRs/0006-posttooluse-hook-narrowing.md`
- **Previous Hook Audit**: ADR-0005 (consolidated to single PostToolUse hook in 2026-04-13)

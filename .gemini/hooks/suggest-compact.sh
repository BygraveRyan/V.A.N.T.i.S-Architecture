#!/bin/bash
# V.A.N.T.i.S. Strategic Compact Suggester
# Adapted from ECC suggest-compact.sh
#
# Runs on PreToolUse or periodically to suggest manual compaction at logical intervals
#
# Threshold: 50 tool calls; reminder every 25 after that
# Counter stored in temporary directory

# Identify session - prefer GEMINI_SESSION_ID, then CLAUDE_SESSION_ID, then PPID
SESSION_ID="${GEMINI_SESSION_ID:-${CLAUDE_SESSION_ID:-${PPID:-default}}}"
# Use a safer temp directory for macOS/Linux parity
TMP_DIR="${TMPDIR:-/tmp}"
COUNTER_FILE="${TMP_DIR}/vantis-tool-count-${SESSION_ID}"
THRESHOLD=${COMPACT_THRESHOLD:-50}

# Initialize or increment counter
if [ -f "$COUNTER_FILE" ]; then
  count=$(cat "$COUNTER_FILE")
  count=$((count + 1))
  echo "$count" > "$COUNTER_FILE"
else
  echo "1" > "$COUNTER_FILE"
  count=1
fi

# Suggest compact after threshold tool calls
if [ "$count" -eq "$THRESHOLD" ]; then
  echo "[StrategicCompact] $THRESHOLD tool calls reached - consider /compact if transitioning phases" >&2
fi

# Suggest at regular intervals after threshold (every 25 calls from threshold)
if [ "$count" -gt "$THRESHOLD" ] && [ $(( (count - THRESHOLD) % 25 )) -eq 0 ]; then
  echo "[StrategicCompact] $count tool calls - good checkpoint for /compact if context is stale" >&2
fi

# Exit with success and provide empty JSON to avoid parse errors in Gemini CLI
echo "{}"
exit 0

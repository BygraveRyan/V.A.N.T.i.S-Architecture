#!/usr/bin/env bash
# V.A.N.T.i.S. Session Ledger Hook
# PostToolUse command hook — captures file modifications in real-time, zero model tokens.
#
# Triggered by: Claude Code PostToolUse on Write | Edit | NotebookEdit
# Output: .gemini/tmp/session-ledger.jsonl (one JSON entry per file touched)

LEDGER_DIR=".gemini/tmp"
LEDGER="$LEDGER_DIR/session-ledger.jsonl"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

mkdir -p "$LEDGER_DIR"

# Read tool data from stdin
TOOL_DATA=$(cat)

# Extract fields — prefer jq, fall back to grep/sed
if command -v jq >/dev/null 2>&1; then
  TOOL_NAME=$(echo "$TOOL_DATA" | jq -r '.tool_name // empty')
  FILE_PATH=$(echo "$TOOL_DATA" | jq -r '.tool_input.file_path // empty')
else
  TOOL_NAME=$(echo "$TOOL_DATA" | grep -o '"tool_name":"[^"]*"' | sed 's/"tool_name":"//;s/"//')
  FILE_PATH=$(echo "$TOOL_DATA" | grep -o '"file_path":"[^"]*"' | head -1 | sed 's/"file_path":"//;s/"//')
fi

# Only record if a file path was captured
if [ -n "$FILE_PATH" ]; then
  echo "{\"timestamp\":\"$TIMESTAMP\",\"tool\":\"$TOOL_NAME\",\"file\":\"$FILE_PATH\"}" >> "$LEDGER"
fi

#!/usr/bin/env bash
# V.A.N.T.i.S. Session Ledger Hook
# PostToolUse command hook — captures file modifications in real-time, zero model tokens.
#
# Triggered by: Agent PostToolUse on mutation tools
# Output: .gemini/tmp/session-ledger.jsonl (one JSON entry per file touched)

HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LEDGER_DIR=".gemini/tmp"
LEDGER="$LEDGER_DIR/session-ledger.jsonl"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

mkdir -p "$LEDGER_DIR"

# Capture tool usage data from stdin
TOOL_DATA=$(cat)

if [ -z "$TOOL_DATA" ]; then
  exit 0
fi

PYTHON_CMD="python3"
if ! command -v "$PYTHON_CMD" >/dev/null 2>&1; then
  PYTHON_CMD="python"
fi

# Delegate logic to the Python script
echo "$TOOL_DATA" | "$PYTHON_CMD" "$HOOK_DIR/session-ledger-logic.py" "$TIMESTAMP" "$LEDGER"

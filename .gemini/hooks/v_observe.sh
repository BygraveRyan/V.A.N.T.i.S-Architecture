#!/bin/bash
# V.A.N.T.i.S. Observation Hook (v_observe.sh)
#
# Captures tool use events for pattern analysis and "instinct" extraction.
# Adapted from ECC continuous-learning-v2.
#
# v1.0.0
#
# Expects JSON data on stdin from the agent CLI (Gemini/Claude).
# Argument 1: "pre" or "post" (phase).

set -e

PHASE="${1:-post}"

# Check if stdin is a TTY or empty to prevent hanging
if [ -t 0 ] || [ ! -p /dev/stdin ]; then
  # Not a pipe or a TTY, but check if there is data available at all
  if ! read -t 0; then
    exit 0
  fi
fi

INPUT_JSON=$(cat)

if [ -z "$INPUT_JSON" ]; then
  exit 0
fi

# 1. Project Detection Logic
PROJECT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
PROJECT_NAME=$(basename "$PROJECT_ROOT")
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "$PROJECT_ROOT")

export PHASE="$PHASE"
export PROJECT_ROOT="$PROJECT_ROOT"
export PROJECT_NAME="$PROJECT_NAME"
export REMOTE_URL="$REMOTE_URL"

# Use Python for robust hashing and JSON processing
PYTHON_CMD="python3"
if ! command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python"
fi

OBSERVATION_LOG="02_MACHINE/State/observations.jsonl"
# Ensure directory exists (relative to repo root)
mkdir -p "$(dirname "$OBSERVATION_LOG")"

# 2. Process and Scrub Observation
echo "$INPUT_JSON" | "$PYTHON_CMD" -c '
import json, sys, os, hashlib, re
from datetime import datetime, timezone

# Constants from Environment
PHASE = os.environ.get("PHASE", "post")
PROJECT_ROOT_VAL = os.environ.get("PROJECT_ROOT", "unknown")
PROJECT_NAME_VAL = os.environ.get("PROJECT_NAME", "unknown")
REMOTE_URL_VAL = os.environ.get("REMOTE_URL", "unknown")

# Secret Scrubbing Regex
_SECRET_RE = re.compile(
    r"(?i)(api[_-]?key|token|secret|password|authorization|credentials?|auth)"
    r"""(["\047"\042\s:=]+)"""
    r"([A-Za-z]+\s+)?"
    r"([A-Za-z0-9_\-/.+=]{8,})"
)

def scrub(val):
    if val is None: return None
    # Truncate to 5000 chars before scrubbing to preserve performance
    val_str = str(val)
    is_truncated = False
    if len(val_str) > 5000:
        val_str = val_str[:5000]
        is_truncated = True
    
    scrubbed = _SECRET_RE.sub(lambda m: m.group(1) + m.group(2) + (m.group(3) or "") + "[REDACTED]", val_str)
    return scrubbed + " [TRUNCATED]" if is_truncated else scrubbed

try:
    data = json.load(sys.stdin)
    
    # Generate Project ID
    project_id = hashlib.sha256(REMOTE_URL_VAL.encode()).hexdigest()[:12]
    
    event = "tool_start" if PHASE == "pre" else "tool_complete"
    tool_name = data.get("tool_name", data.get("tool", "unknown"))
    tool_input = data.get("tool_input", data.get("input", {}))
    tool_output = data.get("tool_response", data.get("tool_output", data.get("output", "")))
    session_id = data.get("session_id", "unknown")

    observation = {
        "timestamp": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "event": event,
        "tool": tool_name,
        "session": session_id,
        "project_id": project_id,
        "project_name": PROJECT_NAME_VAL,
        "project_root": PROJECT_ROOT_VAL
    }

    if PHASE == "pre":
        observation["input"] = scrub(json.dumps(tool_input) if isinstance(tool_input, dict) else tool_input)
    else:
        observation["output"] = scrub(json.dumps(tool_output) if isinstance(tool_output, dict) else tool_output)

    print(json.dumps(observation))

except Exception as e:
    # Minimal error logging to stderr to avoid breaking the tool call
    sys.stderr.write(f"[v_observe] Error: {str(e)}\n")
' PHASE="$PHASE" PROJECT_ROOT="$PROJECT_ROOT" PROJECT_NAME="$PROJECT_NAME" REMOTE_URL="$REMOTE_URL" >> "$OBSERVATION_LOG"

exit 0

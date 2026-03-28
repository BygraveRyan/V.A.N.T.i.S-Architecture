#!/usr/bin/env bash
# V.A.N.T.i.S. Session Ledger Hook
# PostToolUse command hook — captures file modifications in real-time, zero model tokens.
#
# Triggered by: Agent PostToolUse on mutation tools
# Output: .gemini/tmp/session-ledger.jsonl (one JSON entry per file touched)

LEDGER_DIR=".gemini/tmp"
LEDGER="$LEDGER_DIR/session-ledger.jsonl"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

mkdir -p "$LEDGER_DIR"

TOOL_DATA=$(cat)
if [ -z "$TOOL_DATA" ]; then
  exit 0
fi

PYTHON_CMD="python3"
if ! command -v "$PYTHON_CMD" >/dev/null 2>&1; then
  PYTHON_CMD="python"
fi

echo "$TOOL_DATA" | "$PYTHON_CMD" -c '
import json
import os
import re
import sys

timestamp = sys.argv[1]
ledger_path = sys.argv[2]
raw = sys.stdin.read().strip()

if not raw:
    raise SystemExit(0)

try:
    data = json.loads(raw)
except Exception:
    raise SystemExit(0)


def detect_agent(payload):
    env = os.environ
    model = str(
        payload.get("model")
        or env.get("CODEX_MODEL")
        or env.get("CLAUDE_MODEL")
        or env.get("GEMINI_MODEL")
        or ""
    ).lower()
    session_markers = {
        "CODEX": env.get("CODEX_SESSION_ID"),
        "CLAUDE": env.get("CLAUDE_SESSION_ID"),
        "Gemini": env.get("GEMINI_SESSION_ID"),
    }
    for name, value in session_markers.items():
        if value:
            return name
    if "gpt" in model or "codex" in model or "o1" in model or "o3" in model:
        return "Codex"
    if "claude" in model:
        return "Claude"
    if "gemini" in model:
        return "Gemini"
    return "Codex"


def add_candidate(container, value):
    if isinstance(value, str) and value:
        container.add(value)
    elif isinstance(value, list):
        for item in value:
            add_candidate(container, item)
    elif isinstance(value, dict):
        for key in ("file_path", "path", "target_file", "new_file", "old_file"):
            if key in value:
                add_candidate(container, value[key])


tool_name = (
    data.get("tool_name")
    or data.get("tool")
    or data.get("name")
    or "unknown"
)
tool_input = data.get("tool_input") or data.get("input") or {}

paths = set()

for key in (
    "file_path",
    "path",
    "target_file",
    "new_file",
    "old_file",
    "file",
    "files",
    "paths",
    "filePaths",
    "modified_files",
    "added_files",
    "updated_files",
    "deleted_files",
):
    if isinstance(tool_input, dict) and key in tool_input:
        add_candidate(paths, tool_input[key])

patch_blob = ""
if isinstance(tool_input, dict):
    patch_blob = str(tool_input.get("patch") or tool_input.get("content") or "")
elif isinstance(tool_input, str):
    patch_blob = tool_input

for pattern in (
    r"^\*\*\* Update File: (.+)$",
    r"^\*\*\* Add File: (.+)$",
    r"^\*\*\* Delete File: (.+)$",
    r"^--- a/(.+)$",
    r"^\+\+\+ b/(.+)$",
):
    for match in re.findall(pattern, patch_blob, flags=re.MULTILINE):
        paths.add(match.strip())

clean_paths = []
for path in sorted(paths):
    normalized = str(path).strip()
    if not normalized or normalized == "/dev/null":
        continue
    clean_paths.append(normalized)

if not clean_paths:
    raise SystemExit(0)

agent = detect_agent(data)
with open(ledger_path, "a", encoding="utf-8") as handle:
    for file_path in clean_paths:
        row = {
            "timestamp": timestamp,
            "agent": agent,
            "tool": tool_name,
            "file": file_path,
        }
        handle.write(json.dumps(row) + "\n")
' "$TIMESTAMP" "$LEDGER"

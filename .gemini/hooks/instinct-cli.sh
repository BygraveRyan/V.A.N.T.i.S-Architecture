#!/bin/bash
# V.A.N.T.i.S. Instinct CLI (instinct-cli.sh)
#
# Tool for reviewing observations and extracting patterns ("instincts").
#
# v1.0.0

set -e

COMMAND="${1:-review}"
OBSERVATIONS_LOG="02_MACHINE/State/observations.jsonl"

if [ ! -f "$OBSERVATIONS_LOG" ]; then
    echo "No observations found at $OBSERVATIONS_LOG"
    exit 0
fi

# Use Python for analysis
PYTHON_CMD="python3"
if ! command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python"
fi

case "$COMMAND" in
    "review")
        echo "--- V.A.N.T.i.S. Observation Review ---"
        "$PYTHON_CMD" -c '
import json
from collections import Counter

observations_file = "02_MACHINE/State/observations.jsonl"
tool_counts = Counter()
session_tools = {}

try:
    with open(observations_file, "r") as f:
        for line in f:
            obs = json.loads(line)
            tool = obs.get("tool", "unknown")
            session = obs.get("session", "unknown")
            event = obs.get("event", "unknown")
            
            if event == "tool_start":
                tool_counts[tool] += 1
                if session not in session_tools:
                    session_tools[session] = []
                session_tools[session].append(tool)

    print(f"Total Observations: {sum(tool_counts.values())}")
    print("\nMost Frequent Tools:")
    for tool, count in tool_counts.most_common(5):
        print(f"  - {tool}: {count}")

    print("\nSession Summary:")
    for session, tools in list(session_tools.items())[-5:]: # Show last 5 sessions
        print(f"  - {session}: {len(tools)} tool calls")

except Exception as e:
    print(f"Error during review: {str(e)}")
'
        ;;
    "list")
        echo "Instinct listing not yet implemented."
        ;;
    *)
        echo "Unknown command: $COMMAND"
        echo "Usage: $0 [review|list]"
        exit 1
        ;;
esac

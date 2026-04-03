#!/bin/bash

# V.A.N.T.i.S. Log-to-PR Body Extractor
# This script extracts the Reasoning Summary and Outcome from a VANTIS log
# and populates the PULL_REQUEST_TEMPLATE.md for high-signal PR creation.

LOG_FILE=$1
TEMPLATE=".github/PULL_REQUEST_TEMPLATE.md"
TMP_DIR=".gemini/tmp"
OUTPUT_PR_BODY="$TMP_DIR/PR_BODY.md"

mkdir -p "$TMP_DIR"

if [ -z "$LOG_FILE" ]; then
    echo "❌ Error: No log file provided."
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "❌ Error: Log file $LOG_FILE not found."
    exit 1
fi

echo "📂 Extracting reasoning from: $LOG_FILE"

# Extract sections from the log
WHY_CONTENT=$(sed -n '/## Reasoning Summary/,/## Outcome/p' "$LOG_FILE" | grep -v "## Reasoning Summary" | grep -v "## Outcome" | sed 's/^[[:space:]]*//' | tr '\n' ' ')
OUTCOME_CONTENT=$(sed -n '/## Outcome/,$p' "$LOG_FILE" | grep -v "## Outcome" | sed 's/^[[:space:]]*//' | tr '\n' ' ')

# Prepare the PR body
cp "$TEMPLATE" "$OUTPUT_PR_BODY"

# Inject content into the PR body template using a safer delimiter (| instead of /)
sed -i '' "s|<!-- Explain the friction or limitation in the current architecture. e.g., \"V.A.N.T.i.S. lacks a personal context layer...\" -->|$WHY_CONTENT|g" "$OUTPUT_PR_BODY"
sed -i '' "s|<!-- Detail the technical implementation. e.g., \"Created USER_CONTEXT.md and updated the system prompt.\" -->|See HOW section in $LOG_FILE|g" "$OUTPUT_PR_BODY"
sed -i '' "s|<!-- Explain how the system is better now. e.g., \"V.A.N.T.i.S. can now generate Ryan-specific insights.\" -->|$OUTCOME_CONTENT|g" "$OUTPUT_PR_BODY"

# Add the log reference to Traceability (escaping brackets and brackets for sed)
sed -i '' "s|- \[ \] Related Audit Log / Task ID:|- [x] Related Audit Log / Task ID: $LOG_FILE|g" "$OUTPUT_PR_BODY"

echo "✅ PR Body generated at: $OUTPUT_PR_BODY"

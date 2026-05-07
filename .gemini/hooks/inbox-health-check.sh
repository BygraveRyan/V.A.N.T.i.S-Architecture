#!/bin/bash
# Inbox Health Check for Diagnose Integration
# Purpose: Report inbox status for health scoring
# Version: 1.0.0
# Cost: Zero agent tokens (pure shell execution)

INBOX_DIR="01_HUMAN/Inbox"
LEDGER_FILE=".gemini/state/inbox-ledger.csv"

echo "📮 INBOX HEALTH STATUS"
echo "========================"
echo ""

# Count unprocessed items
unprocessed=0
for file in "$INBOX_DIR"/*.md; do
  [ -e "$file" ] || continue
  filename=$(basename "$file")

  # Check if file is in ledger
  if ! grep -q "^[^,]*,\"$filename\"," "$LEDGER_FILE" 2>/dev/null; then
    unprocessed=$((unprocessed + 1))
  fi
done

echo "✓ Unprocessed items: $unprocessed"

# Find oldest unprocessed item
if [ $unprocessed -gt 0 ]; then
  oldest=$(ls -rt "$INBOX_DIR"/*.md 2>/dev/null | head -1)
  if [ -n "$oldest" ]; then
    filename=$(basename "$oldest")
    age_days=$(( ($(date +%s) - $(stat -f%m "$oldest")) / 86400 ))
    echo "✓ Oldest item: $filename (${age_days} days old)"

    # Warn if older than 7 days
    if [ $age_days -ge 7 ]; then
      echo "⚠️  WARNING: Inbox has stale items (7+ days old)"
    fi
  fi
else
  echo "✓ Oldest item: None (inbox clean)"
fi

# Report health score deduction
echo ""
echo "Health Score Impact:"
echo "  Deduct: $((unprocessed * 2)) points (${unprocessed} items × 2 pts each, max -20)"

if [ $unprocessed -ge 10 ]; then
  echo "  ⚠️  Max deduction: -20 points (10+ items capped)"
  echo "  Status: 🔴 CRITICAL (inbox overflow)"
elif [ $unprocessed -ge 5 ]; then
  echo "  Status: 🟠 WARNING (moderate backlog)"
else
  echo "  Status: 🟢 HEALTHY"
fi

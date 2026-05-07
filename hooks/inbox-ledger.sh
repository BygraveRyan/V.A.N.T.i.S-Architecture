#!/bin/bash
# Inbox Processing Ledger
# Purpose: Track processed inbox items to prevent duplicates and enable resume-on-interruption
# Version: 1.0.0
# Cost: Zero agent tokens (pure shell execution)

LEDGER_FILE=".gemini/state/inbox-ledger.csv"
INBOX_DIR="private workspace/Inbox"

# Initialize ledger if it doesn't exist
if [ ! -f "$LEDGER_FILE" ]; then
  mkdir -p "$(dirname "$LEDGER_FILE")"
  echo "processed_date,filename,file_hash,destination,status,archived_date" > "$LEDGER_FILE"
fi

# Function: Get hash of file (for duplicate detection)
get_file_hash() {
  local file="$1"
  if [ -f "$file" ]; then
    md5 < "$file" | awk '{print $1}'
  else
    echo ""
  fi
}

# Function: List pending (new, unprocessed) inbox items
list_pending() {
  echo "📋 PENDING INBOX ITEMS (new, not yet processed):"
  echo ""

  local pending_count=0

  for file in "$INBOX_DIR"/*.md; do
    [ -e "$file" ] || continue
    filename=$(basename "$file")
    file_hash=$(get_file_hash "$file")

    # Check if this exact file (by name and hash) has been processed before
    if ! grep -q "\"$filename\",.*\"$file_hash\"" "$LEDGER_FILE"; then
      echo "  ✓ $filename"
      pending_count=$((pending_count + 1))
    fi
  done

  echo ""
  echo "Total pending: $pending_count items"
  return $pending_count
}

# Function: Check if file has been processed
check_processed() {
  local filename="$1"

  if grep -q "^[^,]*,$filename," "$LEDGER_FILE"; then
    echo "✅ Already processed: $filename"
    grep "^[^,]*,$filename," "$LEDGER_FILE" | cut -d',' -f1,4,5
    return 0
  else
    echo "❌ Not found in ledger: $filename"
    return 1
  fi
}

# Function: Add entry to ledger
add_entry() {
  local filename="$1"
  local destination="$2"
  local status="${3:-processed}"
  local processed_date=$(date +%Y-%m-%d\ %H:%M:%S)
  local file_hash=$(get_file_hash "$INBOX_DIR/$filename")

  # Append to ledger
  echo "\"$processed_date\",\"$filename\",\"$file_hash\",\"$destination\",\"$status\",\"\"" >> "$LEDGER_FILE"

  echo "✓ Logged: $filename → $destination ($status)"
}

# Function: Mark as archived
archive_entry() {
  local filename="$1"
  local archived_date=$(date +%Y-%m-%d\ %H:%M:%S)

  # Update the archived_date field for this file
  if [ -f "$LEDGER_FILE" ]; then
    # Use a temp file to avoid in-place sed issues
    local temp_file=$(mktemp)
    while IFS=',' read -r proc_date fname fhash dest status arch_date; do
      if [ "$fname" = "\"$filename\"" ]; then
        echo "$proc_date,$fname,$fhash,$dest,$status,\"$archived_date\"" >> "$temp_file"
      else
        echo "$proc_date,$fname,$fhash,$dest,$status,$arch_date" >> "$temp_file"
      fi
    done < "$LEDGER_FILE"
    mv "$temp_file" "$LEDGER_FILE"
    echo "✓ Archived: $filename"
  fi
}

# Function: Show ledger stats
show_stats() {
  echo "📊 LEDGER STATISTICS:"
  echo "Total processed: $(tail -n +2 "$LEDGER_FILE" | wc -l)"
  echo "Archived: $(tail -n +2 "$LEDGER_FILE" | awk -F',' '$NF != ""' | wc -l)"
  echo "Pending archive: $(tail -n +2 "$LEDGER_FILE" | awk -F',' '$NF == ""' | wc -l)"
  echo ""
}

# Main dispatcher
case "${1:-list-pending}" in
  list-pending)
    list_pending
    ;;
  add-entry)
    add_entry "$2" "$3" "${4:-processed}"
    ;;
  check-processed)
    check_processed "$2"
    ;;
  archive-entry)
    archive_entry "$2"
    ;;
  show-stats)
    show_stats
    ;;
  *)
    echo "Usage: $0 {list-pending|add-entry <filename> <destination> [status]|check-processed <filename>|archive-entry <filename>|show-stats}"
    exit 1
    ;;
esac

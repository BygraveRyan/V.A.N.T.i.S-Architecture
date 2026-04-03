#!/bin/bash
# V.A.N.T.i.S. Cleanup Hook (v_cleanup.sh)
#
# Automates vault hygiene by:
# 1. Archiving logs older than 7 days to 04_ARCHIVES/Daily/.
# 2. Compacting observations.jsonl to the last 1000 entries.
# 3. Clearing temporary files and system noise (.DS_Store, .gemini/tmp/).
#
# Version: 1.0.0
#

set -e

echo "🧹 V.A.N.T.i.S. VAULT CLEANUP"
echo "   Date: $(date +%Y-%m-%d)"
echo ""

# 1. ARCHIVING OLD LOGS
echo "[1/3] Archiving legacy logs (7+ days old)..."
LOGS_DIR="logs"
ARCHIVE_DIR="04_ARCHIVES/Daily"
mkdir -p "$ARCHIVE_DIR"

# Find directories in logs/ that are older than 7 days (formatted as YYYY-MM-DD)
# On macOS, we use find with -mtime
# We check if the directory name matches a date pattern to be safe
THRESHOLD_DATE=$(date -v-7d +%Y-%m-%d)

cd "$LOGS_DIR"
for dir in */; do
    dir=${dir%/}
    if [[ "$dir" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        if [[ "$dir" < "$THRESHOLD_DATE" ]]; then
            echo "   📦 Archiving: $dir"
            mv "$dir" "../$ARCHIVE_DIR/"
        fi
    fi
done
cd ..

# 2. COMPACTING OBSERVATIONS
echo "[2/3] Compacting observation log..."
OBS_LOG="02_MACHINE/State/observations.jsonl"
if [ -f "$OBS_LOG" ]; then
    SIZE=$(du -h "$OBS_LOG" | cut -f1)
    LINES=$(wc -l < "$OBS_LOG")
    if [ "$LINES" -gt 1000 ]; then
        echo "   📉 Current: $SIZE ($LINES lines). Compacting to last 1000 entries..."
        tail -n 1000 "$OBS_LOG" > "${OBS_LOG}.tmp"
        mv "${OBS_LOG}.tmp" "$OBS_LOG"
        NEW_SIZE=$(du -h "$OBS_LOG" | cut -f1)
        echo "   ✅ Compacted to $NEW_SIZE."
    else
        echo "   ℹ️ Observation log is healthy ($LINES lines)."
    fi
else
    echo "   ℹ️ No observation log found."
fi

# 3. PURGING TEMP & NOISE
echo "[3/3] Purging temporary files and system noise..."
# Clean .gemini/tmp
if [ -d ".gemini/tmp" ]; then
    echo "   🗑️ Clearing .gemini/tmp/..."
    # Keep the directory, delete the contents
    find .gemini/tmp -mindepth 1 -delete
fi

# Clean .DS_Store
echo "   🗑️ Removing .DS_Store files..."
find . -name ".DS_Store" -delete

echo ""
echo "✨ CLEANUP COMPLETE"
exit 0

#!/bin/bash
# inbox-router.sh — Pattern-based inbox classifier
# Classifies inbox items into auto-route (≥80% confidence) and manual review (<80%) buckets
# Output format: classification decisions with confidence scores

INBOX_DIR="01_HUMAN/Inbox"

# Initialize counters
auto_route_items=()
manual_review_items=()

classify_item() {
    local filename="$1"
    local lower=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

    # Northern Strata (highest priority, highest confidence)
    if [[ $lower =~ northern.strata|northernstrata|jr-yt ]] || [[ $lower =~ "trades web" ]]; then
        echo "01_HUMAN/Business/NorthernStrata|90|NS business match"
        return
    fi

    # Career/Personal items
    if [[ $lower =~ career|cv|interview ]]; then
        echo "01_HUMAN/Personal|85|Career/personal signal"
        return
    fi

    # Research/Architecture items
    if [[ $lower =~ "research dossier"|dossier ]]; then
        echo "02_MACHINE/ai-candidates|88|Research dossier"
        return
    fi

    if [[ $lower =~ "technical standard"|"architecture specification" ]]; then
        echo "02_MACHINE/ai-candidates|85|Technical/architecture research"
        return
    fi

    # AI Chat Exports
    if [[ $lower =~ gpt-export|gemini-export|perplexity-export ]]; then
        echo "02_MACHINE/AI_Chat_Imports|82|AI chat export"
        return
    fi

    # No match
    echo "NONE|0|No pattern match - needs manual review"
}

echo "📊 INBOX ROUTING ANALYSIS"
echo ""

auto_count=0
manual_count=0

# Find all inbox markdown files (excluding Archive)
cd "$INBOX_DIR" 2>/dev/null || exit 1
for file in *.md; do
    [[ "$file" == "*.md" ]] && continue  # Skip if no .md files exist
    [[ "$file" == "Archive" ]] && continue

    classification=$(classify_item "$file")
    destination=$(echo "$classification" | cut -d'|' -f1)
    confidence=$(echo "$classification" | cut -d'|' -f2)
    reason=$(echo "$classification" | cut -d'|' -f3)

    # Categorize based on confidence
    if [ "$confidence" -ge 80 ]; then
        auto_route_items+=("$file|$destination|$confidence|$reason")
        ((auto_count++))
    else
        manual_review_items+=("$file|$reason")
        ((manual_count++))
    fi
done
cd - > /dev/null

# Print auto-route recommendations
if [ $auto_count -gt 0 ]; then
    echo "✅ HIGH-CONFIDENCE AUTO-ROUTE ($auto_count items):"
    for item in "${auto_route_items[@]}"; do
        IFS='|' read -r filename dest conf reason <<< "$item"
        printf "   • %-50s → %s (%d%%)\n" "$filename" "$dest" "$conf"
    done
    echo ""
fi

# Print manual review list
if [ $manual_count -gt 0 ]; then
    echo "❓ NEEDS MANUAL DECISION ($manual_count items):"
    for item in "${manual_review_items[@]}"; do
        IFS='|' read -r filename reason <<< "$item"
        printf "   - [ ] %s\n" "$filename"
    done
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Summary: $auto_count can auto-route, $manual_count need your decision"
echo ""

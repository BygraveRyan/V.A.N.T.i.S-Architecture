#!/bin/bash
# Link Integrity Checker for Galaxy
# Purpose: Scan Galaxy files for broken wikilinks [[concept-name]]
# Version: 1.0.0
# Cost: Zero agent tokens (pure shell execution)

GALAXY_DIR="private workspace/Knowledge/Galaxy"
TEMP_FILE=$(mktemp)

echo "🔗 GALAXY LINK INTEGRITY CHECK"
echo "Scanning $GALAXY_DIR for broken [[wikilinks]]..."
echo ""

# Extract all wikilinks from all Galaxy files into temp file
grep -roh '\[\[[a-zA-Z0-9-]*\]\]' "$GALAXY_DIR" 2>/dev/null | sort -u > "$TEMP_FILE"

BROKEN_COUNT=0

# Check each link
while IFS= read -r link; do
  # Remove brackets: [[name]] → name
  link_name=$(echo "$link" | sed 's/\[\[//g' | sed 's/\]\]//g')

  # Check if target file exists
  target_file="$GALAXY_DIR/$link_name.md"

  if [ ! -f "$target_file" ]; then
    if [ $BROKEN_COUNT -eq 0 ]; then
      echo "RESULTS:"
      echo "--------"
      echo "❌ Found broken link(s):"
      echo ""
    fi

    BROKEN_COUNT=$((BROKEN_COUNT + 1))
    echo "  ❌ $link"

    # Find which files reference this broken link
    echo "     References:"
    grep -l "$(echo $link | sed 's/\[\[//g' | sed 's/\]\]//g')" "$GALAXY_DIR"/*.md 2>/dev/null | while read -r ref_file; do
      echo "       - $(basename "$ref_file")"
    done
    echo ""
  fi
done < "$TEMP_FILE"

# Clean up
rm -f "$TEMP_FILE"

# Report results
if [ $BROKEN_COUNT -eq 0 ]; then
  echo "RESULTS:"
  echo "--------"
  echo "✅ All links resolved correctly. (0 broken links)"
  exit 0
else
  echo "Total broken links: $BROKEN_COUNT"
  exit 1
fi

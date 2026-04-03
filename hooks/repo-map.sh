#!/usr/bin/env bash
# VANTIS Repository Map Hook (SessionStart)
# Provides an initial directory structure to the agent.

# Consume stdin to prevent script hanging
cat > /dev/null

# Generate a map of the repository (Depth 3, excluding noisy folders)
# Using 'ls -R' as a fallback if 'tree' is not installed
if command -v tree >/dev/null 2>&1; then
    map=$(tree -L 3 -I ".git|.obsidian|node_modules|logs" --noreport)
else
    map=$(ls -R | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/' | head -n 50)
    map="$map\n(Note: Using 'ls' fallback; 'tree' not found for full visualization.)"
fi

# Output the context injection JSON
cat <<EOF
{
  "hookSpecificOutput": {
    "additionalContext": "\n## VANTIS Repository Structure\n\`\`\`\n$map\n\`\`\`"
  }
}
EOF

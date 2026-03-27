#!/usr/bin/env bash
# V.A.N.T.i.S. Council of Universals — Shell Aliases
# Source this file to enable quick access to Council roles.
# Usage: source 03_SYSTEM/Protocols/Universals/aliases.sh

# --- Claude Code Aliases ---
# Launches Claude pre-loaded with the specific Council role context.
alias claude-architect='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/architect.md)"'
alias claude-strategist='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/strategist.md)"'
alias claude-researcher='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/researcher.md)"'
alias claude-guardian='claude --system-prompt "$(cat 03_SYSTEM/Protocols/Universals/guardian.md)"'

# --- Gemini CLI Note ---
# Gemini CLI uses native subagent discovery. 
# Roles are available via: /architect, /strategist, /researcher, /guardian

echo "✅ V.A.N.T.i.S. Council aliases loaded."
echo "   Roles: architect, strategist, researcher, guardian"

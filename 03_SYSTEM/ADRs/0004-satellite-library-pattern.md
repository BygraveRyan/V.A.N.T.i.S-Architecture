# ADR-0004: EXTERNAL SATELLITE LIBRARY PATTERN

**Date**: 2026-03-30  
**Status**: APPROVED  
**Agents**: Gemini CLI (Architect)  
**Context**: The 02_MACHINE/Research/ layer was becoming critically heavy (60MB, 1,742+ files) due to the ingestion of complete external research repositories. This slowed down search, increased context debt, and bloated the primary V.A.N.T.i.S. Git repository.

---

## [DECISION] ARCHITECTURAL SHIFT
We have introduced a **"Satellite Library"** pattern to decouple large, raw research data from the core V.A.N.T.i.S. "Brain."

1.  **Externalized Storage**: Massive research repositories (e.g., `everything-claude-code`) are moved to `~/Documents/VANTIS_LIBRARIES/`.
2.  **Symlink Integration**: A symbolic link is created within `02_MACHINE/Research/` pointing to the external directory.
3.  **Git Invalidation**: The symlink path is strictly `.gitignore`'d to prevent tracking external assets.
4.  **Concept Harvesting**: V.A.N.T.i.S. agents continue to use the symlink as a "reference source" to extract high-signal concepts into the `ai-candidates/` or `Galaxy/` layers.

---

## [RATIONALE] WHY THIS MATTERS
- **Repo Performance**: Reduces the Git-tracked file count in 02_MACHINE by ~97%.
- **Tool Compatibility**: Obsidian, VSCode, and AI agents can still traverse symlinks to read the data.
- **Scalability**: Allows V.A.N.T.i.S. to "point" to gigabytes of data without internalizing the bloat.

---

## [IMPACT] NEXT STEPS
- **System Diagnostics**: Must now account for symlink validity.
- **Promotion Workflow**: When "harvesting" from a Satellite, agents must copy data into the vault, rather than moving it, to preserve the library's integrity.
- **Portability**: Users moving V.A.N.T.i.S. to a new machine must also migrate the `VANTIS_LIBRARIES` folder to maintain symlink integrity.

---
*V.A.N.T.i.S. Architecture Decision Record | Signal v1.3*

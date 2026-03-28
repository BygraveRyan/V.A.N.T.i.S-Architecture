---
id: galaxy-metadata-refactor
type: project-seed
status: todo
vision: "Refine the metadata schema for the Galaxy to better distinguish between human-original, AI-assisted, and verified knowledge nodes."
created: 2026-03-18
updated: 2026-03-18
---

# PROJECT SEED: Galaxy Metadata Refactor

## Vision
"Ensure the Galaxy's metadata reflects the true lineage of every concept while remaining intuitive for human and AI retrieval."

## Problem Statement
The current implementation of `source: ai-assisted` and `verified_by: human` is not yet working as intended. We need a more robust or intuitive system to manage the boundary between AI-generated synthesis and human-verified truth.

## Core Requirements
- **Lineage Clarity**: Clearly distinguish between Human-Original, AI-Proposed (Candidate), and AI-Assisted (Human-Verified).
- **Automation Compatibility**: Ensure the schema can be easily parsed by VANTIS agents for knowledge synthesis.
- **Visual Distinction**: (Optional) Use specific tags or fields that change how notes appear in the Obsidian graph.

## Next Steps
- [ ] Research alternative metadata standards for "Cyborg" Knowledge Bases (e.g., source: human+ai).
- [ ] Define the "Final Approval" state—does a note move from `source: ai-assisted` to `source: human` once verified?
- [ ] Refactor existing Galaxy nodes to the new agreed-upon standard.

---
*Captured after the March 18 morning sync.*

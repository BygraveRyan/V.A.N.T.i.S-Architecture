# Background & Motivation
The V.A.N.T.i.S. `01_HUMAN/Knowledge/Galaxy` folder contains knowledge nodes (concepts) that are essential to the system's long-term memory. A recent inspection revealed that older concepts do not adhere to the newly established `METADATA_SCHEMA.md` (v1.0). Specifically, they lack YAML delimiters (`---`), use inline strings or Obsidian tags instead of YAML arrays, use Obsidian wikilinks (`[[link]]`) instead of proper `concept-id` formats for relationships, and lack mandatory fields like `schema_version`.

To ensure programmatic parsability and AI-readiness of the Knowledge Graph, we must standardize all notes to the V1 schema.

# Key Differences from Current State
Currently, your older notes are formatted for **purely human/Obsidian reading** (e.g., `#Tags`, inline text, missing `---` boundaries). The new standard shifts them to **dual-readability** (Human + Machine).

**Before (Current State):**
```markdown
id: concept-agentic-scoping-matrix 
type: concept 
domain: AI Risk Management 
tags: #Governance #Risk-Assessment
related_concepts: [[NIST-AI-RMF]], [[AWS-Security]] 
```

**After (Standardized V1 Schema):**
```yaml
---
id: concept-agentic-scoping-matrix
type: concept
domain:
  - AI Risk Management
tags:
  - Governance
  - Risk-Assessment
related_concepts:
  - "[[NIST-AI-RMF]]"
  - "[[AWS-Security]]"
schema_version: 1
created: 2026-03-21
updated: 2026-03-21
---
```

# Architectural Impact on V.A.N.T.i.S.
This is a foundational structural change. The initial architecture of V.A.N.T.i.S. treated the Galaxy as a collection of Markdown files. By enforcing this strict YAML standard, we are fundamentally shifting the architecture in three ways:

1. **The Vector Database Pivot:** By converting unstructured text headers into strictly typed YAML fields (`domain: []`, `tags: []`), these notes can now be ingested directly into vector databases (like Pinecone or Chroma) or parsed by MCP (Model Context Protocol) servers with zero pre-processing.
2. **Skill Layer Enablement:** Future agents (like the Knowledge Architect) can now use tools to programmatically query the vault (e.g., `Find all notes where 'domain' includes 'AI Risk Management'`). Currently, this is impossible because the metadata isn't standard YAML.
3. **Graph Integrity:** Obsidian will still render the `[[ ]]` links perfectly, meaning your visual UI (The Human Layer) is unaffected, but the Machine Layer now has a rigid contract to follow when interacting with your knowledge.

# Scope & Impact
- **Target Files**: All `.md` files in `01_HUMAN/Knowledge/Galaxy/`.
- **System Change**: We will write a lightweight Node.js script (using the built-in `fs` module) to parse the head of each Markdown file, extract existing metadata, normalize it, and rewrite the frontmatter cleanly. Crucially, **Obsidian wikilinks (`[[ ]]`) will be preserved** in the `related_concepts` array to maintain full functionality of the Obsidian Graph View.
- **Blast Radius**: Modifies core knowledge files. We will backup the directory to a temporary location before executing the change to ensure zero data loss.

# Proposed Solution
1. **Backup**: Create a copy of `01_HUMAN/Knowledge/Galaxy` to `/tmp/galaxy-backup`.
2. **Standardization Script**: Write a Node.js script (`.gemini/hooks/standardize-galaxy.js`) that:
   - Reads each file.
   - Detects if standard YAML frontmatter exists (`---`). If not, assumes the top block of `key: value` lines is the metadata until the first empty line or `# Header`.
   - Normalizes keys:
     - `domain: string` -> `domain:\n - string`
     - `tags: #tag1 #tag2` -> `tags:\n - tag1\n - tag2` (Obsidian tags converted to clean YAML tag arrays).
     - `related_concepts: [[link1]], [[link2]]` -> `related_concepts:\n - "[[link1]]"\n - "[[link2]]"` (Preserving wikilinks for Graph View).
   - Injects missing required fields: `schema_version: 1`, `created`, `updated`.
   - Writes the new standard frontmatter wrapped in `---` delimiters back to the file.
3. **Execution**: Run the script over the Galaxy directory.
4. **Validation**: Select 3 random files and read their contents to verify the transformation.
5. **Cleanup**: Provide instructions for the user to commit the changes.

# Implementation Plan
1. `run_shell_command`: Execute `git checkout -b feat/galaxy-metadata-refactor` to adhere strictly to **Rule 11 (Branched Evolution)** and isolate these structural changes.
2. `run_shell_command`: Backup Galaxy folder to `/tmp/galaxy-backup` as a secondary safety measure.
3. `write_file`: Create the Node.js transformation script (`.gemini/hooks/standardize-galaxy.js`).
4. `run_shell_command`: Execute the Node.js script.
5. `read_file`: Verify the output of `concept-agentic-scoping-matrix.md`.
6. `write_file`: Create the audit log in `logs/YYYY-MM-DD/`.
7. `run_shell_command`: Stage and commit the standardized notes to the feature branch.

# Verification & Rollback
- **Verification**: Ensure no content below the frontmatter is lost. Ensure `read_file` shows perfectly formatted YAML.
- **Rollback**: If the script corrupts the files, run `cp -r /tmp/galaxy-backup/* 01_HUMAN/Knowledge/Galaxy/` to restore the original state.

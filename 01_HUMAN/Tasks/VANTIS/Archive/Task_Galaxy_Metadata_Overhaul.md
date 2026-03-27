# TASK: V.A.N.T.i.S. Galaxy Metadata Overhaul (v1.5)

**Status:** ✅ Complete  
**Layer:** Knowledge & Intelligence  
**Goal:** System-wide metadata standardization for all Galaxy and Candidate nodes.

---

## 🚀 STRATEGIC MOTIVATION (WHY)
The V.A.N.T.i.S. knowledge graph (Galaxy) has grown inconsistently, leading to "metadata drift." Some notes lack proper YAML frontmatter, use legacy field names, or follow outdated ID protocols. To ensure deterministic AI retrieval and a coherent concept graph, a system-wide upgrade to the **v1.5 Metadata Schema** is required.

---

## 🏗️ ARCHITECTURAL DESIGN (HOW)
Standardize all knowledge nodes in `01_HUMAN/Knowledge/Galaxy/` and `02_MACHINE/Synthesis/` to the v1.5 Metadata Schema.

### Required YAML Structure (v1.5)
```yaml
---
id: concept-<domain>-<name>
type: concept | framework | mental-model | method | definition | pattern
status: seed | developing | evergreen | deprecated
domain:
  - <primary-domain>
abstraction_layer: foundational | component | systemic | strategic | ecosystem
verified_distinct: true
created: YYYY-MM-DD
updated: 2026-03-25
version: 1
schema_version: 1.5
source: human-original | ai-assisted | ai-candidate
confidence: low | medium | high
related_concepts:
  - concept-id-1
  - concept-id-2
aliases:
  - Alias 1
tags:
  - tag1
---
```

---

## 📅 IMPLEMENTATION PLAN

### PHASE 1: AUDIT & MAPPING
- [x] Create a "Source of Truth" mapping table for all existing files (~25 total).
- [x] Assign new IDs and Primary Domains to every node.
- [x] Verify creation dates from file metadata or Git history.

### PHASE 2: BATCH METADATA STANDARDIZATION
- [x] **Frontmatter Injection**: Ensure all notes start with the standard YAML block.
- [x] **Field Normalization**: Convert `domain` and `related_concepts` to YAML lists.
- [x] **Source Mapping**: `human` -> `human-original`, `ai-synthesis` -> `ai-candidate`.
- [x] **ID Alignment**: Rename files to match their new `id` field.

### PHASE 3: RELATIONSHIP REPAIR & PROMOTION
- [x] Update `related_concepts` to use plain IDs (remove wikilinks).
- [x] Update internal wikilinks in the note body to match new IDs.
- [x] Run an orphan check to identify broken or missing connections.
- [x] Promote staged files and deprecate redundant candidates.

### PHASE 4: FINAL VALIDATION & LOGGING
- [x] Run a automated validation script (Grep) to ensure 100% compliance.
- [x] Generate a high-fidelity audit log.
- [x] Update the `System_Intelligence_Center.md` dashboard.

---

## ⚠️ RISK MITIGATION
- **Branch Strategy**: All work performed on `feat/galaxy-metadata-overhaul`.
- **Atomic Commits**: Git commits after each Phase to allow surgical rollbacks.
- **Human Verification**: No file is moved to Galaxy without a final source check.

---

## 📋 NEXT ACTIONS
1. **Draft PR**: Submit the changes to the main repository.

---

## 🔗 RELATED CONCEPTS
- [[METADATA_SCHEMA]]
- [[GALAXY_NOTE_TEMPLATE]]
- [[concept-ai-native-engineering]]

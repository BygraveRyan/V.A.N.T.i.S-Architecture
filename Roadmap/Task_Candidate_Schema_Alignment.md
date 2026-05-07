# TASK: Candidate Schema Alignment & Agent Guardrail
Version: 1.0.1

**ID:** TASK-GALAXY-ALIGN-01
**Status:** SEED
**Priority:** MEDIUM
**Owner:** Gemini (Control Plane)

---

## 🎯 OBJECTIVE
Ensure all AI-generated candidates in `02_MACHINE/ai-candidates/` strictly adhere to the `METADATA_SCHEMA.md` v1.6 standard. Prevent future drift by updating agent instructions/prompts.

---

## 🚩 GAPS IDENTIFIED
A sample audit of `02_MACHINE/ai-candidates/` revealed significant schema drift, particularly in Claude-generated nodes:

1. **Schema Mismatch:** Some nodes use a `name/description` format instead of the mandatory `id` and YAML frontmatter (e.g., `concept-data-engineering-mcp-context-trap.md`).
2. **Missing Mandatory Fields:** Many nodes are missing `abstraction_layer`, `verified_distinct`, and `source_project`.
3. **Legacy Versioning:** Nodes are defaulting to schema v1.5 or lower instead of v1.6.
4. **ID Inconsistency:** Some IDs omit the `concept-` prefix or do not follow the `<domain>-<name>` pattern.

---

## 🛠️ ACTION PLAN

- [ ] **Phase 1: Batch Correction**
  - [ ] Audit all files in `02_MACHINE/ai-candidates/`.
  - [ ] Rewrite frontmatter for non-compliant files to match v1.6.
  - [ ] Rename files to match the new `id` if necessary.

- [ ] **Phase 2: Agent Guardrails**
  - [ ] Update `AGENTS.md` and model-specific instructions (Claude/Gemini) to explicitly enforce the v1.6 schema.
  - [ ] Add a "Schema Validation" step to the Inbox Processor workflow.

- [ ] **Phase 3: Verification**
  - [ ] Run a diagnostic check to ensure zero schema errors in the candidate layer.

---

## 🔗 REFERENCES
- `03_SYSTEM/Protocols/METADATA_SCHEMA.md`
- `02_MACHINE/ai-candidates/`

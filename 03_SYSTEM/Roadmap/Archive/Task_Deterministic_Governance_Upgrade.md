---
id: task-deterministic-governance-upgrade
type: task
status: in-progress
priority: high
created: 2026-03-22
updated: 2026-03-22
---

# TASK: Deterministic Governance & PR Pipeline Upgrade

## Objective
Establish a "Deterministic Governance" framework by synchronizing all repository templates (`.gitmessage`, `commit_template.md`, `PULL_REQUEST_TEMPLATE.md`) to a single, descriptive "Why/How/Impact" standard. This includes implementing a mandatory formatting guardrail and automating the extraction of reasoning from V.A.N.T.i.S. logs into Pull Request descriptions.

## Implementation Steps

### Phase 0: Task Ingestion & Branching
- [x] **Create Task Entry**: Save this plan as `03_SYSTEM/Roadmap/Active/Task_Deterministic_Governance_Upgrade.md`.
- [ ] **Branch Creation**: Initialize `feat/deterministic-governance-v1` from the latest `main`.

### Phase 1: Template Synchronization (SSOT)
- [ ] **Header Alignment**: Standardize all three `.github/` templates to use these exact headers:
   - `### WHY - What problem are we solving?`
   - `### HOW - What did we actually change?`
   - `### IMPACT - What is the result?`
   - `### TRACEABILITY - Linked Logs`
- [ ] **Update `GOVERNANCE.md`**: Codify these headers in Section 3.1 and mandate the use of `gh pr create --body-file`.

### Phase 2: Formatting Guardrails
- [ ] **Update `RULES.md`**: Add "Rule 12 — Template Validation": *Agents must verify commit/PR headers against '.github/commit_template.md' before execution.*
- [ ] **Implementation**: I (the agent) will now perform a `cat` or `grep` check as a mandatory pre-commit turn.

### Phase 3: Log-to-PR Pipeline Automation
- [ ] **Develop Extractor**: Create `.gemini/hooks/extract-pr-body.sh`.
- [ ] **Refine `publish-mirror.sh`**: Add a "Privacy Filter" (e.g., `sed` or `grep -v`) to strip sensitive paths.

### Phase 4: Verification & Archiving
- [ ] **Test PR**: Create a mock PR and verify formatting.
- [ ] **Archive Task**: Move the plan to `03_SYSTEM/Roadmap/Archive/` upon successful merge.
- [ ] **Log Finality**: Produce final audit log.

## Verification & Testing
- [ ] **Header Check**: Confirm `.gitmessage`, `commit_template.md`, and `PULL_REQUEST_TEMPLATE.md` are identical.
- [ ] **Automation Test**: Run `extract-pr-body.sh` on a sample log.
- [ ] **Guardrail Test**: Demonstrate the "Read-First" rule.

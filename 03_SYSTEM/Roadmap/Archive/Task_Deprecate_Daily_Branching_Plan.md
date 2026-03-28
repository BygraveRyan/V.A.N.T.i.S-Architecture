---
id: task-deprecate-daily-branching
type: task
status: in-progress
priority: high
created: 2026-03-22
updated: 2026-03-22
---

# TASK: Deprecate Daily Branching & Restore Governance Standards

## Objective
Transition the V.A.N.T.i.S. workflow from time-based branching (`daily/YYYY-MM-DD`) to the **Branched Evolution** principle (logical `feat/` and `fix/` branches). This includes restoring "lost" documentation in `.github/GOVERNANCE.md` and refactoring the `/daily` command to focus on synthesis rather than Git execution.

## Implementation Steps

### Phase 0: Plan Ingestion & Audit Trail
- [x] **Create Task Entry**: Save this plan as a new task file: `03_SYSTEM/Roadmap/Active/Task_Deprecate_Daily_Branching_Plan.md`.
- [x] **Link to Log**: Ensure the next audit log specifically references the creation of this persistent plan.

### Phase 1: Restore Governance Integrity
- [x] **Extract Missing Content**: Retrieve the full text of Section 3.5 from commit `feac51c`.
- [x] **Update `main`**: Switch to `main` and surgically apply the missing section to `.github/GOVERNANCE.md`.
- [x] **Audit**: Verify that no other "lost" changes exist between the failed merge and the current state.

### Phase 2: Refactor `/daily` Command
- [x] **Decouple Git Operations**: Remove the `!{git checkout ... && git push ...}` logic from `.gemini/commands/daily.toml`.
- [x] **Refocus on Synthesis**: Update the prompt to focus purely on creating the `AI-Daily-Review` markdown file.
- [x] **Standardize Handoff**: Ensure the command output clearly lists recommended `feat/` branches for the next session's work.

### Phase 3: Cleanup & Reconciliation
- [x] **Reconcile `daily/2026-03-21`**: Identify any new logs or task updates on the daily branch.
- [x] **Merge to `main`**: Cherry-pick or merge valid content (logs/tasks) back to `main`.
- [x] **Branch Deletion**: Delete the local and remote `daily/2026-03-21` branches to clear technical debt.

### Phase 4: Archiving & Completion
- [x] **Archive Task**: Upon successful verification, move the task file from `Active/` to `03_SYSTEM/Roadmap/Archive/Task_Deprecate_Daily_Branching_Plan.md`.
- [x] **Log Finality**: Produce a final audit log confirming the decommissioning of the daily branching system.

## Verification & Testing
- [ ] **Governance Check**: Confirm Section 3.5 is visible in `.github/GOVERNANCE.md` on `main`.
- [ ] **Command Test**: Run `/daily` (dry-run/simulated) to ensure it generates the review file without triggering Git branch creation.
- [ ] **Git Status**: Confirm the system is back on `main` (or a specific `feat/` branch) with a clean tree.

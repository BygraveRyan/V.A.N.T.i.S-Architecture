---
name: parent-orchestrator-qa
description: Use a central planner to coordinate creation, then pass results to an independent QA agent for defect discovery.
---

# SKILL: Parent-Orchestrator with QA
Version: 2.0.0

Purpose
Use a central planner to coordinate creation, then pass results to an independent QA agent for defect discovery.

---

# When To Use
- **Trigger**: Building something substantial or complex.
- **Requirement**: You need iterative development with high-fidelity quality control, and want to avoid creator bias.

---

# Do Not Use When
- The task is too small or routine to justify the overhead of orchestration.
- No meaningful or objective QA criteria exist.

---

# Core Protocol (Execution Rules)

## Step 1 — Planning
1. The **Parent Orchestrator** defines the task plan, roles, and success criteria.

## Step 2 — Execution
1. Researchers or builders execute scoped work as directed by the Parent.
2. The Parent assembles the individual components into a candidate output.

## Step 3 — Independent QA
1. A **Fresh QA agent** (using the `zero-context-qa` skill if available) reviews the output with no unnecessary prior context.
2. QA identifies defects, ambiguities, and risks based on the success criteria.

## Step 4 — Adjudication
1. The Parent reviews the QA report and decides whether to revise, escalate, or finalize the output.

---

# QA Output Schema
```json
{
  "passes": ["..."],
  "defects": ["..."],
  "severity": ["low|medium|high"],
  "missing_requirements": ["..."],
  "release_recommendation": "approve|revise|block",
  "confidence": 0.0
}
```

---

# Quality Bar
- QA must be truly independent (no knowledge of builder struggles or shortcuts).
- All severity "high" defects must be addressed or explicitly waived.
- The release recommendation must be justified by the defects listed.

---

# 🛡️ AUDIT HOOK
Every Parent-Orchestrator session MUST result in a QA report in `02_MACHINE/Reports/` and an audit log documenting the initial plan, the QA findings, and the Parent's final decision.

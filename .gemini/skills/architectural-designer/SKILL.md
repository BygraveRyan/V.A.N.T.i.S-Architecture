---
name: architectural-designer
description: Plans and governs multi-file system upgrades, refactors, and feature expansions. Activates before any feat/ or fix/ branch affecting Tier 1-2 system files.
---

# SKILL: Architectural Designer
Version: 1.0.2

Purpose
Standardize the planning, dependency mapping, and execution of complex, multi-file system upgrades, refactors, and feature expansions.

---

# When To Use
- **Trigger**: Intent to modify core system architecture, protocols, or multiple interconnected files.
- **Requirement**: MUST be activated before executing any `feat/` or `fix/` branch that affects Tier 1 or Tier 2 system files.

---

# Core Protocol

## Step 1 — Dependency Mapping
Before proposing changes, the agent MUST:
1. Map all affected core files (consult `CORE_SYSTEM_REGISTRY.md`).
2. Identify potential downstream impacts on agent behavior or knowledge flow.

## Step 2 — Architectural Upgrade Plan (Template)
The agent MUST create a formal plan (using Plan Mode or a task file) with the following structure:
1. **Background & Motivation**: The "Why".
2. **Scope & Impact**: Which files/systems are changing.
3. **Proposed Solution**: Technical implementation details.
4. **Implementation Steps**: Phased rollout (Phase 1, 2, 3...).
5. **Verification & Testing**: How we prove it works.
6. **Rollback Strategy**: How we revert if failure occurs.

---

# 🛡️ POST-PLAN SYNC HOOK (Mandatory)
Any plan generated using this skill (including those in `plan_mode` or temporary research) MUST be persisted into the correct canonical planning layer upon approval. This ensures:
1. Permanent auditability of structural decisions.
2. A human-readable record of the design-to-execution lineage.

Routing rule:
- V.A.N.T.i.S. system, architecture, protocol, agent-layer, parity, and upgrade work -> `03_SYSTEM/Roadmap/`
- Personal or human-centered work -> `01_HUMAN/...`

---

# Execution Protocol
1. **Approval**: Wait for explicit human "Go-Ahead" on the plan.
2. **Branching**: Execute only on a Rule 11 compliant branch (`feat/`, `fix/`, `skill/`).
3. **Finality**: Every phase MUST result in an ASV reflex and a Gold Standard Audit Log.

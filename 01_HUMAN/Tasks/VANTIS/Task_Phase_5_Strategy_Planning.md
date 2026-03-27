---
title: P5 — Phase 5 Strategy & Cognitive Orchestration
status: backlog
priority: high
agent: Opus (planning) → Sonnet (authoring)
branch: feat/phase5-strategy
created: 2026-03-27
version: 1.2.0
---

# P5 — Phase 5 Strategy & Cognitive Orchestration

## Strategic Motivation
Phase 4 focused on system-level performance, governance, and multi-agent parity. Phase 5 shifts from the "Machinery" to the "Cognition" — enabling deeper project-scoped reasoning, autonomous self-correction, and high-fidelity verification. Three focused phases replace five, with overlapping concerns merged to avoid redundant infrastructure.

---

## Core Objectives

### 🧠 1. Project-Scoped Coding Instincts (Self-Improving Agent)
- **Infrastructure**: Implement a persistent "Observation Engine" using deterministic hooks (`PreToolUse`/`PostToolUse`).
- **Workflow**:
    - Log interactions to `02_MACHINE/State/observations.jsonl`.
    - Background "Observer Agent" (Haiku/Flash) extracts atomic instincts (trigger/action pairs).
    - Confidence scoring (0.3 to 0.9) based on repetition and user confirmation.
- **Isolation**: Project-specific instincts (e.g., Car Shopping App vs. VANTIS internal) stored separately to prevent cross-project contamination.
- **Goal**: Reduce repetitive prompting by "learning" user preferences and project patterns over time.

### 🏛️ 2. Advanced Council Orchestration (Peer-Review Loop + Role Postures)
- **Infrastructure**: Create `03_SYSTEM/Protocols/Council_Orchestration_Protocol.md`.
- **Workflow**:
    - **Lead/Validator Pairing**: Assign a "Lead" agent and a "Validator" subagent for complex tasks.
    - **Architectural Gate**: Mandatory Architect review for any Tier 1–3 protocol changes.
    - **Security Gate**: Mandatory Guardian review for network or destructive operations.
    - **Dynamic Role Postures**: Inject role-specific "Postures" and "Decision Patterns" into the system prompt at session start via refined `aliases.sh` — token-efficient transitions without context bloat.
- **Consensus**: Major architectural decisions require a formal ADR and multi-role alignment before execution.

### 🛡️ 3. Guardian Quality Gate (Remediation + Cognitive Verification)
- **Infrastructure**: Enhance `diagnose`, implement a `verify` skill, and expand the Guardian subagent remit.
- **Remediation Workflow**:
    - Periodic audits detect protocol drift (metadata errors, missing logs, invalid paths).
    - Automated "Repair Plans" for batch fixes (e.g., regenerating symlinks, backfilling metadata).
    - Real-time shell command scanning for security violations via Guardian Enforcer.
- **Verification Workflow** (merged from original 5.5):
    - Multi-phase verification pipeline: Lint → Protocol → Security → PR Report.
    - Mandatory "Verification Report" generated for every PR — blocks merge on critical failures.
    - `diagnose --fix` for automated rollback of changes that fail critical verification phases.
- **Rationale for merge**: Remediation and Verification are both quality-gate concerns owned by the Guardian role. Separate infrastructure would duplicate audit logic with no meaningful boundary between them.

---

## ⏭️ Execution Phases (Priority Order)

### Phase 5.1 — The Observer (Instincts Engine)
- [x] Implement `v_observe.sh` hook for both Gemini and Claude (`PostToolUse`).
- [x] Configure `02_MACHINE/State/observations.jsonl` pipeline with project-scoped namespacing.
- [ ] **Note**: `observations.jsonl` will grow indefinitely; managing this (rotation/archiving) is a known v2 item.
- [ ] Author `instinct-cli` script for pattern review, confidence scoring, and promotion to memory.

### Phase 5.2 — The Council (Orchestration + Role Postures)
- [x] Author `Council_Orchestration_Protocol.md` with Lead/Validator pairing rules and gate triggers.
- [x] Update `AGENTS.md` with multi-role session workflows and escalation paths.
- [x] Refine `aliases.sh` to inject role-specific posture blocks at activation (token-efficient).
- [ ] **Note**: `activate_skill` for role-switching remains aspirational; current activation is via shell aliases or subagent calls.

### Phase 5.3 — The Guardian (Remediation + Verification)
- [x] Implement `verify` skill with multi-phase pipeline (Shellcheck → Protocol → Security → PR Report).
- [x] Enhance `diagnose` with `--fix` flag for automated repair plan execution.
- [ ] Wire Guardian Enforcer to `PreToolUse` for real-time destructive operation scanning.

---

## Design Constraints
- Each phase must be independently deployable — no cross-phase hard dependencies at implementation time.
- Observer data (`observations.jsonl`) must never be auto-promoted to instincts without explicit user confirmation.
- Verification Reports are advisory for Phase 5; mandatory merge gates are Phase 6 scope.

---
*V.A.N.T.i.S. Strategic Planning | 2026-03-27 | v1.2.0 | Revised by Claude (Execution Plane)*

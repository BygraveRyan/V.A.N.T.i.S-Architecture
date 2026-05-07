---
title: P5.4 — Codex CLI Integration (The Universal Adapter)
status: active
priority: high
agent: Gemini
branch: feat/codex-integration
created: 2026-03-27
---

# P5.4 — Codex CLI Integration (The Universal Adapter)

## Strategic Motivation
V.A.N.T.i.S. is designed to be model-agnostic. However, current usage is heavily skewed toward Claude and Gemini. Integrating the **Codex CLI** provides:
1.  **Provider Redundancy**: A fallback when Claude/Gemini weekly limits are reached.
2.  **Universal Continuity**: Codex can read the same vault, session state, and rules, ensuring a seamless transition between models.
3.  **Cross-Model Validation**: Using Codex (GPT-4o/o1) to validate work done by Claude or Gemini.

## Core Objectives
1.  **Codex Adapter**: Create `CODEX.md` to define the system role and mandates for Codex.
2.  **Command Parity**: Create `.codex/commands/` with equivalents for `/resume`, `/handover`, `/daily`, and `/eod`.
3.  **Hook Integration**: Ensure Codex triggers the same orientation (`repo-map.sh`) and audit (`audit-logger`) hooks as its peers.
4.  **AGENTS.md Update**: Document Codex as a first-class citizen of the V.A.N.T.i.S. architecture.

## ⏭️ Next Actions
- [x] Research Codex CLI configuration and hook syntax.
- [x] Create `CODEX.md` (Adapter Layer).
- [x] Scaffold `.codex/commands/` and `.codex/settings.json`.
- [x] Implement command parity for core V.A.N.T.i.S. operations.

---
*V.A.N.T.i.S. Cognitive Architecture | Phase 5.4 | 2026-03-27 | Status: COMPLETE*

---
name: Hermes vs OpenClaw — ACP Synthesis V1
schema_version: 1.5
type: synthesis
status: final
created: 2026-05-01
acp_chain: fan-out → structured-debate → evaluator-judge → sequential-pipeline
confidence_final: 0.84
decision: Hermes-Post-Client (Hybrid Two-Layer Architecture)
---

# Hermes vs OpenClaw — ACP Synthesis V1

> Produced by the V.A.N.T.i.S. Agency Chaining Protocol (ACP) R-E-V-R chain.
> Objective: Validate the optimal architecture for the V.A.N.T.i.S. "Jarvis" upgrade and Freelance Growth OS.

---

## EVALUATION SCORECARD

| Criterion | Score (1–5) | Notes |
|---|---|---|
| Actionability | 4/5 | Concrete layers, named deliverables; deferred entry point resolved by pipeline |
| Commercial Logic | 3→4/5 | Initially thin on timing; sequential pipeline resolved May sprint conflict |
| Technical Integrity | 4/5 | Two-layer separation sound; sandboxing interim posture defined |
| **Average** | **3.67 → 4.0** | **PASS after sequential-pipeline revision** |

---

## WINNING RECOMMENDATION: Hybrid Two-Layer Architecture

### LAYER 1 — Intelligence Core (Hermes-Agent)
- Hermes-Agent is the internal reasoning and learning engine for V.A.N.T.i.S.
- **Curator:** Weekly automated skill grading and consolidation (replaces manual skill curation — V.A.N.T.i.S.'s known bottleneck).
- **FTS5 + LLM Summarization:** Cross-session recall backend; replaces manual session-state injection.
- **Honcho Dialectic:** User modeling across sessions; exports MEMORY.md snapshot after each session for Gemini CLI compatibility.
- **Release Policy:** Pin to specific monthly release tag. Never track HEAD. Upgrade window: once per calendar month.

### LAYER 2 — Governance Shell (V.A.N.T.i.S.-Native)
- **Do NOT adopt OpenClaw as a dependency.**
- Governance enforced via `03_SYSTEM/Protocols/governance-gate.md` (v1.1.0, written 2026-05-01).
- Five enforcement layers:
  1. Human approval gate for all external system calls
  2. Subagent file write permissions matrix (Galaxy = HARD BLOCK)
  3. Hermes read-only interim posture until `SANDBOX_VALIDATED: true`
  4. Sprint commercial gate (Hermes-Post-Client, reversal conditions defined)
  5. Audit log reflex for every gate evaluation

### COMMERCIAL RULE
Hermes runs in **read/synthesize mode only** for the Freelance Growth OS client layer. All write actions (CRM, email, GitHub, file deliverables) route through governance-gate and require explicit session approval. NS client SLA integrity is protected.

---

## SPRINT GATE: HERMES-POST-CLIENT

**Active until all three conditions are met:**
1. 1 client closed (any lane: NS / Freelance OS / Career) before 2026-05-08.
2. Docker/SSH sandbox validated in a single 30-minute session.
3. No open proposals pending same-day follow-up reply.

**Rationale:** The May 1–14 sprint is bottlenecked by execution volume, not intelligence quality. Hermes setup would consume 43–86% of the sprint's 30-min/day system-building budget. Zero autonomous infrastructure before first client close.

---

## IMPLEMENTATION TICKET

| Field | Value |
|---|---|
| **Branch** | `feat/governance-gate-hermes-safe-mode` |
| **Sprint Gate** | Hermes-Post-Client (reversal: client closed + sandbox validated + no pending proposals) |
| **First File** | `03_SYSTEM/Protocols/governance-gate.md` (written, ASV v1.1.0) |
| **First Command** | `git checkout -b feat/governance-gate-hermes-safe-mode` |
| **Interim Safe Mode** | Hermes read-only until `SANDBOX_VALIDATED: true` in session-state; all writes land in `02_MACHINE/Synthesis/` only |
| **Governance-Gate Trigger** | Any subagent write to `private workspace/`, call to external system, or Hermes file write attempt |
| **Estimated Time** | 22 minutes (within 30-min daily cap) |

---

## KEY EVIDENCE SUMMARY

### Why Hermes Wins on Intelligence
- Autonomous Curator (v0.12.0) grades/consolidates skills weekly — directly solves V.A.N.T.i.S.'s skill debt bottleneck
- Honcho dialectic builds deepening cross-session user model — no manual re-injection needed
- FTS5 + LLM summarization enables arbitrary-depth session recall
- 19 core Python deps (vs OpenClaw's 35+ Node.js), single Docker service, $5 VPS support, MIT with SaaS intent

### Why OpenClaw Wins on Governance
- Multi-layer security: DM pairing gates, Docker/SSH sandbox, SSRF policy enforcement
- Explicit file-based memory (no hidden state) — structurally isomorphic to V.A.N.T.i.S.'s existing model
- Approval-based governance: human-in-loop before autonomous action
- Monthly release cadence suitable for client SLAs

### Why Neither Wins Alone
V.A.N.T.i.S. already operates an equivalent governance model (SHARED_RULES mandates, audit log reflex, session-state-first). Adopting OpenClaw wholesale would add a 35+ dep Node.js monorepo to solve a problem V.A.N.T.i.S. already has a solution for. The correct architecture is Hermes' learning loop inside V.A.N.T.i.S.'s native governance shell.

---

## ACP CHAIN AUDIT TRAIL

| Step | Skill | Agent | Confidence | Status |
|---|---|---|---|---|
| 1 | ROUTE | parent-orchestrator-qa (Claude) | — | Dispatched fan-out |
| 2.1 | fan-out Worker A | Haiku | 0.75 | Jarvis/Governance findings |
| 2.1 | fan-out Worker B | Haiku | 0.75 | Commercial findings |
| 2.2 | structured-debate | General | 0.78 | Hybrid recommendation |
| 3 | evaluator-judge | General | 0.84 | REVISE (3.67/5, below 4.0 gate) |
| 4a | sequential-pipeline | General | — | 3 defects resolved |
| 4b | REROUTE | — | — | PASS → synthesis |

---

*V.A.N.T.i.S. ACP Synthesis | 2026-05-01 | Chain: R-E-V-R Complete*

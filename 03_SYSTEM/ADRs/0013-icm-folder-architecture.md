---
id: ADR-0013
title: ICM Folder Architecture — Position-Addressed Room Structure
status: accepted
date: 2026-05-06
---

## Context
Agents were guessing routing destinations, causing misplaced files and token waste. V.A.N.T.i.S. needed a deterministic "where does this go?" answer at every folder boundary.

## Decision
Adopt ICM (Interpretable Context Methodology) — each major folder gets a `context.md` (Room) that scopes purpose, permissions, naming conventions, and linked skills. CLAUDE.md remains Layer 1 (Map).

## Consequences
- Agents read `context.md` before operating in a folder — no guesswork
- Human-legible, zero-infrastructure cost
- Naming conventions become enforceable (not just documented)
- **Update 2026-05-08**: Tier 1 Room Coverage (Human, Machine, System, Engines) is 100% complete and verified.
- Future: CONTENT_ENGINE and REVENUE_ENGINE get Room treatment in Phase 2

## Related
- ADR-0008 (Token Efficiency)
- ADR-0012 (Pattern-Based Inbox Routing)
- ICM source: `01_HUMAN/Inbox/ICM-Transitioning to the Interpretable Context Methodology.md`

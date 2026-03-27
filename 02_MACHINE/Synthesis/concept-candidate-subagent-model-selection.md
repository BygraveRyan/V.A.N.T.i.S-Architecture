---
id: subagent-model-selection
type: concept
status: ai-candidate

domain:
 - ai-orchestration
 - token-economics

related_domains:
 - cost-management
 - subagent-architecture

level: tactical

created: 2026-03-27
updated: 2026-03-27

review_interval: 90d
next_review: 2026-06-27

version: 1
schema_version: 1

source: ai-candidate
confidence: 0.8

related_concepts:
 - council-of-universals
 - context-budget
 - cognitive-orchestration

aliases:
 - model-routing
 - task-to-model-mapping

tags:
 - phase5
 - token-optimization
 - subagents
 - cost

embedding_version: v1
last_indexed:
---

# Subagent Model Selection Framework

## Core Mechanism
Route tasks to the cheapest model that is sufficient for the job. The default is Sonnet; upgrade to Opus only when complexity demands it; delegate simple search and edits to Haiku.

## Task-to-Model Routing Table

| Task Type | Model | Rationale |
|-----------|-------|-----------|
| Exploration / search | Haiku | Fast, cheap, sufficient for locating files |
| Simple single-file edits | Haiku | Clear instructions, low reasoning demand |
| Multi-file implementation | Sonnet | Best balance of capability and cost |
| Complex architecture | Opus | Deep reasoning required |
| PR reviews | Sonnet | Context-aware, catches nuance |
| Security analysis | Opus | Cannot afford missed vulnerabilities |
| Writing docs | Haiku | Structure is simple and predictable |
| Debugging complex bugs | Opus | Must hold entire system in context |

## Upgrade Triggers (Sonnet → Opus)
- First attempt failed
- Task spans 5+ files
- Architectural decision involved
- Security-critical code

## Why This Matters for V.A.N.T.i.S.
The Council subagents (Architect, Guardian, Researcher, Strategist) currently have no explicit model assignments. Applying this framework would:
- Assign Haiku to Researcher for vault scans and file location
- Assign Sonnet to Strategist for LinkedIn drafts and synthesis
- Assign Opus to Architect for Tier 1–3 protocol changes
- Assign Opus to Guardian for security gate reviews

This directly feeds Phase 5.1 Observer design (confidence-weighted instinct promotion) and Phase 5.2 Council Orchestration (Lead/Validator pairing).

## Source
ECC Longform Guide — `01_HUMAN/Knowledge/Resources/Sources/the-longform-guide.md`

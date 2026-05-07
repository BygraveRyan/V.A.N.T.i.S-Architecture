---
type: roadmap
topic: vantis-internal-architecture-design-second-pass
date: 2026-05-02
status: superseded
superseded_by: vantis-internal-architecture-design_2026-05-02.md
depends_on:
  - perplexity-memory-research.md
  - vantis-internal-architecture-design_2026-05-02.md
  - jarvis-upgrade-v2_karpathy-superskills-synthesis_2026-05-02.md
  - Technical Standard-Enterprise Integration of Karpathy’s AI Coding Principles.md
  - Architecture Specification- Engineering High-Value 'Super Skills' for Self-Improving AI Agents.md
---

# V.A.N.T.i.S. Internal Architecture Design
## Second Pass: Memory Backend, Missing Components, and Refined System Shape

This document has been merged into `vantis-internal-architecture-design_2026-05-02.md`.

Use this file as change history, not as the canonical architecture spec.

## 1. What Changed From First Pass

The first pass got the overall shape right:
- Hermes stays locked as the intelligence core
- V.A.N.T.i.S. governance stays as the outer control shell
- the runtime should be split into control, execution, memory, and refinement planes

The main thing that needed tightening was the memory decision.

The first pass treated Bucket 2 largely as:
- Pinecone now or later,
- or a generic retrieval layer.

That is too coarse.

The correct second-pass view is:
- **memory is not one subsystem**
- different memory types need different storage behavior
- the system should not force strategy state, session recall, and foundational retrieval into the same backend model

---

## 2. Revised Memory Architecture Principle

Do not ask:
- "Which one database should power memory?"

Ask:
- "Which combination of state store, retrieval engine, and local cache best serves the three buckets?"

### Revised rule

The memory plane should be split into four concerns:

1. **System of Record**
   - canonical storage for structured state, logs, memory metadata, and governance-linked records
2. **Retrieval Engine**
   - optimized search over foundational knowledge and selected memory artifacts
3. **Local Recall Cache**
   - fast local/offline recall for recent sessions and lexical search
4. **Strategy State**
   - explicit structured and versioned live operating posture, not free-floating chunks

This is the biggest improvement from the Perplexity research.

---

## 3. Revised Recommendation

### V1 Recommendation

Use:
- **Postgres + pgvector** as the canonical backend
- **SQLite + FTS5** as a local session/cache layer

Do **not** make Pinecone the default V1 commitment.

### Why

For V1, the system needs:
- one place to store structured state,
- strong metadata filtering,
- transaction-safe updates,
- retrieval telemetry,
- and a clean path to governance, audit, and refinement analytics.

Postgres fits that better than Pinecone for a personal AI operating system.

SQLite + FTS5 then gives you:
- very fast local recall,
- low-overhead lexical search,
- offline-friendly recent-session memory,
- and a compact local appliance for Bucket 1 style recall.

### Long-Term Recommendation

If retrieval becomes heavy enough to deserve its own service:
- keep **Postgres** as system-of-record
- add **Qdrant** as a dedicated retrieval engine

This is stronger than committing early to Pinecone because it preserves control and reduces lock-in while the architecture is still evolving.

---

## 4. Updated View of the Three Buckets

### Bucket 1: Session Memory

Best fit:
- SQLite + FTS5 locally
- mirrored or summarized into Postgres

Why:
- append-heavy
- lexical lookup matters
- speed matters more than large-scale vector semantics
- local/offline access is useful

This bucket should store:
- session wrap-ups
- task outcomes
- decisions made
- unresolved blockers
- recent approvals and denials

### Bucket 2: Foundational Knowledge

Best fit:
- Postgres + pgvector at V1
- optionally Qdrant later if retrieval complexity grows

Why:
- needs embeddings plus metadata
- needs chunk-level search
- needs selective retrieval
- needs evaluation telemetry

This bucket should store:
- standards
- architecture docs
- stable project knowledge
- curated source notes
- validated precedents

### Bucket 3: Strategic Profile

Best fit:
- structured state in Postgres
- optional small markdown projection for human-readable session start

Why:
- this is not a normal retrieval corpus
- it changes over time
- it needs versioning, provenance, confidence, and revocation

This is the most important correction from second pass:

**Bucket 3 should not primarily live as vectorized text chunks.**

It should be explicit state such as:
- active objective
- constraints
- gates
- current architecture commitments
- preferred decision heuristics
- current experiments

---

## 5. Pinecone Repositioned

Pinecone is still valid, but it is no longer the default recommendation.

### Pinecone is strongest when:
- you want the fastest managed cloud path
- you expect the retrieval layer to become product-like quickly
- you value low ops overhead more than local control

### Pinecone is weaker when:
- the system is still personal and evolving
- governance and structured memory mutation matter more than pure retrieval convenience
- local-first and lock-in concerns matter

### Updated judgment

Pinecone is:
- a good option
- not a wrong option
- but probably **not the best first option** for this V.A.N.T.i.S. design

---

## 6. New Architecture Components Missing From First Pass

The Perplexity research surfaced several missing components that should now be made explicit.

### A. Retrieval Telemetry Layer

The system needs to log:
- what bucket was queried
- what filters were applied
- what was retrieved
- what entered the prompt
- whether the retrieval helped

Without this, the self-improvement loop cannot improve memory quality.

### B. Memory Write Policy

The system needs explicit rules for:
- what gets stored
- what gets summarized
- what expires
- what is immutable
- what can be revised
- what is observation vs inference vs policy

Without this, memory quality degrades quickly.

### C. Memory Typing

Memory entries should be typed, for example:
- `observation`
- `decision`
- `constraint`
- `preference`
- `strategy`
- `artifact`
- `evaluation`

This is necessary for good filtering and for preventing strategy drift.

### D. Strategy Versioning

Bucket 3 must support:
- version history
- confidence level
- source/provenance
- superseded state
- explicit revocation

Otherwise stale strategy beliefs will quietly linger.

### E. Retrieval Compression Layer

The system should not always pass raw chunks forward.

It needs the option to:
- retrieve
- compress
- structure
- then inject only the minimal useful slice

This is one of the main levers for token efficiency.

---

## 7. Refined Target-State Topology

```text
                         [ YOU ]
                           |
          Telegram / Discord / Web Console / Mobile Actions
                           |
                     CONTROL PLANE
       commands | approvals | status | resume | interrupt
                           |
                 HERMES INTELLIGENCE CORE
      planner | executor | verifier | critic | refiner
                           |
    ----------------------------------------------------------------
    |                      |                    |                    |
EXECUTION PLANE      STATE PLANE           RETRIEVAL PLANE      LOCAL RECALL
tools, runners,      Postgres              pgvector now         SQLite + FTS5
jobs, browser,       strategy_state        Qdrant later         session cache
mobile actuators     memory metadata       foundational docs    lexical search
                     retrieval logs        hybrid search        offline recall
                           |
                 GOVERNANCE SHELL (V.A.N.T.i.S.)
         approvals | audit | write policy | protected zones
```

### Key change from first pass

The memory plane is no longer one box.

It is now:
- state plane
- retrieval plane
- local recall plane

That is a more accurate design.

---

## 8. Refined Role of the Super Skill Loop

The refinement loop should not only patch skill prompts.

It should eventually refine:
- retrieval filters
- chunking policy
- memory typing rules
- prompt compaction behavior
- approval request templates

### Concrete implication

A skill can fail because:
- the prompt was weak,
- the retrieved memory was noisy,
- the wrong bucket was queried,
- the strategy state was stale,
- or the verification rule was weak.

The refinement loop therefore needs a broader defect model than "rewrite the skill file."

### Suggested defect taxonomy

- `instruction_defect`
- `retrieval_defect`
- `memory_hygiene_defect`
- `verification_defect`
- `tool_selection_defect`
- `strategy_state_defect`

This should be built into the evaluation pipeline from the start.

---

## 9. Refined Build Order

### Phase 1
- control plane
- job queue
- planner/executor/verifier loop
- workstation execution substrate

### Phase 2
- Postgres schema for strategy state, memory metadata, source artifacts, retrieval logs
- SQLite + FTS5 local session recall
- first retrieval policy over foundational docs

### Phase 3
- pgvector integration for Bucket 2
- retrieval telemetry
- chunking and compression policy

### Phase 4
- refinement loop for one skill
- defect taxonomy
- evaluation-driven skill patching

### Phase 5
- optional Qdrant promotion if retrieval grows beyond what Postgres should comfortably handle
- phone actuation hardening
- long-running 24/7 operating posture

This order is better than going straight to Pinecone because it gets the information model and telemetry right first.

---

## 10. Updated Architecture Verdict

### Locked
- Hermes as intelligence core
- V.A.N.T.i.S. governance shell
- planner/executor/verifier pattern
- three-bucket memory model
- Karpathy cognitive protocol
- Super Skill refinement loop

### Revised
- Pinecone is no longer the assumed memory backend
- Bucket 3 should be structured state, not mostly vector memory
- memory must be split into state, retrieval, and local recall concerns

### Added
- retrieval telemetry
- memory write policy
- memory typing
- strategy versioning
- retrieval compression
- broader refinement defect taxonomy

---

## 11. Final Second-Pass Recommendation

If you were making the backend decision today, the strongest architecture would be:

### V1
- **Postgres + pgvector**
- **SQLite + FTS5**

### Later if needed
- **Qdrant** for dedicated high-quality retrieval

### Not ruled out
- **Pinecone**, if you later decide you want the fastest managed hosted retrieval layer and are comfortable with that tradeoff

This is the cleanest version of the architecture so far because it stops treating memory as one vague vector database decision and instead designs memory as an operating system.

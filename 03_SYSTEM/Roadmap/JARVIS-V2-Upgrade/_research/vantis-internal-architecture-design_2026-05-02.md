---
type: synthesis
topic: vantis-internal-architecture-design
date: 2026-05-02
tags: [architecture, jarvis, hermes, mobile-agent, memory-os, super-skills, karpathy, pgvector, sqlite, qdrant]
status: current
depends_on:
  - codex-handoff-briefing_2026-05-02.md
  - jarvis-upgrade-v2_karpathy-superskills-synthesis_2026-05-02.md
  - Technical Standard-Enterprise Integration of Karpathy’s AI Coding Principles.md
  - Architecture Specification- Engineering High-Value 'Super Skills' for Self-Improving AI Agents.md
  - perplexity-memory-research.md
  - 03_SYSTEM/Protocols/governance-gate.md
---

# V.A.N.T.i.S. INTERNAL ARCHITECTURE DESIGN
## Canonical JARVIS V2 Architecture for Autonomous Execution, Memory Efficiency, and Self-Improvement

**Date:** 2026-05-02  
**Purpose:** Define the internal architecture for a personal V.A.N.T.i.S. system that can:
1. accept goals from phone and execute them in the background,
2. reduce context waste through a disciplined memory operating system,
3. improve its own skills and execution quality over time,
4. stay governable while becoming more autonomous.

---

## 1. Executive Verdict

The correct architecture is still a **hybrid two-layer system**:

- **Layer 1: Hermes Intelligence Core**
  - plans, reasons, retrieves memory, delegates work, verifies outcomes, and refines skills.
- **Layer 2: V.A.N.T.i.S. Governance Shell**
  - controls approvals, audit logs, state persistence, write boundaries, and protected zones.

The key refinement is that Layer 1 must not be treated as one vague agent. It should be implemented as a compound runtime with four internal planes:

1. **Control Plane**
   - phone and chat interface for starting, monitoring, approving, interrupting, and resuming jobs
2. **Execution Plane**
   - workstation/server agents and tool runners that perform the actual work
3. **Memory Plane**
   - state storage, retrieval, local recall, and strategy state
4. **Refinement Plane**
   - skill grading, defect classification, and self-improvement loops

This is the shortest path to the real target outcome:

**"I can message V.A.N.T.i.S. from my phone, it can work for 1-2 hours without supervision, and it comes back with completed results, logs, and a better operating system than it had last week."**

---

## 2. Design Constraints That Actually Matter

For this architecture pass, ignore weekend or sprint pacing constraints. The design should optimize for the target-state system.

The constraints that still matter are structural:

- **Autonomy must be real, not performative.**
  The system must execute multi-step work while you are away, not just produce plans.
- **Phone control is mandatory.**
  The command surface cannot assume you are at the workstation.
- **Context efficiency is mandatory.**
  The system cannot depend on repeatedly re-reading large session-state or vault-wide files.
- **Self-improvement must change behavior, not just produce reflections.**
  A refinement loop that never changes prompts, skill files, retrieval policy, or tool routing is not a refinement loop.
- **Governance cannot be removed.**
  Any personal JARVIS powerful enough to act broadly must still be bounded by explicit approvals, logs, and protected zones.

---

## 3. Source Pattern Synthesis

### 3.1 What the reference repositories contribute

#### Remote control and background execution
- **SafeRL-Lab/cheetahclaws**
  - small, inspectable agent loop
  - proactive agent mode, remote bridge, persistent job execution
- **Ramsbaby/jarvis**
  - message-app-as-ops-console
  - long-running background assistance, command handling, service behavior

#### Phone-side actuation
- **agents-io/PokeClaw**
  - on-device phone action harness
  - generic mobile tools: tap, swipe, text input, open app, notifications
- **minitap-ai/mobile-use**
  - reliable task completion on phones
  - planner/executor/verifier decomposition and verified mobile execution

#### Long-term memory and second-brain grounding
- **isair/jarvis**
  - always-on local assistant behavior
  - persistent memory, privacy-first posture, tool modularity
- **your-papa/obsidian-Smart2Brain**
  - note-aware assistant behavior inside a vault
- **flepied/second-brain-agent**
  - agent-over-knowledge-base structure
- **Hirofumi-I/second-brain-joiner**
  - vault compaction and AI-optimized context preparation

#### Feature-surface inspiration, not primary architecture
- **Arnav3241/Jarvis-v13**
- **GauravSingh9356/J.A.R.V.I.S**

These help with assistant surface area and command ideas, but they should not define the core runtime.

### 3.2 What the Karpathy and Super Skills documents contribute

#### Karpathy document contributes the cognitive protocol
- Think Before Coding
- Simplicity First
- Surgical Changes
- Goal-Driven Execution

These are not style preferences. They are the operating standard for how Hermes reasons.

#### Super Skills document contributes the compounding mechanism
- skill creation discipline
- external connectors
- persistent memory
- refinement loop

These are the mechanism that turns a useful assistant into a system that gets better over time.

---

## 4. Core Architecture Decision

Do **not** replace the hybrid two-layer decision.

The correct move is:
- keep **V.A.N.T.i.S. Governance Shell** as the outer control boundary,
- build **Hermes Intelligence Core** as the inner autonomous runtime,
- add a **mobile actuator subsystem** and **messaging control surface** as internal Layer 1 components,
- treat the **memory operating system** and **skill refinement loop** as internal Layer 1 services.

This preserves the strongest earlier decision:
- governance remains stable and native,
- intelligence remains evolvable,
- memory and execution can improve without rewriting the operating constitution.

---

## 5. Target-State Topology

```text
                         [ YOU ]
                           |
      Telegram / Web Console / Mobile Actions
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

### Key topology principle

The system should **not** be built as one monolithic agent.

It should be built as:
- one orchestrator,
- several specialized worker roles,
- one memory operating system,
- one refinement loop,
- one governance boundary.

That is how you get long-running execution without turning the whole thing into an opaque black box.

---

## 6. Control Plane: How You Command It From Your Phone

The control plane exists to satisfy the autonomy goal.

### Required capabilities

- start a job
- approve or deny actions
- ask for current status
- interrupt or pause a running job
- resume a paused job
- receive final artifact links and summaries

### Recommended interface shape

- **Primary**: Telegram bot interface
- **Secondary**: lightweight web console for long-form status, logs, and artifacts
- **Later optional expansion**: Discord, only if shared multi-user or channel-based workflows become necessary

### Why

- `cheetahclaws` validates the remote chat bridge pattern
- `Ramsbaby/jarvis` validates the persistent assistant-through-chat pattern
- phone-native control is much easier through messaging first than through a custom app
- Telegram is the cleanest fit for a private command and approval surface

### Command classes

#### Intent commands
- `run`
- `research`
- `design`
- `fix`
- `summarize`
- `audit`

#### Runtime commands
- `status`
- `pause`
- `resume`
- `abort`
- `show-plan`

#### Governance commands
- `approve`
- `deny`
- `why`

#### Memory commands
- `recall`
- `strategy`
- `what-did-you-learn`

### Control-plane principle

The phone interface should be a **thin command and approval surface**, not the place where the intelligence lives.

The phone tells the system what to do.  
The workstation/server does the reasoning and execution.

### Locked decision

**V1 control plane: Telegram**

Rationale:
- best fit for a personal, private JARVIS command surface
- simpler than Discord for direct command, approval, and status loops
- no current need for channel-heavy or multi-user collaboration features

---

## 7. Execution Plane: How It Actually Gets Work Done

This plane handles the real work.

### Runtime roles

- **Orchestrator**
  - receives a goal
  - converts it into a declarative success target
  - builds a plan
  - selects tools and workers

- **Planner**
  - decomposes the job
  - defines checkpoints
  - decides when verification is needed

- **Executor**
  - performs code, file, browser, shell, API, and workflow actions

- **Verifier**
  - checks if the output actually meets the goal
  - runs tests, spot checks, artifact validation, and output-shape checks

- **Critic**
  - challenges over-engineering, drift, and ambiguous assumptions

- **Scheduler**
  - manages asynchronous jobs, retries, pauses, and resumed sessions

### Core decomposition pattern

Use the `mobile-use` pattern conceptually:
- planner
- executor
- verifier

This is the correct pattern for long-running background tasks because it separates:
- deciding what to do,
- doing it,
- checking whether it worked.

### Workstation/server substrate

The execution substrate should support:
- shell commands
- git operations
- browser automation
- file edits
- document generation
- retrieval jobs
- queued retries

The `cheetahclaws` pattern is the closest reference for a compact, production-practical loop that can coordinate this behavior without excessive framework overhead.

### Phone actuation subsystem

This is a specialized tool domain, not the main runtime.

Use a PokeClaw-like capability set:
- open app
- tap
- swipe
- enter text
- read screen
- handle notifications
- send reply

The phone is where lightweight interaction happens.  
The workstation/server is where planning, retrieval, and long-running work happen.

---

## 8. Memory Operating System

This is the most important token-efficiency decision in the system.

### The first-pass correction

Do **not** ask:
- "Which one database should power memory?"

Ask:
- "Which combination of state store, retrieval engine, and local cache best serves the memory system?"

### Memory is four concerns, not one box

1. **System of Record**
   - canonical storage for structured state, logs, memory metadata, and governance-linked records
2. **Retrieval Engine**
   - optimized search over foundational knowledge and selected memory artifacts
3. **Local Recall Cache**
   - fast local/offline recall for recent sessions and lexical search
4. **Strategy State**
   - explicit structured and versioned live operating posture, not free-floating chunks

### V1 recommendation

Use:
- **Postgres + pgvector** as the canonical backend
- **SQLite + FTS5** as the local session/cache layer

Do **not** make Pinecone the default V1 commitment.

### Long-term recommendation

If retrieval becomes heavy enough to deserve its own service:
- keep **Postgres** as system-of-record
- add **Qdrant** as a dedicated retrieval engine

### Pinecone repositioned

Pinecone is:
- a good option
- not a wrong option
- but probably **not the best first option** for this V.A.N.T.i.S. design

It becomes more attractive when:
- you want the fastest managed cloud path
- you expect retrieval to become product-like quickly
- you value low ops overhead more than local control

---

## 9. The Three Buckets

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

**Bucket 3 should not primarily live as vectorized text chunks.**

It should be explicit state such as:
- active objective
- constraints
- gates
- current architecture commitments
- preferred decision heuristics
- current experiments

---

## 10. Retrieval Policy and Missing Components

The Perplexity research surfaced several missing components that should be explicit.

### Retrieval telemetry layer

The system needs to log:
- what bucket was queried
- what filters were applied
- what was retrieved
- what entered the prompt
- whether the retrieval helped

Without this, the self-improvement loop cannot improve memory quality.

### Memory write policy

The system needs explicit rules for:
- what gets stored
- what gets summarized
- what expires
- what is immutable
- what can be revised
- what is observation vs inference vs policy

Without this, memory quality degrades quickly.

### Memory typing

Memory entries should be typed, for example:
- `observation`
- `decision`
- `constraint`
- `preference`
- `strategy`
- `artifact`
- `evaluation`

This is necessary for good filtering and for preventing strategy drift.

### Strategy versioning

Bucket 3 must support:
- version history
- confidence level
- source/provenance
- superseded state
- explicit revocation

Otherwise stale strategy beliefs will quietly linger.

### Retrieval compression layer

The system should not always pass raw chunks forward.

It needs the option to:
- retrieve
- compress
- structure
- then inject only the minimal useful slice

This is one of the main levers for token efficiency.

---

## 11. Karpathy Auto-Research Methodology

The Karpathy standard should not sit in the repo as static doctrine. It should shape execution.

### Required reasoning loop

Before action, Hermes must:
1. restate the goal as a verifiable outcome
2. surface assumptions
3. identify tradeoffs
4. choose the simplest path
5. define how it will verify success

### Auto-research mode

When Hermes lacks enough confidence to act, it should enter a bounded research loop:

1. identify the uncertainty
2. retrieve the minimum references needed
3. extract only the decision-relevant facts
4. restate the plan
5. execute

This creates a "think before acting" runtime behavior rather than a generic preamble.

Better reasoning means:
- fewer wasted loops
- fewer broad retrievals
- fewer dead-end implementations

---

## 12. Refinement Plane: The Super Skill Loop

This is the compounding engine.

### Definition

A Super Skill is not just a markdown instruction file.

It is a skill with:
- defined scope
- live tools
- persistent memory access
- explicit quality criteria
- a mechanism to improve its own source after execution

### Required loop

```text
Execute
-> Grade output against goal and rubric
-> Identify deficiency
-> Propose change to skill or routing
-> Apply narrow patch
-> Verify improved behavior on next run
```

### What the loop can refine

#### Skill source
- wording
- step order
- stop conditions
- verification instructions
- tool selection policy

#### Memory behavior
- retrieval query templates
- bucket selection logic
- context compaction rules

#### Orchestration behavior
- when to ask clarifying questions
- when to delegate
- when to verify
- when to stop

### Broader defect taxonomy

A skill can fail because:
- the prompt was weak,
- the retrieved memory was noisy,
- the wrong bucket was queried,
- the strategy state was stale,
- the verification rule was weak,
- or the wrong tool was chosen.

The evaluation pipeline should classify defects such as:
- `instruction_defect`
- `retrieval_defect`
- `memory_hygiene_defect`
- `verification_defect`
- `tool_selection_defect`
- `strategy_state_defect`

### What must not happen

The system must not blindly rewrite its core prompts after every session.

Refinement should be:
- localized
- evidence-based
- reversible
- verified

That is where the Karpathy principles matter again:
- refinement must be simple,
- surgical,
- and goal-driven.

---

## 13. Week-by-Week Transformation Narrative

### Week 1
- system completes tasks, but needs frequent clarification
- memory retrieval is broad
- skill outputs vary in quality

### Week 2
- skill prompts are tighter
- fewer unnecessary tool calls
- session wrap-ups become more useful
- approval requests become more precise

### Week 3
- recurring tasks follow stable patterns
- memory retrieval narrows automatically
- the system asks fewer but better clarification questions
- background runs complete with fewer retries

### Week 4+
- the system becomes measurably faster and cheaper
- not because the model got smarter,
- but because the runtime, memory policy, and skills got sharper

That is the actual compounding story.

---

## 14. Governance and Safety Model

The governance shell should remain external to Hermes.

### Why

Self-improving systems should not self-authorize.

The same system that wants to act is not the right system to decide whether action is allowed.

### Governance responsibilities

- protect `01_HUMAN/Knowledge/Galaxy`
- control external system writes
- require approvals for sensitive actions
- log decisions and actions
- preserve session state and handoff integrity

### Architectural rule

Hermes proposes.  
V.A.N.T.i.S. governs.  
Only then does execution proceed.

---

## 15. Recommended Implementation Blueprint

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

## 16. Concrete Technology Shape

### Control Plane
- Telegram bot
- optional lightweight web dashboard

### Execution Plane
- long-running server/workstation runtime
- queue-backed jobs
- shell, git, browser, file, and document tools

### State Plane
- Postgres for structured strategy state, memory metadata, governance-linked records, and telemetry

### Retrieval Plane
- pgvector for V1 foundational retrieval
- Qdrant later if retrieval deserves its own dedicated service

### Local Recall Plane
- SQLite + FTS5 for fast local session recall and offline cache

### Refinement Plane
- skill registry
- rubric store
- patch and rollback mechanism
- evaluation logs

### Governance Plane
- approval gate
- audit log
- path restrictions
- state persistence

---

## 17. Sharp Recommendations

1. **Do not build this as a phone-native intelligence system.**
   Use phone as control surface and actuator, not as the primary reasoning environment.

2. **Do not rely on one giant session-state file.**
   Split strategy, session deltas, foundation retrieval, and local recall cleanly.

3. **Do not start with full self-modification.**
   Start with one skill and one verified refinement loop.

4. **Do not let governance collapse into convenience.**
   The more autonomous the system gets, the more valuable the boundary becomes.

5. **Do not over-framework the agent core.**
   The `cheetahclaws` lesson is right: a small, inspectable loop beats a giant abstracted agent stack.

6. **Use mobile-use ideas for decomposition, not necessarily its full stack.**
   The lasting lesson is planner/executor/verifier, not LangGraph specifically.

7. **Treat the Karpathy protocol as executable policy.**
   It should change runtime behavior, not just document style.

8. **Treat memory as an operating system, not as a vector database decision.**
   This is the most important architectural correction in the second pass.

9. **Lock Telegram for V1 unless a real collaboration need appears.**
   Do not add Discord complexity before the core execution loop is working.

---

## 18. Final Architecture Statement

The system you want is not "an AI assistant with some memory."

It is:
- a **remote-commandable execution system**,
- with a **small but disciplined reasoning core**,
- grounded by a **memory operating system**,
- improved by a **skill refinement loop**,
- and contained by a **governance shell**.

The shortest correct interpretation of the final design is:

**CheetahClaws-style loop for orchestration.**  
**Mobile-use decomposition for reliable execution.**  
**PokeClaw-style phone tools for mobile actuation.**  
**Telegram as the V1 remote command surface.**  
**Postgres + pgvector as canonical V1 memory backend.**  
**SQLite + FTS5 for local session recall.**  
**Qdrant later if retrieval becomes a dedicated service.**  
**Karpathy protocol for disciplined reasoning.**  
**Super Skills for compounding improvement.**  
**V.A.N.T.i.S. governance for safety and control.**

If built in that order, the system will not just be impressive. It will be operational.

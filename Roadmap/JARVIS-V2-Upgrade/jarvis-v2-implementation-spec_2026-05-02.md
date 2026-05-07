---
type: specification
topic: jarvis-v2-implementation-spec
date: 2026-05-02
status: draft-v1
depends_on:
  - 03_SYSTEM/Roadmap/JARVIS-V2-Upgrade/README.md
  - 03_SYSTEM/Roadmap/JARVIS-V2-Upgrade/vantis-internal-architecture-design_2026-05-02.md
---

# JARVIS V2 Implementation Spec
## V1 Execution Contract for Hermes Inside V.A.N.T.i.S.

**Date:** 2026-05-02
**Scope:** This document converts the 2026-05-02 JARVIS V2 architecture into an implementation-level V1 spec.
**Constraint:** This spec does not reopen the architecture decision unless a real contradiction is found during implementation. No contradiction was found in this pass.

---

## 1. V1 Objective

JARVIS V2 V1 is a remote-commandable execution system that can:

1. accept a user command from a phone-first control surface,
2. create and run a bounded multi-step job in the background,
3. retrieve only the minimum memory needed to execute well,
4. pause for approval when governance rules require it,
5. return a result, trace, and artifact set,
6. write back only governed memory outputs,
7. evaluate one execution path and propose narrow refinements.

V1 is successful if the system can complete real 1-2 hour workstation tasks through Telegram-mediated control while remaining governable and auditable.

---

## 2. Core Services

### 2.1 Control Plane Services

- **Telegram Command Gateway**
  - receives user commands
  - normalizes them into structured job requests
  - sends approval prompts, status updates, and final summaries

- **Web Status Console**
  - read-only or lightly interactive status surface
  - exposes job state, step trace, approvals, artifacts, and logs
  - optional in V1 deployment, but included in service design

### 2.2 Execution Plane Services

- **Job Orchestrator**
  - creates jobs
  - owns lifecycle transitions
  - coordinates planner, executor, verifier, and scheduler

- **Planner Service**
  - converts a goal into checkpoints, success criteria, assumptions, and tool intents
  - applies the Karpathy reasoning loop before execution

- **Executor Service**
  - performs shell, git, file, browser, document, API, and mobile-actuation actions

- **Verifier Service**
  - checks outputs against declared success criteria
  - records pass/fail evidence

- **Scheduler Service**
  - runs queued asynchronous work
  - manages retries, pauses, timeouts, and resume points

### 2.3 Memory Plane Services

- **Memory Write Gateway**
  - enforces memory typing and write policy
  - prevents raw execution noise from being written as durable memory

- **Retrieval Service**
  - selects the correct memory bucket
  - performs hybrid retrieval against foundational and local recall stores
  - logs retrieval telemetry

- **Strategy State Service**
  - reads and writes explicit operating posture state
  - enforces versioning, provenance, and supersession rules

- **Local Recall Cache**
  - provides fast lexical recall for recent sessions and resumptions

### 2.4 Refinement Plane Services

- **Evaluation Service**
  - grades job outcomes, retrieval usefulness, and verification quality

- **Defect Classifier**
  - maps failures into defect classes

- **Refinement Proposer**
  - proposes narrow changes to skill wording, routing, retrieval policy, or verification policy

### 2.5 Governance Shell Services

- **Approval Gate**
  - blocks sensitive operations until explicit approval is received

- **Audit Logger**
  - records high-fidelity action and decision logs

- **Boundary Enforcer**
  - applies protected-zone rules and path restrictions

---

## 3. System Boundaries

### 3.1 Inside Hermes Intelligence Core

Hermes owns:

- planning
- execution orchestration
- retrieval requests
- verification
- evaluation
- refinement proposals

### 3.2 Inside V.A.N.T.i.S. Governance Shell

V.A.N.T.i.S. owns:

- approval decisions
- write permissions
- protected-zone enforcement
- audit obligations
- session and handoff persistence rules

### 3.3 Boundary Rule

Hermes may propose actions, plans, memory writes, and refinements.
V.A.N.T.i.S. must authorize any action that crosses a governed boundary.

### 3.4 Protected V1 Boundaries

V1 must treat these as governed boundaries:

- writes to protected vault zones
- external side effects
- destructive file or git actions
- persistent strategy-state changes
- refinement patches to skills, prompts, or routing logic

---

## 4. Source-of-Truth Ownership

### 4.1 Primary Ownership Model

- **Job state source of truth:** Postgres
- **Approval state source of truth:** Postgres
- **Strategy state source of truth:** Postgres
- **Memory metadata source of truth:** Postgres
- **Foundational retrieval source of truth:** Postgres with pgvector-backed retrieval records
- **Local session recall source of truth:** SQLite + FTS5
- **Audit log source of truth:** vault log files plus linked Postgres record metadata
- **Artifact files source of truth:** filesystem paths referenced from Postgres

### 4.2 Bucket Ownership

- **Bucket 1: Session Memory**
  - operational source: SQLite
  - durable summary mirror: Postgres

- **Bucket 2: Foundational Knowledge**
  - source: Postgres
  - retrieval index: pgvector in Postgres

- **Bucket 3: Strategic Profile**
  - source: structured Postgres tables only
  - optional markdown projection is read convenience, not canonical state

### 4.3 Non-Canonical Stores

These are not allowed to become source of truth in V1:

- transient prompts
- raw LLM outputs
- queue payload copies
- Telegram message history
- vector chunks for strategic profile state

---

## 5. Synchronous vs Asynchronous Flows

### 5.1 Synchronous Flows

These must complete inline with immediate user feedback:

- command receipt and validation
- initial job creation
- first-pass planning
- approval request emission
- approval or denial acknowledgement
- status lookup
- pause, resume, and abort commands
- final result notification

### 5.2 Asynchronous Flows

These run as background jobs:

- multi-step execution
- scheduled retries
- long-running browser or shell work
- retrieval indexing
- session-memory summarization
- evaluation runs
- refinement proposal generation

### 5.3 Mixed Flows

Some flows begin synchronously and continue asynchronously:

1. user sends command
2. system validates and creates job synchronously
3. planner generates a bounded plan synchronously
4. job enters async execution
5. system re-enters synchronous mode when approval or final reporting is needed

---

## 6. Schemas and Tables

V1 uses Postgres as the canonical structured backend and SQLite for local recall.

### 6.1 Postgres Tables

#### `jobs`
- `job_id` UUID primary key
- `created_at_utc` timestamptz
- `updated_at_utc` timestamptz
- `requested_by` text
- `origin_channel` text
- `intent_type` text
- `goal_text` text
- `success_definition` text
- `status` text
- `priority` integer
- `requires_approval` boolean
- `current_step_id` UUID nullable
- `resume_token` text nullable
- `final_summary` text nullable
- `failure_reason` text nullable

#### `job_steps`
- `step_id` UUID primary key
- `job_id` UUID foreign key
- `step_order` integer
- `step_type` text
- `step_description` text
- `status` text
- `tool_scope` jsonb
- `verification_rule` text nullable
- `started_at_utc` timestamptz nullable
- `completed_at_utc` timestamptz nullable
- `evidence_ref` text nullable

#### `job_events`
- `event_id` UUID primary key
- `job_id` UUID foreign key
- `step_id` UUID nullable
- `event_type` text
- `event_time_utc` timestamptz
- `payload` jsonb

#### `approval_requests`
- `approval_id` UUID primary key
- `job_id` UUID foreign key
- `approval_type` text
- `reason_text` text
- `requested_action` jsonb
- `status` text
- `requested_at_utc` timestamptz
- `resolved_at_utc` timestamptz nullable
- `resolved_by` text nullable
- `resolution_note` text nullable

#### `strategy_state_versions`
- `strategy_version_id` UUID primary key
- `state_key` text
- `state_value` jsonb
- `confidence` numeric
- `provenance_type` text
- `provenance_ref` text
- `is_active` boolean
- `supersedes_version_id` UUID nullable
- `revoked_at_utc` timestamptz nullable
- `created_at_utc` timestamptz

#### `memory_entries`
- `memory_id` UUID primary key
- `memory_bucket` text
- `memory_type` text
- `title` text
- `body_text` text
- `summary_text` text nullable
- `source_ref` text
- `source_kind` text
- `job_id` UUID nullable
- `confidence` numeric nullable
- `is_immutable` boolean
- `is_superseded` boolean
- `created_at_utc` timestamptz

#### `memory_links`
- `link_id` UUID primary key
- `from_memory_id` UUID foreign key
- `to_memory_id` UUID foreign key
- `link_type` text

#### `retrieval_runs`
- `retrieval_run_id` UUID primary key
- `job_id` UUID nullable
- `query_text` text
- `bucket_target` text
- `filters_json` jsonb
- `compression_mode` text
- `started_at_utc` timestamptz
- `completed_at_utc` timestamptz nullable
- `helpfulness_score` numeric nullable

#### `retrieval_results`
- `result_id` UUID primary key
- `retrieval_run_id` UUID foreign key
- `memory_id` UUID nullable
- `source_ref` text
- `rank_position` integer
- `selected_for_prompt` boolean
- `compressed_payload` text nullable

#### `evaluations`
- `evaluation_id` UUID primary key
- `job_id` UUID foreign key
- `evaluation_scope` text
- `rubric_json` jsonb
- `score` numeric nullable
- `result_summary` text
- `created_at_utc` timestamptz

#### `defect_reports`
- `defect_id` UUID primary key
- `job_id` UUID foreign key
- `evaluation_id` UUID foreign key
- `defect_type` text
- `severity` text
- `evidence` jsonb
- `proposed_fix` text nullable
- `created_at_utc` timestamptz

#### `refinement_proposals`
- `proposal_id` UUID primary key
- `job_id` UUID foreign key
- `target_type` text
- `target_ref` text
- `proposal_text` text
- `expected_gain` text
- `risk_level` text
- `status` text
- `created_at_utc` timestamptz

#### `artifacts`
- `artifact_id` UUID primary key
- `job_id` UUID foreign key
- `artifact_type` text
- `path_ref` text
- `content_hash` text nullable
- `created_at_utc` timestamptz

### 6.2 SQLite Tables

#### `session_recall`
- `recall_id` integer primary key
- `session_date` text
- `job_id` text nullable
- `memory_type` text
- `title` text
- `body_text` text
- `source_ref` text
- `created_at_utc` text

#### `session_recall_fts`
- FTS5 virtual table over title and body text

### 6.3 Enum Domains

V1 should standardize at least these enum families:

- `job_status`
  - `queued`
  - `planning`
  - `awaiting_approval`
  - `running`
  - `paused`
  - `verifying`
  - `completed`
  - `failed`
  - `aborted`

- `approval_status`
  - `pending`
  - `approved`
  - `denied`
  - `expired`

- `memory_type`
  - `observation`
  - `decision`
  - `constraint`
  - `preference`
  - `strategy`
  - `artifact`
  - `evaluation`

- `defect_type`
  - `instruction_defect`
  - `retrieval_defect`
  - `memory_hygiene_defect`
  - `verification_defect`
  - `tool_selection_defect`
  - `strategy_state_defect`

---

## 7. Job Lifecycle

### 7.1 Lifecycle States

1. `queued`
2. `planning`
3. `awaiting_approval` if any governed action is required
4. `running`
5. `paused` if user pauses or system hits a safe interrupt point
6. `verifying`
7. terminal state:
   - `completed`
   - `failed`
   - `aborted`

### 7.2 Lifecycle Rules

- every job must have a declared success definition before `running`
- every step must record evidence or failure reason
- retries return to `running`, not to `queued`
- resume must restore the last safe checkpoint, not replay the full job blindly
- finalization is blocked until verification completes

### 7.3 Minimum V1 Job Trace

Each job must retain:

- original goal
- plan
- approvals issued
- steps executed
- retrieval runs used
- verification result
- artifacts produced
- final summary

---

## 8. Approval Lifecycle

### 8.1 Trigger Conditions

V1 approval is required for:

- protected-zone writes
- destructive actions
- external publishing or sending
- strategy-state mutation
- refinement patch application

### 8.2 Lifecycle States

1. approval requested
2. pending user decision
3. approved or denied
4. execution continues or job fails safely

### 8.3 Approval Flow

1. orchestrator detects governed action
2. planner packages concise justification and action payload
3. approval gate stores request in Postgres
4. Telegram gateway sends approval prompt
5. user replies `approve` or `deny`
6. gateway resolves the approval record
7. scheduler resumes or terminates the blocked step

### 8.4 Approval Principles

- approvals are action-specific, not blanket session consent
- denial is durable for the targeted action instance
- approval prompts must explain why the action is needed
- self-improving logic cannot bypass this gate

---

## 9. Retrieval Lifecycle

### 9.1 Retrieval Pipeline

1. planner identifies uncertainty or context need
2. retrieval service chooses memory bucket
3. service applies filters and query template
4. results are ranked
5. compression step produces minimal prompt-ready context
6. selected context is injected into execution or planning
7. helpfulness is scored after completion

### 9.2 Bucket Selection Rules

- use **Bucket 1** for recent session continuity, blockers, and recent approvals
- use **Bucket 2** for foundational standards, architecture, validated notes, and precedents
- use **Bucket 3** for live strategic posture and constraints

### 9.3 Retrieval Telemetry Requirements

Every retrieval run must record:

- bucket queried
- filters used
- results returned
- results passed into prompt
- whether the retrieval materially helped

### 9.4 Retrieval Compression Rule

Raw chunks should not be injected by default.
V1 should prefer compressed, structured context unless the task explicitly requires direct source excerpts.

---

## 10. Memory Write Policy

### 10.1 Write Classes

V1 memory writes are restricted to:

- validated observations
- explicit decisions
- persistent constraints
- strategy updates
- artifact references
- evaluations with evidence

### 10.2 Non-Writable by Default

These do not become durable memory unless transformed:

- raw chain-of-thought style reasoning
- transient tool noise
- failed speculative plans
- unverified inferences
- duplicate session chatter

### 10.3 Policy Rules

- every memory write must include `memory_type`
- every durable write must include provenance
- strategy writes require explicit versioning
- inferred beliefs must be distinguishable from direct observations
- immutable records are append-only
- superseded beliefs are marked, not silently overwritten

### 10.4 Bucket-Specific Rules

- **Bucket 1**
  - write recent outcomes, blockers, and approvals
  - summarize before mirroring into Postgres

- **Bucket 2**
  - write only curated or validated source artifacts
  - store chunk metadata and retrieval-ready structure

- **Bucket 3**
  - write only explicit structured strategy state
  - never treat embeddings as the canonical state layer

---

## 11. Refinement and Evaluation Flow

### 11.1 V1 Principle

V1 refines one bounded skill or routing path at a time.
It does not permit broad self-rewrites.

### 11.2 Evaluation Flow

1. job completes or fails
2. evaluator grades against goal and rubric
3. defect classifier identifies failure mode
4. system decides whether the issue is instructional, retrieval, memory, verification, tool-selection, or strategy-state related
5. refinement proposer creates a narrow proposal
6. proposal awaits governance approval if it changes durable operating logic
7. approved refinement is applied as a reversible patch
8. next comparable run is used to validate improvement

### 11.3 Evaluation Inputs

- goal success
- verification evidence
- number of retries
- approval precision
- retrieval helpfulness
- artifact quality
- runtime efficiency

### 11.4 Evaluation Outputs

- score
- defect report
- targeted refinement proposal
- validation requirement for next run

---

## 12. Provider Execution Strategy

V1 should intentionally leverage multiple frontier models where this improves execution quality, provided they operate against the same governance shell and implementation contract.

### 12.1 Core Rule

Models are execution operators, not alternate architectures.
Claude, Codex, or other providers may lead individual tasks, but they must all inherit the same:

- system boundaries
- approval rules
- memory write policy
- retrieval policy
- audit obligations
- implementation spec

### 12.2 Recommended V1 Working Split

- **Claude**
  - stronger fit for planning, architecture interpretation, refinement review, and long-form reasoning passes

- **Codex**
  - stronger fit for direct repository execution, implementation throughput, and tool-heavy build work

### 12.3 Coordination Rule

If both models are used during V1 delivery:

- the implementation spec remains the single build contract
- no provider may silently redefine scope or boundaries
- handoffs must persist through normal V.A.N.T.i.S. state and audit channels
- disagreements are resolved by the written spec unless implementation exposes a real contradiction

### 12.4 V1 Intent

This gives JARVIS V2 provider redundancy and higher execution quality without reintroducing framework dependence or architectural drift.

---

## 13. V1 In Scope

- Telegram as the control plane
- queue-backed job orchestration
- planner/executor/verifier decomposition
- workstation/server execution substrate
- Postgres as canonical structured backend
- pgvector for foundational retrieval
- SQLite + FTS5 for local session recall
- approval gate with Telegram-mediated approval loop
- retrieval telemetry
- explicit memory typing and write policy
- structured strategy state with versioning
- evaluation pipeline
- one bounded refinement path
- dual-model execution under one shared implementation contract

---

## 14. Deferred From V1

- Discord control plane
- full phone-native intelligence runtime
- broad mobile actuation coverage beyond a narrow tool harness
- Qdrant as a dedicated retrieval service
- multi-user collaboration model
- unrestricted autonomous self-modification
- broad skill-library auto-patching
- always-on 24/7 operating posture
- generalized productization features

---

## 15. V1 Non-Negotiable Rules

1. Hermes is not allowed to self-authorize governed actions.
2. Postgres remains the canonical state store.
3. Strategy state remains structured and versioned.
4. Retrieval must be typed, filtered, and logged.
5. Refinement must be narrow, evidence-based, and reversible.
6. Telegram is the locked V1 command surface unless implementation exposes a concrete blocker.
7. Provider choice cannot change system boundaries, source-of-truth ownership, or approval requirements.

---

## 16. Minimum Delivery Order

1. Control plane plus job queue
2. Planner/executor/verifier runtime
3. Postgres job, approval, strategy, and memory metadata tables
4. SQLite local recall cache
5. Foundational retrieval with pgvector
6. Retrieval telemetry and memory write policy enforcement
7. Evaluation and one bounded refinement loop

This is the shortest V1 path that stays faithful to the architecture while remaining implementable.

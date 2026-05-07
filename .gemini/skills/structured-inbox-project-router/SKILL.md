---
name: structured-inbox-project-router
description: Processes structured AI chat exports from 01_HUMAN/Inbox one file at a time, extracts atomic ideas, routes them into Projects, Business, or 02_MACHINE/AI_Chat_Imports, and finishes with a cross-batch synthesis.
---

# SKILL: Structured Inbox Project Router
Version: 1.0.1

Purpose
Process structured AI-chat exports in V.A.N.T.i.S. with higher rigor than the generic inbox workflow. This skill is designed for handover-style exports that already contain extracted signal and need controlled routing, dedupe, and prioritization.

---

# When To Use
Activate this skill when:
- `01_HUMAN/Inbox/` contains structured AI chat exports.
- The source files follow a stable schema such as:
  - `PRIMARY TOPIC`
  - `HIGH-SIGNAL INSIGHTS`
  - `ATOMIC CONCEPT PROPOSALS`
  - `DECISIONS MADE`
  - `OPEN LOOPS & RESEARCH`
- The user wants one-file-at-a-time processing with final batch synthesis.

Do not use this skill for:
- generic inbox cleanup
- direct Galaxy promotion
- unstructured notes with no stable schema
- simple one-off moves with no extraction or routing logic

---

# Core Workflow

## Step 1 - Scan the Intake Set
Identify the target files in `01_HUMAN/Inbox/`.

Default handling:
- process one file at a time
- preserve the source files as intake records unless the user explicitly asks to archive or move them

If volume is high and the active provider supports sub-agents, use a Fan-Out / Fan-In pattern:
- one worker per inbox file
- one head agent for synthesis, dedupe, and final routing authority

## Step 2 - Parse the Source Structure
Interpret the sections as follows:
- `PRIMARY TOPIC`: routing anchor
- `HIGH-SIGNAL INSIGHTS`: reusable signal and evidence
- `ATOMIC CONCEPT PROPOSALS`: primary split points for individual ideas
- `DECISIONS MADE`: maturity and commitment signals
- `OPEN LOOPS & RESEARCH`: uncertainty and unresolved work

## Step 3 - Extract Atomic Items
Split the source into atomic ideas where needed.

Rules:
- keep each non-duplicate idea as its own unit
- do not bury multiple viable ideas inside one downstream artifact
- preserve source nuance rather than flattening the export into a generic summary

## Step 4 - Check for Duplication
Check for overlap against:
- items already processed in the current batch
- obvious existing project folders in `01_HUMAN/Projects/`
- obvious existing business material in `01_HUMAN/Business/`

Do not merge silently.
If two items are merged or treated as duplicates, record the rationale explicitly.

## Step 5 - Route Each Item
Use the following lanes.

### Lane A - Project
Route to `01_HUMAN/Projects/<project>/` when:
- the item has a clear problem or objective
- the scope is coherent
- next steps are identifiable
- the material reads as something to build, test, or develop

### Lane B - Business
Route to `01_HUMAN/Business/...` when:
- the item is immediately usable in an active business lane
- the commercial application is concrete now
- confidence is high

Business routing uses the highest threshold. If a commercial use exists but the case is still ambiguous, prefer `Projects` or `02_MACHINE/AI_Chat_Imports/`.

### Lane C - AI Chat Imports
Route to `02_MACHINE/AI_Chat_Imports/` when:
- the content is valuable
- it is not yet clearly a project
- it is not yet clearly a business-use asset
- it needs later promotion, refinement, or cross-referencing

### Hard Constraint
Never route imported chat material directly to `01_HUMAN/Knowledge/Galaxy/`.

---

# Output Artifacts

This skill should produce three output layers.

## 1. Per-Source Processing Record
Required fields:
- `Source File`
- `Primary Topic`
- `Atomic Items Identified`
- `Duplicate Check`
- `Routing Decision`
- `Destination Path`
- `Confidence`
- `Reasoning`
- `Notes / Deferred Questions`

## 2. Per-Idea Routed Artifact
Required fields:
- `Title`
- `Source`
- `Status`
- `Summary`
- `Key Insights`
- `Decisions Already Made`
- `Open Loops`
- `Why This Lives Here`
- `Next Step`

## 3. Final Batch Synthesis Report
Required sections:
- `Files Processed`
- `Ideas Routed`
- `Duplicates / Overlap`
- `Projects Count`
- `Business Count`
- `AI_Chat_Imports Count`
- `Highest-Priority Opportunities`
- `Lower-Priority / Leave for Now`
- `Northern Strata Immediate Uses`
- `Recommended Next Moves`
- `Priority Ranking`
- `Routing Table`

Required routing table fields:
- `Source File`
- `Atomic Item`
- `Destination`
- `Confidence`
- `Rationale`

---

# Behaviour Rules
- `AI_Chat_Imports` is the fallback lane, not the universal lane.
- Direct routing to `Projects` or `Business` is allowed when confidence is strong.
- The safeguard against bad routing is the mandatory final routing table and destination counts, not forced staging of everything.
- Preserve source files during the initial run unless the user explicitly changes the policy.
- Keep final routing authority centralized in the head agent when multiple workers are used.

---

# Protocol Compliance

## Output & Lineage
- Project-shaped outputs may be written directly into `01_HUMAN/Projects/`.
- Business-shaped outputs may be written directly into `01_HUMAN/Business/`.
- Ambiguous but valuable outputs must be staged in `02_MACHINE/AI_Chat_Imports/`.
- Galaxy promotion is out of scope for this skill.

## Audit Reflex
- Every successful ingestion run MUST conclude with the `audit-logger` skill or an equivalent Tier 2 reasoning log when changes warrant it.

## ASV Reflex
- Any modifications to this skill's logic MUST be followed by: `node .gemini/hooks/version-incrementer.js .gemini/skills/structured-inbox-project-router/SKILL.md`


---
type: synthesis
topic: jarvis-upgrade-v2
date: 2026-05-02
tags: [architecture, karpathy, super-skills, pinecone, zapier-mcp, hermes, vantis-upgrade]
status: final
supersedes: hermes_vs_openclaw_master_plan.md, hermes-vs-openclaw_ACP_V1.md
sprint-gate: HERMES-POST-CLIENT (active)
---

# JARVIS UPGRADE — V2 SYNTHESIS
**Integrating Karpathy Cognitive Protocol + Three-Bucket Memory + Super Skills Refinement Loop**

> Built on top of the Hybrid Two-Layer Architecture decided 2026-05-01 (ACP V1, confidence 0.84).
> This document is additive, not a reversal. It answers: "what does the new inbox information change?"

---

## 1. CONCEPTUAL BRIDGE: WHAT THE NEW MATERIAL ACTUALLY CHANGES

The Karpathy framework and Super Skills architecture are not a "different method" — they are the **missing implementation spec** for Layer 1 (Hermes). The May 1 ACP decision named *what* to build (FTS5 + Honcho + autonomous skill curator). The new material names *how to build it and how it self-improves*.

Specifically:

- **Karpathy's four principles** (Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution) are the **cognitive operating rules** for every agent task in the system. They answer the open question of "how does Hermes reason before acting?" They map directly to V.A.N.T.i.S.'s existing PLAN MODE mandate but extend it with declarative success criteria and surgical diff discipline.
- **The Super Skills spec** answers the ACP V1 commitment to "autonomous Curator (v0.12.0) grades/consolidates skills weekly." It provides the exact mechanism: agents grade their own output, identify deficiencies, and rewrite their source `.md` skill file. This is the Refinement Loop.
- **The Three-Bucket Memory Model** provides a named, structured implementation of what the ACP V1 vaguely called "FTS5 + LLM summarization" and "cross-session recall backend." It is not a replacement — it is a specification.

**The "different method" language** in the assignment refers to this: instead of building a generic intelligent agent, the new material says to build an agent with *a defined cognitive protocol* (Karpathy) that stores to *a defined memory hierarchy* (Three Buckets) and orchestrates tools via *a defined governed layer* (Zapier MCP). The old plan had the right destination but no road map.

---

## 2. THREE-LAYER VS. TWO-LAYER: ARCHITECTURE VERDICT

**Verdict: The architecture remains two layers. The Three-Bucket model is an internal implementation detail of Layer 1, not a new layer.**

The Three Buckets map cleanly as follows:

| Bucket | Description | V.A.N.T.i.S. Implementation | Location |
|---|---|---|---|
| Bucket 1 — Session Memory | `/wrap-up` command indexes session outcomes | `/handover` skill + audit-logger → Honcho dialect | `02_MACHINE/State/` + Honcho |
| Bucket 2 — Foundational Knowledge | Immutable technical docs, project history, standards | Existing Galaxy + `private workspace/Knowledge/` (read-only) | Pinecone namespace: `vantis-foundation` |
| Bucket 3 — Mutable Strategy Profile | Dynamic Markdown read at every session start | `02_MACHINE/State/session-state_LATEST.md` | Already exists — this IS Bucket 3 |

**Conclusion:** Bucket 3 already exists. Bucket 1 is already partially implemented via `/handover`. Bucket 2 is the new addition — indexing the Galaxy into Pinecone. No new architectural layer is required. Add a Pinecone indexer as a component inside the existing Hermes Layer.

A third *governance* layer is not warranted — V.A.N.T.i.S.'s native governance shell (Layer 2) already handles enforcement, audit logging, and approval gates. Adding Zapier MCP (see Section 4) extends Layer 2's tool reach without becoming a new layer.

---

## 3. MEMORY INFRASTRUCTURE: FTS5+HONCHO vs PINECONE+THREE-BUCKETS

### Current Plan (ACP V1)
- **FTS5 SQLite:** Fast full-text search over session transcripts; low cost; local-first
- **Honcho:** User modeling across sessions; tracks preferences, energy, coding style
- **Combined cost:** ~$5/month VPS; no external API fees

### New Approach (Pinecone + Three-Bucket)
- **Pinecone Serverless:** Vector + keyword hybrid search; P90 150ms; horizontal scale; enterprise namespacing for multi-tenancy
- **Three-Bucket structure:** Precise retrieval by bucket type (session vs. foundational vs. strategy)
- **Cost:** Pinecone Serverless free tier handles ~100k vectors (enough for months of vault content); scales to paid at ~$0.10/GB stored

### What Changes in Capability
| Capability | FTS5 + Honcho | Pinecone + Three-Bucket | Delta |
|---|---|---|---|
| Semantic search (conceptual recall) | No — keyword only | Yes — dense vector | **Major gain** |
| Multi-tenancy (client isolation) | Not built-in | Namespaces native | **Major gain** (client work at scale) |
| Token cost to retrieve | Low (FTS5 efficient) | Low (selective vector pull, no full-file reads) | Equivalent |
| Upfront setup complexity | Low (SQLite local) | Medium (Pinecone API, indexer job) | **Pinecone is harder** |
| Vendor dependency | None (local) | Pinecone (cloud) | Risk: Pinecone pricing change |
| Honcho user modeling | Yes | Not replaced — still needed | No conflict |

### Recommendation
**Run FTS5 + Honcho as the interim (pre-client) memory layer, then index into Pinecone post-gate.** Rationale: Pinecone setup costs approximately 2–3 hours of implementation time — above the 30-min/day system-building cap. FTS5 handles session recall well enough for the sprint period. Pinecone unlocks the multi-tenancy story needed for Tier 2 "Chief of Staff" clients, so it belongs in the post-client implementation queue.

The Three-Bucket model is the structural specification for *how* content is organized in either system. Adopt the naming and the segmentation logic now (costs zero time), implement the Pinecone backend later.

---

## 4. TOOL ORCHESTRATION: DOES ZAPIER MCP BELONG IN THE PLAN?

**Yes — but it belongs at the commercial tier boundary, not as core V.A.N.T.i.S. infrastructure.**

### Zapier MCP in the Architecture

Zapier MCP acts as the "governed connection fabric" between the agent and external apps (Salesforce, Slack, Gmail, HubSpot, etc.). The governance document (`governance-gate.md` v1.1.0) already mandates that all external system calls require human approval. Zapier MCP *mechanizes* that policy: instead of ad-hoc integrations with individual APIs, every external action routes through a single governed runtime with:
- Centralized OAuth (no hardcoded keys)
- Endpoint-level permissions (allow Read, block Delete)
- Audit trail per action (satisfies CISO-level visibility)

This is structurally identical to what `governance-gate.md` enforces manually today. Zapier MCP is the productized version of that governance layer.

### Commercial Tier Mapping

| Tier | Product | Zapier MCP Role |
|---|---|---|
| Tier 1 — "The Automator" | SMB predictable workflows | **Core delivery mechanism** — Zapier's 9,000+ app library is the product. Client buys reliable automation. Governed, Docker-sandboxed. |
| Tier 2 — "The Chief of Staff" | Founder/exec autonomous ops | **Enhanced orchestration** — Zapier MCP + Hermes memory + Karpathy cognitive protocol = agent that learns and acts across the client's full app stack. |

**For V.A.N.T.i.S. internally:** Zapier MCP is low-priority pre-client. The system currently uses Claude MCP tools (Gmail, Google Drive — visible in the deferred tool list) directly. Zapier becomes relevant when delivering Tier 1 automations to NS clients. Add it to the post-client implementation queue alongside Pinecone.

**Immediate action (zero cost):** Document the Zapier MCP as the intended delivery mechanism for Tier 1 Automator packages in the NS/Freelance OS pitch. It strengthens the "governance and reliability" narrative for B2B clients.

---

## 5. SUPER SKILLS AS THE MOAT: PRODUCT POSITIONING IMPACT

### What Super Skills Add to Freelance OS Positioning

The existing dual-tier model (Automator vs. Chief of Staff) sells based on architecture. Super Skills add a *compounding* story that changes the pricing logic:

**Old framing:** "I set up automations that reliably execute your workflows." (Static value)

**New framing with Super Skills:** "I deliver a system that grades its own performance and rewrites itself to improve each month — your AI ops partner gets better the longer you keep it." (Compounding value)

This unlocks a third revenue logic that does not require a new product tier:

**Tier 1 → Retainer Stickiness:** Automations built with the Refinement Loop justify ongoing retainers ($500–$1,000/month) over one-time builds. The agent improves the automation monthly. Client cannot easily replicate this internally.

**Tier 2 → Performance Fee Potential:** If a Chief of Staff agent demonstrably improves conversion rates or reduces ops overhead (measurable via Honcho tracking), you can charge against outcomes, not just time. Super Skills + Pinecone recall gives you the audit trail to prove it.

### New Revenue Tier (Unlocked Post-Gate)
**Tier 0 — "The Audit"** (pre-Super Skills, usable immediately):
- One-time AI ops audit for SMBs: "What automations would save you 10+ hours/week?"
- Deliverable: A PDF report + a Zapier-powered demo
- Price: £300–£500 flat
- Relevance: This is discoverable from NS conversations today. No Hermes required. Generates the first NS client close.

---

## 6. IMMEDIATE IMPLEMENTATION PATH: PRE-GATE vs. POST-GATE

### This Week (PRE-GATE — Zero Infrastructure Cost)

These items are pure documentation and cognitive protocol adoption. They honor the gate because they build no systems.

| Item | File to Modify/Create | Time Estimate |
|---|---|---|
| Add Karpathy four principles to `SHARED_RULES.md` as a "Cognitive Protocol" section | `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` | 15 min |
| Name and define the Three Buckets in session-state (Bucket 3 already exists as LATEST.md) | `02_MACHINE/State/session-state_LATEST.md` — add a `[MEMORY]` section | 10 min |
| Add "Tier 0 — The Audit" to NS pitch framework | `private workspace/Business/private-client/NS_COMMAND_CENTER.md` | 15 min |
| Document Zapier MCP as Tier 1 delivery mechanism | `private workspace/Business/private-client/NS_COMMAND_CENTER.md` (same edit) | 5 min |
| Update `/wrap-up` command spec to explicitly label Bucket 1 behavior | `.claude/commands/handover.md` or relevant skill file | 10 min |
| Add Super Skills "Refinement Loop" criteria to skill-creator skill | `.gemini/skills/skill-creator.md` | 20 min |
| **Total** | | **~75 min; split across days at 15 min/day** |

**Note:** Per the 30-min/day system-building cap, spread this across 5 days. Execution-first mandate holds. None of this is blocked by the gate — it is documentation, not infrastructure.

### After First Client Closes (POST-GATE — Infrastructure Unlocked)

These are sequenced by dependency order:

1. **Docker/SSH Sandbox Validation** (30 min, gate condition)
   - Run Hermes in a Docker container; confirm isolation
   - Set `SANDBOX_VALIDATED: true` in session-state

2. **FTS5 + Honcho Memory Layer** (3–4 hours)
   - Hermes integration at read-only, then full read/write after sandbox confirmed
   - Bucket 1 (session memory) and Bucket 2 (foundation) indexed via FTS5 initially
   - File: `03_SYSTEM/Protocols/hermes-integration.md` (new, create on unlock)

3. **Pinecone Serverless Namespace Setup** (2–3 hours)
   - Namespaces: `vantis-session`, `vantis-foundation`, `vantis-strategy`
   - Indexer job: nightly cron over `private workspace/Knowledge/Galaxy` and `02_MACHINE/`
   - Client namespace isolation for Tier 2 Chief of Staff delivery

4. **Zapier MCP Integration** (2–3 hours, client-driven)
   - Triggered by first Tier 1 Automator client, not before
   - Replaces manual API integrations in client delivery scripts

5. **Super Skills Refinement Loop — First Live Agent** (4–6 hours)
   - Select one existing skill (candidate: `ns-batch`) for Refinement Loop retrofitting
   - Agent grades output after each batch run, updates skill file with observed deficiencies
   - This becomes the proof-of-concept for Tier 2 Chief of Staff pitch

---

## 7. REVISED JARVIS UPGRADE PLAN V2

### Architecture Diagram (Text)

```
┌─────────────────────────────────────────────────────────┐
│  LAYER 2 — GOVERNANCE SHELL (V.A.N.T.i.S. Native)       │
│  governance-gate.md v1.1.0 | SHARED_RULES v1.19         │
│  + Karpathy Cognitive Protocol (new — docs only)         │
│  + Zapier MCP endpoint (post-gate, client delivery)      │
└─────────────────────┬───────────────────────────────────┘
                      │ approval gate
┌─────────────────────▼───────────────────────────────────┐
│  LAYER 1 — INTELLIGENCE CORE (Hermes-Agent)              │
│                                                          │
│  MEMORY OS (Three-Bucket Model):                         │
│  ┌──────────┐  ┌──────────────┐  ┌───────────────────┐  │
│  │ Bucket 1 │  │  Bucket 2   │  │    Bucket 3       │  │
│  │ Session  │  │ Foundation  │  │ Strategy Profile  │  │
│  │ /wrap-up │  │ Galaxy Index│  │ session-state_    │  │
│  │ → Honcho │  │ → Pinecone  │  │ LATEST.md (live)  │  │
│  └──────────┘  └──────────────┘  └───────────────────┘  │
│                                                          │
│  SUPER SKILLS REFINEMENT LOOP:                           │
│  Execute → Grade Output → Identify Deficiency →          │
│  Update .md Skill File → Next Execution Improved         │
│                                                          │
│  TOOL ACQUISITION: Firecrawl (AI-optimized markdown)     │
└─────────────────────────────────────────────────────────┘
```

### Commercial Product Map (Updated)

| Tier | Product | Key Technology | Price Point | Gate |
|---|---|---|---|---|
| Tier 0 | The Audit | Human analysis + demo | £300–£500 flat | **Available NOW** |
| Tier 1 | The Automator | Zapier MCP + governance shell | $500–$1,000/month | Post-gate (client delivery) |
| Tier 2 | The Chief of Staff | Hermes + Pinecone + Super Skills | $2,500–$5,000/month + setup | Post-gate + post-Pinecone |

### Sprint Gate Status (Unchanged)

**HERMES-POST-CLIENT gate remains active.** The V2 plan does not change the gate — it enriches what unlocks behind it.

Gate reversal conditions (from ACP V1, unchanged):
1. 1 client closed (any lane) before 2026-05-08
2. Docker/SSH sandbox validated (30-min session)
3. No open proposals pending same-day follow-up reply

---

## 8. WHAT CHANGES, WHAT STAYS THE SAME

### Stays the Same
- The two-layer architecture (Hermes intelligence core + V.A.N.T.i.S. governance shell)
- The HERMES-POST-CLIENT gate and all three reversal conditions
- The commercial Tier 1 / Tier 2 framing
- The 30-min/day system-building cap
- Execution-first mandate through May 14

### Changes (V2 Additions)
- **Cognitive Protocol:** Karpathy four principles are formally adopted as the agent's reasoning standard (document only, no infrastructure)
- **Memory Model:** Three-Bucket naming and segmentation now explicit (Bucket 3 was already live; Bucket 1 gets stronger `/wrap-up` discipline; Bucket 2 queued for Pinecone)
- **Super Skills Mechanism:** Refinement Loop spec is now defined — skill files are living documents that agents update; first candidate is `ns-batch` post-gate
- **New Revenue Tier:** Tier 0 "The Audit" is immediately deployable for NS conversations
- **Zapier MCP:** Named as the Tier 1 delivery mechanism (not infrastructure yet, just framing)
- **Pinecone:** Queued after Docker sandbox validation; replaces "FTS5 for Bucket 2" post-gate

---

*V.A.N.T.i.S. Synthesis | 2026-05-02 | Jarvis Upgrade V2*
*Supersedes: hermes_vs_openclaw_master_plan.md, hermes-vs-openclaw_ACP_V1.md*
*Status: Ready for main session finalization*

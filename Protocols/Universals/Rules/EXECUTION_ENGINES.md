# V.A.N.T.i.S. EXECUTION ENGINES — OPERATING PROTOCOL

Version: 1.5
Applies To: All V.A.N.T.i.S. Agents (Gemini, Claude, GPT, Local)

---

## [OVERVIEW] WHAT THIS IS

REVENUE_ENGINE and CONTENT_ENGINE are two standalone execution systems that are part of the V.A.N.T.i.S. agentic architecture. They are **not** internal VANTIS modules — they are sibling repositories with their own agent rules and should expose either a shared `AGENTS.md` or provider adapters (`CLAUDE.md` / `GEMINI.md` / `CODEX.md`). V.A.N.T.i.S. acts as the **intelligence layer** that receives only validated, promoted outputs from both engines.

These engines are available to V.A.N.T.i.S. for any client engagement, project, or market. They are currently deployed for **private client (NS)** work but are general-purpose tools within the architecture.

---

## [ARCHITECTURE] EXECUTION/INTELLIGENCE SPLIT

Both engines follow the same architectural pattern. This pattern is non-negotiable.

All execution engines live at `~/Documents/VANTIS_ENGINES/`. For agent orientation, read `~/Documents/VANTIS_ENGINES/AGENTS.md` first when available. Otherwise read the adapter for the active provider.

| Layer | REVENUE_ENGINE | CONTENT_ENGINE | NS_OUTREACH_ENGINE |
| :--- | :--- | :--- | :--- |
| **Execution Repo** | `~/Documents/VANTIS_ENGINES/revenue-engine/` | `~/Documents/VANTIS_ENGINES/content-engine/` | `~/Documents/VANTIS_ENGINES/ns-outreach-engine/` |
| **Intelligence Layer** | `~/Documents/V.A.N.T.i.S/REVENUE_ENGINE/` | `~/Documents/V.A.N.T.i.S/CONTENT_ENGINE/` | `~/Documents/V.A.N.T.i.S/REVENUE_ENGINE/06_CAMPAIGNS/` |
| **Contains (Execution)** | Raw market data, scraping, runs, experiments, unvalidated outputs | Raw generated assets, scripts, analytics exports, draft copy | Prospect data, enriched JSON, batch output files, contacted_log.csv |
| **Contains (Intelligence)** | Validated insights, opportunities, offers, decisions | Approved media, performance patterns, strategic decisions | Validated campaign angles, offer positioning, outreach decisions |

**Rule:** The execution repo is where work happens. VANTIS only receives the output of a deliberate promotion decision — not drafts, not experiments, not works in progress.

---

## [REVENUE_ENGINE] Operating Protocol

### Purpose
Convert raw market data into validated service offers and outreach campaigns.

Core pipeline (mandatory — no stage skipping):
```
Market Run → Insights → Opportunity → Offer → Campaign → Feedback → Decision → Promote to VANTIS
```

### Physical Location
- Execution: `~/Documents/VANTIS_ENGINES/revenue-engine/`
  - Key subdirectories: `runs/`, `insights/`, `offers/`, `campaigns/`, `crm/`, `scripts/`
- Intelligence: `~/Documents/V.A.N.T.i.S/REVENUE_ENGINE/`
  - Key subdirectories: `01_MARKETS/`, `03_INSIGHTS/`, `04_OPPORTUNITIES/`, `05_OFFERS/`, `06_CAMPAIGNS/`, `08_DECISIONS/`

### How Agents Should Use It
1. **Open the execution repo** — `~/Documents/VANTIS_ENGINES/revenue-engine/` — and work within `runs/`
2. **Run the pipeline in sequence.** Each stage has mandatory file outputs. Do not produce chat-only responses.
3. **Never promote unvalidated output to VANTIS.** Promotion is a conscious, manual decision point.
4. **Resume behaviour:** If given minimal context, check `runs/` for the most recent folder and identify the incomplete pipeline stage.

### The Service-First Constraint (Locked)
If any SaaS, tool, or product idea surfaces during a run:
- Extract the underlying problem
- Convert to a **done-for-you service** first
- Only productize after validation with paying clients

This constraint exists to maximise speed to revenue and minimise overhead.

### Agent Execution Rules (from the execution-engine adapters)
- No follow-up questions by default — execute immediately on valid input
- Structured outputs are mandatory (5-section format)
- All outputs go to files in `runs/` — not chat
- Avoid consulting mode — don't present options, execute

---

## [CONTENT_ENGINE] Operating Protocol

### Purpose
Convert ideas into approved, distributed content artifacts. Feed performance data back into decision-making.

Core pipeline:
```
Idea → Prompt → Raw Asset → Assembly → Review → Approved → Distribution → Performance → Repurposing
```

### Physical Location
- Execution: `~/Documents/VANTIS_ENGINES/content-engine/`
  - Key subdirectories: `_config/`, `raw/`, `approved_media/`, `analytics/`, `archive/`
- Intelligence: `~/Documents/V.A.N.T.i.S/CONTENT_ENGINE/`
  - Key subdirectories: `01_IDEAS/`, `04_ASSEMBLY/`, `05_APPROVED/`, `07_PERFORMANCE/`

### How Agents Should Use It
CONTENT_ENGINE operates in **four strict session types**. Do not freestyle it.

| Session Type | What It Produces | Output Location |
| :--- | :--- | :--- |
| **Idea Session** | `01_IDEA.md` only | `01_IDEAS/` |
| **Production Session** | Full pipeline: idea → assembly | `raw/`, `04_ASSEMBLY/` |
| **Review Session** | Verdict only (approve/reject) | `05_APPROVED/` or rejected |
| **Performance Session** | Analytics note only | `analytics/` |

**Hard Rule:** Any production beyond the permitted ceiling for a session type is an overproduction failure.

### Content Strategy Rule
Content ideas should be sourced from REVENUE_ENGINE market research — not generated independently. Pain points, objections, and offer language from market runs feed directly into content ideas.

---

## [NS_OUTREACH_ENGINE] Operating Protocol

### Purpose
Discover prospects without websites, enrich with contact data, and generate channel-sorted outreach batches for manual sending.

Core pipeline (mandatory — sequential):
```
Search → Enrich → Dedupe → Batch Generation → Manual Send → Log to contacted_log.csv
```

### Physical Location
- Execution: `~/Documents/VANTIS_ENGINES/ns-outreach-engine/`
  - Key subdirectories: `scripts/`, `output/`, `prompts/`
  - Key files: `contacted_log.csv`, `package.json`
- Intelligence: `~/Documents/V.A.N.T.i.S/REVENUE_ENGINE/06_CAMPAIGNS/`

### How Agents Should Use It
1. **Via VANTIS** — run `/ns-batch` from inside the active V.A.N.T.i.S. session. Pass trade/location as needed.
2. **Direct execution** — `cd ~/Documents/VANTIS_ENGINES/ns-outreach-engine/` and run:
   ```bash
   npm run search -- "[trade] [location] UK no website"
   npm run enrich
   npm run dedupe
   NS_BATCH_SIZE=10 npm run batch
   ```
3. **Output** lands in `output/YYYY-MM-DD_batch_NN.md` — channel-sorted: WhatsApp → Email → Facebook → Manual Research
4. **After sending** — append sent rows to `contacted_log.csv`
5. **Never auto-send.** Batches are for manual review and send only.

### Compliance Rules
- Manual send only — no automated dispatch
- Include `Reply STOP to unsubscribe` for `entity_type: sole_trader` in WhatsApp/SMS
- Follow-up cadence: Day 4 / Day 8 / Day 12 only

---

## [TANDEM OPERATION] The Integration Loop

The two engines are designed to feed each other. This loop is where compounding value is created.

```
REVENUE_ENGINE
    │
    │  Pain points, objections, offer language, campaign angles
    ▼
CONTENT_ENGINE
    │
    │  Market objections from comments, proof hooks, lead signals
    ▼
REVENUE_ENGINE (feedback)
    │
    │  Validated insights, decisions
    ▼
V.A.N.T.i.S. Intelligence Layer
```

**In practice:**
- A completed market run in REVENUE_ENGINE should immediately generate 1–3 content ideas in CONTENT_ENGINE
- Content performance data (comments, objections, leads) feeds back into campaign refinement in REVENUE_ENGINE
- Both loops complete before promoting synthesis to VANTIS

---

## [PROMOTION] What Gets Promoted to VANTIS

Only the following warrant a promotion to the VANTIS intelligence layer. **Mandatory Validation**: Before any item is promoted, it MUST undergo an `evaluator-judge` validation turn as per the **Agency Chaining Protocol (ACP)** to ensure the intelligence is high-signal and evidence-backed.

| From | Promote When |
| :--- | :--- |
| REVENUE_ENGINE | An offer is validated (at least one paying client OR strong market signal) |
| REVENUE_ENGINE | A market insight has been confirmed across multiple runs |
| CONTENT_ENGINE | A content format has demonstrated repeatable performance |
| CONTENT_ENGINE | A repurposing pattern has been validated |

Promoting raw runs, draft offers, or single-data-point observations contaminates the intelligence layer.

---

## [ADDING A NEW ENGINE] Convention

When creating a new execution engine, follow this checklist:

1. Create repo at `~/Documents/VANTIS_ENGINES/<engine-name>/`
2. Add `AGENTS.md` to the repo root when possible, plus provider adapters (`CLAUDE.md`, `GEMINI.md`, `CODEX.md`) as needed — brief agents on purpose, pipeline, and session types
3. Create intelligence layer folder at `~/Documents/V.A.N.T.i.S/<ENGINE_NAME>/`
4. Add `INTEGRATION.md` to the VANTIS intelligence layer (execution/intelligence split, promotion rules)
5. Add a new section to **this file** (`EXECUTION_ENGINES.md`) following the pattern above
6. Update the architecture table at the top of this file
7. Update `VAULT_MAP.md` — add to VANTIS_ENGINES section and routing table
8. Update `SHARED_RULES.md` — add to engine table
9. Update `~/Documents/VANTIS_ENGINES/AGENTS.md` — add engine block, or update the relevant provider adapters if no shared adapter exists
10. Write an ADR in `03_SYSTEM/ADRs/` documenting the decision
11. Run ASV reflex on all modified `03_SYSTEM/Protocols/` files

---

## [FAILURE MODES] Common Mistakes — Do Not Do These

1. **Proposing new infrastructure instead of running the pipeline.** Both engines are fully scaffolded. The bottleneck is execution, not tooling.
2. **Merging the execution repo and intelligence layer.** They are intentionally separate. Do not co-locate raw work with validated outputs.
3. **Generating content independently of REVENUE_ENGINE insights.** Content without market grounding is speculation.
4. **Promoting before validation.** A draft offer is not a validated offer. One paying client is the minimum bar.
5. **Overengineering sessions.** CONTENT_ENGINE sessions are strictly typed. REVENUE_ENGINE pipeline stages are strictly sequenced. Do not add complexity.
6. **Skipping outreach.** The pipeline is not complete until market contact is made. Analysis without outreach is a research project, not a revenue operation.

---

## [CURRENT STATE] As of 2026-04-20

- **REVENUE_ENGINE**: First market run complete (Sheffield Fencing & Decking). First offer ready ("Never Miss a Fencing Lead System" — £350 setup + £97/month). Outreach phase not yet executed.
- **CONTENT_ENGINE**: Restructured to 4-stage model (01_IDEAS → 02_DRAFTS → 03_LIVE → 04_PERFORMANCE). First productions in progress.
- **NS_OUTREACH_ENGINE**: Fully scaffolded and verified. First four batches generated (2026-04-20_batch_01–04). Live Firecrawl search confirmed working.
- **All engines relocated**: Moved to `~/Documents/VANTIS_ENGINES/` (ADR-0007).
- **Active Client/Context**: private client (NS) — all engines currently deployed for NS work.
- **VANTIS Promotion**: No engine has yet promoted validated intelligence to VANTIS. First promotion pending first paying client.

---
*V.A.N.T.i.S. Execution Engine Protocol | Part of Core Governance | See also: SHARED_RULES.md*

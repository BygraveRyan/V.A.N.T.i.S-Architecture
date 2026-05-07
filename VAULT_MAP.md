# VANTIS VAULT MAP

Version: 2.3 (Galaxy-First Edition)

---

# ROUTING TABLE
> **Agent Directive:** Use this table FIRST. Read ONLY the files listed for your task intent. Do not explore broadly.

| Task Intent | Read These Files | Skip |
| :--- | :--- | :--- |
| **Orientation / Resume** | `session-state_YYYY-MM-DD.md`, `AGENTS.md` | Everything else |
| **System Rules / AI Behavior** | `01_HUMAN/Knowledge/Galaxy/concept-ai-*`, `SHARED_RULES.md` | Inbox, Projects |
| **Workflow / Engine Ops** | `01_HUMAN/Knowledge/Galaxy/concept-architecture-*`, `VANTIS_ENGINES/AGENTS.md` or the active engine adapter (`CLAUDE.md` / `GEMINI.md` / `CODEX.md`) | Inbox |
| **Business Strategy / Sales** | `01_HUMAN/Knowledge/Galaxy/concept-business-*`, `01_HUMAN/Business/*` | Protocols |
| **Inbox Processing** | `01_HUMAN/Inbox/*`, `03_SYSTEM/Protocols/METADATA_SCHEMA.md` | Galaxy, Projects |
| **Project Work** | `01_HUMAN/Projects/<project>/` | Galaxy, Inbox |
| **EOD / Daily Audit** | `02_MACHINE/State/session-state_YYYY-MM-DD.md`, `02_MACHINE/Daily/*_MASTER_AUDIT.md` | Galaxy, Projects |
| **Vault Cleanup** | `.gemini/commands/cleanup.toml`, `04_ARCHIVES/` | Everything else |

---

# 03_SYSTEM

Core operational rules and architectural history.

**Sub-directories:**
• **Protocols** (The "System Engine" — deterministic rules for agents and vaults)
  - `METADATA_SCHEMA.md` (Tagging and linking rules for Galaxy nodes)
  - `STAI_Infrastructure_Cookbook.md` (Step-by-step tech implementation)
  - ` Council_Orchestration_Protocol.md` (Multi-agent coordination)
• ADRs (Architecture Decision Records)
• Roadmap (Systemic evolution & upgrades)

---

# 01_HUMAN/Knowledge

Permanent knowledge storage. Built on the **LLM Wiki Pattern**.

**Sub-directories:**
• **Galaxy** (Flat knowledge graph — **Primary source of truth for all concepts**)
  - *Naming*: `concept-[domain]-[name].md`
  - *Linking*: Heavy use of wikilinks and YAML `related_concepts`.
• **Resources** (Reference material, documentation, research papers)

---

# 02_MACHINE

AI-generated synthesis, drafts, and patterns.

**Sub-directories:**
• **ai-candidates** (Extracted patterns awaiting promotion to Galaxy. Check `Archive/` for history.)
• **Daily** (Daily Master Audits and session reviews)
• **State** (Handovers and `session-state_LATEST.md`)
• **Drafts** (Generated content and templates)

---

# VANTIS_ENGINES

All execution engine repos live at `~/Documents/VANTIS_ENGINES/`. This directory is external to the VANTIS Git repo. Each engine has an Execution/Intelligence Split — raw work stays in the engine repo, validated outputs are promoted to the VANTIS intelligence layer.

**Engines:**
- `revenue-engine/` — market data, scraping, runs, offers, campaigns
- `content-engine/` — raw assets, scripts, analytics exports, draft copy
- `ns-outreach-engine/` — prospect discovery, enrichment, batch message generation

**Agent orientation:** Read `~/Documents/VANTIS_ENGINES/AGENTS.md` first when available. If the engine repo has no shared adapter, read the active provider adapter (`CLAUDE.md`, `GEMINI.md`, or `CODEX.md`).
**Full protocol:** `03_SYSTEM/Protocols/Universals/Rules/EXECUTION_ENGINES.md`

---

# REVENUE_ENGINE

Intelligence layer for the closed-loop revenue system. Raw processing lives in `~/Documents/VANTIS_ENGINES/revenue-engine/` — only distilled outputs are promoted here.

**Sub-directories:**
• **01_MARKETS** (Market profiles and observations)
• **02_DATA_SOURCES** (Scraping source configs — reference only, not raw data)
• **03_INSIGHTS** (Extracted patterns — primary promotion target from execution repo)
• **04_OPPORTUNITIES** (Business ideas derived from insights)
• **05_OFFERS** (Packaged, priced offers ready to sell)
• **06_CAMPAIGNS** (Outreach plans and execution)
• **07_FEEDBACK** (Campaign responses and loop-back to insights)
• **08_DECISIONS** (Decision log with outcomes — authoritative record)
• **_TEMPLATES** (Canonical templates for each layer)
• **_SYSTEM** (Command reference)

**Rules:** Do NOT skip layers. Always populate `03_INSIGHTS` before `04_OPPORTUNITIES` or `05_OFFERS`. See `INTEGRATION.md` for sync protocol.

---

# CONTENT_ENGINE

Intelligence layer for the closed-loop content production system. Raw media files live in `~/Documents/VANTIS_ENGINES/content-engine/` — only structured records, approved artifacts, and validated learnings are promoted here.

**Sub-directories:**
• **01_IDEAS** (Idea intake by use case: brand/, lead-gen/, _backlog/)
• **02_PROMPTS** (Engineered prompts by type: copy/, image/, video/)
• **03_RAW_ASSETS** (Unreviewed generation output records — not raw media files)
• **04_ASSEMBLY** (Post drafts combining copy + visual brief + CTA)
• **05_APPROVED** (Final signed-off artifacts by category: brand/, lead-gen/)
• **06_DISTRIBUTION** (Deployment decision log — not a scheduler; records where artifacts were deployed and why)
• **07_PERFORMANCE** (Engagement signal notes per artifact + `_PATTERNS/` aggregation layer for VANTIS staging)
• **08_REPURPOSING** (Adapted artifacts with provenance tracking via Parent Content ID)
• **_TEMPLATES** (Canonical templates for each stage)
• **_SYSTEM** (Content rules, pipeline rules, VANTIS promotion rules, commands)

**Rules:** Do NOT skip pipeline stages. Raw assets must be reviewed before assembly. Only validated patterns from `07_PERFORMANCE/` are promoted to VANTIS. See `CONTENT_ENGINE/_SYSTEM/pipeline_rules.md` and `_SYSTEM/vantis_promotion_rules.md`.

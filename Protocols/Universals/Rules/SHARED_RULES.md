# V.A.N.T.i.S. SHARED OPERATIONAL RULES

Version: 1.26
Applies To: All V.A.N.T.i.S. Agents (Gemini, Claude, GPT, Local)

---

# [CANONICAL PATHS] External Project Locations
- **Websites-AI Project**: `/Users/REDACTED/websites-AI/` — Web projects, demos, design outputs. Check here first for electrician/plumbing/fencer demo sites.

---

# [EFFICIENCY] CONTEXT & TOKEN HYGIENE
**Protocol: "Insurance, Not a Goal."**
The 1M token window is a safety net; peak reasoning (90%+) occurs in the first 120k tokens.

1.  **LOCAL SECRETS**: API keys and environment variables are managed via `~/.ai-env`. This file MUST be sourced before running build scripts (e.g., OpenRouter).
2.  **THE 12% RULE**: Agents MUST proactively plan a session reset (Summarize -> Clear -> Paste) when context consumption approaches **120,000 tokens**. Do not wait for auto-compaction.
2.  **THE REWIND HABIT (`/re`)**: Prohibit "arguing" with failed logic or low-efficiency attempts. If a prompt or tool call results in junk or logic drift, rewind to the last clean message to prevent context pollution.
3.  **MARKDOWN-FIRST INGESTION**: External assets (PDF, HTML, DOCX) MUST be converted to Markdown (via `Dockling` or similar) before ingestion to reduce token overhead by up to 90%.
4.  **AGENCY CHAINING**: Delegate high-volume research, complex multi-step execution, and quality control to the 7-Skill Master Pattern defined in `03_SYSTEM/Protocols/AGENCY_CHAINING_PROTOCOL.md` to protect the primary orchestrator's reasoning headspace.
5.  **HYGIENE AUDIT**: Run `/context` in fresh sessions to audit for "invisible bloat" in `claude.md` or active MCP tools.

---

# [RESUMPTION] RESUMPTION & HANDOVER PROTOCOL (The "Save Game")
Before taking any action, you MUST:

1.  **Read Session State**:
    - **Preferred path for all providers**: Read `02_MACHINE/State/session-state_LATEST.md` (symlink). If missing or broken, sort `02_MACHINE/State/` by filename descending and read the top result.
    - **Provider note**: If a provider cannot resolve symlinks cleanly, fall back to the latest dated `session-state_YYYY-MM-DD.md`.
2.  **Identify Objective**: Identify the **Active Objective** and **Next Steps**.
3.  **Check Signals**: Check for **SIGNAL** markers (e.g., `WAIT`, `SYNC`) in `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.
4.  **Auto-Resume**: Alternatively, run `/resume` to automate steps 1–3 with a structured orientation brief.

Before terminating a session for handoff:
1.  **Run `/handover`** to persist the current objective, next steps, and context for the next agent.

**Session State Append Rule (Non-Negotiable):**
- Session state files are **APPEND-ONLY** within a calendar day.
- Each agent contribution MUST be a new `## ADDENDUM` section — never a rewrite or overwrite of existing content.
- Exception: The first agent of a new calendar day creates the file fresh using the `SESSION_STATE_TEMPLATE`.
- This ensures the `/eod` audit consolidates a complete, multi-agent audit trail into one master daily review.

---

# [COGNITIVE PROTOCOL] KARPATHY PRINCIPLES
**The Four Pillars of Agent Reasoning** — Applied to all V.A.N.T.i.S. work.
*Foundational from Andrej Karpathy's "A Hackers' Guide to LLMs." Adopted as the core cognitive protocol for all agents.*

These principles form the mental model that guides planning, implementation decisions, and code/system design:

1. **Think Before Coding**: Before writing code, designing systems, or taking action, spend time understanding the problem space, constraints, and desired outcome. Plan rigorously. Invest in clarity upfront to avoid costly rework later.

2. **Simplicity First**: Favor the simplest solution that solves the problem. Do not introduce abstractions, complexity, or "future-proofing" beyond what the current task requires. Resist over-engineering.

3. **Surgical Changes**: Make minimal, targeted changes. Each modification should have one clear purpose. Avoid bundling unrelated work or "while we're here" refactors. This keeps diffs reviewable and rollbacks safe.

4. **Goal-Driven Execution**: Every action should map back to the stated goal. Delete code that doesn't contribute. Avoid side quests. Keep the objective visible and measure progress against it, not against abstract quality metrics.

**How They Apply:**
- **Planning**: Before any multi-step task, articulate the goal, constraints, and minimal viable approach. Write it down.
- **Implementation**: Write the simplest code that achieves the goal. Add comments only when the WHY is non-obvious. Resist refactoring side-quests.
- **Review**: Check that changes are minimal, necessary, and goal-aligned. Question any scope creep.
- Errors: When blocked, revisit the goal. Do not solve the wrong problem elegantly.

---

# [MEMORY] THREE-BUCKET MEMORY MODEL

V.A.N.T.i.S. uses three named memory buckets. All agents must understand which bucket they are reading from or writing to.

| Bucket | Name | Contents | V1 Implementation | Write Path |
|---|---|---|---|---|
| 1 | Session Memory | Per-session recall — context, decisions, steps taken | SQLite+FTS5 (local); Honcho deferred post-sandbox | `/handover` + selective reasoning logs → `02_MACHINE/State/` and `logs/` |
| 2 | Foundational Knowledge | Durable knowledge — Galaxy, research, domain expertise | `private workspace/Knowledge/Galaxy/` (file-based); pgvector post-sandbox | Orchestrator only (subagents BLOCKED) |
| 3 | Strategy Profile | Active strategic state — current objectives, priorities, constraints | `02_MACHINE/State/session-state_LATEST.md` | `/handover` → dated session-state + LATEST symlink |

**Rules:**
- Subagents may READ all three buckets.
- Subagents may NOT write to Bucket 2 (Galaxy is hard-blocked).
- Bucket 1 writes go through the `/handover` command — never directly.
- Bucket 3 is the source of truth for active objectives between sessions.

---

# [ORCHESTRATION] OPENROUTER ROUTING PROTOCOL
OpenRouter is an explicit secondary provider lane inside V.A.N.T.i.S. It serves two distinct purposes:

1.  **Continuity fallback**: When the native Claude lane is blocked by quota, rate limits, or provider instability, continue the task through OpenRouter using an Anthropic model.
2.  **Cost lane**: For bulk drafting, summarization, extraction, or lower-stakes implementation, route to a cheaper OpenRouter model on purpose.
3.  **Build handoff**: For long buildouts or staged implementation runs, keep using the existing OpenRouter handoff flow.

## Lane A - Continuity Fallback
Use when:
- native Claude quota is exhausted
- provider-side rate limits are blocking progress
- task continuity matters more than preserving a provider-native session

Default invocation:
`bash .gemini/hooks/openrouter-build.sh --profile continuity --plan <path_to_plan>`

## Lane B - Cost Lane
Use when:
- the task is high-volume and cost-sensitive
- frontier Anthropic quality is not required
- the output will be reviewed by a primary agent afterward

Default invocation:
`bash .gemini/hooks/openrouter-build.sh --profile cheap --plan <path_to_plan>`

## Lane C - Build Handoff
To optimize for cost and speed during long buildouts, use the existing **OpenRouter Handoff (Option A)**.

1.  **Trigger**: When a primary agent (Claude/Gemini/Codex) completes a complex reasoning/design phase, stage the implementation for OpenRouter.
2.  **Staging**: Write a handoff plan to `02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md` using the template in `03_SYSTEM/Protocols/OPENROUTER_HANDOFF_TEMPLATE.md`.
3.  **Security**: Adhere to the **Zero-Trust Security Checklist**. NO naked URLs, NO API keys, NO financial data in the handoff file.
4.  **Execution**: The user executes the build via: `.gemini/hooks/openrouter-build.sh --plan <path_to_plan>` or an explicit profile/model override.
5.  **Re-Ingestion**: The results of the build are logged to `logs/YYYY-MM-DD/` and should be reviewed/ingested by the primary agent in the next session.

## Routing Rule
- If continuity with Claude behavior matters, prefer an Anthropic model on OpenRouter.
- If throughput and price matter more than model parity, prefer a cheaper OpenRouter profile.
- If the work is long-running and pre-scoped, use the staged handoff file rather than ad hoc prompts.

---

# [GOVERNANCE] GLOBAL AGENT MANDATES
**These rules apply to all agents at all times. Failure to comply constitutes a governance violation.**
*Note: Update compact summaries in adapters (`CLAUDE.md`, `GEMINI.md`, `CODEX.md`) when changing mandates.*

1.  **STRICT FINALITY (LOG REFLEX)**: No interaction turn may conclude after meaningful vault, system, or protocol changes without either:
    - a reasoning log in `logs/YYYY-MM-DD/`, or
    - an explicit handoff/state artifact when continuity is the only missing context.
    Routine low-context edits may rely on Git history plus lightweight hook telemetry and do not require an automatic Git-derived session audit.
    - *Tip: If mutating files via shell (sed, rm, etc.), include `# [FILE] path` in your command to ensure the session-ledger hook captures the change correctly.*
2.  **NO GALAXY WRITES**: Agents are strictly prohibited from writing or moving files into `private workspace/Knowledge/Galaxy`. All synthesis must land in `02_MACHINE` for human verification.
3.  **METADATA v1.5**: All proposed knowledge nodes MUST follow the schema in `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
    - **Note on Technical Files**: For `.gemini/agents/*.md` or `SKILL.md` files, metadata MUST be placed in Markdown **below** the YAML frontmatter block. Placing V.A.N.T.i.S. metadata (like `Version`) inside the YAML delimiters (`---`) will crash the Gemini CLI boot sequence.
4.  **ASV REFLEX**: Before finalizing any interaction turn that involves system-level modifications (Tier 1, 2, or 3), the agent MUST execute the Automated System Versioning hook: `node .gemini/hooks/version-incrementer.js <file_path>`.
5.  **AGENCY CHAINING**: All multi-agent/high-stakes tasks MUST follow the R-E-V-R cycle defined in `03_SYSTEM/Protocols/AGENCY_CHAINING_PROTOCOL.md`.
6.  **PLAN BEFORE EXECUTION**: For operations affecting multiple files or system architecture, agents MUST create a plan, request approval, and execute on a dedicated Git branch (Rule 11).
7.  **SKILL TRIGGERS**: Agents MUST proactively consult the **Skill Trigger Matrix** below and load required skills using provider-native mechanics before execution.

---

# [TRIGGERS] SKILL TRIGGER MATRIX
Agents MUST proactively load and follow the relevant skill instructions based on the following task intents. If the active agent has a native skill activation tool, use it. Otherwise, manually read the skill file and execute according to its protocol.

| Task Intent | Trigger Skill |
| :--- | :--- |
| **Core Master Skills (ACP)** | |
| Orchestrate multi-agent tasks, route work, or perform initial planning | `parent-orchestrator-qa` |
| Execute parallel research or decompose broad tasks into MECE questions | `fan-out` |
| Resolve ambiguity or find robust conclusions across multiple attempts | `stochastic-consensus` |
| Stress-test strategic claims through adversarial critique and red-teaming | `structured-debate` |
| Execute ordered, multi-stage specialist tasks with validated handoffs | `sequential-pipeline` |
| Perform independent quality audits on completed work-products | `parent-orchestrator-qa` |
| Score outputs against a rubric and determine pass/fail or next skill | `evaluator-judge` |
| **System & Architecture** | |
| Modify System Architecture, Protocols, or Rules | `architectural-designer` |
| Draft or optimize LinkedIn content | `linkedin-content-generation`, `precedent-detection`, `linkedin-os` |
| Process items from `private workspace/Inbox` or analyze research | `inbox-processor`, `concept-extraction` |
| Process structured AI chat exports from `private workspace/Inbox` | `structured-inbox-project-router` |
| Convert raw insights into permanent concepts or detect orphan notes | `memory-curator` |
| Identify cross-domain synergies or map conceptual precedents | `concept-mapper` |
| Execute Git Branching, Commits, or PRs | `github-ops` |
| Finalize meaningful changes that need rationale, risks, or handoff context | `audit-logger` |
| **Business & Commercial Intelligence** | |
| Analyse financial statements, build valuation/DCF model, budget variance | `financial-analyst` |
| Design pricing tiers, optimise pricing page, SaaS monetisation strategy | `pricing-strategy` |
| Analyse sales pipeline, revenue forecasting, GTM efficiency metrics | `revenue-operations` |
| Analyse competitors, build battlecard, track market positioning | `competitive-intel` |
| Deep competitor product teardown, quarterly competitive review | `competitive-teardown` |
| Plan product launch, go-to-market strategy, Product Hunt execution | `launch-strategy` |
| Write B2B cold outreach emails or prospecting sequences | `cold-email` |
| **Product & Research** | |
| Write product spec, prioritise backlog, define user stories, PM decisions | `product-manager` |
| Validate product idea, map assumptions, run discovery sprint | `product-discovery` |
| Define product KPIs, cohort analysis, retention analysis, feature adoption | `product-analytics` |
| User research, persona creation, journey mapping, usability testing | `ux-researcher-designer` |
| Customer health scoring, churn risk assessment, expansion opportunities | `customer-success-manager` |
| **Engineering & Architecture** | |
| Design REST API, database architecture, authentication, microservices | `senior-backend` |
| Scaffold a new SaaS or Next.js project, wire auth and payments | `saas-scaffolder` |
| Review or audit an API design or REST spec | `api-design-reviewer` |
| Review code quality, analyse PR, identify code smells or SOLID violations | `code-reviewer` |
| Deep PR review for security issues and architectural concerns | `pr-review-expert` |
| Track technical debt, code quality assessment, plan a cleanup sprint | `tech-debt-tracker` |
| Build a CI/CD pipeline or set up GitHub Actions | `ci-cd-pipeline-builder` |
| **Security** | |
| Audit AI/ML system for prompt injection, adversarial robustness, MITRE ATLAS mapping | `ai-security` |
| Audit cloud infrastructure, IAM permissions, GCP/AWS/Azure security posture | `cloud-security` |
| **SEO & Analytics** | |
| Set up GA4/GTM tracking, debug missing events, build a tracking plan | `analytics-tracking` |
| Build programmatic SEO pages at scale — directory, location, comparison pages | `programmatic-seo` |
| **Landing Pages & Prompts** | |
| Create a marketing or lead-capture landing page | `landing-page-generator`, `rapid-website-workflow` |
| Improve prompts, create prompt templates, optimise AI content workflow | `prompt-engineer-toolkit` |
| Manage prompts in production — versioning, A/B testing, eval pipelines | `prompt-governance` |
| **Agent & Workflow Design** | |
| Design a multi-agent system or agent architecture | `agent-designer` |
| Design agent workflow coordination and orchestration patterns | `agent-workflow-designer` |
| **Operations & Project Health** | |
| Check project health, generate portfolio risk matrix | `project-health` |
| Run a postmortem, analyse an incident, review what went wrong | `postmortem` |
| Generate changelog or release notes from git history | `changelog-generator` |
| Log or review strategic/board decisions and action items | `decision-logger` |
| Respond to RFP/RFI, build feature comparison matrix, plan a sales POC | `sales-engineer` |
| **Standalone Skills** | |
| Audit session context window consumption across agents and protocols | `context-budget` |
| Run quality gate before merging — lint, protocol compliance, security scan | `verify` |
| Capture an architectural decision as a structured ADR | `architecture-decision-records` |

---

# [TOOLCHAIN] EXECUTION ENGINE REGISTRY
> **Canonical source:** `03_SYSTEM/Protocols/Universals/Rules/EXECUTION_ENGINES.md` — **READ before any work involving market analysis, content production, or outreach.**

All execution engines live at `~/Documents/VANTIS_ENGINES/`. The root `AGENTS.md` there should orient any agent to all engines and the pattern for adding new ones. If an engine lacks `AGENTS.md`, use the active provider adapter (`CLAUDE.md`, `GEMINI.md`, or `CODEX.md`).

| Engine | Execution Repo | Purpose |
| :--- | :--- | :--- |
| **REVENUE_ENGINE** | `~/Documents/VANTIS_ENGINES/revenue-engine/` | Market data → validated offers → outreach campaigns |
| **CONTENT_ENGINE** | `~/Documents/VANTIS_ENGINES/content-engine/` | Ideas → approved content artifacts → performance data |
| **NS_OUTREACH_ENGINE** | `~/Documents/VANTIS_ENGINES/ns-outreach-engine/` | Prospect discovery → enrichment → outreach batch generation |

**Key rules (full protocol in EXECUTION_ENGINES.md):**
1. All engines use an Execution/Intelligence Split. Raw work stays in the execution repo. Only validated outputs are promoted to VANTIS.
2. REVENUE_ENGINE pipeline stages are mandatory and sequential — no skipping.
3. CONTENT_ENGINE sessions are strictly typed (Idea / Production / Review / Performance).
4. The engines feed each other — content ideas should derive from revenue market runs.
5. Service-first constraint: any product/SaaS idea must be converted to a done-for-you service before productizing.

---

# [COLLABORATION] UNIFIED INTEROPERABILITY
V.A.N.T.i.S. is model-agnostic. To coordinate with peer agents:

1.  **Shared Context**: All agents use the same directory structure and core protocols.
2.  **Hand-offs**: State transitions are managed via `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md`.
3.  **State Persistence**: Update the latest `session-state_YYYY-MM-DD.md` before terminating a turn if a hand-off is occurring.
4.  **Concurrency**: Agents operating in parallel MUST use separate Git branches or worktrees to prevent collisions.

---

# [OPERATIONS] DEVELOPMENT LIFECYCLE (The 5-Step Loop)
1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using available tools.
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a reasoning log or handoff artifact when the change requires rationale, risks, or continuity context.
5. **HANDOFF**: Run `/handover` to persist state for the next session.

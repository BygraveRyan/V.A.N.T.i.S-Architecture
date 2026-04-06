# V.A.N.T.i.S. SHARED OPERATIONAL RULES

Version: 1.9
Applies To: All V.A.N.T.i.S. Agents (Gemini, Claude, GPT, Local)

---

# [RESUMPTION] RESUMPTION & HANDOVER PROTOCOL (The "Save Game")
Before taking any action, you MUST:

1.  **Read Session State**: 
    - **Gemini**: Read `02_MACHINE/State/session-state_LATEST.md` (symlink). If missing, sort `02_MACHINE/State/` by filename descending and read the top result.
    - **Claude**: Sort `02_MACHINE/State/` by filename descending and read the top result.
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

# [GOVERNANCE] GLOBAL AGENT MANDATES
**These rules apply to all agents at all times. Failure to comply constitutes a governance violation.**
*Note: Update compact summaries in adapters (CLAUDE.md/GEMINI.md) when changing mandates.*

1.  **STRICT FINALITY (LOG REFLEX)**: No interaction turn may conclude if file modifications or creations have occurred without a corresponding high-fidelity audit log being generated in the `logs/YYYY-MM-DD/` directory.
    - *Tip: If mutating files via shell (sed, rm, etc.), include `# [FILE] path` in your command to ensure the session-ledger hook captures the change correctly.*
2.  **NO GALAXY WRITES**: Agents are strictly prohibited from writing or moving files into `01_HUMAN/Knowledge/Galaxy`. All synthesis must land in `02_MACHINE` for human verification.
3.  **METADATA v1.5**: All proposed knowledge nodes MUST follow the schema in `03_SYSTEM/Protocols/METADATA_SCHEMA.md`.
4.  **ASV REFLEX**: Before finalizing any interaction turn that involves system-level modifications (Tier 1, 2, or 3), the agent MUST execute the Automated System Versioning hook: `node .gemini/hooks/version-incrementer.js <file_path>`.
5.  **PLAN BEFORE EXECUTION**: For operations affecting multiple files or system architecture, agents MUST create a plan, request approval, and execute on a dedicated Git branch (Rule 11).
6.  **SKILL TRIGGERS**: Agents MUST proactively consult the **Skill Trigger Matrix** below and activate required skills based on task intent before execution.

---

# [TRIGGERS] SKILL TRIGGER MATRIX
Agents MUST proactively load and follow the relevant skill instructions based on the following task intents. If the active agent has a native skill activation tool, use it. Otherwise, manually read the skill file and execute according to its protocol.

| Task Intent | Trigger Skill |
| :--- | :--- |
| Modify System Architecture, Protocols, or Rules | `architectural-designer` |
| Draft or optimize LinkedIn content | `linkedin-content-generation`, `precedent-detection` |
| Process items from `01_HUMAN/Inbox` or analyze research | `inbox-processor`, `concept-extraction` |
| Convert raw insights into permanent concepts or detect orphan notes | `memory-curator` |
| Identify cross-domain synergies or map conceptual precedents | `concept-mapper` |
| Execute Git Branching, Commits, or PRs | `github-ops` |
| Finalize a turn involving file modifications | `audit-logger` |
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
| Create a marketing or lead-capture landing page | `landing-page-generator` |
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
4. **LOG**: Create a high-fidelity audit log.
5. **HANDOFF**: Run `/handover` to persist state for the next session.

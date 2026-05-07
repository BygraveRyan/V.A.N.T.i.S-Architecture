# Task: Expand Skill Trigger Matrix
**Status**: Ready to Execute
**Branch**: `feat/expand-skill-trigger-matrix`
**Assigned To**: Gemini CLI (or any agent)

## Context
33 new skills were added to `.gemini/skills/` but none are registered in the Skill Trigger Matrix in `SHARED_RULES.md`. Without matrix entries, no agent will proactively load these skills based on task context. This task adds all 33 to the matrix, organised by category.

## Files to Change

| File | Change Type |
|------|-------------|
| `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` | **Primary** — expand `[TRIGGERS] SKILL TRIGGER MATRIX` with 33 new rows, grouped by category |
| `AGENTS.md` | **Review only** — check `[SYSTEM] SKILLS VS SUBAGENTS` section; no change expected |

**Not changing:** `CLAUDE.md`, `GEMINI.md`, `CODEX.md` — these only contain a one-line Rule 6 pointer to `SHARED_RULES.md`.

## Implementation

### Step 1 — Edit SHARED_RULES.md

Locate the existing `[TRIGGERS] SKILL TRIGGER MATRIX` table (currently 7 rows) and expand it in-place. Keep all 7 existing rows. Add new rows grouped under category sub-headers for scannability.

**New rows to add:**

**Business & Commercial Intelligence**
| Analyse financial statements, build valuation/DCF model, budget variance | `financial-analyst` |
| Design pricing tiers, optimise pricing page, SaaS monetisation strategy | `pricing-strategy` |
| Analyse sales pipeline, revenue forecasting, GTM efficiency metrics | `revenue-operations` |
| Analyse competitors, build battlecard, track market positioning | `competitive-intel` |
| Deep competitor product teardown, quarterly competitive review | `competitive-teardown` |
| Plan product launch, go-to-market strategy, Product Hunt execution | `launch-strategy` |
| Write B2B cold outreach emails or prospecting sequences | `cold-email` |

**Product & Research**
| Write product spec, prioritise backlog, define user stories, PM decisions | `product-manager` |
| Validate product idea, map assumptions, run discovery sprint | `product-discovery` |
| Define product KPIs, cohort analysis, retention analysis, feature adoption | `product-analytics` |
| User research, persona creation, journey mapping, usability testing | `ux-researcher-designer` |
| Customer health scoring, churn risk assessment, expansion opportunities | `customer-success-manager` |

**Engineering & Architecture**
| Design REST API, database architecture, authentication, microservices | `senior-backend` |
| Scaffold a new SaaS or Next.js project, wire auth and payments | `saas-scaffolder` |
| Review or audit an API design or REST spec | `api-design-reviewer` |
| Review code quality, analyse PR, identify code smells or SOLID violations | `code-reviewer` |
| Deep PR review for security issues and architectural concerns | `pr-review-expert` |
| Track technical debt, code quality assessment, plan a cleanup sprint | `tech-debt-tracker` |
| Build a CI/CD pipeline or set up GitHub Actions | `ci-cd-pipeline-builder` |

**Security**
| Audit AI/ML system for prompt injection, adversarial robustness, MITRE ATLAS mapping | `ai-security` |
| Audit cloud infrastructure, IAM permissions, GCP/AWS/Azure security posture | `cloud-security` |

**SEO & Analytics**
| Set up GA4/GTM tracking, debug missing events, build a tracking plan | `analytics-tracking` |
| Build programmatic SEO pages at scale — directory, location, comparison pages | `programmatic-seo` |

**Landing Pages & Prompts**
| Create a marketing or lead-capture landing page | `landing-page-generator` |
| Improve prompts, create prompt templates, optimise AI content workflow | `prompt-engineer-toolkit` |
| Manage prompts in production — versioning, A/B testing, eval pipelines | `prompt-governance` |

**Agent & Workflow Design**
| Design a multi-agent system or agent architecture | `agent-designer` |
| Design agent workflow coordination and orchestration patterns | `agent-workflow-designer` |

**Operations & Project Health**
| Check project health, generate portfolio risk matrix | `project-health` |
| Run a postmortem, analyse an incident, review what went wrong | `postmortem` |
| Generate changelog or release notes from git history | `changelog-generator` |
| Log or review strategic/board decisions and action items | `decision-logger` |
| Respond to RFP/RFI, build feature comparison matrix, plan a sales POC | `sales-engineer` |

**Standalone Skills (missing from matrix)**
| Audit session context window consumption across agents and protocols | `context-budget` |
| Run quality gate before merging — lint, protocol compliance, security scan | `verify` |
| Capture an architectural decision as a structured ADR | `architecture-decision-records` |

### Step 2 — Run ASV Reflex
`SHARED_RULES.md` is a Tier 1 system file. After editing, run:
```
node .gemini/hooks/version-incrementer.js 03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md
```

### Step 3 — Write Audit Log
Per LOG REFLEX mandate, write an audit entry to `logs/YYYY-MM-DD/`.

### Step 4 — Review AGENTS.md
Read the `[SYSTEM] SKILLS VS SUBAGENTS` section. If it only describes the distinction generically, no change needed.

## Verification
1. `SHARED_RULES.md` matrix has all 7 original rows + 33 new rows grouped by category
2. Grep confirms new skill names appear (e.g. `pricing-strategy`, `senior-backend`)
3. ASV reflex incremented the file version
4. Audit log written

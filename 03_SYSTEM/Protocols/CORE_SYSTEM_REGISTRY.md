# CORE SYSTEM REGISTRY (CSR)
Version: 1.0.16

This registry defines the **Watch List** for the V.A.N.T.i.S. Automated System Versioning (ASV) engine. Files listed here will have their `Version: X.Y.Z` metadata incremented automatically upon modification.

---

## [OPERATIONS] TIER 1: THE ENGINE
*High-level identity and operational protocols. Increments Major.Minor (e.g., 1.1 -> 1.2).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `GEMINI.md` | Intelligence Layer Core | Major.Minor |
| `CLAUDE.md` | Claude Layer Core | Major.Minor |
| `CODEX.md` | Codex Layer Core | Major.Minor |
| `RULES.md` | System Guardrails | Major.Minor |
| `AGENTS.md` | Agent Definitions | Major.Minor |
| `VAULT_MAP.md` | Directory Architecture | Major.Minor |
| `BOOT_IMAGE.md` | Identity Layer | Major.Minor |
| `CHANGELOG.md` | System History | Major.Minor |

---

## [LOGS] TIER 2: PROTOCOLS
*Standard specifications for data and knowledge flow. Increments Major.Minor (e.g., 1.0 -> 1.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `03_SYSTEM/Protocols/METADATA_SCHEMA.md` | Galaxy Metadata Spec | Major.Minor |
| `03_SYSTEM/Protocols/MACHINE_LAYER_PROTOCOL.md` | AI Execution Sandbox Rules | Major.Minor |
| `03_SYSTEM/Protocols/AGENT_PERMISSIONS.md` | Domain Restrictions | Major.Minor |
| `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md` | Signal Interpretation | Major.Minor |
| `03_SYSTEM/Protocols/CONCEPT_NAMING_PROTOCOL.md` | Naming Standards | Major.Minor |
| `03_SYSTEM/Protocols/GALAXY_LINKING_RULES.md` | Graph Logic | Major.Minor |
| `03_SYSTEM/Protocols/VANTIS_DIAGNOSTIC_PROTOCOL.md` | System Health Check | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md` | Shared Operational Rules | Major.Minor |
| `03_SYSTEM/Protocols/Universals/architect.md` | Architect Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/strategist.md` | Strategist Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/researcher.md` | Researcher Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/guardian.md` | Guardian Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/Knowledge_Architect.md` | Knowledge Architect Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/Memory_Curator.md` | Memory Curator Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/Inbox_Processor.md` | Inbox Processor Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/Security_Architect.md` | Security Architect Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/Research_Analyst.md` | Research Analyst Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/Roles/LinkedIn_Strategist.md` | LinkedIn Strategist Role | Major.Minor |
| `03_SYSTEM/Protocols/Universals/aliases.sh` | Role Shell Aliases | Major.Minor |

---

## [STRUCTURE] TIER 3: LOGIC & UI
*Templates, dashboards, and automated scaffolding. Increments Patch (e.g., 1.0.0 -> 1.0.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `03_SYSTEM/Protocols/GALAXY_NOTE_TEMPLATE.md` | Note Structure | Patch |
| `03_SYSTEM/Protocols/SESSION_STATE_TEMPLATE.md` | Session Logic | Patch |
| `03_SYSTEM/Protocols/LINKEDIN_POST_TEMPLATE.md` | Content Structure | Patch |
| `03_SYSTEM/Protocols/DYNAMIC_GALAXY_SCAFFOLDER.md` | Templater Logic | Patch |
| `03_SYSTEM/Protocols/System_Intelligence_Center.md` | Dataview Dashboard | Patch |
| `03_SYSTEM/ADRs/README.md` | Decision Log | Patch |
| `03_SYSTEM/Roadmap/VANTIS_Upgrade_Dashboard.md` | System Roadmap | Patch |
| `03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md` | This File | Patch |
| `.gemini/SKILLS_INDEX.md` | Skills Discovery Index | Patch |

---

## [TRIGGERS] TIER 4: SKILLS
*Modular system capabilities. Increments Patch (e.g., 1.0.0 -> 1.0.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `.gemini/skills/architectural-designer/SKILL.md` | System Planning | Patch |
| `.gemini/skills/audit-logger/SKILL.md` | Log Reflex | Patch |
| `.gemini/skills/concept-extraction/SKILL.md` | Principle Extraction | Patch |
| `.gemini/skills/concept-mapper/SKILL.md` | Similarity Scans | Patch |
| `.gemini/skills/github-ops/SKILL.md` | GitHub CLI Operations | Patch |
| `.gemini/skills/inbox-processor/SKILL.md` | Information Routing | Patch |
| `.gemini/skills/linkedin-content-generation/SKILL.md` | Content Strategy | Patch |
| `.gemini/skills/memory-curator/SKILL.md` | Galaxy Promotion | Patch |
| `.gemini/skills/precedent-detection/SKILL.md` | Concept Matching | Patch |

---

## [INTERFACE] TIER 5: AGENT LAYERS
*Agent-native configuration and commands. Increments Patch (e.g., 1.0.0 -> 1.0.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `.claude/settings.local.json` | Claude Code hooks and permissions | Patch |
| `.claude/commands/resume.md` | Deterministic session resumption command | Patch |
| `.claude/commands/daily.md` | Daily session review command | Patch |
| `.claude/commands/eod.md` | End-of-day master audit command | Patch |
| `.claude/commands/inbox.md` | Inbox audit and routing command | Patch |
| `.claude/commands/gh/pr.md` | PR review command | Patch |
| `.claude/commands/gh/issue.md` | Issue management command | Patch |
| `.claude/commands/gh/pulse.md` | Pulse sync backup command | Patch |
| `.claude/commands/gh/publish.md` | Portfolio mirror deploy command | Patch |
| `.claude/agents/architect.md` | Claude Architect Subagent | Patch |
| `.claude/agents/strategist.md` | Claude Strategist Subagent | Patch |
| `.claude/agents/researcher.md` | Claude Researcher Subagent | Patch |
| `.claude/agents/guardian.md` | Claude Guardian Subagent | Patch |
| `.codex/settings.json` | Codex CLI hooks and command configuration | Patch |
| `.codex/commands/resume.md` | Codex deterministic session resumption command | Patch |
| `.codex/commands/handover.md` | Codex handover command | Patch |
| `.codex/commands/daily.md` | Codex daily session review command | Patch |
| `.codex/commands/eod.md` | Codex end-of-day master audit command | Patch |
| `.codex/commands/inbox.md` | Codex inbox audit and routing command | Patch |
| `.codex/commands/context-budget.md` | Codex context budget audit command | Patch |
| `.codex/commands/gh-pr.md` | Codex PR review alias command | Patch |
| `.codex/commands/gh-issue.md` | Codex issue management alias command | Patch |
| `.codex/commands/gh-pulse.md` | Codex pulse sync alias command | Patch |
| `.codex/commands/gh-publish.md` | Codex portfolio mirror alias command | Patch |
| `.codex/commands/gh/pr.md` | Codex PR review nested command | Patch |
| `.codex/commands/gh/issue.md` | Codex issue management nested command | Patch |
| `.codex/commands/gh/pulse.md` | Codex pulse sync nested command | Patch |
| `.codex/commands/gh/publish.md` | Codex portfolio mirror nested command | Patch |
| `.gemini/agents/architect.md` | Gemini Architect Subagent | Patch |
| `.gemini/agents/strategist.md` | Gemini Strategist Subagent | Patch |
| `.gemini/agents/researcher.md` | Gemini Researcher Subagent | Patch |
| `.gemini/agents/guardian.md` | Gemini Guardian Subagent | Patch |
| `.gemini/settings.json` | Gemini CLI configuration | Patch |

---

## [GOVERNANCE] EXCLUSIONS
- All files in `03_SYSTEM/Protocols/Archive/` are frozen and will NOT be incremented.
- `README.md` is excluded (Public Portfolio use only).
- All non-markdown files.

---
*Managed by V.A.N.T.i.S. ASV Hook | Updated: 2026-03-28*

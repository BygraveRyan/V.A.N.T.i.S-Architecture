# PROJECT: VANTIS Multi-Universal Upgrade

**Status:** ⬜ Planned (On Hold)  
**Layer:** Intelligence & Agent  
**Goal:** Transition from single-agent to multi-agent cognitive orchestration.

---

## 🚀 STRATEGIC MOTIVATION (WHY)

As the VANTIS vault grows, a single-agent model faces "context fatigue" and "privilege bloat." 

The **Multi-Universal Upgrade** introduces specialized agent roles to:
- **Increase Precision:** Narrowly scoped prompts for specific tasks.
- **Enforce Security:** Limit tool access (e.g., shell commands) based on agent role.
- **Improve Auditability:** Trace which specific sub-agent made a decision.
- **Enable Self-Correction:** One agent can peer-review another's output.

---

## 🏗️ ARCHITECTURAL DESIGN (HOW)

The system shifts to a **Council of Universals** model:

| Universal | Responsibility | Tool Access |
| :--- | :--- | :--- |
| **THE ARCHITECT** | System rules, Vault structure, Logging. | `write_file`, `replace`, `run_shell_command` (restricted) |
| **THE STRATEGIST** | Project planning, LinkedIn, Strategic Signals. | `read_file`, `grep_search`, `google_web_search` |
| **THE RESEARCHER** | Tech docs, API analysis, Knowledge promotion. | `mcp_context7`, `find-docs`, `google_web_search` |
| **THE GUARDIAN** | Security audit, PII/Secret scanning, Permissions. | `mcp_github_run_secret_scanning`, `read_file` (.env) |

---

## 📅 PHASED IMPLEMENTATION (STEADY PROGRESS)

To avoid a "large leap," the upgrade is broken into three distinct, reversible phases.

### PHASE 1: FOUNDATION (SIGNAL & TRACEABILITY)
*Goal: Prepare the system for multi-agent handoffs.*
- [ ] **Standardize Signal Protocol:** Mature the `SIGNAL_PROTOCOL.md` to include "Agent Handoff" signals.
- [x] **Agent Persona Library:** `03_SYSTEM/Protocols/Universals/` created with 4 placeholder role files (Architect, Strategist, Researcher, Guardian). Full context authoring remaining — see `Task_Improvement_Sprint_P1-P13.md` § P8. *(2026-03-27)*
- [x] **Skills vs Subagents distinction:** Formalised in `AGENTS.md` with Council tool scope table. *(2026-03-27)*
- [ ] **Traceability Audit:** Ensure 100% of today's logs use the new "Agent" field correctly.

### PHASE 2: ROLE DELEGATION (PILOT)
*Goal: Test specialized agents for non-critical tasks.*
- [ ] **The Strategist Pilot:** Assign all LinkedIn content generation and project roadmapping to the "Strategist" persona.
- [ ] **The Researcher Pilot:** Assign all `mcp_context7` calls and technical research tasks to the "Researcher" persona.
- [ ] **Validation:** Compare the quality of output from specialized agents vs. the generalist.

### PHASE 3: ORCHESTRATION & SECURITY
*Goal: Enforce strict role boundaries and automated peer-review.*
- [ ] **The Guardian Enforcer:** Implement a skill that automatically scans all proposed `run_shell_command` calls for high-risk patterns.
- [ ] **Recursive Review Workflow:** Establish a protocol where **The Architect** must review any change to `03_SYSTEM/Protocols` proposed by another agent.
- [ ] **Full Multi-Agent Loop:** Move the `/daily` command from a general prompt to a multi-agent synthesis (Strategist identifies signals → Architect updates state).

---

## ⚠️ RISK MITIGATION

- **Safe Points:** Every phase transition will be marked with a `git commit` to allow 1-click rollback.
- **Privacy:** All sub-agent reasoning remains local.
- **Scope Creep:** Each phase must be fully validated before starting the next.

---

## 📋 NEXT ACTIONS

1. **Phase 1 Initiation:** Refine the `SIGNAL_PROTOCOL.md` to support handoffs.
2. **Persona Drafting:** Define the "Strategist" persona in `03_SYSTEM/Protocols`.

---

## 🔗 RELATED CONCEPTS
- [[concept-ai-native-engineering]]
- [[concept-ai-native-security]]
- [[SIGNAL_PROTOCOL]]

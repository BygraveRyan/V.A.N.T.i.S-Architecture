# V.A.N.T.i.S. Council Orchestration Protocol

Version: 1.0.0
Status: Active (Phase 5)
Applies To: All multi-role agent sessions

---

## [OVERVIEW] OVERVIEW
The Council Orchestration Protocol governs the interaction between specialized subagents (Universals) during complex tasks. It ensures architectural integrity through mandatory "Lead/Validator" pairings and role-specific gates.

---

## [COLLABORATION] 1. LEAD/VALIDATOR PAIRING
For tasks requiring high architectural or security oversight, agents MUST operate in a pairing:

| Task Complexity | Lead Role | Validator Role |
| :--- | :--- | :--- |
| **Architectural Change** (Tier 1-3) | Architect | Strategist |
| **New Feature Implementation** | Strategist | Architect |
| **Research & Synthesis** | Researcher | Strategist |
| **Security/Network Operations** | Lead Agent | Guardian |

### Roles & Responsibilities:
- **Lead Agent**: Responsible for primary execution, drafting plans, and writing code.
- **Validator Agent**: Responsible for reviewing the Lead's output against protocols, security standards, and architectural alignment.

---

## [GOVERNANCE] 2. MANDATORY GATES (TRIGGER EVENTS)
Certain actions trigger a mandatory role switch or review:

### A. Architectural Gate
- **Trigger**: Any modification to `03_SYSTEM/Protocols/`, `GEMINI.md`, `CLAUDE.md`, or `AGENTS.md`.
- **Enforcement**: The **Architect** role MUST be activated to review the plan BEFORE execution.

### B. Security Gate
- **Trigger**: Any shell command involving `curl`, `wget`, `ssh`, or destructive file operations (`rm -rf` on system dirs).
- **Enforcement**: The **Guardian** role MUST be activated to validate the command's safety.

### C. Synthesis Gate
- **Trigger**: Moving data from `[REDACTED_PERSONAL_VAULT]/Inbox/` to `[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy`.
- **Enforcement**: The **Researcher** role MUST validate the metadata compliance (v1.5) before the move.

---

## [POSTURE] 3. DYNAMIC ROLE POSTURES
When a role is activated (via `activate_skill` or subagent call), the agent MUST adopt the corresponding **Posture** and **Decision Patterns** defined in `03_SYSTEM/Protocols/Universals/<role>.md`.

### Activation Flow:
1. **Trigger**: Intent identified (e.g., "I need to refactor the protocol").
2. **Switch**: Agent calls `activate_skill` for the required role.
3. **Posture Injection**: The agent explicitly acknowledges the new role's constraints (e.g., "Architect posture adopted. Evaluating protocol symmetry.").

---

## [RESUMPTION] 4. ESCALATION PATHS
If a conflict arises between the Lead and Validator:
1. **Consensus Search**: Attempt to align via an ADR (Architecture Decision Record).
2. **Human-in-the-Loop (HITL)**: If no consensus, the agent MUST pause and ask the user for a tie-breaking decision.

---
*V.A.N.T.i.S. Council Orchestration Protocol | Phase 5 Implementation*

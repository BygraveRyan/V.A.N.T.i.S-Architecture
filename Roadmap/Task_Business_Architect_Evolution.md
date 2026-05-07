# Task: Business Architect Evolution (v3 - Galaxy Integration)

## 1. Background & Motivation
The current "Strategist" role is focused on high-level leverage and LinkedIn content but lacks a formal framework for identifying revenue opportunities ("Clogs-to-Cash") within the vault. By integrating established business frameworks (e.g., Nate Herk's "5 AI Automations", Jack's models), we transform the Strategist into a **Business Architect** capable of scanning knowledge for actionable business systems.

## 2. Scope & Impact
- **Tier 1**: `AGENTS.md`, `VAULT_MAP.md` (Routing).
- **Tier 2**: `03_SYSTEM/Protocols/Universals/strategist.md`, new `03_SYSTEM/Protocols/Universals/Roles/Business_Architect.md`.
- **Tier 5**: `.gemini/agents/strategist.md` (Tool scope expansion).
- **Knowledge**: `private workspace/Business/Frameworks/` (Reference sources).

## 3. Proposed Solution
- **The Galaxy as the "Market"**: The Business Architect is now mandated to perform recursive `grep_search` and `glob` scans across `private workspace/Knowledge/Galaxy/` to find connections between disparate concepts.
- **New Output Zone**: Create `02_MACHINE/Business_Synthesis/` as the primary staging area for "Clogs-to-Cash" reports.
- **Proactive Hook (The "Clog Scanner")**: Update the Strategist persona to run a "Business Framework Filter" every time a new note is processed in `private workspace/Inbox/`.
- **Candidate Feedback Loop**: When the Business Architect finds a business opportunity, it will check if the underlying *concepts* are already in the Galaxy. If not, it will stage **Concept Candidates** in `02_MACHINE/ai-candidates/`.

## 4. Implementation Steps
### Phase 1: Structural Setup
- [ ] Create `02_MACHINE/Business_Synthesis/` directory.
- [ ] Update `03_SYSTEM/Protocols/MACHINE_LAYER_PROTOCOL.md` to formally register this new sub-directory.

### Phase 2: Protocol Updates (Tier 2)
- [ ] Update `03_SYSTEM/Protocols/Universals/strategist.md` with "Business Architect" persona.
- [ ] Create `03_SYSTEM/Protocols/Universals/Roles/Business_Architect.md` for detailed business logic.
- [ ] ASV reflex on all protocol changes.

### Phase 3: Agent Configuration (Tier 5 & Tier 1)
- [ ] Update `.gemini/agents/strategist.md` (and Claude equivalent) with new tool permissions.
- [ ] Update `AGENTS.md` to reflect the evolved role name/objective.

### Phase 4: Routing & Discovery (Tier 1)
- [ ] Update `VAULT_MAP.md` Routing Table with "Business Discovery" intent.

## 5. Verification & Testing
- [ ] **Validation**: Simulate a "Clog" note in the Inbox and ensure the Strategist automatically drafts a report in the correct location.
- [ ] **Galaxy Integration**: Ask the Strategist to find a business opportunity using at least 3 unrelated Galaxy concepts.

## 6. Rollback Strategy
- [ ] Revert `strategist.md` to Version 1.1.0 using git checkout.
- [ ] Delete new `02_MACHINE/Business_Synthesis/` directory.
- [ ] Revert `AGENTS.md` and `VAULT_MAP.md`.

---
*Created: 2026-04-01 | Agent: Gemini (Architect Mode)*

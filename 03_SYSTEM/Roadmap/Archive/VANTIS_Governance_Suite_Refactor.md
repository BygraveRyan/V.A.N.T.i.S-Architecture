# Plan: V.A.N.T.i.S. Governance Suite Refactor

## Objective
Standardize VANTIS governance by aligning core instructions with automated "reflexes," implementing a persistent session state protocol, and refining the knowledge lineage schema for the Galaxy.

## Background & Motivation
VANTIS has evolved from a manual, protocol-heavy system to a more automated engine. However, the core instruction files (`GEMINI.md`, `RULES.md`) and commands (`/eod`, `/resume`) still contain legacy logic that doesn't fully leverage the new automated hooks (ASV) or persistent state capabilities. This refactor will close the loop between "Policy" and "Execution."

## Scope & Impact
- **Instructional Layer**: `GEMINI.md`, `RULES.md`, `GOVERNANCE.md`.
- **Command Layer**: `.gemini/commands/eod.toml`, `.gemini/commands/resume.toml`.
- **Memory Layer**: Creation of `02_MACHINE/State/` and session templates.
- **Knowledge Layer**: `03_SYSTEM/Protocols/METADATA_SCHEMA.md`, `03_SYSTEM/Protocols/GALAXY_NOTE_TEMPLATE.md`.

---

## Proposed Solution

### 1. Instructional Alignment (Standardization)
- Update **Rule 3** in `RULES.md` to point to the logging section in `GEMINI.md`.
- Refactor the **Logging Requirements** in `GEMINI.md` to explicitly mention the `version-incrementer.js` hook as a mandatory system reflex.
- Ensure all references to deprecated or archived protocols (e.g., `LOGGING_PROTOCOL.md`) are removed.

### 2. Session State Protocol (Memory Persistence)
- Formally evaluate and approve the "Session State Protocol" proposal.
- Create the directory `02_MACHINE/State/`.
- Create a `SESSION_STATE_TEMPLATE.md` in `03_SYSTEM/Protocols/`.
- This protocol replaces "investigative context reconstruction" with "deterministic state loading."

### 3. Command Evolution (Automation)
- **Refactor `/eod`**: Update the command to produce a `session-state_<scope>_<date>.md` file in the session state directory as its final action.
- **Refactor `/resume`**: Update the command to prioritize loading the latest session state file, setting the "Active Objective" and "Next Steps" immediately.

### 4. Knowledge Layer (The Lineage)
- Update `METADATA_SCHEMA.md` to refine the `source` field:
    - `source: human-original` (Fully human authored)
    - `source: ai-assisted` (AI drafted, Human verified/edited)
    - `source: ai-candidate` (AI generated, awaiting human verification in 02_MACHINE)
- Update `GALAXY_NOTE_TEMPLATE.md` to reflect these changes.

---

## Phased Implementation Plan

### Phase 1: The Instructional Layer (The Constitution)
1. **RULES.md**: Update Rule 3; remove deprecated protocol links.
2. **GEMINI.md**: Update "Logging Requirements" to include the ASV hook instruction.

### Phase 2: The Memory Layer (The Reflex)
1. **Directory Setup**: Create `02_MACHINE/State/`.
2. **Template Creation**: Author `03_SYSTEM/Protocols/SESSION_STATE_TEMPLATE.md`.
3. **Registry Update**: Add new system files to `CORE_SYSTEM_REGISTRY.md` for ASV tracking.

### Phase 3: The Command Layer (The Execution)
1. **eod.toml**: Update prompt to generate the session state file.
2. **resume.toml**: Update prompt to load the latest session state.

### Phase 4: The Knowledge Layer (The Lineage)
1. **METADATA_SCHEMA.md**: Refine `source` field allowed values.
2. **GALAXY_NOTE_TEMPLATE.md**: Update default YAML values.

---

## Verification & Testing
1. **ASV Test**: Modify `GEMINI.md` and verify the `version-incrementer.js` hook triggers and increments the version correctly.
2. **EOD Test**: Run `/eod` and verify a session state file is created in the correct directory with high-signal content.
3. **Resume Test**: Run `/resume` and verify it successfully identifies and loads the latest session state.
4. **Metadata Test**: Create a dummy Galaxy note using the new template and verify it matches the refined schema.

## Finality
1. **Audit Log**: Document the entire "Governance Suite" deployment.
2. **PR Creation**: Create a comprehensive Pull Request on the `feat/governance-standardization` branch.

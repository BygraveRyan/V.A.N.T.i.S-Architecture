# /openrouter
Purpose: Prepare a high-fidelity OpenRouter plan for one of three lanes: continuity fallback, cheap bulk execution, or staged build handoff.

## PROTOCOL
1.  **Analyze**: Review the current session state and identify whether this task is best treated as `continuity`, `cheap`, or `build`.
2.  **Stage**: Create a new file `02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`.
3.  **Template**: Follow the structure in `03_SYSTEM/Protocols/OPENROUTER_HANDOFF_TEMPLATE.md`.
4.  **Zero-Trust**: Scrub all plain-text API keys, internal secrets, and naked URLs from the handoff file.
5.  **Route**:
    - `continuity`: prefer an Anthropic model on OpenRouter when native Claude is unavailable.
    - `cheap`: prefer a lower-cost model for drafting, extraction, or bulk work.
    - `build`: keep the existing large-build handoff pattern.
6.  **Notify**: Provide the user with the command to execute the selected lane.

## COMMAND
Continuity fallback:
`bash .gemini/hooks/openrouter-build.sh --profile continuity --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

Cheap lane:
`bash .gemini/hooks/openrouter-build.sh --profile cheap --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

Existing build lane:
`bash .gemini/hooks/openrouter-build.sh --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

## SKILL TRIGGER
- `architectural-designer` (for complex build staging)
- `audit-logger` (to log the handoff creation)

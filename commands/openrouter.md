# /openrouter

Prepare a high-fidelity OpenRouter plan for one of three lanes: continuity fallback, cheap bulk execution, or staged build handoff.

## PROTOCOL
1. Review the active task and determine whether the correct lane is `continuity`, `cheap`, or `build`.
2. Create `02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`.
3. Follow `03_SYSTEM/Protocols/OPENROUTER_HANDOFF_TEMPLATE.md`.
4. Scrub plain-text keys, secrets, naked URLs, and sensitive business data.
5. Recommend the exact execution command for the selected lane.

## COMMANDS
Continuity fallback:
`bash .gemini/hooks/openrouter-build.sh --profile continuity --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

Cheap lane:
`bash .gemini/hooks/openrouter-build.sh --profile cheap --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

Existing build lane:
`bash .gemini/hooks/openrouter-build.sh --plan 02_MACHINE/State/handoff-openrouter_YYYY-MM-DD.md`

## ROUTING RULE
- Use `continuity` when native Claude is blocked and Anthropic-style output continuity matters.
- Use `cheap` for bulk drafting, summarization, extraction, and lower-stakes implementation.
- Use `build` for long-running or pre-scoped implementation handoffs.

## SKILL TRIGGER
- `architectural-designer`
- `audit-logger`

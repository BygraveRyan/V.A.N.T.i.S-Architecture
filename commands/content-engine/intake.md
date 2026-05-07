Capture a new content idea into Stage 1 of the CONTENT_ENGINE pipeline in under 90 seconds.

## Step 1 - Gather the minimum input

Ask for only two things if they are missing:

- A freeform idea in 1-3 sentences
- Category: `BRD` for brand/authority or `LGN` for lead generation/conversion

Title is optional. If the operator does not provide one, derive a concise title from the idea.

Do not ask the operator to provide Audience, Platform, Format, Job, Angle, or Problem Addressed during intake unless the idea is too vague to classify. Derive those fields from the freeform input and Northern Strata context.

## Step 2 - Derive the structured fields

Populate the idea fields as follows:

| Field | Source |
| --- | --- |
| Title | Operator-provided, or agent-derived |
| Category | Operator-provided, required |
| Evidence / Trigger | Operator-provided from the freeform idea |
| Audience | Agent-derived |
| Platform | Agent-derived, single platform only |
| Format | Agent-derived |
| Job | Agent-derived |
| Angle | Agent-derived |
| Problem Addressed | Agent-derived |
| Source Reference | Deferred, leave blank unless provided |
| Priority | Agent-derived, default `Medium` unless urgency is clear |
| Status | Auto-set to `Idea` |
| Notes | Deferred production notes, only if useful |

Allowed formats:

- `Reel`
- `Carousel`
- `Static Image`
- `Image Post`
- `Text Post`
- `Doc Post`

If multiple platforms or formats are implied, choose the primary one for the file and put the others in `## Notes`.

## Step 3 - Single confirm beat

Before writing the file, show one compact confirmation table:

```markdown
| Field | Value |
| --- | --- |
| Title | [title] |
| Category | BRD / LGN |
| Audience | [one sentence] |
| Platform | [single platform] |
| Format | [allowed format] |
| Job | [one sentence] |
| Angle | [hook / approach] |
| Problem Addressed | [problem] |
| Evidence / Trigger | [operator signal] |
| Priority | High / Medium / Low |
```

Ask: `File this idea?`

Proceed only after the operator confirms. If the operator corrects a field, update the table once and ask again.

## Step 4 - Route and name the file

- `BRD` -> `CONTENT_ENGINE/01_IDEAS/brand/`
- `LGN` -> `CONTENT_ENGINE/01_IDEAS/lead-gen/`

Filename format: `Descriptive_Title_YYYY-MM-DD.md`

Use words separated by underscores, append today's date, and remove special characters.

## Step 5 - Write the idea file

Use this exact structure and preserve all heading names:

```markdown
# [Idea Title]

## Category
`BRD` or `LGN`

## Audience
[One sentence - who they are and what they care about]

## Platform
[Single platform]

## Format
[One format type]

## Job
[One sentence - what this asset must make the viewer feel or do]

## Angle
[The creative hook or approach - how the idea lands]

## Problem Addressed
[The underlying problem this content solves or responds to]

## Evidence / Trigger
[Why now? What prompted this idea - a launch, a moment, data, a conversation]

## Source Reference
[Blank unless provided]

## Priority
`High` / `Medium` / `Low`

## Status
`Idea`

## Repurposed
`false`

## Repurpose Of
`null`

## Notes
- [Any production notes, alternate platforms/formats, constraints, or context]
```

## Step 6 - Confirm filing

After writing the file, output:

```markdown
**Idea filed.**

| Field | Value |
| --- | --- |
| File | `CONTENT_ENGINE/01_IDEAS/[subfolder]/[filename].md` |
| Category | BRD / LGN |
| Platform | [platform] |
| Format | [format] |
| Job | [job sentence] |
| Status | Idea |

Next step: mark `Status: Selected for Development` when ready to draft.
```

---
name: architecture-decision-records
description: Capture architectural decisions made during V.A.N.T.i.S. sessions as structured ADRs. Auto-detects decision moments, records context, alternatives considered, and rationale. Maintains an ADR log so future agents understand why the system is shaped the way it is.
origin: ECC (adapted for V.A.N.T.i.S.)
version: 1.0.0
---

# Architecture Decision Records (V.A.N.T.i.S.)

Capture architectural decisions as they happen during sessions. Instead of decisions living only in session logs or an agent's memory, this skill produces structured ADR documents in `03_SYSTEM/ADRs/` that persist across sessions and agents.

## When to Activate

- User explicitly says "record this decision" or "ADR this"
- User chooses between significant alternatives (agent, protocol, tooling, path, infrastructure)
- User says "we decided to..." or "the reason we're doing X instead of Y is..."
- User asks "why did we choose X?" (read existing ADRs)
- During planning phases when architectural trade-offs are discussed
- A Phase item is deferred, scoped down, or superseded

## ADR Format

Use the lightweight ADR format adapted for V.A.N.T.i.S.:

```markdown
# ADR-NNNN: [Decision Title]

**Date**: YYYY-MM-DD
**Status**: proposed | accepted | deprecated | superseded by ADR-NNNN
**Deciders**: [agent / human / session]

## Context

[2-5 sentences describing the situation, constraints, and forces at play]

## Decision

[1-3 sentences stating the decision clearly]

## Alternatives Considered

### Alternative 1: [Name]
- **Pros**: [benefits]
- **Cons**: [drawbacks]
- **Why not**: [specific reason this was rejected]

## Consequences

### Positive
- [benefit 1]

### Negative
- [trade-off 1]

### Risks
- [risk and mitigation]
```

## Workflow

### Capturing a New ADR

1. **Identify the decision** — extract the core architectural choice
2. **Gather context** — what problem prompted this? What constraints exist?
3. **Document alternatives** — what other options were considered? Why rejected?
4. **State consequences** — trade-offs, what becomes easier/harder
5. **Assign a number** — scan `03_SYSTEM/ADRs/` and increment from the highest existing NNNN
6. **Draft and confirm** — present draft to user. Only write to `03_SYSTEM/ADRs/NNNN-decision-title.md` after explicit approval
7. **Update the index** — append a row to `03_SYSTEM/ADRs/README.md`

### Reading Existing ADRs

When a user asks "why did we choose X?":

1. Read `03_SYSTEM/ADRs/README.md` index
2. Read matching ADR file and present Context + Decision sections
3. If no match: "No ADR found for that decision. Would you like to record one now?"

### ADR Directory Structure

```
03_SYSTEM/
└── ADRs/
    ├── README.md                         ← index of all ADRs
    ├── 0001-phase4-p10-deferral.md
    └── template.md                       ← blank template for manual use
```

## Decision Detection Signals

**Explicit signals**
- "Let's go with X"
- "We should use X instead of Y"
- "The trade-off is worth it because..."
- "Record this as an ADR"

**Implicit signals** (suggest recording — do not auto-create without user confirmation)
- Comparing two approaches and reaching a conclusion
- Deferring a Phase item with a stated reason
- Changing agent assignments with rationale
- Choosing between protocol patterns
- Scoping a feature down from its original specification

## V.A.N.T.i.S. Decision Categories

| Category | Examples |
|----------|---------|
| **Agent decisions** | Which agent owns a task, tool scope changes, Council role assignments |
| **Protocol changes** | Rule additions, signal changes, metadata schema evolution |
| **Feature scope** | Full implementation vs. Lite version, deferral to future phase |
| **Tooling** | Hook adoption, new skills, command splits (e.g., EOD vs handover) |
| **Path / structure** | Directory reorganisation, naming conventions |
| **Integration** | Model selection policy, cross-agent hand-off patterns |

## What Makes a Good ADR

### Do
- **Record the why** — rationale matters more than what
- **Include rejected alternatives** — future agents need to know what was considered
- **State consequences honestly** — every decision has trade-offs
- **Keep it short** — readable in 2 minutes
- **Use present tense** — "We use X" not "We will use X"

### Don't
- Record trivial decisions — naming a variable or minor formatting
- Write essays — context section over 10 lines is too long
- Omit alternatives — "we just picked it" is not valid
- Let ADRs go stale — superseded decisions should reference their replacement

## ADR Lifecycle

```
proposed → accepted → [deprecated | superseded by ADR-NNNN]
```

- **proposed**: under discussion, not yet committed
- **accepted**: in effect and being followed
- **deprecated**: no longer relevant (feature removed, approach abandoned)
- **superseded**: a newer ADR replaces this one (always link the replacement)

## Mandate Compliance

- Writing a new ADR counts as a vault modification — produce a log entry per the Strict Finality mandate
- ADRs live in `03_SYSTEM/` (Architectural history area) — not in `private workspace/Knowledge/Galaxy`
- No ASV reflex required (ADRs are not `03_SYSTEM/Protocols/` files)

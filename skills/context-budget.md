---
name: context-budget
description: Audits V.A.N.T.i.S. context window consumption across agents, skills, and protocols. Identifies bloat, redundant components, and produces prioritized token-savings recommendations.
origin: ECC (adapted for V.A.N.T.i.S.)
version: 1.0.0
---

# Context Budget (V.A.N.T.i.S.)

Analyze token overhead across every loaded component in a V.A.N.T.i.S. session and surface actionable optimizations to reclaim context space.

## When to Use

- Session performance feels sluggish or output quality is degrading.
- You've recently added many subagents, skills, or protocols.
- You want to know how much context headroom you actually have.
- Planning to add more components and need to know if there's room.

## How It Works

### Phase 1: Inventory

Scan V.A.N.T.i.S. component directories and estimate token consumption:

**Subagents** (`.claude/agents/*.md`, `.gemini/agents/*.md`)
- Count lines and tokens per file (words × 1.3).
- Extract `description` frontmatter length.
- Flag: files >200 lines (heavy), description >30 words (bloated frontmatter).

**Skills** (`.gemini/skills/**/*.md`)
- Count tokens per skill Markdown file.
- Flag: files >400 lines.

**Protocols** (`03_SYSTEM/Protocols/**/*.md`)
- Count tokens per file.
- Flag: files >150 lines.
- Detect content overlap between protocols.

**Adapters** (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`)
- Count tokens per file.
- Flag: combined total >400 lines.

### Phase 2: Classify

Sort every component into a bucket:

| Bucket | Criteria | Action |
|--------|----------|--------|
| **Core** | Referenced in `CLAUDE.md`/`GEMINI.md`, or part of `AGENTS.md` mandates. | Keep |
| **Domain-Specific** | Project-specific protocols or niche skills. | Consider lazy-loading |
| **Redundant** | Overlapping content between protocols and agents. | Consolidate or remove |

### Phase 3: Detect Issues

Identify the following problem patterns:

- **Bloated agent descriptions**: description >30 words in frontmatter loads into every Task tool invocation.
- **Heavy agents**: files >200 lines inflate subagent tool context on every spawn.
- **Redundant protocols**: protocols that duplicate `AGENTS.md` or adapter rules.
- **Adapter bloat**: verbose explanations in `CLAUDE.md` or `GEMINI.md` that should be moved to protocols.

### Phase 4: Report

Produce the context budget report:

```
Context Budget Report (V.A.N.T.i.S.)
═══════════════════════════════════════

Total estimated overhead: ~XX,XXX tokens
Context model: [Current Model] (e.g., Gemini 2.0 Flash - 1M window)
Effective available context: ~XXX,XXX tokens (XX%)

Component Breakdown:
┌─────────────────┬────────┬───────────┐
│ Component       │ Count  │ Tokens    │
├─────────────────┼────────┼───────────┤
│ Subagents       │ N      │ ~X,XXX    │
│ Skills          │ N      │ ~X,XXX    │
│ Protocols       │ N      │ ~X,XXX    │
│ Adapters        │ N      │ ~X,XXX    │
└─────────────────┴────────┴───────────┘

⚠ Issues Found (N):
[ranked by token savings]

Top 3 Optimizations:
1. [action] → save ~X,XXX tokens
2. [action] → save ~X,XXX tokens
3. [action] → save ~X,XXX tokens

Potential savings: ~XX,XXX tokens (XX% of current overhead)
```

## Best Practices

- **Token estimation**: use `words × 1.3` for prose, `chars / 4` for code-heavy files.
- **Agent descriptions are loaded always**: even if the agent is never invoked, its description field is present in every Task tool context.
- **Audit after changes**: run after adding any agent, skill, or protocol to catch creep early.
- **Consolidate protocols**: if multiple protocols cover the same ground, the Architect should merge them.

---
Version: 1.0.0
*V.A.N.T.i.S. Strategic Resource Management | Context Budget Protocol v1.0.0*

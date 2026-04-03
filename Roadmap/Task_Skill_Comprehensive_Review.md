# V.A.N.T.i.S. Skill Comprehensive Review
Date: 2026-04-01
Author: Claude Code (Sonnet 4.6) via skill-creator
Status: Awaiting Prioritisation

---

## Scope

**25 items audited across:**
- `.gemini/skills/` — 12 skills (mix of `SKILL.md` folders and flat `.md` files)
- `.claude/commands/` — 13 commands (flat `.md` files + `gh/` subdirectory)

---

## CRITICAL ISSUES

> These break things or cause silent failures.

| # | Location | Issue |
|---|----------|-------|
| C1 | `.claude/commands/gh-pr.md` | References `node .gemini/hooks/extract-pr-body.sh` — `node` cannot run a shell script. Should be `bash`. Bug. |
| C2 | `.claude/commands/resume.md` | Typo on line 12: "SYNTESIZE" should be "SYNTHESIZE". Visible every session. |
| C3 | `.gemini/skills/concept-extraction/SKILL.md`, `concept-mapper/SKILL.md`, `memory-curator/SKILL.md` | All say "Consult Skill Trigger Matrix in `GEMINI.md`" — Gemini-specific reference, invisible to Claude. Should be removed or replaced with the actual trigger conditions inline. |

---

## STRUCTURAL ISSUES

> Inconsistency or weak triggering that degrades the skill system over time.

| # | Skill | Issue |
|---|-------|-------|
| S1 | `architectural-designer`, `audit-logger`, `github-ops`, `inbox-processor`, `precedent-detection`, `verify.md`, `linkedin-content-generation` | **No YAML frontmatter** — no `name`/`description` fields. Description-optimization loop (via skill-creator) cannot tune triggering for these. |
| S2 | `audit-logger`, `github-ops` | **No description at all** — no triggering hint visible to any agent. |
| S3 | `gh-pr.md` + `gh/pr.md` | **Duplicate commands** — both exist. The `gh/` subdirectory versions are more detailed and appear to be the intended canonical versions. The flat `gh-*.md` files are likely stale originals. Needs consolidation decision. |
| S4 | `context-budget.md` in `.gemini/skills/` AND `.claude/commands/` | Same skill name in two locations. Confirm if content is in sync or diverged. |

---

## QUALITY ISSUES

> Skills work but are sub-optimal.

| # | Skill | Issue |
|---|-------|-------|
| Q1 | `.gemini/skills/precedent-detection/SKILL.md` | ~120 lines for a skill that could be ~35. "No fabrication", "Do not fabricate", and "CONSTRAINTS" all restate the same rule. Verbose structure adds noise. |
| Q2 | `.claude/commands/daily.md` | 3 lines — no synthesis structure, no output template. Very bare relative to the scope of the command. |
| Q3 | `.claude/commands/inbox.md` | 3 lines — inconsistent with the full `inbox-processor` skill it should invoke. Routing logic missing. |
| Q4 | `.claude/commands/gh-issue.md` | 2 lines — links issues to `CORE_SYSTEM_REGISTRY.md` but `gh/issue.md` is far more capable. Stale. |
| Q5 | `.gemini/skills/linkedin-content-generation/SKILL.md` | Hardcodes Obsidian wikilink `[[2026-03-18_LinkedIn_Post_VANTIS_Reveal]]` as a reference for tone. Will become stale as the post history grows. Should be dynamic (read latest N posts). |

---

## SKILLS IN GOOD SHAPE

> No action needed.

| Skill | Why it's good |
|-------|---------------|
| `architecture-decision-records.md` | Proper YAML frontmatter, clear workflow, decision detection signals, good examples |
| `context-budget.md` | Frontmatter present, structured 4-phase approach, clean report template |
| `audit-logger` | Dual-tier design (tokenless + reasoning) is sound and well-explained |
| `.claude/commands/eod.md` | Clear, sequential, comprehensive — covers all EOD obligations |
| `.claude/commands/gh-publish.md` | Includes critical workflow order note, prevents common mistake |

---

## RECOMMENDED PRIORITY ORDER

### Tier 1 — Quick Wins (< 5 min each)
1. **[C1]** Fix `gh-pr.md`: change `node` → `bash` for the shell script reference
2. **[C2]** Fix `resume.md`: correct "SYNTESIZE" → "SYNTHESIZE"
3. **[C3]** Remove Gemini-specific trigger matrix references from `concept-extraction`, `concept-mapper`, `memory-curator`

### Tier 2 — Structural Cleanup (30–60 min total)
4. **[S1/S2]** Add YAML frontmatter (`name`, `description`) to the 7 skills missing it — unlocks description optimization
5. **[S3]** Decide: keep flat `gh-*.md` commands or retire in favour of `gh/` subdirectory. Remove the stale set.
6. **[S4]** Confirm `context-budget.md` content parity between `.gemini/skills/` and `.claude/commands/`

### Tier 3 — Quality Improvements (per-skill sessions)
7. **[Q1]** Rewrite `precedent-detection` — cut from ~120 to ~35 lines, preserve logic
8. **[Q2/Q3/Q4]** Beef up `daily.md`, `inbox.md`, `gh-issue.md` commands to match depth of their `.gemini/skills/` counterparts
9. **[Q5]** Make `linkedin-content-generation` reference the latest N posts dynamically instead of hardcoding a specific post

---

## NOTES FOR EXECUTION

- Tier 1 fixes should go directly on `main` (no feature branch needed — these are typo/bug fixes).
- Tier 2 structural changes warrant a `fix/skill-system-cleanup` branch and a single PR.
- Tier 3 improvements are candidates for individual `skill/` branches and can be done incrementally.
- Any changes to `.gemini/skills/*/SKILL.md` files require the ASV reflex: `node .gemini/hooks/version-incrementer.js <file_path>`.

---

*Generated by V.A.N.T.i.S. Skill Review | skill-creator protocol | 2026-04-01*

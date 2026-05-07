# Task: CONTENT_ENGINE 4-Stage Restructure

**Date:** 2026-04-17
**Status:** Approved — Pending Execution
**Scope:** Pipeline collapse (8 → 4 stages), intake skill redesign, idea file normalisation
**Supersedes:** `Task_ContentEngine_IdeaTemplate_v2_Migration.md`
**Blueprint:** `01_HUMAN/Business/NorthernStrata/Strategy/ContentEngine_Restructure_Blueprint_2026-04-17.md`

---

## Context

The CONTENT_ENGINE was built with an 8-stage pipeline designed for team handoffs. For a solo operator producing 3-5 pieces/week for one brand, this is over-engineered. Multi-agent consensus review (5x Sonnet + Opus) identified the pipeline as the primary friction source and recommended a collapse to 4 stages with a redesigned intake skill.

The v2 template migration (superseded task) was partially complete — template and pipeline_rules were updated, but 4 non-compliant idea files remain unfixed. Those are absorbed into P1 of this task.

---

## P0 — This Week (Skill + Rules)

### 1. Redesign `/intake` skill
- Accept freeform 1-3 sentence input + Category (BRD/LGN)
- Claude derives: Audience, Platform, Format, Job, Angle, Problem Addressed
- Auto-set Status: `Idea`; defer Priority, Notes, Source Reference
- Single confirm beat before filing
- Target: <90 seconds capture-to-filed
- File writes to `CONTENT_ENGINE/01_IDEAS/{brand|lead-gen}/`

### 2. Update `CONTENT_ENGINE/_SYSTEM/pipeline_rules.md`
- Replace 8-stage model with 4-stage: `01_IDEAS → 02_DRAFTS → 03_LIVE → 04_PERFORMANCE`
- Update stage entry/exit conditions accordingly
- Remove references to: `02_PROMPTS`, `03_RAW_ASSETS`, `05_APPROVED`, `06_DISTRIBUTION`, `08_REPURPOSING`
- Add repurposing-as-frontmatter-flag documentation

### 3. Update `CONTENT_ENGINE/_TEMPLATES/IDEA_TEMPLATE.md`
- Add comment annotations distinguishing required-at-capture vs AI-derived fields
- Add `repurposed: false` and `repurpose_of: null` frontmatter fields
- Keep all 12 fields — just clarify which the operator provides vs Claude derives

---

## P1 — Next Week (Directory Restructure)

### 4. Collapse directory structure
- Create `CONTENT_ENGINE/02_DRAFTS/` with `brand/` and `lead-gen/` subfolders
- Migrate any content from `04_ASSEMBLY/` into `02_DRAFTS/`
- Create `CONTENT_ENGINE/03_LIVE/` (empty, ready for approved pieces)
- Rename `07_PERFORMANCE/` → `04_PERFORMANCE/` (preserve `_PATTERNS/` subfolder)
- Delete empty directories: `02_PROMPTS/`, `03_RAW_ASSETS/`, `05_APPROVED/`, `06_DISTRIBUTION/`, `08_REPURPOSING/`
- Move any salvageable prompt content to `_SYSTEM/prompts/library.md`

### 5. Fix 4 non-compliant idea files
- `NS_Owned_Pipeline_vs_Aggregators_2026-04-14.md` → Format: `High-impact Text` → `Text Post`
- `NS_90_Minute_Build_Reveal_2026-04-14.md` → single platform (Instagram), format: `Reel`
- `NS_Story_Demo_Screen_Record_2026-04-14.md` → single platform (Instagram), format: `Reel`
- `NS_Story_Lead_Decay_Timer_2026-04-14.md` → single platform (Instagram), format: `Reel` or `Static Image`

### 6. Update `CONTENT_ENGINE/README.md`
- Reflect 4-stage pipeline
- Update directory tree

---

## Human Checkpoints (Canonical)

Three decisions per piece of content:
1. **Capture** — freeform idea + Category
2. **Accept/Reject** — read draft once, PASS or FAIL
3. **Deploy** — timing + publish

No prompt review gate. No formal approval folder. No distribution log.

---

## Operating Rhythm (Target)

| Day | Session | Time |
|:---|:---|:---|
| Monday | Intake + idea selection | 45 min |
| Wednesday | Batch generation + review | 60 min |
| Friday | Post + performance log | 20 min |

---

## Files NOT Changed in This Task
- `_SYSTEM/content_rules.md`
- `_SYSTEM/vantis_promotion_rules.md`
- `_SYSTEM/COMMANDS.md` (until intake skill is finalised)
- `INTEGRATION.md` (cross-system references remain valid)
- Individual performance templates

---

## Files to Archive
- `04_ASSEMBLY/NS_FB_IG_Carousel_Outreach_Post_2026-04-15.md` → migrate to `02_DRAFTS/lead-gen/` during P1

# Task: CONTENT_ENGINE Idea Template v2 Migration

**Date**: 2026-04-13
**Status**: SUPERSEDED — 2026-04-17
**Superseded by**: `Task_ContentEngine_4Stage_Restructure_2026-04-17.md`
**Reason**: Multi-agent consensus review identified the 8-stage pipeline as the root friction source. Template and pipeline_rules were already v2-compliant; remaining file migrations absorbed into the restructure task. This task is closed.
**Scope**: CONTENT_ENGINE template + pipeline rules + 3 existing idea file migrations

---

## Context
The external CONTENT_ENGINE agent has revamped the idea intake format. The new template introduces a critical new field (`## Job`), renames several existing fields for precision, narrows platform to single-platform-per-file, expands Status values, and designates 4 fields as the required machine-readable intake fields Content Engine reads directly. This task brings the VANTIS-side CONTENT_ENGINE into alignment with that spec.

---

## Changes Required

### 1. `CONTENT_ENGINE/_TEMPLATES/IDEA_TEMPLATE.md`
Full rewrite to match the new spec exactly.

**Field changes:**
- `## Idea Title` → `# [Idea Title]` (promoted to H1)
- `## Category` — value simplifies from `BRD — Brand/Organic` to just `BRD` or `LGN`
- `## Target Audience` → `## Audience` (one sentence)
- `## Platform Target` → `## Platform` (single platform only — no multi-platform)
- `## Format Hypothesis` → `## Format` (new options: Reel / Carousel / Static Image / Image Post / Text Post / Doc Post)
- `## Job` — **NEW FIELD** (between Format and Angle — what the asset must make the viewer feel or do)
- `## Angle` — unchanged
- `## Problem Addressed` — unchanged
- `## Evidence or Trigger` → `## Evidence / Trigger` (minor rename)
- `## Source Reference` — unchanged
- `## Priority` — unchanged
- `## Status` — values expand from `Backlog / Selected for Development` → `Idea / Selected for Development / In Production / Complete`
- `## Notes` — unchanged

**Required machine-readable fields (per Content Engine spec):**
`## Audience`, `## Platform`, `## Format`, `## Job` — must be present, exact heading names.

---

### 2. `CONTENT_ENGINE/_SYSTEM/pipeline_rules.md`
Update Stage 1 section only.

- Update Entry condition reference to note the 4 required fields
- Add single-platform rule: "One platform per idea file. If the idea works across multiple platforms, create separate idea files — one per platform."
- Update Status values to reflect `Idea / Selected for Development / In Production / Complete`
- Clarify status progression: `Idea` → `Selected for Development` (prompt being built) → `In Production` (prompt run, moving through pipeline) → `Complete` (artifact reaches `05_APPROVED/`)

---

### 3. Migrate 3 existing idea files

#### `01_IDEAS/01_IDEA.md` — "The Engine Behind the Leads"
- Set `## Platform` to `Instagram`; note Facebook and LinkedIn under `## Notes`
- Add `## Job` field
- Rename `## Target Audience` → `## Audience`, `## Format Hypothesis` → `## Format`, `## Evidence or Trigger` → `## Evidence / Trigger`
- Update `## Category` from `BRD — Brand/Organic` to `BRD`

#### `01_IDEAS/brand/NS_Logo_Reveal_Video_2026-04-09.md` — NS Logo Reveal
- Set `## Platform` to `Instagram`; note Facebook under `## Notes`
- Add `## Job` field
- Same field renames as above

#### `01_IDEAS/lead-gen/NS_Social_Outreach_2026-04-13.md` — NS Social Outreach
- Set `## Platform` to `Facebook` (primary — B2B trade owners); note Instagram and Nextdoor under `## Notes`
- Add `## Job` field
- Same field renames as above

#### `01_IDEAS/lead-gen/Northern Strata — Social Outreach Posts.md`
- Pre-template informal copy brief — not a template idea record
- Add single comment line at top noting status. Leave in place as historical reference.

---

## Files to Modify
1. `CONTENT_ENGINE/_TEMPLATES/IDEA_TEMPLATE.md`
2. `CONTENT_ENGINE/_SYSTEM/pipeline_rules.md` (Stage 1 section only)
3. `CONTENT_ENGINE/01_IDEAS/01_IDEA.md`
4. `CONTENT_ENGINE/01_IDEAS/brand/NS_Logo_Reveal_Video_2026-04-09.md`
5. `CONTENT_ENGINE/01_IDEAS/lead-gen/NS_Social_Outreach_2026-04-13.md`
6. `CONTENT_ENGINE/01_IDEAS/lead-gen/Northern Strata — Social Outreach Posts.md` (comment only)

## Files NOT Changed
- `COMMANDS.md` — commands unchanged
- `content_rules.md` — no new rules required
- `vantis_promotion_rules.md` — no impact
- All templates except IDEA_TEMPLATE — not affected
- Prompt files in `02_PROMPTS/` — not affected

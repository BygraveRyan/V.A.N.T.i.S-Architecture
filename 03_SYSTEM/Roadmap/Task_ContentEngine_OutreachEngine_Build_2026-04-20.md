# Build Plan: Content Engine + Outreach Engine
Date: 2026-04-20 | Annual Leave Sprint
Status: READY FOR CODEX EXECUTION

## Context
Two engines fully architecturally designed and approved (2026-04-17) but not yet implemented.
Claude is the runtime operator once engines are live. Codex handles the build.

Blueprints:
- `01_HUMAN/Business/NorthernStrata/Strategy/ContentEngine_Restructure_Blueprint_2026-04-17.md`
- `01_HUMAN/Business/NorthernStrata/Strategy/Outreach_Engine_Architecture_Blueprint_2026-04-17.md`

---

## ENGINE 1 — Content Engine 4-Stage Restructure
**Repo**: `/Users/ryanderice/Documents/V.A.N.T.i.S/`

### Task 1 — P0: Skill & System File Rewrites (3 files)

| File | What to Do |
|:---|:---|
| `.claude/commands/content-engine/intake.md` | Full rewrite: freeform 1-3 sentence input + Category → Claude derives Audience, Platform, Format, Job, Angle, Problem → single confirm beat → write file. Target: <90s capture |
| `CONTENT_ENGINE/_SYSTEM/pipeline_rules.md` | Replace 8-stage model with 4-stage: `01_IDEAS → 02_DRAFTS → 03_LIVE → 04_PERFORMANCE`. Remove all refs to PROMPTS, RAW_ASSETS, APPROVED, DISTRIBUTION, REPURPOSING stages |
| `CONTENT_ENGINE/_TEMPLATES/IDEA_TEMPLATE.md` | Add `repurposed: false` and `repurpose_of: null` frontmatter fields; annotate which fields are operator-provided vs Claude-derived |

### Task 2 — P1: Directory Restructure (run after Task 1 verified)

**Create:**
- `CONTENT_ENGINE/02_DRAFTS/brand/`
- `CONTENT_ENGINE/02_DRAFTS/lead-gen/`
- `CONTENT_ENGINE/03_LIVE/`
- `CONTENT_ENGINE/04_PERFORMANCE/` (rename from `07_PERFORMANCE/`, preserve `_PATTERNS/` subfolder)

**Migrate:**
- `CONTENT_ENGINE/04_ASSEMBLY/NS_FB_IG_Carousel_Outreach_Post_2026-04-15.md` → `CONTENT_ENGINE/02_DRAFTS/lead-gen/`

**Delete (after migration):**
- `CONTENT_ENGINE/02_PROMPTS/`
- `CONTENT_ENGINE/03_RAW_ASSETS/`
- `CONTENT_ENGINE/05_APPROVED/`
- `CONTENT_ENGINE/06_DISTRIBUTION/`
- `CONTENT_ENGINE/08_REPURPOSING/`

**Fix 4 non-compliant idea files** in `CONTENT_ENGINE/01_IDEAS/brand/` — format/platform corrections per blueprint table.

**Update** `CONTENT_ENGINE/README.md` to reflect 4-stage directory tree.

---

## ENGINE 2 — NS Outreach Engine
**New repo**: `~/Documents/Playground/ns-outreach-engine/`

### Task 3 — Full Scaffold + VANTIS Command

**Repo structure to create:**
```
ns-outreach-engine/
├── .env.example          # FIRECRAWL_API_KEY placeholder
├── .gitignore            # .env, node_modules, output/
├── package.json          # Node.js, firecrawl-js dependency
├── scripts/
│   ├── search.js         # Firecrawl search → raw prospects JSON
│   ├── enrich.js         # Add has_website, entity_type, data_confidence, tier T1-T5
│   └── dedupe.js         # Filter against contacted_log.csv
├── prompts/
│   ├── full-cold-read.md     # data_confidence: FULL variant
│   ├── partial-cold-read.md  # data_confidence: PARTIAL variant
│   └── no-website.md         # has_website: false (T1 — highest priority)
├── output/               # .gitignored; YYYY-MM-DD_batch_NN.md files land here
├── contacted_log.csv     # Dedup log — header row only to start
└── README.md
```

**Also create** `.claude/commands/ns-batch.md` inside the VANTIS repo:
- Orchestrates: `search.js` → `enrich.js` → `dedupe.js` → batch generation from prompts
- Output: channel-presorted markdown (WhatsApp block first, then Email, then Facebook)
- Each entry includes follow-up schedule (Day 4 / 8 / 12)
- Default batch size: ~10 prospects per run

**Key rules to encode in README + prompts:**
- Tier scoring: No-website + active GBP = T1 (highest priority)
- PECR/sole-trader compliance note in each prompt header
- Follow-up cadence: Day 4 / 8 / 12 only — no "just checking in"
- Core pitch: £399 build + £79/mo managed + 30-day free-work guarantee
- Demo URL: `plumbing.northernstrata.co.uk`

---

## Execution Order

| Step | Task | Can Parallelize? |
|:---|:---|:---|
| 1 | Task 1 — Content Engine P0 (3 file rewrites) | Start first |
| 2 | Task 2 — Content Engine P1 (directory restructure) | After Task 1 verified |
| 3 | Task 3 — Outreach Engine scaffold + ns-batch | Parallel with Task 2 |

## Verification
- **Content Engine**: Run `/content-engine:intake` with a freeform sentence; confirm it derives all fields and shows single confirm before filing
- **Outreach Engine**: `node scripts/search.js` → raw JSON; `node scripts/enrich.js` → tier flags added; `contacted_log.csv` dedup filters correctly; `/ns-batch` generates a channel-sorted batch file

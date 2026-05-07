# Plan: private client Content Engine Fast-Lane

**Date**: 2026-04-17 | **Status**: Approved — Pending Execution  
**Repo**: `CONTENT_ENGINE` (execution) + `V.A.N.T.i.S/CONTENT_ENGINE` (intelligence)

## Context
The content engine pipeline is fully operational (9 production runs exist, 3 skills built, scripts ready) but the on-ramp is high-friction. Every session starts cold — no NS brand context pre-loaded, the session type question causes abandonment, and there is no path for user-provided assets (all 3 existing skills generate Kie.ai prompts). Kie.ai credits are currently zero. Goal: make daily NS content production achievable in under 5 minutes with zero background knowledge.

**The 3 deliverables are build-ordered by dependency:**

---

## Deliverable 1 — NS Brand Context File (root dependency)

**Path:** `/Users/REDACTED/Documents/V.A.N.T.i.S/CONTENT_ENGINE/01_IDEAS/_ns-context.md`

Not a production run — a standing reference file. Underscore prefix mirrors `_backlog/` convention; sorts to top of `01_IDEAS/`.

**Sections:**
1. File identity header (3 lines — states "not a run, reference only")
2. Audience definition (Sheffield sole traders + small teams — plumbers, electricians, fencers, roofers, scaffolders — owner-operators, non-technical, currently on aggregators)
3. Offer details — exact product: £399 build + £79/mo managed, 30-second WhatsApp alerts, owned pipeline vs aggregator framing
4. Brand voice — direct, working-class confident, no tech jargon, problem-first, short sentences. 3–4 approved copy fragments as voice anchors
5. 4 content pillars (verbatim from `CONTENT_STRATEGY_2026-04-16.md` — Proof of Work, Pain/Revenue Leak, Trade-Specific Demo, Authority/Process)
6. Pain point list — 5 specific pains from approved runs (lead decay, aggregator squeeze, invisible online, slow reply, mobile site broken on job site)
7. Pre-approved CTAs only — "DM me 'PIPELINE'", "DM me 'BUILD'", "DM me 'DEMO'", "Want a free revenue leak estimate?", "See what we'd build for your business"
8. Platform notes — Facebook = trust/lead, Instagram = visual proof. One platform per run. If calendar says both, ask which.
9. Calendar pointer — path to `30-DAY_CONTENT_CALENDAR_2026-04-16.csv`, look at Type column

**Target length:** ~80–100 lines. Source data: `private-client/Brand/BRAND.md`, `CONTENT_STRATEGY_2026-04-16.md`, approved runs in `raw/copy/`.

---

## Deliverable 2 — Copy-Only Skill (second dependency)

**Path:** `/Users/REDACTED/Documents/CONTENT_ENGINE/.claude/skills/copy-only/SKILL.md`

Must follow exact YAML frontmatter + numbered steps + error recovery table schema of existing skills (`hero-shot`, `deconstruct-shot`, `video-transition`).

**YAML frontmatter:**
```yaml
name: copy-only
description: >
  Generates one copy set (hook, caption body, CTA, text overlay options) for a
  user-provided asset (screenshot or phone video). No AI image/video generation.
  Output recorded in 02_PROMPTS.md under skill: copy-only.
compatible_sessions: Production
output: One copy set in 02_PROMPTS.md under skill: copy-only
asset_destination: raw/copy/[RUN_ID]/
```

**Steps:**
1. **Confirm inputs** — asset description (one sentence from operator) + NS context loaded. Hard stop if either missing.
2. **Read active session** — extract Audience, Platform, Format, Job from `01_IDEA.md`. Job field drives all copy direction.
3. **Write the copy set:**
   - Hook (1 line, max 12 words, platform-adjusted: 6–8 words for Stories, up to 12 for Feed). Must lead with problem/cost/consequence. No banned openers ("Are you...", "Did you know...").
   - Caption Body (3–5 sentences: Problem → Evidence/consequence → Mechanism → Outcome → optional 5th). Short sentences. No passive voice. Unverified numbers → scenario-framed.
   - CTA (one from pre-approved list in `_ns-context.md`, matched to Job field).
   - Text Overlay Options (exactly 3, max 5 words each — for operator selection, not 3 variants). Agent notes which best matches visual but does not select automatically.
4. **Write to `02_PROMPTS.md`** under `skill: copy-only` with labelled sections. Operator selects one overlay option and notes it in the file. Pipeline proceeds to `03_RAW_ASSETS.md` review gate normally.

**Error recovery table rows:**
- Asset description too vague → "Describe what a viewer would see in the first 0.5 seconds."
- Hook uses banned pattern → rewrite to lead with cost or consequence
- Caption contains unattributed specific claim → reframe as scenario: "A business like yours..."
- CTA not in pre-approved list → replace with closest approved form from `_ns-context.md`
- Text overlay option > 5 words → trim to single most arresting phrase

**Note on review gate interpretation for own-asset runs:** Include in skill body — "Production readiness" check = is the asset file present in `raw/[type]/[RUN_ID]/` AND does the copy work alongside it? "Distribution fit" = is the asset format (screenshot/video) appropriate for the specified platform?

---

## Deliverable 3 — NS Daily Post Cheat Sheet (final, depends on 1+2)

**Path:** `/Users/REDACTED/Documents/V.A.N.T.i.S/private workspace/Business/private-client/NS_DAILY_POST_CHEAT_SHEET.md`

**Constraint:** Under 40 lines. Every line is an action or a decision. No background explanation.

**Sections:**
1. **Step 1 — Check the calendar** (3 lines): Open `30-DAY_CONTENT_CALENDAR_2026-04-16.csv`. Today's row → Type column. If Type = Outreach: don't run a production session — use the outreach template instead.
2. **Step 2 — Start the session** (5 lines): Exact copy-paste opening prompt the user pastes to Claude: `"Production session. Use NS context: ~/Documents/V.A.N.T.i.S/CONTENT_ENGINE/01_IDEAS/_ns-context.md. Today's post type: [from calendar]. Source idea: [path to VANTIS idea file]."` This resolves session type + NS context + idea in one message.
3. **Path A — You have your own asset** (6 lines): When agent reaches `02_PROMPTS.md` stage, say: `"Use skill: copy-only. Asset: [one sentence describing your screenshot/video]."` Drop your file into `raw/images/[RUN_ID]/` or `raw/video/[RUN_ID]/`. Review gate still runs — agent will guide you.
4. **Path B — Using Kie.ai** (2 lines): Only if credits available. Skip copy-only skill — agent produces generation prompt. Run `kie-generate.sh` after `02_PROMPTS.md`.
5. **Step 3 — Review gate** (3 lines): Agent runs 5 checks at `03_RAW_ASSETS.md`. If FAIL: wait for minimum correction instruction. When all PASS: `04_ASSEMBLY.md` is created automatically.
6. **Step 4 — Post it** (2 lines): Open `04_ASSEMBLY.md`. Copy caption. Attach your asset in Instagram/Facebook composer. Post to platform in `01_IDEA.md`.

---

## Build Order
1. `_ns-context.md` — populate from `CONTENT_STRATEGY_2026-04-16.md`, `BRAND.md`, and existing approved copy in `raw/copy/`
2. `copy-only/SKILL.md` — match schema exactly from `hero-shot/SKILL.md` (read this first)
3. `NS_DAILY_POST_CHEAT_SHEET.md` — write last, after paths in 1+2 are confirmed

## Critical Reference Files (read-only)
- `/Users/REDACTED/Documents/CONTENT_ENGINE/.claude/skills/hero-shot/SKILL.md` — canonical skill schema to match
- `/Users/REDACTED/Documents/V.A.N.T.i.S/private workspace/Business/private-client/Strategy/CONTENT_STRATEGY_2026-04-16.md` — source of pillars + offer details
- `/Users/REDACTED/Documents/V.A.N.T.i.S/private workspace/Business/private-client/Brand/BRAND.md` — voice/visual constraints

## Verification
1. **Cold start test:** New session, paste the cheat sheet opening prompt → `01_IDEA.md` created with zero clarifying questions
2. **Copy-only end-to-end:** Pick an unrun VANTIS idea file, invoke copy-only skill with asset description → `04_ASSEMBLY.md` produced with no Kie.ai credits needed
3. **Calendar connection:** Find today's row in CSV → session opening prompt constructable in under 60 seconds with no brand details typed from scratch

---

## Intelligence Integration — Outbound Science (2026-04-17)

Source: `private workspace/Inbox/Archive/The Science of Outbound-Cold Email and Copywriting Course.md`

This section governs how the Notebook LM outreach science maps into the content engine. Every deliverable above must comply.

### 7 Principles → Content Engine Mapping

| Principle | Content Engine Application |
|:---|:---|
| **Give First** | Pain/Revenue Leak posts must quantify the loss (£ value or missed jobs) BEFORE any CTA. The calculator belongs here. Never ask first. |
| **Micro Commitments** | CTAs should ask for a small, low-friction action — not a sale. "Drop me your trade → I'll estimate your leak" beats "DM me 'PIPELINE'." |
| **Social Proof** | Always scenario-frame. "A plumber like yours in Sheffield..." or "Businesses we've built for..." — never unattributed claims. Specific numbers > vague claims. |
| **Authority** | Use trade-specific language in all posts. Speak like someone who knows their world: "rewires", "callouts", "Checkatrade", "no-show leads". |
| **Rapport** | Mirror audience tone — short, blunt, working-class confident. No marketing speak. Facebook = conversational. Instagram = visual proof. |
| **Scarcity** | Offer or pricing framing should imply limited availability or time window. "Taking on 3 more Sheffield trades this month." |
| **Shared Identity** | Every post and message should signal insider status. Reference Sheffield specifically, reference their trade, reference the pain they already know. |

### Hook Rules (mandatory for copy-only skill and all content)

**Banned openers — hard stop, rewrite required:**
- "Are you a [trade]...?"
- "Did you know...?"
- "Hope this finds you well"
- "We [anything]..." — always "I" not "we"
- Any question format that doesn't lead with cost, consequence, or identity

**Required hook structure:** Lead with COST, CONSEQUENCE, or IDENTITY.
- Cost: "Every missed call is a competitor's invoice."
- Consequence: "Your reply speed is losing you jobs."
- Identity: "Sheffield plumbers don't advertise. They get found."

### CTA Upgrades (add to `_ns-context.md` pre-approved list)

| Old CTA | Upgraded Micro-Commitment CTA |
|:---|:---|
| "DM me 'PIPELINE'" | "Drop me your trade — I'll tell you exactly what you're losing." |
| "DM me 'BUILD'" | "DM me and I'll send you a 30-second demo for your trade." |
| "DM me 'DEMO'" | "Comment your trade below — I'll build you a quick mockup." |
| "Want a free revenue leak estimate?" | Keep as-is — this IS Give First correctly applied. |

### Risk Reversal (add to _ns-context.md offer details)

Standard risk reversal phrase for any content that mentions the offer:
> "Built, live, and pinging enquiries to your phone in 7 days — or you don't pay a penny until it is."

### Data-Driven Testing Protocol

When running A/B content tests:
- Test 2 fundamentally different hook styles on similar post types (e.g., cost-focused vs consequence-focused)
- Track: saves, DM rate, comment engagement — treat these as reply rate / open rate equivalents
- Once a hook style wins, make only small changes (one variable at a time) to optimise further
- Never change hook style AND caption body AND CTA at the same time — isolate variables

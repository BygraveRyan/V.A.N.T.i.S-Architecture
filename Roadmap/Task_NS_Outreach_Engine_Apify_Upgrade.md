# Task: NS Outreach Engine — Multi-Source Discovery Upgrade (Apify + Firecrawl)

Status: `Ready to Execute`
Created: 2026-04-20
Priority: High
Executor: Claude Code or Codex

---

## Context

The current engine uses Firecrawl web search as its discovery step — a general Google-style search wrapper returning mixed results with no phone numbers or structured contact data. All contact details require full manual research per prospect, capping realistic daily output at ~10-15 usable leads.

Goal: Replace Firecrawl search with Apify actors targeting 5 platforms (Google Maps, Checkatrade, Facebook Pages, Instagram, Yell) to produce 30-50 clean, phone-bearing prospects per run. Firecrawl moves to the enrichment step — scraping each prospect's actual website for cold read material.

Cost at scale: ~$7-10/month total.

---

## Architecture Change

### Before
```
Firecrawl search → enrich (classify only) → dedupe → batch
```

### After
```
Apify multi-source discover → merge + within-run dedupe → enrich (classify + Firecrawl website scrape) → dedupe vs contacted_log → batch
```

---

## Files to Change

| File | Change |
| :--- | :--- |
| `package.json` | Add `apify-client` dependency |
| `.env.example` | Add `APIFY_TOKEN`, `NS_ENRICH_MAX_TIER` |
| `scripts/search.js` | Replace with `scripts/discover.js` |
| `scripts/enrich.js` | Add Firecrawl website scrape step (T1/T2 only) |
| `scripts/pipeline.js` | Update first stage to call `discover.js` |
| `scripts/batch.js` | Extend cold read logic for `source_platform` + `website_summary` |

All files at: `~/Documents/VANTIS_ENGINES/ns-outreach-engine/`

---

## Step 1 — Add apify-client

```bash
cd ~/Documents/VANTIS_ENGINES/ns-outreach-engine
npm install apify-client
```

Add to `.env.example`:
```
APIFY_TOKEN=your_token_here
NS_ENRICH_MAX_TIER=2
```

---

## Step 2 — Create scripts/discover.js

Replaces `search.js`. Accepts `--trade` and `--location` CLI args:

```bash
node scripts/discover.js --trade "plumber" --location "Sheffield"
```

### Sources

| Source | Apify Actor | Fields returned |
| :--- | :--- | :--- |
| Google Maps | `compass/crawler-google-places` | name, phone, website, address, rating, reviewCount |
| Checkatrade | `apify/web-scraper` (custom config) | name, phone, trade, location, reviews |
| Facebook Pages | `apify/facebook-pages-scraper` | name, phone, website, pageUrl |
| Instagram | `apify/instagram-scraper` | username, bio, website, phone (from bio) |
| Yell | `apify/web-scraper` (custom config) | name, phone, address, website |

Each source normalises to the existing prospect schema plus two new fields:
```javascript
source_platform: "google_maps" | "checkatrade" | "facebook" | "instagram" | "yell",
address: string
```

### Within-run deduplication

After merging all sources:
- Primary key: `phone` (normalised — strip spaces, `+44`, leading zeros)
- Fallback: `name` slug match
- When duplicate: keep record from highest-priority source (Maps > Checkatrade > Facebook > Instagram > Yell)

Outputs `{date}_raw_prospects.json` — same filename, compatible with existing `enrich.js`.

---

## Step 3 — Update enrich.js

After existing classification block, add:

```
For each prospect where website_url is populated AND tier is T1 or T2:
  → Call Firecrawl.scrape(website_url)
  → Extract: title, meta description, contact info, trust signals
  → Store as prospect.website_summary (string, max ~300 chars)
```

Controlled by `NS_ENRICH_MAX_TIER` env var (default: 2).

---

## Step 4 — Update pipeline.js

Change stage 1 from `search.js` → `discover.js`. Pass CLI args through:

```bash
npm run pipeline -- --trade "electrician" --location "Sheffield"
```

Update `package.json` scripts:
```json
"discover": "node scripts/discover.js",
"search": "node scripts/discover.js",
"pipeline": "node scripts/pipeline.js"
```

---

## Step 5 — Update batch.js cold read logic

Extend opening line construction:
1. If `website_summary` populated → write specific observation from it
2. If `source_platform === "checkatrade"` → "Spotted [name] on Checkatrade..."
3. If `source_platform === "instagram"` → "Saw [name] on Instagram..."
4. Otherwise → existing logic unchanged

---

## Phasing

### Phase 1 — Google Maps only (validate first)
- `discover.js` with Google Maps actor only
- Updated `pipeline.js` and `package.json`
- Confirm `_raw_prospects.json` has phone numbers and existing schema is compatible

### Phase 2 — All 5 sources
- Add Checkatrade, Facebook Pages, Instagram, Yell
- Add `source_platform` and within-run dedupe
- Update `batch.js` platform-aware cold reads

### Phase 3 — Firecrawl website enrichment
- Add Firecrawl scrape to `enrich.js`
- Add `website_summary` and summary-driven cold reads in `batch.js`

---

## Verification

1. `node scripts/discover.js --trade "plumber" --location "Sheffield"` → `_raw_prospects.json` has phone numbers
2. `npm run pipeline -- --trade "plumber" --location "Sheffield"` → full pipeline completes
3. Check `_batch_NN.md` — WhatsApp channel assigned to phone-bearing prospects
4. Spot-check 3 prospects against Google Maps — names, phones, websites match
5. Run pipeline twice — second run skips previously logged prospects

---

## Context for Executor

- Engine repo: `~/Documents/VANTIS_ENGINES/ns-outreach-engine/`
- Existing utilities in `scripts/lib.js` — reuse `loadEnv`, `writeJson`, `readJson`, `todayStamp`, `slug`, `contactId`
- Prospect schema is defined in `scripts/search.js` (the file being replaced) and consumed by `scripts/enrich.js`
- Prompt templates in `prompts/` are unchanged
- `contacted_log.csv` and `dedupe.js` are unchanged
- APIFY_TOKEN goes in `~/Documents/VANTIS_ENGINES/ns-outreach-engine/.env` (already gitignored)

---
name: "trades-seo"
description: "Audits and optimises static HTML trades websites (electricians, plumbers, builders) for UK local search. Covers on-page, technical, local SEO, LocalBusiness schema, AEO, link building, content strategy, and measurement. Produces a prioritised gap list, schema block, and implementation checklist. Use when launching a new trades site, doing a quarterly SEO health check, prepping a client site for ranking, or diagnosing why a trades site isn't appearing in local search."
type: method
status: evergreen
domain:
  - seo
  - local-trades
  - web-performance
abstraction_layer: component
verified_distinct: true
version: 1
schema_version: 1.6
source: ai-assisted
---

# Trades SEO Skill

**Tier:** POWERFUL  
**Category:** Web / Growth  
**Domain:** Local SEO, UK Trades, Static Sites

---

## When to Use

- New trades site just deployed — needs baseline SEO before outreach
- Quarterly health check on an existing client site
- Diagnosing why a site isn't appearing in local pack / Maps results
- Pre-launch audit before handover to client
- Building programmatic location pages for multi-area coverage

---

## Scope & Constraints

This skill is **scoped to**:
- Static HTML sites (no CMS, no Next.js SSR)
- UK local trades: electricians, plumbers, builders, HVAC, roofers
- Single-location or small multi-location setups
- Vercel / Netlify / GitHub Pages deployments

This skill does **not** cover: national brands, e-commerce SEO, backlink outreach campaigns, or paid search.

---

## Audit Workflow

Run these phases in order. Each phase produces a scored output. Combine scores into the Gap Priority Table at the end.

---

### Phase 1 — On-Page Audit

**Goal:** Clarity, relevance, and intent match for local queries.

Check each item. Mark: ✅ Pass | ⚠️ Partial | ❌ Fail

| Check | Notes |
|-------|-------|
| Unique `<title>` per page — service + location near the front | e.g. "Electrician Sheffield — Hal-Systems Ltd" |
| Unique meta description per page — click-through focused, not keyword-stuffed | Max 155 chars |
| One clear `<h1>` per page matching primary intent | e.g. "Emergency Electrician Sheffield" |
| `<h2>` used for service detail, proof, FAQs, coverage area | Not used for decoration |
| Service + location phrase in opening paragraph + one heading | Natural, not repeated 5× |
| Content includes: pricing cues, areas served, qualifications, response time, guarantees | |
| Single-page sites: section anchors + jump links present | |
| No keyword stuffing / over-exact-match repetition | Google rewrites titles from page copy anyway |

**Quick wins if failing:**
- Add location to `<title>` and `<h1>` immediately
- Add a "Service Areas" section listing towns/postcodes
- Add guarantee text near CTA (e.g. "30-day free-work guarantee")

---

### Phase 2 — Technical SEO Audit

**Goal:** Google can crawl, render, and score the page fast on mobile.

| Check | Target | Tool |
|-------|--------|------|
| LCP (Largest Contentful Paint) | < 2.5s | PageSpeed Insights |
| INP (Interaction to Next Paint) | < 200ms | PageSpeed Insights |
| CLS (Cumulative Layout Shift) | < 0.1 | PageSpeed Insights |
| Mobile usability — no horizontal scroll, tap targets > 48px | Pass | Search Console |
| Images: compressed, WebP/AVIF, explicit width/height, lazy-loaded | | Manual check |
| Tailwind: purged unused classes in production build | | Check bundle size |
| HTTPS enforced, single canonical host, no redirect chains | | curl -I check |
| Canonical `<link rel="canonical">` on every indexable page | | Source check |
| `robots.txt` — no accidental blocking of service pages | | /robots.txt |
| `sitemap.xml` — submitted to Search Console | | Search Console |
| Clean descriptive URLs: `/electrician-sheffield/` not `/?page=3` | | URL check |
| Mobile version contains all content, links, contact, schema | | Responsive test |

**Run this check:**
```bash
curl -I https://yourdomain.co.uk | grep -E "HTTP|Location|Strict-Transport"
```

**Common failures on static Tailwind sites:**
- Hero image not using `fetchpriority="high"` — kills LCP
- Font loading blocking render — use `font-display: swap`
- No `width`/`height` on images — causes CLS

---

### Phase 3 — Local SEO Audit

**Goal:** Appear in Google Maps local pack for "[trade] [city]" queries.

| Check | Notes |
|-------|-------|
| Google Business Profile (GBP) claimed and verified | |
| GBP primary category set correctly (e.g. "Electrician") | |
| GBP secondary categories added (e.g. "Electrical installation service") | |
| Services list populated in GBP | |
| Service area set in GBP (towns/postcodes you cover) | |
| Photos uploaded (at least 5 — exterior, work examples, team) | |
| NAP consistent: Name, Address, Phone identical on site + GBP + directories | Use same format exactly |
| Local phone number (not 0800) preferred | |
| Top UK directories listed: Yell, Bing Places, Apple Business Connect, FreeIndex | |
| Reviews being actively requested after jobs | |
| All reviews have owner replies | |
| Review text mentions service + town naturally | |

**NAP check — compare these three sources:**
1. Footer of website
2. Google Business Profile contact tab
3. Yell.com listing

Any mismatch = fix immediately.

**Review velocity target:**
- 1+ review/week for first 3 months
- Reply within 24h

---

### Phase 4 — LocalBusiness Schema

**Goal:** Structured data confirms entity to Google; enables rich results.

Generate this block and add to `<head>` or just before `</body>` as JSON-LD.

```json
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Electrician",
  "name": "{{BUSINESS_NAME}}",
  "url": "https://{{DOMAIN}}",
  "telephone": "{{PHONE}}",
  "email": "{{EMAIL}}",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "{{STREET}}",
    "addressLocality": "{{CITY}}",
    "addressRegion": "{{COUNTY}}",
    "postalCode": "{{POSTCODE}}",
    "addressCountry": "GB"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": {{LAT}},
    "longitude": {{LNG}}
  },
  "areaServed": [
    {"@type": "City", "name": "{{CITY_1}}"},
    {"@type": "City", "name": "{{CITY_2}}"}
  ],
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday"],
      "opens": "08:00",
      "closes": "18:00"
    }
  ],
  "priceRange": "££",
  "description": "{{ONE_SENTENCE_SERVICE_DESCRIPTION}}",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "Electrical Services",
    "itemListElement": [
      {"@type": "Offer", "itemOffered": {"@type": "Service", "name": "Fuse Board Replacement"}},
      {"@type": "Offer", "itemOffered": {"@type": "Service", "name": "EV Charger Installation"}},
      {"@type": "Offer", "itemOffered": {"@type": "Service", "name": "Emergency Electrical Repairs"}}
    ]
  }
}
</script>
```

**Schema type by trade:**
| Trade | `@type` |
|-------|---------|
| Electrician | `Electrician` |
| Plumber | `Plumber` |
| Builder | `GeneralContractor` |
| Roofer | `RoofingContractor` |
| HVAC | `HVACBusiness` |

**Validate:** https://search.google.com/test/rich-results

**Rules:**
- Schema must match visible page content — don't add fields not shown on page
- Don't add `AggregateRating` unless reviews are genuinely from third-party sources
- FAQ schema only for genuine user-facing FAQ sections

---

### Phase 5 — AEO (Answer Engine Optimisation)

**Goal:** Be the source AI Overviews and answer boxes quote for local trade queries.

| Pattern | Implementation |
|---------|---------------|
| Question headings | `<h2>How much does a fuse board replacement cost in Sheffield?</h2>` |
| Direct answer first, then detail | "Typically £400–£600. Here's what affects the price..." |
| Pricing range stated explicitly | Don't hide pricing — AI surfaces it |
| Service area stated in plain text | "We cover Sheffield, Rotherham, and Barnsley" |
| Guarantee stated clearly | "30-day guarantee — no new enquiries, we work free until there are" |
| Qualifications/accreditations named | "NICEIC approved, Part P certified" |
| Emergency availability | "Same-day response available 7 days" |

**Priority AEO questions to answer on-page:**
1. "How much does [service] cost in [city]?"
2. "How fast can you respond to an emergency?"
3. "Are you [accreditation] certified?"
4. "What areas do you cover?"
5. "Do you offer a guarantee?"

---

### Phase 6 — Content Structure Audit

**Goal:** Right pages for the right queries; no thin content.

**Recommended structure for a trades site:**

| Page | Target Query | Minimum Content |
|------|-------------|-----------------|
| Home | "[trade] [city]" | Hero + services summary + trust signals + CTA |
| Core Service 1 | "[specific service] [city]" | Full service description + pricing + FAQs + proof |
| Core Service 2 | "[specific service] [city]" | Same as above |
| Service Areas | "[trade] near [town]" | Unique content per area — local proof, FAQs |
| About | Branded queries | Qualifications, years, insurance, guarantees |
| Contact | | Phone, WhatsApp, form, map embed, hours |

**Single-page sites (common for NS clients):**
- Use strong section anchors: `#services`, `#pricing`, `#areas`, `#contact`
- Each section must be independently scannable
- Avoid thin sections with 1-2 lines of text — minimum 100 words per section

**Location pages — only build if:**
- You genuinely work in that area
- You can write unique content (local landmark, local proof job)
- Don't mass-produce identical pages swapping only the town name

---

### Phase 7 — Link & Citation Baseline

**Goal:** Enough local signals to confirm business legitimacy to Google.

**Priority UK directories (in order):**
1. Google Business Profile
2. Bing Places for Business
3. Apple Business Connect
4. Yell.com
5. FreeIndex.co.uk
6. Checkatrade / TrustATrader (if trades-specific)
7. Local Chamber of Commerce

**Each listing must have:**
- Identical NAP to website footer
- Link to website
- Category set correctly

**Local link targets (low-effort, high-value):**
- Supplier/manufacturer "approved installer" pages
- Local trade bodies (NICEIC, Gas Safe, etc.)
- Local Chamber of Commerce member directory
- Sponsorship/community event pages

**Avoid:** bulk directory submissions, generic guest post networks.

---

### Phase 8 — Measurement Setup

**Goal:** Track leads, not just rankings.

**Minimum tracking stack:**
| Tool | What to track |
|------|--------------|
| Google Search Console | Impressions, clicks, Core Web Vitals, index coverage |
| GA4 (or server logs) | Form submissions, call clicks, WhatsApp click events |
| GBP Insights | Calls, direction requests, website clicks, photo views |

**Key events to fire (add to `<script>` or GTM):**
```javascript
// Track WhatsApp click
document.querySelector('a[href^="https://wa.me"]').addEventListener('click', () => {
  gtag('event', 'whatsapp_click', { event_category: 'lead' });
});

// Track phone click
document.querySelector('a[href^="tel:"]').addEventListener('click', () => {
  gtag('event', 'phone_click', { event_category: 'lead' });
});

// Track form submission
document.querySelector('form').addEventListener('submit', () => {
  gtag('event', 'form_submit', { event_category: 'lead' });
});
```

**Expectations for a new site:**
- Weeks 1-4: Branded search impressions appear
- Month 1-2: Map pack eligibility builds (reviews + citations)
- Month 2-4: Non-branded local terms start ranking
- Rankings before reviews = unlikely for competitive terms

---

## Gap Priority Table

After running all phases, score each gap 1–10 (10 = highest conversion impact):

| Rank | Gap | Current State | Phase | Action |
|------|-----|--------------|-------|--------|
| 1 | LocalBusiness schema missing | None | 4 | Add JSON-LD block |
| 2 | GBP incomplete | Not claimed / partial | 3 | Claim + fully populate |
| 3 | No pricing on-page | Hidden | 1 | Add pricing range |
| 4 | Hero image LCP > 2.5s | Slow | 2 | Compress + fetchpriority |
| 5 | No FAQ / AEO content | No questions answered | 5 | Add 5 Q&A blocks |
| 6 | NAP inconsistent | Mismatch | 3 | Standardise across all |
| 7 | No service area page | Only home | 6 | Add area coverage section |
| 8 | No reviews / no asks | 0 reviews | 3 | Implement review request workflow |

*Repopulate this table with actual findings during the audit.*

---

## Quick-Reference Checklist

Copy this into the project before delivery:

```
[ ] Title: service + location near front, unique per page
[ ] H1: one, matches primary intent
[ ] Opening para: service + location, natural
[ ] Pricing range stated on-page
[ ] Areas served listed (text + section)
[ ] Guarantee stated near CTA
[ ] Core Web Vitals: LCP < 2.5s, INP < 200ms, CLS < 0.1
[ ] Mobile: all content present, tap targets OK
[ ] Canonical tag on every indexable page
[ ] sitemap.xml submitted to Search Console
[ ] robots.txt — service pages not blocked
[ ] GBP: claimed, verified, fully populated
[ ] NAP: identical on site + GBP + Yell
[ ] LocalBusiness JSON-LD: valid, matches visible content
[ ] Rich Results Test: passes
[ ] 5+ directory listings with consistent NAP
[ ] FAQ section: 5+ real customer questions answered
[ ] AEO: pricing, coverage, qualifications in plain text
[ ] GA4 or equivalent: form/call/WhatsApp events firing
[ ] Search Console: connected, sitemap submitted
[ ] Review request workflow: active
```

---

## Resources

- Google title links: https://developers.google.com/search/docs/appearance/title-link
- Core Web Vitals: https://developers.google.com/search/docs/appearance/core-web-vitals
- LocalBusiness schema: https://developers.google.com/search/docs/appearance/structured-data/local-business
- Rich Results Test: https://search.google.com/test/rich-results
- PageSpeed Insights: https://pagespeed.web.dev/
- Google Search Console: https://search.google.com/search-console
- UK citation guide: https://whitehat-seo.co.uk/blog/uk-business-directories-citation-sites

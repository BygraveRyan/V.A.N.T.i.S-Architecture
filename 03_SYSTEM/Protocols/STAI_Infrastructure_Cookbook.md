# 📖 STAI Infrastructure Cookbook (v1.1)
**Status**: Active / Verified
**Date**: April 16, 2026
**Objective**: Rapid, frictionless deployment of Northern Strata / STAI demo sites.

---

## 🛠 1. Domain & Vercel (Subdomain Configuration)
If the root domain (e.g., `northernstrata.co.uk`) is managed at an external registrar (e.g., Namecheap) and is **not** fully managed by Vercel DNS:

### The "Frictionless" Setup:
1.  **Vercel Project**: Add the subdomain (e.g., `plumbing.northernstrata.co.uk`) directly in the **Project Settings > Domains**.
2.  **External Registrar (Namecheap)**: Add a **CNAME** record:
    - **Host**: `subdomain-prefix` (e.g., `plumbing`)
    - **Value**: Initial setup can use `cname.vercel-dns.com` for speed.
3.  **Mandatory Optimization (Post-Launch)**: As soon as the site is live, update the Namecheap CNAME value to the **Unique Value** provided by Vercel in the red error box (e.g., a project-specific alias) for the most secure and direct connection. **Never leave it as the generic value permanently.**
4.  **Conflict Resolution**: If the subdomain shows a DNS error in Vercel, check the **Global Domains Dashboard** (`vercel.com/dashboard/domains`) and delete any stale `A` or `CNAME` records for that subdomain before refreshing the project settings.

---

## 📲 2. WhatsApp Business API (Meta "Unverified" Shortcut)
Bypass the 1-2 week "Business Verification" wall (Sole Trader docs) for Phase 1.5 validation.

### The "Start" Tier Logic:
- **Status**: "Unverified" Meta Business Account.
- **Limits**: 250 business-initiated conversations per 24h.
- **Mandatory New WABA**: Twilio **cannot** use a WhatsApp Business Account (WABA) created outside its own onboarding flow. 
- **Action**: When prompted by the Twilio/Meta popup, always select **"Create a new WhatsApp Business Account"** even if one already exists. Ensure it is created under your **Main Meta Business Account** for asset consolidation.
- **Requirements**: No formal legal documents required initially—only a verified Facebook Business Page.

---

## 🤖 3. Automation Bridge (Make.com)
The most cost-effective and low-friction bridge for Phase 1.5.

### The Webhook Setup:
- **Trigger**: `Custom Webhook` node.
- **Communication**: Use **JSON** (`JSON.stringify(payload)`) and `headers: { 'Content-Type': 'application/json' }` in the website's `fetch` call.

### Make.com → Twilio WhatsApp Integration:
**Node 1: Custom Webhook**
- Receives form data (name, phone, email, job_type, message, source, submitted_at)

**Node 2: Twilio WhatsApp Message**
1. Add Twilio module → Select **"Send a Message"** action
2. **Create new connection**:
   - Paste your **Twilio Account SID** (from Twilio Console → Account → API Keys & Tokens)
   - Paste your **Twilio Auth Token**
3. **Configure fields**:
   - **From**: `whatsapp:+447863792351` (your WABA number with `whatsapp:` prefix and `+44` international format)
   - **To**: `whatsapp:+44[CLIENT_PHONE]` (recipient with `whatsapp:` prefix and `+44` — NOT `07`)
   - **Message Body**: Use dynamic field mapping to construct message:
     ```
     📌 New Lead Alert
     
     Name: [map to webhook.name]
     Phone: [map to webhook.phone]
     Message: [map to webhook.message]
     
     Reply here or call them.
     ```
   - Click the `{}` icon in the message field to insert dynamic webhook values

**Critical Format Notes**:
- **Phone numbers MUST be prefixed with `whatsapp:`** — this tells Twilio to route via WhatsApp, not SMS
- **Use `+44` international format**, NOT `07` — e.g. `whatsapp:+447700123456` not `whatsapp:07700123456`
- **From and To must use identical formats** — both need `whatsapp:` prefix and `+44` format
- Error **"Invalid From and To pair"** = phone number format mismatch

**Testing the Flow**:
1. Activate the scenario in Make.com
2. Submit test form on your site (`stai-plumbing.vercel.app` OR `plumbing.northernstrata.co.uk`)
3. Verify alert arrives on recipient's WhatsApp within 30 seconds
4. Check Make.com execution logs if message doesn't arrive

**Template Messages (Future)**:
Once your Twilio WhatsApp template is approved by Meta, you can switch from dynamic message body to pre-approved templates using the template's **Content SID** — this is required for production at scale.

---

## 📲 4. The "Smart" WhatsApp CTA
Always lower the friction for the lead by pre-filling the conversation.

### The URL Pattern:
`https://wa.me/[NUMBER]?text=[URL_ENCODED_MESSAGE]`

- **Example Message**: "Hi Northern Strata! I'm interested in your Lead-Capture system. Can you show me a demo for my business?"

---

## 📈 5. Instagram Growth & Outreach (2026 Protocol)
Instagram is the primary discovery engine for UK trades. 

### The "5-Hashtag Rule":
- **Constraint**: Stick to exactly **5 high-impact hashtags** to avoid being flagged as "spam" by the 2026 algorithm.
- **Mix**: 2 Local + 2 Niche + 1 Brand.

### The "Reel-First" Launch:
- **Format**: 15-second screen-recording of the live demo site.
- **On-Screen Text**: "Sheffield [TRADE]: Is your website doing this? ⚡️"
- **CTA**: "Comment 'DEMO' or DM for the link."
- **Social Proof**: Use organic growth as "evidence" before starting cold outreach.

### The "Clone & Close" Strategy:
- **Phase 2**: Once organic baseline is established, perform personalized outreach by creating a "15-minute clone" of the prospect's current site on a branded subdomain (e.g., `theirbusiness.northernstrata.co.uk`) to show, not tell.

---

## 🔍 6. SEO & Google Presence (New Site Checklist)
Every new NS site and the agency site itself needs this done at launch.

### Step 1 — Google Search Console
1. Go to [search.google.com/search-console](https://search.google.com/search-console)
2. Add property → **Domain** (covers root + all subdomains, http + https)
3. Verify via **TXT record** in Namecheap Host Records:
   - Type: `TXT` | Host: `@` | Value: `google-site-verification=XXXX` | TTL: Automatic
4. Hit **Verify** in Search Console
5. Submit sitemap: enter full URL e.g. `https://northernstrata.co.uk/sitemap.xml`

### Step 2 — Sitemap Generation (Static HTML Sites)
Vercel + plain HTML sites do **not** auto-generate a sitemap. Create `sitemap.xml` manually and drop it in the project root:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yourdomain.co.uk/</loc>
    <lastmod>YYYY-MM-DD</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```
Redeploy to Vercel → verify live at `yourdomain.co.uk/sitemap.xml` → submit full URL in Search Console.

### Step 3 — Google Business Profile
1. Go to [business.google.com](https://business.google.com)
2. Business type: **Service business** (no physical location)
3. Service area: Sheffield, Barnsley, Rotherham, Chesterfield, Doncaster (tight South Yorkshire focus — do not over-extend)
4. Hours: 8am–7pm Mon–Fri
5. Description: 750 char max. Include: what you offer, service area, no URLs, no promo language
6. Services: add each individually with a keyword-rich description (each is indexed separately)
7. Add social links: Instagram + Facebook only (no placeholders for inactive platforms)
8. **Do not** claim the £400 Google Ads credit until at least 1-2 clients are closed — requires £400 spend upfront before credit is returned

### Key SEO Facts (2026)
- Brand name appears in Google within **1-2 weeks** of Search Console verification
- Local keyword ranking takes longer — GBP + directory listings accelerate this
- Posting on GBP **2x per week** is a top-tier ranking signal
- **Reviews** are the strongest local SEO signal — build into founding member offer from day one
- A tight service area ranks better than a sprawling one — expand only when reviews support it

---
*V.A.N.T.i.S. Operational Protocol | Created April 14, 2026 | Updated April 15, 2026*

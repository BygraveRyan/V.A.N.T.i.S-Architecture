Run a private client outreach batch from the external outreach engine.

Operational repo:

```text
~/Documents/VANTIS_ENGINES/ns-outreach-engine/
```

Do not copy API keys, prospect output, or contacted-log data into VANTIS.

---

## Actor Configuration

Apify actor IDs are set via env vars in `~/.ai-env` or `ns-outreach-engine/.env`.
The operator can override any actor by setting:

```
NS_APIFY_GOOGLE_MAPS_ACTOR=<actor-id>
NS_APIFY_FACEBOOK_ACTOR=<actor-id>
NS_APIFY_INSTAGRAM_ACTOR=<actor-id>
NS_APIFY_CHECKATRADE_ACTOR=<actor-id>
NS_APIFY_YELL_ACTOR=<actor-id>
```

Default source is Google Maps only until other actors are validated.

---

## Single Trade Run

```bash
cd ~/Documents/VANTIS_ENGINES/ns-outreach-engine
NS_DISCOVER_SOURCES=google_maps NS_DISCOVER_LIMIT=50 npm run pipeline -- --trade "[trade]" --location "[location]"
```

## Multi-Trade Run

When the operator specifies multiple trades, run the pipeline once per trade and let each step append to the shared output pool. Use the same location unless told otherwise.

```bash
cd ~/Documents/VANTIS_ENGINES/ns-outreach-engine

for trade in "[trade1]" "[trade2]" "[trade3]"; do
  NS_DISCOVER_SOURCES=google_maps NS_DISCOVER_LIMIT=30 npm run pipeline -- --trade "$trade" --location "[location]"
done
```

After all trades complete, the deduped combined batch is in `output/YYYY-MM-DD_batch_NN.md`.

---

## Output Rules

The batch file must land in:

```text
~/Documents/VANTIS_ENGINES/ns-outreach-engine/output/YYYY-MM-DD_batch_NN.md
```

The markdown must be channel-presorted in this order:

1. WhatsApp
2. Email
3. Facebook
4. Manual Research

Each prospect entry must include:

- Business name
- `entity_type`
- `has_website`
- `tier`
- `data_confidence`
- Phone/email/channel where available
- Source URL
- Prompt variant
- Message block
- Follow-up schedule: Day 4 / Day 8 / Day 12

## Prompt Branching

Use the script-selected prompt variant:

- `has_website: false` -> `prompts/no-website.md`
- `data_confidence: FULL` -> `prompts/full-cold-read.md`
- `data_confidence: PARTIAL` -> `prompts/partial-cold-read.md`
- `data_confidence: SKIP` -> exclude from batch

Never hallucinate details when confidence is partial.

## Tier Priority

Use the engine tier order:

- `T1` - no website + active GBP/directory signal + high-value trade
- `T2` - website exists but lead capture is broken or weak
- `T3` - no website, lower confidence/manual research needed
- `T4` - dated or weak website
- `T5` - functional website, skip Phase 1

No-website plus active GBP is the highest-priority segment.

## Compliance

- Manual send only.
- If `entity_type: sole_trader`, include `Reply STOP to unsubscribe` in WhatsApp/SMS copy.
- Follow-up cadence is Day 4 / Day 8 / Day 12 only.
- Do not write "just checking in."

## Offer

Use the same pitch across variants:

- £399 build
- £79/mo managed
- 30-day free-work guarantee
- Demo URL: `plumbing.northernstrata.co.uk`

## Closeout

After generation, report:

```markdown
**NS batch generated.**

| Field | Value |
| --- | --- |
| Output | `~/Documents/VANTIS_ENGINES/ns-outreach-engine/output/YYYY-MM-DD_batch_NN.md` |
| Trades | [list] |
| Prospects | [count] |
| WhatsApp | [count] |
| Email | [count] |
| Facebook | [count] |
| Manual Research | [count] |

Next step: review the batch manually, send by channel, then append sent rows to `contacted_log.csv`.
```

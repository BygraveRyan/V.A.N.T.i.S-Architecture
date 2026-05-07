# Task: NS Outreach Engine — Framework Alignment (Science Edition)
**Status:** BACKLOG | **Priority:** HIGH
**Created:** 2026-04-22

## Objective
Update the `ns-outreach-engine` prompt templates and generation scripts to strictly enforce the "Outreach Framework Science" (April 17th) guidelines, ensuring all future generated batches are 100% compliant without manual rewriting.

## Target Directory
`/Users/REDACTED/Documents/VANTIS_ENGINES/ns-outreach-engine/`

---

## 1. Update Prompt Templates (`prompts/*.md`)
The prompt templates dictating the LLM's output must be rewritten to align with the framework.

**Files to update:**
- `prompts/full-cold-read.md`
- `prompts/partial-cold-read.md`
- `prompts/no-website.md`

**Required Changes:**
*   **Remove Link Mandate:** Delete references to `Demo URL: [link]`. Add a strict negative constraint: `CRITICAL: Do NOT include any links or URLs in this first message. Links are reserved for Message 2.`
*   **Enforce Singular Pronouns:** Add a rule: `Use "I" instead of "We". (e.g., "I run private client", "I build trade websites").`
*   **Fix Call To Action (CTA):** Change the "Low-friction call ask" instruction to: `End with a single question proposing a 5-minute call with two specific times (e.g., "Can ring you Tuesday 10am or Thursday 2pm — whichever works."). NEVER use vague questions like "Worth a look?" or "Worth 5 minutes?".`
*   **Remove Bot Language:** Delete the PECR rule requiring `Reply STOP to unsubscribe` for sole traders. This violates the human-to-human tone required by the framework.
*   **Fix Openers (Specifically `no-website.md`):** Forbid robotic openers like "I searched for...". Mandate observation-based framing: *"Searched for a local plumber and noticed you don't have a proper site set up..."*

---

## 2. Update Generation Script (`scripts/generate.js` or equivalent)
To prevent the LLM from hallucinating violations and ensure strict adherence, the generation logic needs to be updated.

**Required Changes:**
*   **Remove Demo URL Context:** Ensure the script does not pass the `demo_url` variable to the LLM during the first-message generation step.
*   **Implement Post-Generation Validation (Optional but Recommended):** Add a validation step after the LLM generates the message. If the message fails validation, it can be flagged or regenerated.
    *   *Check 1:* Fails if `http` or `.co.uk` is present (Catches links).
    *   *Check 2:* Fails if `We build` or `We run` is present (Catches plural pronouns).
    *   *Check 3:* Fails if `Worth 5 minutes?` or `Worth a look?` is present (Catches weak CTAs).
    *   *Check 4:* Fails if `STOP` is present (Catches bot language).

---

## 3. Update Markdown Batch Template
Ensure the final markdown output (the `batch_XX.md` files) reflects the new rules in its header.

**Required Changes:**
*   Update the header text in the output script to reflect the removal of the Demo URL and the new CTA rules.

---

## Verification Steps
1. Run a test generation batch of 5 prospects.
2. Verify zero links are present in the output.
3. Verify all pronouns are singular ("I").
4. Verify all CTAs offer two specific times.
5. Verify no "STOP to unsubscribe" footers are included.

---
*Task documented via Gemini on 2026-04-22*

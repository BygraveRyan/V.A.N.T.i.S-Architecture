# PLAN: GitHub Gold Standard & Safety Audit
**Project:** V.A.N.T.i.S. Public Portfolio Preparation
**Status:** Drafting
**Priority:** High (Pre-Launch)

---

## 🎯 OBJECTIVE
Professionalize the public-facing V.A.N.T.i.S. repository ("The Engine") by completing documentation gaps and performing a rigorous security audit to ensure no PII or secrets are leaked during the LinkedIn launch.

---

## 🛠️ DOCUMENTATION UPGRADES

### 1. README.md Expansion (Stack & Setup)
- **Problem:** Currently lacks actionable setup instructions.
- **Solution:** Add a "Getting Started" section covering:
    - **Obsidian Setup**: Required community plugins (Templater, etc.).
    - **Gemini CLI Setup**: How to point the CLI to the V.A.N.T.i.S. repository.
    - **Initialization**: First-run checklist.

### 2. CONTRIBUTING.md Creation
- **Objective:** Establish the engineering culture of the repository.
- **Content:**
    - Branching Strategy (feat/, fix/).
    - Commit Standards (Why/How/Impact).
    - Rule 11 & Rule 12 enforcement (Template validation).
    - PR expectations (Linked logs).

### 3. LICENSE (MIT)
- **Objective:** Legal clarity for the open-source community.
- **Action:** Initialize a standard MIT License.

---

## 🛡️ SAFETY & SECURITY AUDIT

### 1. PII & Secret Scan
- **Verification:** Confirm the whitelisted files for the public mirror are clean.
- **Findings so far:** 
    - No Emails or Phone Numbers in whitelisted files.
    - No API Keys (Google, GitHub, etc.) detected in whitelisted files.
    - Absolute paths (`/Users/`) are referenced in logic (`publish-mirror.sh`) but only as part of a safety *check* script, not as hardcoded paths that will be leaked.
- **Action:** Perform a final "Double-Blind" grep for the user's name (`Bygrave`, `Ryan`) to ensure no accidental metadata is present.

### 2. .gitignore Robustness
- **Review:** Current `.gitignore` correctly excludes `.env*`, `.gh_token*`, and private vault folders.
- **Action:** Add `logs/` to the mirror's local exclusion if it isn't already handled by the `publish-mirror.sh` whitelist logic (Note: `publish-mirror.sh` uses a strict whitelist, so it's already secure).

---

## 🚀 IMPLEMENTATION STEPS

1.  **Branch Creation**: `feat/github-gold-standard`.
2.  **Documentation Drafting**: 
    - Update `README.md`.
    - Create `CONTRIBUTING.md`.
    - Create `LICENSE`.
3.  **Sanitization Check**: 
    - Run final `grep` scans on whitelisted files.
    - Verify `publish-mirror.sh` logic doesn't accidentally pull `01_HUMAN/Personal`.
4.  **PR Finalization**: 
    - Commit and push to Private Core.
    - Run `/gh:publish` to sync the Public Engine.
    - Verify the Public PR on GitHub.

---

## ✅ VERIFICATION & TESTING
- [ ] Manual review of `README.md` for clarity.
- [ ] Automated scan results (Emails, Secrets, Paths) = 0 matches in whitelisted files.
- [ ] Successful mirror sync via `publish-mirror.sh`.

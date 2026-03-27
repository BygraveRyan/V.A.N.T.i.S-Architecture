# V.A.N.T.i.S. Upgrade: Private Core & Public Mirror Architecture

**Status:** Complete (Verified 2026-03-21)
**Priority:** High
**Date Initiated:** 2026-03-20

## Overview
Implement "Architecture A" to establish a zero-risk, cross-platform synchronization method. The primary repository will become 100% private, tracking the entire vault. A secondary public repository (`V.A.N.T.i.S-Architecture`) will serve as the portfolio mirror, updated via a custom, automated CLI command.

## The Architecture A Implementation Plan

### Phase 1: Re-Secure the Current Repository
*   **Action:** Use the `gh` CLI to change the visibility of the current repository back to **Private**.
*   **Action:** Modify the root `.gitignore`. Remove rules blocking private folders (`01_HUMAN/Inbox`, `01_HUMAN/Projects`, `01_HUMAN/Personal`, etc.) so Git tracks the entire Brain.
*   **Action:** Commit the newly un-ignored private files and push them to the Private Core.

### Phase 2: Create the Public "Mirror"
*   **Action:** Use the `gh` CLI to create a new public repository called `V.A.N.T.i.S-Architecture`.
*   **Action:** Leave it completely blank (no auto-initialization).

### Phase 3: Build the `/gh:publish` Automation
*   **Action:** Create a deployment script at `.gemini/hooks/publish-mirror.sh`.
    *   *Logic:* Create a temp dir, `rsync` only whitelisted "Engine" files (e.g., `.gemini/`, `.github/`, `03_SYSTEM/Protocols/`, `README.md`, `CHANGELOG.md`, `BOOT_IMAGE.md`), initialize Git, commit, push to the public remote, and clean up.
*   **Action:** Create a new command file at `.gemini/commands/gh/publish.toml` to execute the script.

### Phase 4: Final Validation
*   **Action:** Execute the `/gh:publish` command.
*   **Action:** Verify the public mirror contains only architecture files, and the private core remains 100% secure and synced.

# V.A.N.T.i.S. Task: Portfolio PR Reconstruction

**Status:** Active Execution
**Priority:** High
**Date Initiated:** 2026-03-20

## Objective
Reconstruct the `V.A.N.T.i.S-Architecture` public mirror repository's Git history to present a chronological, storytelling series of Pull Requests that demonstrate the system's evolution from March 15 to March 20. This will be achieved by using the newly ingested `GitHub PR Best Practices` framework (Why/How/Impact).

## Execution Plan

### Phase 1: Standardize the PR Template
1.  **Action:** Read the `01_HUMAN/Inbox/GitHub PR Best Practices.md` file (Completed).
2.  **Action:** Rewrite the `.github/PULL_REQUEST_TEMPLATE.md` file in the Private Core to enforce the "Why/How/Impact" and "Reviewer-First Checklist" structure.
3.  **Action:** Archive the `GitHub PR Best Practices.md` file from the INBOX to `01_HUMAN/Inbox/Archive/`.
4.  **Action:** Commit these changes to the `feat/user-context-layer` branch and merge them into `main` on the Private Core.

### Phase 2: The Public Mirror "Wipe"
1.  **Action:** Delete the local cloned temporary folder if it exists.
2.  **Action:** Use `gh repo delete BygraveRyan/V.A.N.T.i.S-Architecture --yes` to delete the current flattened public repository.
3.  **Action:** Use `gh repo create V.A.N.T.i.S-Architecture --public --description "Vectorised Astral Navigation & Thought Intelligence System (Portfolio Engine)"` to create a fresh, empty public repository.
4.  **Action:** Create a new temporary deployment directory and initialize it as a Git repository connected to the newly recreated public mirror.
5.  **Action:** Create a basic `README.md` as the initial "Empty State" commit and push it to the `main` branch of the public mirror.

### Phase 3: The Reconstruction Sequence (Scripted Deployment)
A bash script will be executed within the temporary deployment directory to simulate the timeline. For each of the 5 eras:
1.  Create a new feature branch (e.g., `feat/core-protocols`).
2.  Copy specific V.A.N.T.i.S. Engine files representing that era's state from the Private Core into the temporary deployment directory.
3.  Commit the files and push the feature branch to the public remote.
4.  Use `gh pr create` with the "Why/How/Impact" framework to open the PR.

#### The 5 Target PRs:
*   **PR 1: `feat(core): establish intelligence layer and core protocols`** (Simulating Mar 15-16)
    *   *Files:* `GEMINI.md`, `AGENTS.md`, `RULES.md`, `VAULT_MAP.md`, `CHANGELOG.md`
*   **PR 2: `feat(security): enforce ai boundaries and logging layer`** (Simulating Mar 16-17)
    *   *Files:* `03_SYSTEM/Protocols/AGENT_PERMISSIONS.md`, `03_SYSTEM/Protocols/Archive/LOGGING_PROTOCOL.md`
*   **PR 3: `feat(governance): implement github templates and standardization`** (Simulating Mar 18)
    *   *Files:* `.github/` folder
*   **PR 4: `feat(engine): transition to native skills and github ops`** (Simulating Mar 20 - "The Metamorphosis")
    *   *Files:* `.gemini/skills/`, `.gemini/commands/`, `03_SYSTEM/Protocols/METADATA_SCHEMA.md`
*   **PR 5: `feat(architecture): deploy private-core to public-mirror pipeline`** (Simulating Mar 20)
    *   *Files:* `.gemini/hooks/`, `.gemini/commands/gh/`

### Phase 4: Finalization
1.  **Action:** Delete the temporary deployment directory.
2.  **Action:** The user will navigate to GitHub and manually review/merge the 5 PRs sequentially.
3.  **Action:** Log the task as complete in the local V.A.N.T.i.S. audit trail.

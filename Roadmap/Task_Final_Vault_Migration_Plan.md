# Plan: V.A.N.T.i.S. Legacy Vault Migration & Cleanup
Version: 1.0.1
Status: Drafted
Date: 2026-03-27
Agent: Gemini (Intelligence Layer)

---

## 🎯 Objective
Execute the final migration of unmigrated assets from the legacy `vault/` directory to the new tripartite structure (`private workspace/`, `02_MACHINE/`, `03_SYSTEM/`) and perform a repository-wide cleanup of legacy `vault/` references.

---

## 🛠️ Step 1: Asset Migration (The "Surgical Extraction")

The following files were identified as unmigrated or having unique value in the `vault/` directory:

### A. Inbox & Guides
- `vault/01_INBOX/the-longform-guide.md` -> `private workspace/Inbox/The_Longform_Guide.md`
- `vault/01_INBOX/the-security-guide.md` -> `private workspace/Inbox/The_Security_Guide.md`
- `vault/01_INBOX/the-shortform-guide.md` -> `private workspace/Inbox/The_Shortform_Guide.md`

### B. System Blueprints
- `vault/00_SYSTEM/DYNAMIC_GALAXY_SCAFFOLDER.md` -> `03_SYSTEM/Protocols/DYNAMIC_GALAXY_SCAFFOLDER.md`
- `vault/00_SYSTEM/VANTIS_SYSTEM_DIAGRAM.md` -> `03_SYSTEM/Protocols/VANTIS_SYSTEM_DIAGRAM.md`

### C. Resources & Security
- `vault/02_KNOWLEDGE/Resources/BMAD_Method_Documentation.md` -> `private workspace/Knowledge/Resources/BMAD_Method_Documentation.md`
- `vault/02_KNOWLEDGE/Resources/YT's-Obsidan+AI Setup.md` -> `private workspace/Knowledge/Resources/YT_Obsidian_AI_Setup.md`
- `vault/02_KNOWLEDGE/Resources/Security/OWASP_Cheatsheets/` -> `private workspace/Knowledge/Resources/Security/OWASP_Cheatsheets/` (recursive move)

### D. Projects & Personal
- `vault/03_PROJECTS/GCP_Flights_Analytics_Pipeline/obsidian_mirror/` -> `private workspace/Projects/GCP_Flights_Analytics_Pipeline/obsidian_mirror/`
- `vault/04_PERSONAL/MyPrompts/` -> `private workspace/Personal/MyPrompts/`

---

## 🛠️ Step 2: Reference Remediation (The "Path Update")

Update the following active files to remove `vault/` references:

### A. Universal Role Protocols
- `03_SYSTEM/Protocols/Universals/strategist.md`: Update `Tool Scope` to include new tripartite root directories.
- `03_SYSTEM/Protocols/Universals/guardian.md`: Update `Tool Scope` to include new tripartite root directories.

### B. Agent System Governance
- `AGENTS.md`: Update the `PARALLEL AGENT CONFIG PATTERN` diagram and the intro description to remove the `vault/` root.

### C. Drafts & Showcases
- `02_MACHINE/Drafts/README_v2_UPGRADE.md`
- `02_MACHINE/Drafts/README_v3_UPGRADE.md`
- `02_MACHINE/Drafts/VANTIS_LINKEDIN_SHOWCASE.md`
- Update all these to replace "Memory Layer (`vault/`)" with "Memory Layer (`private workspace/`)" or similar.

---

## 🛠️ Step 3: Final Verification & Cleanup

1. **Dry-Run Check**: Verify that `private workspace/`, `02_MACHINE/`, and `03_SYSTEM/` contain all files from the legacy `vault/`.
2. **ASV Reflex**: Run `node .gemini/hooks/version-incrementer.js` on all modified protocol files.
3. **The Final rm**: `rm -rf vault`.
4. **Log & Audit**: Create a high-fidelity audit log documenting the final migration and closure of the legacy `vault/` structure.

---

## ⚠️ Verification Checklist
- [ ] Guides present in `private workspace/Inbox/`
- [ ] OWASP Cheatsheets present in `private workspace/Knowledge/Resources/`
- [ ] `strategist.md` & `guardian.md` updated and valid
- [ ] `AGENTS.md` diagram updated
- [ ] No active files (non-archive, non-log) contain "vault/"
- [ ] `vault/` directory is deleted

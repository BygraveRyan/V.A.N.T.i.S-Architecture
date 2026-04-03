# V.A.N.T.i.S. 33-Skill Integration Plan

## 🎯 1. Target Scope: The 33 V.A.N.T.i.S. Skills
The following 33 skills have been curated to directly support the Sheffield Trades AI (n8n "Black Box" integration), B2B "Trojan Horse" marketing, and Vault Hygiene/AI Governance.

### Business Growth & Product (15)
`competitive-teardown`, `competitive-intel`, `pricing-strategy`, `launch-strategy`, `financial-analyst`, `customer-success-manager`, `revenue-operations`, `sales-engineer`, `product-discovery`, `product-manager`, `ux-researcher-designer`, `analytics-tracking`, `product-analytics`, `landing-page-generator`, `saas-scaffolder`

### Engineering, Security & Automation (11)
`senior-backend`, `api-design-reviewer`, `cloud-security`, `ai-security`, `ci-cd-pipeline-builder`, `tech-debt-tracker`, `code-reviewer`, `pr-review-expert`, `decision-logger`, `changelog-generator`, `postmortem`

### AI Governance & Marketing (7)
`cold-email`, `programmatic-seo`, `prompt-engineer-toolkit`, `prompt-governance`, `agent-designer`, `agent-workflow-designer`, `project-health`

---

## 🛠️ Phase 1: Symlink Generation Pipeline
Instead of duplicating files and cluttering the V.A.N.T.i.S. repository, we will map the skills dynamically.

**Execution:**
- [x] ~~Define the 33 target skills in a script.~~
- [x] ~~For each skill, resolve the absolute path to the source `SKILL.md` in `~/VANTIS_LIBRARIES/claude-skills/`.~~
- [x] ~~Create a new directory for the skill in `~/Documents/V.A.N.T.i.S/.gemini/skills/<skill_name>/`.~~
- [x] ~~Symlink the resolved source `SKILL.md` into the V.A.N.T.i.S. skill directory.~~
- [x] ~~Copy over any required `scripts/` or `assets/` directories into the V.A.N.T.i.S. skill folder.~~

---

## 🧬 Phase 2: Metadata v1.5 Injection
V.A.N.T.i.S. requires robust metadata for Galaxy indexing (`03_SYSTEM/Protocols/METADATA_SCHEMA.md`). 

**Execution:**
- [x] ~~Append the required V.A.N.T.i.S. v1.5 fields (`domain`, `abstraction_layer`, `verified_distinct`, etc.) to the YAML frontmatter of the source `SKILL.md` files.~~

---

## 🔒 Phase 3: Governance, ASV, and Logging
V.A.N.T.i.S. mandates strict audit trails for structural additions.

**Execution:**
- [x] ~~Generate a Tier 2 Master Audit Log in `logs/` detailing the injection of the 33 new capabilities.~~
- [x] ~~Update `SKILLS_INDEX.md` or create `02_MACHINE/Synthesis/skill-roster.md`.~~

---

## ✅ Phase 4: Capability Verification (Sheffield Test)
To prove the integration is successful, we will run a live validation test aligned with the active objective.

**Execution:**
- [x] ~~Trigger the `financial-analyst` skill locally within V.A.N.T.i.S.~~
- [x] ~~Provide it with dummy financial data simulating the "Sheffield Fencer".~~
- [x] ~~Execute `ratio_calculator.py` and output to `02_MACHINE/Synthesis/`.~~
- [x] ~~Confirm no writes occurred to `01_HUMAN/Knowledge/Galaxy`.~~

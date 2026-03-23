# CORE SYSTEM REGISTRY (CSR)
Version: 1.0.4

This registry defines the **Watch List** for the V.A.N.T.i.S. Automated System Versioning (ASV) engine. Files listed here will have their `Version: X.Y.Z` metadata incremented automatically upon modification.

---

## 🛠️ TIER 1: THE ENGINE
*High-level identity and operational protocols. Increments Major.Minor (e.g., 1.1 -> 1.2).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `GEMINI.md` | Intelligence Layer Core | Major.Minor |
| `RULES.md` | System Guardrails | Major.Minor |
| `AGENTS.md` | Agent Definitions | Major.Minor |
| `VAULT_MAP.md` | Directory Architecture | Major.Minor |
| `BOOT_IMAGE.md` | Identity Layer | Major.Minor |
| `CHANGELOG.md` | System History | Major.Minor |

---

## 📜 TIER 2: PROTOCOLS
*Standard specifications for data and knowledge flow. Increments Major.Minor (e.g., 1.0 -> 1.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `vault/00_SYSTEM/METADATA_SCHEMA.md` | Galaxy Metadata Spec | Major.Minor |
| `vault/00_SYSTEM/AGENT_PERMISSIONS.md` | Domain Restrictions | Major.Minor |
| `vault/00_SYSTEM/SIGNAL_PROTOCOL.md` | Signal Interpretation | Major.Minor |
| `vault/00_SYSTEM/CONCEPT_NAMING_PROTOCOL.md` | Naming Standards | Major.Minor |
| `vault/00_SYSTEM/GALAXY_LINKING_RULES.md` | Graph Logic | Major.Minor |
| `vault/00_SYSTEM/VANTIS_DIAGNOSTIC_PROTOCOL.md` | System Health Check | Major.Minor |

---

## 📐 TIER 3: LOGIC & UI
*Templates, dashboards, and automated scaffolding. Increments Patch (e.g., 1.0.0 -> 1.0.1).*

| File Path | Description | Versioning Logic |
| :--- | :--- | :--- |
| `vault/00_SYSTEM/GALAXY_NOTE_TEMPLATE.md` | Note Structure | Patch |
| `vault/00_SYSTEM/SESSION_STATE_TEMPLATE.md` | Session Logic | Patch |
| `vault/00_SYSTEM/LINKEDIN_POST_TEMPLATE.md` | Content Structure | Patch |
| `vault/00_SYSTEM/DYNAMIC_GALAXY_SCAFFOLDER.md` | Templater Logic | Patch |
| `vault/00_SYSTEM/System_Intelligence_Center.md` | Dataview Dashboard | Patch |
| `vault/00_SYSTEM/CORE_SYSTEM_REGISTRY.md` | This File | Patch |

---

## 🚫 EXCLUSIONS
- All files in `vault/00_SYSTEM/Archive/` are frozen and will NOT be incremented.
- `README.md` is excluded (Public Portfolio use only).
- All non-markdown files.

---
*Managed by V.A.N.T.i.S. ASV Hook | Updated: 2026-03-23*

# V.A.N.T.i.S. Skills Index
Version: 1.0.5

Purpose
This file provides a discoverable index of all V.A.N.T.i.S. skills. Skills are **agent-agnostic** — defined as pure Markdown protocols readable and executable by any agent (Gemini CLI, Claude Code, or future agents). They are housed in `.gemini/skills/` for historical reasons but are not Gemini-exclusive.

---

# Available Skills

## architectural-designer (v1.0.0)
**Location:** `.gemini/skills/architectural-designer/`
**Purpose:** Standardize the planning and execution of system upgrades.
**Capabilities:** Dependency mapping, Architectural Upgrade Plan generation, and Post-Plan Sync Hook.
**Output Location:** `vault/05_TASKS/` (via Sync Hook)

---

## audit-logger (v1.4.0)
**Location:** `.gemini/skills/audit-logger/`
**Purpose:** Ensure high-fidelity audit trails via automated Log Reflex processing.
**Capabilities:** Gold Standard Log generation and ASV reflex integration.
**Output Location:** `logs/YYYY-MM-DD/`

---

## concept-extraction (v1.1.0)
**Location:** `.gemini/skills/concept-extraction/`
**Purpose:** Extract reusable conceptual knowledge from research material.
**Capabilities:** Principle extraction and Concept Candidate drafting.
**Output Location:** `06_MACHINE/ai-candidates/`

---

## concept-mapper (v1.1.0)
**Location:** `.gemini/skills/concept-mapper/`
**Purpose:** Perform agentic "Similarity Scans" to identify cross-domain synergies.
**Capabilities:** Mechanism extraction and conceptual relationship mapping.
**Output Location:** `06_MACHINE/ai-candidates/`

---

## github-ops (v1.2.0)
**Location:** `.gemini/skills/github-ops/`
**Purpose:** Professional-grade GitHub repository management.
**Capabilities:** Automated PR body generation and structured Git interactions.

---

## inbox-processor (v1.3.0)
**Location:** `.gemini/skills/inbox-processor/`
**Purpose:** Maintain system organization by processing and routing incoming information.
**Capabilities:** Categorization, routing, and raw note archival.

---

## linkedin-content-generation (v1.1.0)
**Location:** `.gemini/skills/linkedin-content-generation/`
**Purpose:** Synthesize project progress and insights into high-authority content.
**Capabilities:** Mechanism-to-Value drafting and precedent-based storytelling.
**Output Location:** `06_MACHINE/LinkedIn_Drafts/`

---

## memory-curator (v1.1.0)
**Location:** `.gemini/skills/memory-curator/`
**Purpose:** Convert raw information into permanent, high-quality knowledge.
**Capabilities:** Orphan note detection and Galaxy promotion staging.
**Output Location:** `06_MACHINE/ai-candidates/`

---

## precedent-detection (v1.2.0)
**Location:** `.gemini/skills/precedent-detection/`
**Purpose:** Detect and surface previously encountered concepts from the Galaxy.
**Capabilities:** Semantic matching and relationship explanation.
**Rules:** Read-only access to 02_KNOWLEDGE.

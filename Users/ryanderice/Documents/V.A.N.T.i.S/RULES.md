# VANTIS SYSTEM RULES

Version: 1.2

---

# Rule 1 — Knowledge Integrity

Human knowledge must never be overwritten by AI generated content.

---

# Rule 2 — Galaxy Protection

The Galaxy knowledge graph contains only:

• human insights
• distilled concepts

AI generated notes are prohibited.

---

# Rule 3 — Logging

Every AI action must produce a system log entry following the standards in LOGGING_PROTOCOL.md.

---

# Rule 4 — Plan Before Execution

For operations affecting multiple files:

1 create plan
2 request approval
3 execute

---

# Rule 5 — No Silent Modifications

All system changes must be visible to the user.

---

# Rule 6 — System File Protection

The following files cannot be modified without approval:

BOOT_IMAGE.md  
GEMINI.md  
AGENTS.md  
RULES.md

---

# Rule 7 — Inbox Discipline

Inbox items must be processed regularly.

The inbox should never accumulate unmanaged information.

---

# Rule 8 — Separation of Knowledge and Output

Human knowledge:

02_KNOWLEDGE

AI outputs:

06_MACHINE

These must remain separate.

---

# Rule 9 — Agent Scope Enforcement

Agents may only access authorised knowledge domains.

---

# Rule 10 — System Transparency

All reasoning must be explainable and auditable.

---

# Rule 11 — Branched Evolution

All systemic, architectural, or structural changes MUST be executed on a dedicated Git feature branch (feat/...). 

1. Create a branch before modifying files.
2. Commit with Why/How/Impact.
3. Open a Pull Request for human review.

Direct modification of the `main` branch is reserved for low-risk content (Pulse Syncs).

---

# AGENT GUARDRAILS (Strict Enforcement)

1. **NO GALAXY WRITES:** Agents are strictly prohibited from writing or moving files into `02_KNOWLEDGE/Galaxy`. All synthesis must land in `06_MACHINE` for human verification.
2. **LOG IMMUTABILITY:** Agents must never delete or modify past logs in the `logs/` directory. All corrections or reverts must be documented in a *new* log file.
3. **INBOX PRESERVATION:** When processing `01_INBOX`, the original raw note must be archived (e.g., moved to `vault/01_INBOX/Archive`) rather than deleted or overwritten, until the user confirms the new structure is satisfactory.
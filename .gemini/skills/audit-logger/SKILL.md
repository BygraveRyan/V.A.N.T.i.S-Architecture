# SKILL: Audit Logger (v1.4)

Purpose
Ensure high-fidelity audit trails via automated **Log Reflex** processing.

---

# When To Use
- **Manual:** Whenever a file is modified.
- **Reflex:** Automatically triggered at the end of every task turn involving workspace changes.

---

# Logging Process (Reflex-Driven)

Step 0 — Automated System Versioning (ASV)
Before log generation, run: `node .gemini/hooks/version-incrementer.js <file_path>` for all Tier 1, 2, or 3 system files modified.

Step 1 — The Context Ledger (JSON Payload)
The agent provides a `context_ledger` object (serialized in thought):
```json
{
  "agent": "IntelligenceLayer",
  "task": "Hyphenated-Task-Name",
  "files_read": ["file1.md", "file2.md"],
  "files_modified": ["file1.md"],
  "skills_used": ["skill-name"],
  "reasoning_delta": "The core logic of why this change happened.",
  "outcome_impact": "The result of the change."
}
```

Step 2 — Generate Filename
`logs/YYYY-MM-DD/YYYY-MM-DD_HHMMSS_AgentName_TaskDescriptor.md`.

Step 3 — Assembly
Construct the Markdown log using the ledger data.
- **Frontmatter:** Include `delta` (calculated from Git or session state).
- **Sections:** User Request, Reasoning, Files Read, Files Modified, Outcome.

---

# Deterministic Assembly Rules
1. **Delta Generation:** High-signal summary (e.g., "+1 Skill, -1 Protocol").
2. **Formatting:** Use the "Gold Standard" format from `logs/2026-03-20_235500_IntelligenceLayer_Private-Core-Mirror-Deployment.md`.
3. **No Silent Actions**: Every file change requires a log entry.
4. **Immutability**: Never edit or delete existing logs.

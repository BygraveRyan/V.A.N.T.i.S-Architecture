# LOGGING_PROTOCOL

VANTIS Operational Audit & Traceability Standard

Version: 1.0
Applies To: `logs/` directory

---

# PURPOSE

Logging is the **Layer 6 (Logging Layer)** of the VANTIS architecture. 

It provides a high-fidelity audit trail of every decision, file modification, and reasoning step taken by the system. This ensures:

• **System Transparency:** Humans can always see *why* an action was taken.
• **State Recovery:** AI can reconstruct previous states from log history.
• **Auditability:** Every file change is linked to a specific agent and timestamp.
• **Self-Optimization:** Provides data for system performance and error analysis.

---

# LOG FILENAME STANDARD

To ensure perfect chronological sorting and easy identification, all log files MUST follow this naming convention:

```
YYYY-MM-DD_HHMMSS_AgentName_TaskDescriptor.md
```

**Components:**
* `YYYY-MM-DD`: Current date.
* `HHMMSS`: 24-hour timestamp (Hours, Minutes, Seconds).
* `AgentName`: The name of the agent that performed the task (e.g., `InboxProcessor`).
* `TaskDescriptor`: A brief, hyphenated description of the action (e.g., `Process-Article-Highlights`).

**Example:**
`2026-03-15_143005_KnowledgeArchitect_Propose-RAG-Concept.md`

---

# LOG STRUCTURE (YAML METADATA)

Every log file MUST begin with a YAML frontmatter block to enable automated analysis, indexing, and dashboarding.

```yaml
---
timestamp: YYYY-MM-DDTHH:MM:SSZ
agent: Agent Name
task: Task Description
status: success | failure
human_reviewed: false        # Default to false for user verification
related_logs:                # Graph-based tracing (flat links)
  - YYYY-MM-DD_HHMMSS_Agent_PreviousTask.md
skills_used:                 # For system debugging and optimization
  - skill-name
delta: "+X Output, -Y Inbox"   # High-signal summary of vault changes
affected_files:
  - path/to/file.md
log_version: 1.0
---
```

---

# REQUIRED LOG SECTIONS

### 1. User Request
The original prompt or trigger that initiated the action.

### 2. Reasoning Summary
A concise explanation of the logic used. This MUST include any specific "Protocols" or "Rules" (e.g., `INBOX_PROCESSING_PROTOCOL.md`) that guided the behavior.

### 3. Files Read
A list of all files accessed during the research phase.

### 4. Files Modified / Created
A precise list of files changed, created, moved, or deleted.

### 5. Outcome & Impact
A summary of the final state. What was achieved? How does this change the system's knowledge or organization?

---

# LOGGING RULES (STRICT ENFORCEMENT)

1. **No Silent Actions:** If a file is modified, moved, or created, a log MUST be generated.
2. **Immutability:** Logs must never be deleted or edited after creation.
3. **Location:** Logs must be stored in daily folders: `logs/YYYY-MM-DD/`.
4. **Human Readable:** While data-rich, logs must remain legible in Obsidian for human review.
5. **No Credentials:** Logs must never contain API keys, passwords, or sensitive personal data.
6. **Surgical Precision:** When reading logs for context, agents should use `grep_search` on YAML fields to minimize token usage.

---

# LOG ARCHIVAL & ROTATION

* **Active Logs:** Current month's logs remain in the main `logs/` directory.
* **Archival:** Older logs may be moved to a long-term archive after 90 days, provided the system state remains searchable.

---

# FINAL PRINCIPLE

The Log is the **Memory of the Machine**.

Just as the Galaxy maps human understanding, the Logs map system action.
A system without a perfect log is a system that cannot learn from its mistakes.

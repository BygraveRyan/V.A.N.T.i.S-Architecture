# INBOX_PROCESSING_PROTOCOL

Version: 1.0
Applies To: 01_HUMAN/Inbox

---

# PURPOSE

The Inbox is the **capture layer of the VANTIS system**.

It acts as a temporary holding area for raw information before it is processed into structured knowledge.

Examples of Inbox content include:

* quick ideas
* research notes
* meeting notes
* article highlights
* AI-generated outputs
* voice note transcriptions
* temporary reminders

The Inbox should be treated as a **processing queue**, not long-term storage.

No note should remain in the Inbox indefinitely.

---

# CORE PRINCIPLE

The Inbox prioritizes **speed of capture over structure**.

When capturing ideas, the goal is to record information quickly without worrying about formatting, linking, or categorization.

Structure is applied later during processing.

---

# INBOX PROCESSING PIPELINE

All Inbox items should pass through the following pipeline:

```
CAPTURE → CLARIFY → ROUTE → ARCHIVE
```

Each stage progressively transforms raw information into structured knowledge.

---

# STAGE 1 — CAPTURE

Information enters the system and is stored in the Inbox.

Location:

```
01_HUMAN/Inbox
```

Examples of Inbox files:

```
idea-rag-systems.md
note-data-pipelines.md
article-transformer-architecture.md
ai-summary-knowledge-graphs.md
```

At this stage:

* formatting is optional
* metadata is not required
* linking is not required

The only goal is **capturing the idea before it is lost**.

---

# STAGE 2 — CLARIFY

During processing, each Inbox item should be reviewed and clarified.

Questions to ask:

* What does this information mean?
* Is this useful knowledge?
* Is this temporary information?
* Does this relate to an existing concept?

Clarification may involve:

* rewriting unclear notes
* extracting key insights
* removing unnecessary information

The goal is to determine the **true value of the note**.

---

# STAGE 3 — ROUTE

After clarification, the note should be routed to the appropriate location.

Possible destinations include:

```
01_HUMAN/Knowledge/Galaxy
01_HUMAN/Projects
01_HUMAN/Personal
01_HUMAN/Tasks
02_MACHINE
```

Routing depends on the nature of the information.

---

# ROUTING GUIDELINES

### Route to Galaxy

Send notes to the Galaxy when they contain **reusable conceptual knowledge**.

Examples:

* explanations of technical systems
* general principles
* conceptual frameworks

Example:

```
idea-rag-systems.md
↓
concept-rag-architectures.md
```

---

### Route to Projects

Send notes related to **specific ongoing work**.

Examples:

* project plans
* research tasks
* implementation notes

Location:

```
01_HUMAN/Projects
```

---

### Route to Personal

Send notes related to personal reflection or life management.

Examples:

* personal goals
* reflections
* journaling

Location:

```
01_HUMAN/Personal
```

---

### Route to Tasks

Send actionable items to the task system.

Examples:

* to-do items
* reminders
* action steps

Location:

```
01_HUMAN/Tasks
```

---

### Route to Output

Send AI-generated content or temporary analytical work here.

Examples:

* AI research summaries
* brainstorming sessions
* generated reports

Location:

```
02_MACHINE
```

AI outputs should **not enter the Galaxy directly**.

They must first be reviewed and curated.

---

# STAGE 4 — ARCHIVE

After routing and generating synthesis (in 02_MACHINE), the original Inbox note MUST be moved to:

```
01_HUMAN/Inbox/Archive
```

This ensures:

1. No human knowledge is lost.
2. The Inbox remains clean and manageable.
3. Raw input is preserved for future reference or re-analysis.

---

# PROCESSING FREQUENCY

Inbox processing should occur regularly.

Recommended cadence:

Daily:

* quick scan for urgent items

Weekly:

* full Inbox processing session

This prevents the Inbox from accumulating large amounts of unprocessed information.

---

# AGENT RESPONSIBILITY

Primary responsible agent:

```
Inbox Processor
```

Responsibilities include:

* reviewing new Inbox entries
* summarizing raw notes
* identifying useful insights
* routing notes to the correct destination

Agents should assist with processing but **final knowledge decisions require human judgment**.

---

# INBOX HEALTH RULE

A healthy Inbox should remain small.

Recommended size:

```
0–20 notes
```

If the Inbox grows significantly larger, the processing workflow is not functioning correctly.

---

# FINAL PRINCIPLE

The Inbox is a **temporary staging area for thought**.

Its purpose is to capture information quickly and move it into the correct system layer.

Long-term knowledge belongs in the Galaxy.

Temporary thinking belongs in Output or Projects.

The Inbox itself should remain **empty most of the time**.

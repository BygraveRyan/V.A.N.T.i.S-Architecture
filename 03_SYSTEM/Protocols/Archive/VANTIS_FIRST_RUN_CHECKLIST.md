\# VANTIS FIRST RUN CHECKLIST

Purpose: Verify that the VANTIS cognitive system is operational.

Goal: Ensure the architecture works in practice before expanding the system.

---

# ~~STEP 1 — Create Repository Structure~~

Confirm the repository contains the core system files.

Required files:

~~BOOT_IMAGE.md~~ 
~~GEMINI.md~~
~~AGENTS.md~~
~~RULES.md~~
~~VAULT_MAP.md~~
~~METADATA_SCHEMA.md~~
~~AGENT_PERMISSIONS.md~~
~~GALAXY_LINKING_RULES.md~~
~~GALAXY_NOTE_TEMPLATE.md~~
~~INBOX_PROCESSING_PROTOCOL.md~~
~~MEMORY_CURATION_PROTOCOL.md~~

If any file is missing, create it before proceeding.

---

# ~~STEP 2 — Create Vault Structure~~

Inside the vault folder, create the following directories.

03_SYSTEM/Protocols
01_HUMAN/Inbox
01_HUMAN/Knowledge/Galaxy
01_HUMAN/Projects
01_HUMAN/Personal
01_HUMAN/Tasks
02_MACHINE

This vault is the long-term memory layer of VANTIS.

---

# ~~STEP 3 — Create First Inbox Entry~~

Create a file in:

01_HUMAN/Inbox

Example:

idea-rag-systems.md

Content example:

RAG architectures allow LLMs to retrieve external knowledge rather than relying solely on training data.

Goal: verify the capture stage of the system.

---

# ~~STEP 4 — Process the Inbox Entry~~

Apply the Inbox Processing Protocol.

Ask:

Is this reusable knowledge?

If yes → convert it into a concept.

---

# STEP 5 — Create First Galaxy Concept

~~Create a file in:~~

~~01_HUMAN/Knowledge/Galaxy~~

~~Example:~~

~~concept-rag-architectures.md~~

~~Use the Galaxy note template.~~

~~Example structure:~~

---

id: concept-rag-architectures
type: concept
status: evergreen

domain:

* ai-systems

related_domains:

* information-retrieval

level: intermediate

created:
updated:

source: human
confidence: high

related_concepts:

* concept-vector-databases
* concept-semantic-search

tags:

* rag
* ai-systems

---

# Concept

Retrieval Augmented Generation (RAG) is an architecture that allows language models to retrieve external information before generating responses.

---

# Explanation

RAG systems connect LLMs with retrieval systems such as vector databases.

Instead of relying purely on training data, the model retrieves relevant documents and incorporates them into the generation process.

---

# Related Concepts

[[concept-vector-databases]]

[[concept-semantic-search]]

---

# ~~STEP 6 — Create Two Supporting Concepts~~

Create at least two additional Galaxy notes.

Examples:

concept-vector-databases.md
concept-semantic-search.md

Link them together.

This verifies that the **knowledge graph works**.

---

# ~~STEP 7 — Confirm Graph Connectivity~~

Open the Obsidian Graph View.

You should see a small network:

rag architectures
vector databases
semantic search

This confirms the Galaxy concept graph is operational.

---

# STEP 8 — Create First AI Output

Create a file in:

02_MACHINE

Example:

ai-summary-rag.md

Purpose: verify separation between AI output and human knowledge.

---

# STEP 9 — Perform First Memory Curation

Review the AI output.

Extract any reusable concepts.

If valid, convert them into Galaxy concepts.

This validates the **Information → Insight → Concept pipeline**.

---

# STEP 10 — Verify Logging

Create a log entry.

Example location:

logs/2026-03-16/

Example file:

interaction-log.md

Example entry:

timestamp: 2026-03-16T19:20:00Z
user_request: "Created first Galaxy concepts"
agent_activated: Memory Curator
files_modified:

* concept-rag-architectures.md
* concept-vector-databases.md
  reasoning_summary: "Converted inbox idea into structured concepts"
  outcome: success

Logs ensure traceability and system auditing.

---

# SUCCESS CRITERIA

VANTIS is considered operational when the following conditions are true.

✓ Inbox capture works
✓ Inbox processing works
✓ Concept creation works
✓ Galaxy linking works
✓ AI output separation works
✓ Memory curation works
✓ Logging works

Once all checks pass, the system is ready for real use.

---

# IMPORTANT RULE

Do not expand the architecture until you have at least:

20 Galaxy concepts

Architecture improvements should only occur after real usage reveals system needs.

The purpose of VANTIS is to support thinking, not endless system design.

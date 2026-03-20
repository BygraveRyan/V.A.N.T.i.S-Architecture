# AGENT_PERMISSIONS.md

VANTIS Agent Domain Permissions

Version: 1.0

---

# Purpose

This document defines **knowledge access permissions** for VANTIS agents.

Permissions restrict which areas of the vault an agent can read or modify.

This improves:

• system safety
• domain accuracy
• agent specialization

Agents must operate only within their authorized knowledge domains.

---

# Permission Types

Each agent is assigned three permission categories.

```
read_access
write_access
restricted_paths
```

---

# Knowledge Architect

Purpose

Build and maintain the Galaxy knowledge graph.

---

Read Access

```
02_KNOWLEDGE/Galaxy
02_KNOWLEDGE/Resources
03_PROJECTS
```

Write Access

```
06_OUTPUT
```

Restricted

```
logs
00_SYSTEM
```

---

# Memory Curator

Purpose

Transform insights into structured knowledge.

---

Read Access

```
01_INBOX
02_KNOWLEDGE/Galaxy
03_PROJECTS
06_OUTPUT
```

Write Access

```
06_OUTPUT
04_PERSONAL/Daily
```

Restricted

```
00_SYSTEM
logs
```

---

# Inbox Processor

Purpose

Organize and categorize incoming information.

---

Read Access

```
01_INBOX
```

Write Access

```
02_KNOWLEDGE
03_PROJECTS
05_TASKS
06_OUTPUT
```

Restricted

```
logs
00_SYSTEM
```

---

# Research Analyst

Purpose

Perform research synthesis.

---

Read Access

```
02_KNOWLEDGE
03_PROJECTS
```

Write Access

```
06_OUTPUT
```

Restricted

```
00_SYSTEM
logs
```

---

# Security Architect

Purpose

Develop security architectures and review security documentation.

---

Read Access

```
02_KNOWLEDGE/Resources/Security
03_PROJECTS/Security
```

Write Access

```
03_PROJECTS/Security
06_OUTPUT
```

Restricted

```
04_PERSONAL
02_KNOWLEDGE/Galaxy
logs
```

---

# LinkedIn / Marketing Strategist

Purpose

Develop professional visibility and marketing content.

---

Read Access

```
03_PROJECTS
02_KNOWLEDGE
```

Write Access

```
06_OUTPUT
```

Restricted

```
04_PERSONAL
logs
00_SYSTEM
```

---

# System Safety Rules

Agents must never modify:

```
BOOT_IMAGE.md
GEMINI.md
AGENTS.md
RULES.md
METADATA_SCHEMA.md
AGENT_PERMISSIONS.md
```

System configuration files may only be modified with explicit user approval.

---

# Future Expansion

New agents must define:

```
domain expertise
allowed knowledge domains
operational scope
```

before being activated within VANTIS.

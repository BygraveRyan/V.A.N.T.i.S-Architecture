# AGENT_PERMISSIONS.md

VANTIS Agent Domain Permissions

Version: 1.2

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
[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy
[REDACTED_PERSONAL_VAULT]/Knowledge/Resources
[REDACTED_PERSONAL_VAULT]/Projects
```

Write Access

```
02_MACHINE
```

Restricted

```
logs
03_SYSTEM/Protocols
```

---

# Memory Curator

Purpose

Transform insights into structured knowledge.

---

Read Access

```
[REDACTED_PERSONAL_VAULT]/Inbox
[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy
[REDACTED_PERSONAL_VAULT]/Projects
02_MACHINE
```

Write Access

```
02_MACHINE
[REDACTED_PERSONAL_VAULT]/Daily
```

Restricted

```
03_SYSTEM/Protocols
logs
```

---

# Inbox Processor

Purpose

Organize and categorize incoming information.

---

Read Access

```
[REDACTED_PERSONAL_VAULT]/Inbox
```

Write Access

```
[REDACTED_PERSONAL_VAULT]/Knowledge
[REDACTED_PERSONAL_VAULT]/Projects
[REDACTED_PERSONAL_VAULT]/Tasks
02_MACHINE
```

Restricted

```
logs
03_SYSTEM/Protocols
```

---

# Research Analyst

Purpose

Perform research synthesis.

---

Read Access

```
[REDACTED_PERSONAL_VAULT]/Knowledge
[REDACTED_PERSONAL_VAULT]/Projects
```

Write Access

```
02_MACHINE
```

Restricted

```
03_SYSTEM/Protocols
logs
```

---

# Security Architect

Purpose

Develop security architectures and review security documentation.

---

Read Access

```
[REDACTED_PERSONAL_VAULT]/Knowledge/Resources/Security
[REDACTED_PERSONAL_VAULT]/Projects/Security
```

Write Access

```
[REDACTED_PERSONAL_VAULT]/Projects/Security
02_MACHINE
```

Restricted

```
[REDACTED_PERSONAL_VAULT]/Personal
[REDACTED_PERSONAL_VAULT]/Knowledge/Galaxy
logs
```

---

# LinkedIn / Marketing Strategist

Purpose

Develop professional visibility and marketing content.

---

Read Access

```
[REDACTED_PERSONAL_VAULT]/Projects
[REDACTED_PERSONAL_VAULT]/Knowledge
```

Write Access

```
02_MACHINE
```

Restricted

```
[REDACTED_PERSONAL_VAULT]/Personal
logs
03_SYSTEM/Protocols
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

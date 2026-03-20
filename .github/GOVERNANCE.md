# V.A.N.T.i.S — GITHUB GOVERNANCE

Version: 2.0

---

## 1. PURPOSE

This document defines the rules and protocols for managing the V.A.N.T.i.S repository on GitHub.

The goal is to ensure:

• system integrity  
• traceability of all changes  
• alignment with VANTIS architecture  
• safe evolution of the cognitive system  

GitHub is the **distributed system state**.  
VANTIS logs are the **source of truth for reasoning**.

---

## 2. BRANCHING STRATEGY

### 2.1 Branch Naming Convention

Branches MUST follow:
<type>/<description>

| Type | Description | Example |
|------|------------|--------|
| feat/ | New features or system layers | feat/v-next |
| fix/ | Bug fixes or rule enforcement | fix/logging-gap |
| agent/ | Agent-specific logic | agent/inbox-processor-upgrade |
| skill/ | Skill creation or modification | skill/precedent-detection |
| docs/ | Documentation updates | docs/vault-map-update |

---

### 2.2 Main Branch Policy

• `main` is the stable branch  
• Direct commits to `main` are prohibited  
• All changes must go through Pull Requests  

---

## 3. COMMIT & PR PROTOCOL

### 3.1 Commit Structure (Why / How / Impact)

All commits MUST follow:
<type>(<scope>): <short summary>

Each commit must include:

• WHY — problem or motivation  
• HOW — implementation details  
• IMPACT — system-level outcome  
• TRACEABILITY — linked VANTIS log  

---

### 3.2 Commit Scope

Commits should include scope when relevant:

Examples:
feat(skill): precedent detection
fix(logging): missing audit entries
docs(vault): update structure

---

### 3.3 Unit of Change

Each commit must represent a **single logical system change**.

Valid:

• one skill addition  
• one agent modification  
• one protocol update  

Invalid:

• multiple unrelated changes  
• mixing logic + refactor + docs  

Each commit must be:

• independently understandable  
• independently reversible  

---

### 3.4 Pull Request Requirements

All PRs MUST:

• use `PULL_REQUEST_TEMPLATE.md`  
• include linked audit logs  
• define affected VANTIS layers  
• summarise vault changes  

---

## 4. VAULT SYNCHRONIZATION RULES

### 4.1 What to Commit

• `.github/` — governance and templates  
• `.gemini/` — skills and system logic  
• `logs/` — full audit history  
• `vault/00_SYSTEM/` — system rules and configs  
• `vault/03_PROJECTS/` — project state  
• `vault/05_TASKS/` — tasks  
• `vault/06_OUTPUT/` — AI synthesis  

---

### 4.2 What NOT to Commit

• `vault/04_PERSONAL/` — private data  
• `vault/02_KNOWLEDGE/Galaxy/` — human knowledge (local-first)  
• `.env` — secrets  
• `.obsidian/workspace.json` — local state  

---

## 5. REPOSITORY SECURITY

• No API keys, credentials, or PII may be committed  
• Security-sensitive changes require review by Security Architect  

---

## 6. TRACEABILITY STANDARD

Every system change must follow:
Log → Commit → Pull Request

Rules:

• Every commit must link to a log  
• Every PR must link to logs  
• Logs must describe reasoning and actions  

If a change exists in GitHub, it must exist in logs.  
If it exists in logs, it must be traceable in GitHub.

---

## 7. MERGE CRITERIA

A Pull Request may only be merged if:

• Logging is complete and linked  
• No violation of Galaxy protection rules  
• Changes follow unit-of-change principle  
• No sensitive data is included  
• Behaviour has been validated  

High-risk changes require manual review.

---

## 8. RISK MANAGEMENT

Changes must be evaluated for system impact.

Risk levels:

• LOW — documentation, non-critical updates  
• MEDIUM — skills, agent logic  
• HIGH — system rules, memory handling  

High-risk changes must include rollback strategy.

---

## 9. FINAL PRINCIPLE

This repository is not just code.

It is the **version-controlled evolution of a cognitive system**.

Every commit represents a change in how the system thinks.
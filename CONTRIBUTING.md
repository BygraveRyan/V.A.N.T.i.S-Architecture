# CONTRIBUTING TO V.A.N.T.i.S.

Welcome to the **Vectorised Astral Navigation & Thought Intelligence System**. This is not just a repository of code; it is a repository of **Cognitive Architecture**. To ensure the system remains reliable and high-signal, we follow a strict AI-native engineering protocol.

---

## 🏗️ 1. ARCHITECTURAL INTEGRITY
All changes must align with the **6-Layer Architecture** (Identity, Intelligence, Agent, Skill, Memory, Logging) as defined in the `README.md`.

### The Mechanism-to-Value Loop
Before making any changes, an AI agent or human contributor must follow the 4-step execution loop:
1. **PLAN**: Define the approach and the verification strategy.
2. **ACT**: Apply targeted changes using surgical tools (like `sed`, `replace`, or `gh`).
3. **VALIDATE**: Run tests or manual checks to confirm success.
4. **LOG**: Create a high-fidelity audit log in `logs/YYYY-MM-DD/`.

---

## 🌿 2. BRANCHING STRATEGY
V.A.N.T.i.S. enforces **Rule 11 (Branched Evolution)**. Direct commits to `main` are prohibited.

- `feat/`: New architectural layers, skills, or capabilities.
- `fix/`: Bug fixes, protocol repairs, or data sanitization.
- `docs/`: Updates to protocols, system diagrams, or the README.
- `skill/`: Creation or modification of specific AI skills in `.gemini/skills/`.

---

## 📝 3. COMMIT & PR STANDARDS

### Why / How / Impact
We use a structured commit format to maximize "Portfolio Signal" and technical traceability.

**Example Commit Message:**
```text
feat(skill): implement autonomous secret scanning

## WHY
- To prevent PII leaks during automated portfolio synchronization.

## HOW
- Created '.gemini/hooks/secret-scanner.js'.
- Updated 'RULES.md' to include mandatory pre-commit scanning.

## IMPACT
- Reduces the risk of credential leakage to 0% in public-facing PRs.

## TRACEABILITY
Log: logs/2026-03-22/2026-03-22_120000_Guardian_Secret-Scanning.md
```

### Pull Request Requirements
Every PR must:
1.  Use the `PULL_REQUEST_TEMPLATE.md`.
2.  Include **Technical Storytelling** in the description.
3.  Link to the relevant **Audit Logs**.
4.  Specify affected layers (e.g., "Intelligence Layer", "Memory Layer").

---

## 🔐 4. SECURITY & PRIVACY
V.A.N.T.i.S. is built on a "Private Core / Public Mirror" model.
- **Never** commit data from `[REDACTED_PERSONAL_VAULT]/Personal/`, `[REDACTED_PERSONAL_VAULT]/Inbox/`, or private `[REDACTED_PERSONAL_VAULT]/Projects/`.
- **Always** verify your `publish-mirror.sh` whitelist before pushing updates to the public repo.

---
*By contributing to V.A.N.T.i.S., you are helping build the future of AI-native knowledge engineering.*

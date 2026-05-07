# OPENROUTER HANDOFF TEMPLATE
Version: 1.1.0
Status: ACTIVE
Author: V.A.N.T.i.S. Intelligence Layer

---

## 1. MISSION CONTEXT
- **OBJECTIVE**: [High-level goal of the build task]
- **TARGET LANE**: [continuity, cheap, build]
- **TARGET MODEL**: [deepseek/deepseek-v3, meta-llama/llama-3.1-405b, etc.]
- **TICKET/ISSUE**: [Reference to issue or draft]

---

## 2. ZERO-TRUST SECURITY CHECKLIST (MANDATORY)
> **WARNING**: For offshore/open-weight models (e.g., DeepSeek), strict data sovereignty is required.
- [ ] NO naked/plain-text URLs.
- [ ] NO plain-text API keys or credentials.
- [ ] NO corporate finance, accounting, or payroll data.
- [ ] NO healthcare or sensitive PII.
- [ ] NO "Planet-Changing" / High-Value proprietary IP.
- [ ] Context scrubbed for internal secrets.

---

## 3. REQUIRED CONTEXT (FILE PATHS)
- [ ] `SHARED_RULES.md` (Rules)
- [ ] `CLAUDE.md` / `GEMINI.md` / `CODEX.md` (Agent Instructions)
- [ ] `02_MACHINE/State/session-state_LATEST.md`
- [ ] [Specific project folder or file required for the build]

---

## 4. EXECUTION STEPS
1. [ ] Step 1...
2. [ ] Step 2...
3. [ ] Step 3...

---

## 5. GOVERNANCE & CONSTRAINTS
- **LOG REFLEX**: All changes must be written to `logs/YYYY-MM-DD/openrouter-build.md`.
- **NO GALAXY WRITES**: Synthesis lands in `02_MACHINE/`. Never write to `private workspace/Knowledge/Galaxy`.
- **ASV REFLEX**: Increment versions for protocol or system-file changes.

---

## 6. RECOVERY & VALIDATION
- **FAILURE MODE**: [Instructions for what to do if the model hallucinate or errors]
- **VALIDATION CMD**: [e.g., npm test, ruff check, tsc]

# TASK: VANTIS GitHub CLI Migration
**Status:** Staged  
**Priority:** High  
**Context:** Workspace Intelligence  

---

## 🎯 OBJECTIVE
Transition the V.A.N.T.i.S. GitHub operations from the **GitHub MCP Server** to the **GitHub CLI (`gh`)**. This move aims to increase "Workspace Richness," enabling deeper agentic control over Actions, Secrets, and Repository Governance.

---

## 🏗️ IMPLEMENTATION PHASES

### Phase 1: Environment Verification
- [x] Check `gh auth status` for active sessions.
- [x] Verify `gh extension list` for any required VANTIS extensions (e.g., `gh-poi` or `gh-dash`).

### Phase 2: Skill Definition
- [x] Create `.gemini/skills/github-ops/SKILL.md`.
- [x] Define **Output Rules**: Always use `--json` to provide structured data to the Intelligence Layer.
- [x] Define **Security Rules**: Use `gh secret` for credential rotation; never print tokens in logs.

### Phase 3: Command Integration
- [x] Implement `/gh:pr`: Enhanced PR review with `gh pr diff`.
- [x] Implement `/gh:run`: Monitor and fix failed GitHub Actions.
- [x] Implement `/gh:issue`: Advanced issue management with project board integration.

### Phase 4: Migration & Deprecation
- [x] Update `GEMINI.md` to prioritize `gh` over MCP tools.
- [x] Disable/Remove GitHub MCP server after validation. (VANTIS configuration updated)

---

## 🧠 STRATEGIC VALUE
- **Native Reach**: Access to `gh api` for anything not covered by standard commands.
- **Traceability**: All interactions are logged as local shell commands.
- **Performance**: Faster response times than the MCP bridge.

---
*Created 2026-03-20 | Intelligence Layer*

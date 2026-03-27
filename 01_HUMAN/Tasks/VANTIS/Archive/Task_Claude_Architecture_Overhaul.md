# TASK: Claude Architecture Overhaul
Version: 1.0
Status: APPROVED — AWAITING EXECUTION
Branch: `feat/claude-architecture`
Skill: `architectural-designer`
Created: 2026-03-26

---

## 1. Background & Motivation

V.A.N.T.i.S. is declared model-agnostic in `CLAUDE.md` v1.8 and `AGENTS.md` v1.7. However, the current implementation is asymmetric: Gemini CLI has a fully built-out native layer (hooks, slash commands, skill wiring, session context injection) while Claude Code has a near-empty `.claude/` config with only one permission rule.

This creates three concrete risks:
- **Context Gap**: Claude does not receive the repo-map on session start (Gemini gets it automatically via `repo-map.sh`). Claude has to be manually oriented.
- **Reflex Gap**: The `audit-logger` skill has no automated trigger for Claude. Logging depends entirely on Claude remembering to apply it — a governance violation risk.
- **Command Gap**: The 8 Gemini slash commands (`/daily`, `/eod`, `/inbox`, `/resume`, `/gh:*`) have no Claude equivalents. Ryan must context-switch to Gemini CLI to run operational workflows.

**Goal**: Bring Claude Code to full operational parity with Gemini CLI within the V.A.N.T.i.S. multi-agent architecture — without merging agent configs or breaking Gemini's layer.

---

## 2. Scope & Impact (Dependency Map)

### Files Modified (CSR Watch List)

| File | Tier | ASV Logic | Change |
| :--- | :--- | :--- | :--- |
| `CLAUDE.md` | Tier 1 | Major.Minor | Add Claude Command Reference section |
| `AGENTS.md` | Tier 1 | Major.Minor | Document parallel `.claude/` + `.gemini/` architecture pattern |
| `.gemini/SKILLS_INDEX.md` | Tier 3 | Patch | Add note: skills are agent-agnostic, readable by both agents |
| `03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md` | Tier 3 | Patch | Add `.claude/` entries to the watch list |

### New Files Created (Not Yet in CSR)

| File | Purpose |
| :--- | :--- |
| `.claude/commands/daily.md` | Claude slash command — daily session review |
| `.claude/commands/eod.md` | Claude slash command — end-of-day master audit |
| `.claude/commands/inbox.md` | Claude slash command — inbox audit and routing |
| `.claude/commands/resume.md` | Claude slash command — deterministic session resumption |
| `.claude/commands/gh-pr.md` | Claude slash command — PR review |
| `.claude/commands/gh-issue.md` | Claude slash command — issue management |
| `.claude/commands/gh-pulse.md` | Claude slash command — pulse sync backup |
| `.claude/commands/gh-publish.md` | Claude slash command — portfolio mirror deployment |
| `.claude/settings.local.json` | Expanded: SessionStart hook + PostToolUse audit reflex + full permissions |

### Files Intentionally NOT Modified

| File | Reason |
| :--- | :--- |
| `.gemini/settings.json` | Gemini layer — must not be touched |
| `.gemini/commands/*.toml` | Gemini layer — Claude has its own format |
| `.gemini/skills/*/SKILL.md` | Agent-agnostic already — no changes needed |
| `03_SYSTEM/Protocols/*` | READ ONLY — except CORE_SYSTEM_REGISTRY.md (Tier 3) |
| `01_HUMAN/Knowledge/Galaxy/*` | NO GALAXY WRITES |

### Downstream Impact Assessment

- **Gemini**: Zero impact. All changes are isolated to `.claude/`.
- **Obsidian**: Zero impact. No vault structure changes.
- **Session State handoff**: No impact — both agents already share `02_MACHINE/State/`.
- **Public Mirror** (`publish-mirror.sh` whitelist): `.claude/` is not in the whitelist — it will NOT be published to the public portfolio repo. This is correct behaviour (agent config is private).

---

## 3. Proposed Solution

### Architecture Principle: Parallel Layers, Shared Vault

```
SHARED (agent-agnostic)              AGENT-SPECIFIC (native wiring)
────────────────────────             ──────────────────────────────
vault/                               .gemini/          .claude/
AGENTS.md                              hooks/            commands/
CLAUDE.md                              commands/         settings.local.json
GEMINI.md                              skills/  ◄── both agents read from here
03_SYSTEM/Protocols/ (protocols)           settings.json
02_MACHINE/ (session state)
logs/ (audit trail)
```

Skills remain in `.gemini/skills/` — they are pure Markdown and readable by any agent. The location is irrelevant to Claude since Claude reads the full directory. Neither agent's config bleeds into the other.

### Hook Strategy for `.claude/settings.local.json`

Claude Code's `settings.local.json` supports hooks on lifecycle events:

| Hook Event | Purpose | Maps To |
| :--- | :--- | :--- |
| `PreToolUse` on `Bash` | None required at this time | — |
| `PostToolUse` on `Write`/`Edit` | Remind Claude to trigger audit-logger | Replaces missing Log Reflex automation |
| `Stop` | Prompt session state update if handoff | Mirrors Gemini hand-off protocol |

> Note: Claude Code hooks are advisory/contextual — they inject prompts, not execute scripts autonomously like Gemini's `SessionStart`. The repo-map will be handled via the `resume` command instead.

### Claude Slash Commands Strategy

Claude Code supports project-level slash commands as `.md` files in `.claude/commands/`. Each file's content becomes the command prompt. Commands will be functionally equivalent to their `.gemini/commands/*.toml` counterparts but use Claude's native format and tooling.

---

## 4. Implementation Steps

### Phase 1 — Branch & Permissions Foundation
1. Create branch `feat/claude-architecture` from `main`.
2. Expand `.claude/settings.local.json`:
   - Add `PostToolUse` hook on `Write` and `Edit` to inject audit-logger reminder.
   - Add `Stop` hook to prompt session state update.
   - Add full `permissions.allow` ruleset covering: `Bash(git *)`, `Bash(gh *)`, `Bash(node .gemini/hooks/*)`, `Bash(ls *)`, `Bash(find *)`.

### Phase 2 — Claude Slash Commands
3. Create `.claude/commands/` directory.
4. Write 8 command files (Claude `.md` format, equivalent prompts to Gemini `.toml` commands):
   - `resume.md` — includes repo-map injection logic (compensates for missing SessionStart hook)
   - `daily.md`
   - `eod.md`
   - `inbox.md`
   - `gh-pr.md`
   - `gh-issue.md`
   - `gh-pulse.md`
   - `gh-publish.md`

### Phase 3 — Protocol Updates
5. Update `CLAUDE.md` — add **Claude Command Reference** section listing all 8 commands + their triggers. Run ASV reflex.
6. Update `AGENTS.md` — add **Parallel Agent Config Pattern** section documenting the `.claude/` + `.gemini/` architecture. Run ASV reflex.
7. Update `.gemini/SKILLS_INDEX.md` — add agent-agnostic note. Run ASV reflex.
8. Update `03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md` — add `.claude/` entries. Run ASV reflex.

### Phase 4 — Finality
9. Generate Gold Standard Audit Log in `logs/2026-03-26/`.
10. Update `02_MACHINE/State/session-state_2026-03-26.md`.
11. Commit all changes on `feat/claude-architecture`.
12. Open PR → `main` using `github-ops` skill + `extract-pr-body.sh`.

---

## 5. Verification & Testing

| Test | Pass Criteria |
| :--- | :--- |
| Slash commands discoverable | All 8 appear in Claude Code's `/` command list |
| `/resume` command | Correctly loads latest session state and recent logs |
| `/eod` command | Generates audit to `02_MACHINE/Daily/` |
| `/gh:pulse` equivalent | `pulse-sync.sh` executes without error |
| Permissions | No permission prompts for standard git/gh/node ops |
| Gemini unaffected | `gemini` CLI session still loads `repo-map` on start; all `.toml` commands intact |
| CSR integrity | All modified Tier 1/3 files have incremented versions |
| No Galaxy writes | `01_HUMAN/Knowledge/Galaxy/` unchanged |
| Audit log present | `logs/2026-03-26/` contains a compliant Gold Standard log |

---

## 6. Rollback Strategy

All changes are isolated to:
- `.claude/` directory (new files — simply delete)
- `CLAUDE.md`, `AGENTS.md`, `.gemini/SKILLS_INDEX.md`, `CORE_SYSTEM_REGISTRY.md` (tracked in git — revert to `main`)

Since this branch does not touch `vault/` structure, Gemini's config, or the Galaxy, rollback is a single `git revert` or branch deletion with zero downstream impact.

```bash
# Full rollback if needed
git checkout main
git branch -D feat/claude-architecture
```

---

## 📋 Execution Checklist

- [ ] Phase 1: Branch created + `settings.local.json` expanded
- [ ] Phase 2: All 8 `.claude/commands/*.md` files written
- [ ] Phase 3: `CLAUDE.md` updated + ASV run
- [ ] Phase 3: `AGENTS.md` updated + ASV run
- [ ] Phase 3: `SKILLS_INDEX.md` updated + ASV run
- [ ] Phase 3: `CORE_SYSTEM_REGISTRY.md` updated + ASV run
- [ ] Phase 4: Audit log generated
- [ ] Phase 4: Session state updated
- [ ] Phase 4: PR opened to `main`
- [ ] Dashboard updated (`VANTIS_Upgrade_Dashboard.md`)

---
*Architectural Designer Skill v1.0.1 | V.A.N.T.i.S. Core Protocol*

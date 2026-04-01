---
title: Codex VANTIS Adherence And Command Parity
status: in_progress
priority: high
agent: Codex
branch: fix/codex-vantis-adherence
created: 2026-04-01
updated: 2026-04-01
---

# TASK: Codex VANTIS Adherence And Command Parity

## Background & Motivation
Codex currently has three confirmed VANTIS integration gaps that materially affect safe execution parity:
- weaker audit-hook coverage for shell-based file changes
- missing `diagnose` command parity
- missing `gh/run` command parity

The deeper adherence review also exposed a broader routing problem: Codex followed outdated task-location guidance and initially targeted `01_HUMAN/Tasks/` instead of the current architecture-change task pattern in `03_SYSTEM/Roadmap/`.

Canonical routing decision for this task class:
- VANTIS system, architecture, protocol, agent-layer, parity, and upgrade work belongs in `03_SYSTEM/Roadmap/`
- `01_HUMAN/...` is reserved for personal or human-centered work

This task exists to make Codex follow that system consistently, not merely to add missing commands.

## Scope & Impact
Planned scope covers Codex adherence to current VANTIS system rules and the minimum parity needed for safe operation.

Expected areas:
- `.codex/settings.json`
- `.codex/commands/diagnose.md`
- `.codex/commands/gh/run.md`
- `.codex/commands/gh-run.md`
- `.codex/commands/gh-pr.md`
- `.codex/commands/gh-issue.md`
- `.codex/commands/inbox.md`
- `.codex/commands/daily.md`
- `CODEX.md`
- any canonical architecture or skill-routing documents required to resolve roadmap-vs-human task ambiguity
- any shared skill files that still encode the old routing pattern for architecture/system work

## Proposed Solution
1. Expand Codex hook coverage so shell-driven mutations are captured by the session ledger with stronger parity to Claude/Gemini behavior.
2. Add Codex command definitions for `diagnose` and `gh/run`, preserving both nested and alias command patterns where needed.
3. Remove stale Codex prompt references to `01_HUMAN/Tasks/VANTIS/` or other superseded system-task patterns.
4. Trace why Codex selected the wrong planning location, then update the canonical guidance so future architecture/system planning routes deterministically to `03_SYSTEM/Roadmap/`.
5. Align shared skill guidance where it still points architecture/system plans to the old human task layer.

## Implementation Steps
- [x] Persist this approved task in `03_SYSTEM/Roadmap/`.
- [x] Create a dedicated branch for the Codex parity work.
- [x] Update Codex hook configuration and validate shell-mutation capture behavior at the config level.
- [x] Add Codex `diagnose` command parity.
- [x] Add Codex `gh/run` command parity.
- [x] Audit Codex command prompts for stale routing assumptions and update them to current VANTIS architecture.
- [x] Audit shared architecture-planning and audit-log skill guidance for stale `01_HUMAN/Tasks/` system-task assumptions.
- [ ] Run final validation, audit logging, and handoff documentation.

## Verification & Testing
- inspect `git diff` for the Codex layer changes
- verify `.codex/settings.json` remains valid JSON
- verify command files exist in expected Codex paths
- confirm Codex command prompts no longer direct system work into `01_HUMAN/Tasks/VANTIS/`
- confirm architecture/system planning now points to `03_SYSTEM/Roadmap/`
- confirm personal or human-centered work still routes to `01_HUMAN/...`

## Rollback Strategy
Revert the Codex-specific settings and command files if the new hook matcher causes noisy or incorrect ledger entries, and revert any routing clarification changes that create conflicts with broader VANTIS governance.

## Review Findings Captured In Scope
- Codex shell-mutation audit coverage is currently weaker than VANTIS log-reflex expectations.
- Codex is missing `diagnose` and `gh/run`.
- Codex command prompts still contain stale `01_HUMAN/Tasks/` and `01_HUMAN/Tasks/VANTIS/` assumptions.
- Shared skills still encode outdated system-task placement guidance, which can mislead Codex even when it is trying to follow VANTIS.
- The new canonical routing rule is: system work in `03_SYSTEM/Roadmap/`, personal/human work in `01_HUMAN/...`.

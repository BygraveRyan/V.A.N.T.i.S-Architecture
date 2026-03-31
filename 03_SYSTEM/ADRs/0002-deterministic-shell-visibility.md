# ADR-0002: Deterministic Shell Mutation Visibility

**Date**: 2026-03-30
**Status**: accepted
**Deciders**: Gemini CLI (Lead) | Claude Code (Implementation)

## Context

The V.A.N.T.i.S. architecture requires 100% deterministic audit trails for all vault modifications. While agent tools (Read, Write, Edit) are natively tracked by the session ledger, manual shell commands (`sed`, `mv`, `rm`, `cat >>`) often bypass standard logging hooks, creating "silent mutations" that degrade system integrity.

## Decision

We have implemented a mandatory manual marker protocol for all shell-based file modifications. Agents MUST append a comment or include a string in the command following the pattern: `# [FILE] <path>`.

The `session-ledger.sh` hook (v1.5+) has been updated to parse this marker and include the referenced file in the automated audit log, even if it wasn't touched by a standard agent tool.

## Alternatives Considered

### Alternative 1: Full System Hooking (e.g., `fs_usage` or `auditd`)
- **Pros**: 100% automated, captures everything.
- **Cons**: High overhead, requires root/sudo, OS-specific (Darwin vs. Linux), extremely noisy output.
- **Why not**: Too heavy for a lightweight vault-management system.

### Alternative 2: Disallow Shell Mutations
- **Pros**: Cleanest audit trail.
- **Cons**: Severely limits agent autonomy for complex refactoring or batch operations.
- **Why not**: Hinders productivity and violates the "Senior Engineer" persona requirements.

## Consequences

### Positive
- 100% visibility of file changes regardless of the tool used.
- Lightweight and tool-agnostic.
- Works across all CLI environments (Claude Code, Gemini CLI, Codex).

### Negative
- Requires agent discipline (manual marker injection).
- Risk of human/agent error if the marker is forgotten.

### Risks
- **Omission Risk**: An agent forgets to add the marker. 
- **Mitigation**: The `diagnose` command will eventually verify commit diffs against audit logs to identify silent mutations.

# ADR-0011: Inbox System Optimization and Script-Based Automation

**Date**: 2026-05-06
**Status**: accepted
**Deciders**: Claude (Execution Layer) / V.A.N.T.i.S. Operator / User

## Context

The current inbox processing system (`/inbox` command + `inbox-processor` skill) has a critical reliability gap: **no mechanism to prevent duplicate processing**. When users run `/inbox` multiple times, the same items can be offered for routing again if archival logic is skipped or interrupted. This leads to:

1. **Duplicate work**: Items processed twice in different batches
2. **Lost audit trail**: No record of what's been processed and when
3. **Invisible health impact**: Inbox cleanliness doesn't affect system health scoring
4. **Manual intervention overhead**: Users must visually catch and reject duplicate routing suggestions

Additionally, the current system processes all inbox items through agent logic, consuming tokens for routine data collection, filtering, and logging—operations that could be handled by zero-token shell scripts instead.

The opportunity: Implement a **processing ledger** (shell-based) to track completed items and integrate inbox hygiene into the health scoring system, following the principle that **scripts should handle deterministic operations** (file tracking, hashing, logging) while agents focus on synthesis, routing decisions, and human communication.

## Decision

We are implementing **Inbox System Optimization (v1)** with three components:

1. **Processing Ledger** (`.gemini/hooks/inbox-ledger.sh`)
   - Append-only CSV ledger tracking all processed items
   - Fields: `processed_date`, `filename`, `file_hash`, `destination`, `status`, `archived_date`
   - Functions: `list-pending` (show unprocessed items only), `add-entry`, `check-processed`, `archive-entry`
   - Cost: 0 agent tokens (pure shell execution)
   - Prevents duplicates by filtering input to show only NEW files

2. **Health Score Integration** (`.gemini/hooks/inbox-health-check.sh`)
   - New shell script reports inbox status: unprocessed item count, age of oldest item
   - Integrated into `/diagnose` command as new section "### 7. Inbox Processing Health"
   - Health score deduction: **2 points per unprocessed item** (max -20 for 10+ items)
   - Makes inbox cleanliness visible and measurable in system health

3. **Command Updates**
   - `.gemini/commands/inbox.toml`: Filter on `list-pending` output (show only new items)
   - `.gemini/commands/diagnose.toml`: Add `inbox-health-check.sh` call + health scoring deduction

## Alternatives Considered

### Alternative 1: Agent-Based Duplicate Detection
- **Pros**: Single unified logic; can use natural language reasoning.
- **Cons**: Token-expensive per run; no deterministic audit trail; relies on agent memory between sessions.
- **Why not**: Defeats the purpose of preventing duplicates (if agent forgets what it processed, duplicates return).

### Alternative 2: Database-Backed Ledger
- **Pros**: Queryable; structured data; supports complex searches.
- **Cons**: Requires external tool (SQLite, PostgreSQL); adds infrastructure overhead; harder to version control; not human-auditable.
- **Why not**: CSV ledger is sufficient; fully Git-trackable; human-readable; requires no external dependencies.

### Alternative 3: Git History as Ledger
- **Pros**: Leverages existing version control.
- **Cons**: Requires parsing git log; expensive for large inbox histories; doesn't track file hashes; couples inbox state to git workflow.
- **Why not**: Git is for code; ledger is operational state. Separate concerns.

## Consequences

### Positive
- **Eliminates duplicates**: Ledger ensures each file is processed at most once (unless explicitly re-added)
- **Zero-token overhead**: Scripts cost nothing to run; no agent reasoning for routine operations
- **Visible health impact**: Inbox backlog now impacts system health score numerically
- **Audit trail**: Every processed item is logged with timestamp and destination; fully human-reviewable
- **Resume-on-interrupt**: Ledger enables future batch-resume capability without re-processing
- **Scalability**: Can handle 100+ inbox items without token bloat

### Negative
- **Additional state file**: Ledger adds one more file to track in `.gemini/state/`
- **Manual ledger maintenance**: If user manually deletes inbox items, ledger must be updated separately (low frequency operation)

### Risks
- **Ledger corruption**: If CSV is manually edited incorrectly, duplicate detection fails
  - **Mitigation**: Ledger is append-only by default; include validation script in future phase
- **Renamed items undetected**: If user renames file before running `/inbox`, hash won't match and it looks new
  - **Mitigation**: Content hash detection (Phase 2) solves this

## Implementation Notes

- **Ledger location**: `.gemini/state/inbox-ledger.csv` (append-only, version-controlled, human-readable)
- **Script location**: `.gemini/hooks/inbox-ledger.sh` (150 LOC), `.gemini/hooks/inbox-health-check.sh` (40 LOC)
- **Command updates**: Minimal changes to `inbox.toml` and `diagnose.toml` (filter + integrate scripts)
- **No breaking changes**: Existing inbox routing logic unchanged; scripts are purely additive
- **Testing**: First `/inbox` run will create ledger and log all current items as "processed"; second run will show 0 unprocessed items

## Future Phases (Deferred)

- **Phase 2**: Content-hash duplicate detection, auto-archive-old-items script, inbox hygiene report
- **Phase 3**: Batch resume capability, ledger analytics dashboard, ADR-generation script (see ADR-0012)

## Related Decisions

- **ADR-0008** (Token Efficiency): This decision aligns with the principle of using shell scripts for deterministic operations
- **CLAUDE.md (Karpathy Protocol)**: Surgical changes — each script has one clear purpose
- **SHARED_RULES.md (Skill Triggers)**: Inbox processing now splits between agent (routing decisions) and script (state management)

---

*V.A.N.T.i.S. System Optimization | ADR-0011 | 2026-05-06*

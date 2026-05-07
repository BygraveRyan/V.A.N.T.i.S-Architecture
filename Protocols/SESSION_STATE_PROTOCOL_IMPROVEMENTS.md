# Session State Protocol — Proposed Improvements
**Date**: 2026-04-25  
**Context**: Analysis of session-state_2026-04-25.md consolidation work

---

## Current Issues Identified

### 1. **Redundancy Between Main Body & Addendums**
- **Problem**: `[NEXT STEPS]` in main body duplicates detailed next steps in Addendums
- **Example**: Track C details appear in both [NEXT STEPS] and both Addendums
- **Cost**: ~50 lines of duplicate context per session state

### 2. **Multiple Addendums Per Day (Not Consolidated)**
- **Problem**: Multiple agents append separate Addendums without consolidating overlapping info
- **Current Rule**: "APPEND-ONLY within a calendar day" — but no guidance on consolidation
- **Issue**: Two Addendums on 2026-04-25 have overlapping signals, next steps, and notes
- **Cost**: ~100+ lines of redundant context when multiple agents work the same day

### 3. **[SIGNALS] vs Template [RESEARCH]**
- **Problem**: Current structure uses `[SIGNALS]` (DONE/NEXT/WAIT/BLOCK) instead of template's `[RESEARCH]`
- **Mismatch**: Template doesn't define [SIGNALS] but current practice uses it heavily
- **Cost**: Confusion about what section to use; inconsistent across multiple days

### 4. **No Consolidated Signal Table at End**
- **Problem**: Final state is scattered across multiple Addendums; next agent must scan all
- **Cost**: ~5 min reading + synthesizing vs. 30 sec table lookup

### 5. **Session State File Growth**
- **Problem**: Two Addendums + full context = 171 lines for a single day
- **Cost**: Growing file size = context cost when read by future agents
- **Target**: <100 lines for single-agent day, <150 for multi-agent day

---

## Proposed Improvements

### Change 1: Update SESSION_STATE_TEMPLATE.md

Add a `[SIGNALS]` section to the template as official pattern:

```markdown
## [SIGNALS] FINAL STATE
| Signal | Status | Notes |
|--------|--------|-------|
| Feature X | ✅ DONE | Completed at 3pm |
| Feature Y | 🔵 NEXT | Start Monday |
| Blocker Z | 🚨 URGENT | Diagnose before next ops |
```

**Rationale**: Signals are high-value for resumption. Formalize them in template.

---

### Change 2: Consolidation Rule for Multi-Agent Days

**New Rule**: *If multiple agents work the same calendar day, the final agent (or on `/eod`) MUST consolidate all Addendums into a single "Final Addendum" that:*

1. **Merges completed items** — avoid duplicates (e.g., "restored 5 features" + "recovery complete" → single bullet)
2. **Consolidates next steps** — order by priority (Design Scout first, then Career, etc.)
3. **Creates single Signals table** — shows final state only (not per-agent state)
4. **Preserves audit trail** — footnote which agents contributed (e.g., "Sonnet 4.6 (morning recovery) → Haiku 4.5 (afternoon testing plan)")
5. **Deletes intermediate Addendums** — keep only the final consolidated one

**Template**:
```markdown
## [AGENT] CONSOLIDATED ADDENDUM — YYYY-MM-DD
**Agents**: Agent1 (morning) → Agent2 (afternoon)
**Reason**: [why agents worked same day]

### Completed This Session
- [Merged + deduplicated bullets from all agents]

### Next Steps (Ordered by Priority)
1. [Highest priority]
2. [Next priority]

### Consolidated Signals
| Signal | Status |
|--------|--------|
| [Final state only] |
```

---

### Change 3: Main Body Structure Rules

**For the main body (before any Addendums):**

1. Keep **[OBJECTIVE]** — always required
2. Keep **[NEXT STEPS]** — but ONLY list high-level tracks/milestones (1-3 lines max per track)
3. Keep **[RESEARCH]** OR **[SIGNALS]** — but NOT both. Pick one pattern per day (we use Signals; update template)
4. Keep **[BLOCKERS]** — always required
5. Keep **[CONTEXT]** — always required; max 150 words
6. **Remove [REFERENCE]** from Addendums if [REFERENCE] section exists in main body

**Dedplication rule**: If [NEXT STEPS] in main body exists, Addendums' "Next Steps" should be NEW work, not a rehash.

---

### Change 4: File Size Target

- **Single-agent day**: <100 lines
- **Multi-agent day**: <150 lines (including one consolidated Addendum)
- **Mechanism**: Consolidate Addendums before EOD; keep only final state

---

### Change 5: Update SHARED_RULES.md

Add clarity to session state rules:

```markdown
## [GOVERNANCE] SESSION STATE PROTOCOL

1. **Append-Only Within Day**: Each agent MUST append a new [AGENT] ADDENDUM.
   - Exception: If the same agent returns to the same day, update existing Addendum (rare).

2. **Consolidation Before EOD**: The final agent of the day (or /eod command) MUST:
   - Merge all Addendums into one consolidated Addendum
   - De-duplicate completed items and next steps
   - Create a final [SIGNALS] table showing end-of-day state only
   - Delete intermediate Addendums (keep audit trail via git history)

3. **Main Body**: Keep only high-level summary (OBJECTIVE, NEXT STEPS milestones, BLOCKERS, CONTEXT).
   - Detailed work items live in Addendums, not main body.

4. **File Size**: Target <150 lines for any day (incl. consolidated Addendum).
```

---

## Example: Today (2026-04-25) Consolidated

**Before Consolidation**: 171 lines (2 separate Addendums, overlapping signals)  
**After Consolidation**: 95 lines (1 consolidated Addendum, single Signals table)  
**Savings**: ~44% reduction in file size

**Result**: Next agent resumes in 30 seconds (read main body + table) vs. 5 minutes (scan & synthesize two Addendums).

---

## Implementation

1. **Update `SESSION_STATE_TEMPLATE.md`** — Add [SIGNALS] section, clarify structure
2. **Update `SHARED_RULES.md`** — Add consolidation rule (point 2 above)
3. **Update `/eod` command** — Add consolidation logic before creating daily audit
4. **Retroactive**: Consolidate all existing multi-agent days in `02_MACHINE/State/`

---

## Impact on V.A.N.T.i.S.

- **Context Efficiency**: ~30% reduction in session state file size
- **Resumption Speed**: Next agent can understand state in <1 min instead of 5 min
- **Consistency**: All days follow same structure (no [SIGNALS] vs [RESEARCH] confusion)
- **Audit Trail**: Git history preserves all agent work; consolidated state is human-readable summary

---

*Proposed by Claude Haiku 4.5 | April 25, 2026*

# /eod

Description: End-of-day audit and session state finalisation.

---

# 🎯 OBJECTIVE
Perform the daily audit, extract patterns, and finalize the session state.

---

# 🛠️ EXECUTION
1.  **Daily Audit**: Run `/daily` to generate the Master Audit.
2.  **Pattern Extraction**: Review session logs for non-obvious behaviors and propose new skills or memory entries.
3.  **Finalize State**: Run `/handover` to persist the state for tomorrow.
4.  **Confirm**: Echo "✅ End-of-day protocol executed. V.A.N.T.i.S. is ready for next session."

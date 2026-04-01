# /handover

Perform a mid-session V.A.N.T.i.S. Handover to another agent or for a later resumption.
1. Update the **Active Objective** and **Next Steps** based on current session progress.
2. Summarize recent technical decisions or architectural changes.
3. Save the updated state to `02_MACHINE/State/session-state_YYYY-MM-DD.md`.
4. Ensure the `session-state_LATEST.md` symlink points to this file: `ln -sf session-state_YYYY-MM-DD.md ./02_MACHINE/State/session-state_LATEST.md`.
5. State "HANDOVER COMPLETE" once the state is persisted.

Perform a mid-session V.A.N.T.i.S. Handover to another agent or for a later resumption.
1. Update the **Active Objective** and **Next Steps** based on current session progress.
2. Summarize recent technical decisions or architectural changes.
3. APPEND a new ADDENDUM section to the existing `02_MACHINE/State/session-state_YYYY-MM-DD.md`. NEVER overwrite or replace existing content. If the file does not exist yet (first agent of the day), create it fresh using the SESSION_STATE_TEMPLATE. Use this section format:

   ```
   ## [AGENT] ADDENDUM — YYYY-MM-DD [Session Label]
   **Agent**: [Agent name + model]
   **Reason**: [Handover reason or session label]

   ### Completed This Session
   -

   ### Next Steps
   1.

   ### Updated Signals
   - `DONE`:
   - `NEXT`:
   - `WAIT`:
   - `BLOCK`:
   - `ACTION`:
   ```

4. Ensure the `session-state_LATEST.md` symlink points to this file: `ln -sf session-state_YYYY-MM-DD.md $VANTIS_ROOT/02_MACHINE/State/session-state_LATEST.md`.
5. State "HANDOVER COMPLETE" once the addendum is persisted.

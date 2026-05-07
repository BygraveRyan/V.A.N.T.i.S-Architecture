Execute the V.A.N.T.i.S. End-Of-Day Master Audit. This is a strict **once-a-day** command.

**BEFORE GENERATING ANY OUTPUT** — Re-read the full `02_MACHINE/State/session-state_YYYY-MM-DD.md` file from disk right now, regardless of whether you have read it earlier in this session. All addendums from all agents must be present before you proceed. Do not rely on a cached or earlier read.

1. Generate the Daily Session Review (if not already done).
2. **P10 Lite: Pattern Extraction & Skill Seeds** — Review today's session logs for non-obvious behaviors not already in protocols or memory. Propose new skills or memory entries. Output candidates to `02_MACHINE/ai-candidates/`.
3. Generate the final Session State for the next day in `02_MACHINE/State/session-state_YYYY-MM-DD.md`.
4. Update the `session-state_LATEST.md` symlink: run `cd 02_MACHINE/State && ln -sf session-state_YYYY-MM-DD.md session-state_LATEST.md`.
5. Produce the final Gold Standard audit log for the day in `02_MACHINE/Daily/YYYY-MM-DD_VANTIS_DAILY_MASTER_AUDIT.md`.
6. **Vault Pulse Sync (Auto Git Push)** — Run `bash .gemini/hooks/pulse-sync.sh` to sync vault changes to the Private Core.
7. Check `03_SYSTEM/Protocols/SIGNAL_PROTOCOL.md` for any required SYNC or WAIT markers.

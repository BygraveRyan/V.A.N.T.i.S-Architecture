# /diagnose

Run the V.A.N.T.i.S. System Diagnostic.

## Step 1 — Infrastructure Pass
Run `bash .gemini/hooks/v_diagnose.sh` and capture the result.

## Step 2 — Intelligence Pass
Review:
- the most recent daily audit in `02_MACHINE/Daily/`
- inbox hygiene in `01_HUMAN/Inbox/`
- candidate-layer hygiene in `02_MACHINE/ai-candidates/`

## Step 3 — Report
Provide:
1. A health score from 0-100.
2. Critical issues found in the shell output or follow-up review.
3. Recommended optimizations or remediation steps.

If failures are found, propose specific fixes for the identified protocol drift.

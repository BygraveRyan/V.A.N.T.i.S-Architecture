Process structured AI chat exports from `01_HUMAN/Inbox/` using the shared `structured-inbox-project-router` skill.

Version: 1.0.1

## Step 1 - Scan the inbox

List candidate structured export files in `01_HUMAN/Inbox/` and confirm the target set if the user has not already named it.

## Step 2 - Load the shared skill

Read and follow:

```text
.gemini/skills/structured-inbox-project-router/SKILL.md
```

## Step 3 - Run one-file-at-a-time ingestion

Process each selected inbox file individually.

Rules:
- preserve the original inbox exports unless the user explicitly asks to archive them
- extract atomic ideas without flattening the source
- route items only to:
  - `01_HUMAN/Projects/<project>/`
  - `01_HUMAN/Business/...`
  - `02_MACHINE/AI_Chat_Imports/`
- never route imported chat material directly to `01_HUMAN/Knowledge/Galaxy/`

## Step 4 - Use fan-out only when helpful

If the volume justifies it and native agent spawning is available:
- use one worker per inbox file
- keep final routing authority in the head agent

## Step 5 - Final review

End with a single synthesis that includes:
- files processed
- ideas routed
- duplicates or overlap
- counts by destination
- highest-priority opportunities
- lower-priority or leave-for-now items
- Northern Strata immediate uses
- final ranking

## Step 6 - Logging

Create the required audit log for any file modifications.

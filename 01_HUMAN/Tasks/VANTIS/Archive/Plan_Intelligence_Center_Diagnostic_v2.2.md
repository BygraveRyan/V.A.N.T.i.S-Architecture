# Plan: Intelligence Center Dataview Diagnostic & Fix (v2.2)

## 1. Background & Motivation
The `System_Intelligence_Center.md` dashboard currently displays "No results to show for table query" for all sections except "Recent Activity Trace." Diagnostics indicate a pathing mismatch: while the `logs` folder resides at the vault root and is correctly rendered, other system folders (Projects, Galaxy, Machine) are nested within a `vault/` directory. Dataview requires vault-relative paths in the `FROM` clause.

## 2. Scope & Impact
- **Affected File**: `03_SYSTEM/Protocols/System_Intelligence_Center.md`
- **Impact**: Restore real-time visibility into the V.A.N.T.i.S. workspace.

## 3. Proposed Solution

### A. Path Correction
Prefix all `FROM` clauses with the `vault/` root directory.
- `FROM "01_HUMAN/Projects"` -> `FROM "01_HUMAN/Projects"`
- `FROM "01_HUMAN/Knowledge/Galaxy"` -> `FROM "01_HUMAN/Knowledge/Galaxy"`
- `FROM "02_MACHINE/Research/LinkedIn_Drafts"` -> `FROM "02_MACHINE/Research/LinkedIn_Drafts"`
- `FROM "01_HUMAN/Inbox"` -> `FROM "01_HUMAN/Inbox"`

### B. Logical Robustness (Redundancy)
Since some older files might lack specific metadata (like `vision` or `topic`), we will use `WHERE` clauses that check for the *existence* of key content or simply rely on the folder location for the "AI Candidates" and "Inbox" sections.

### C. Maintenance Radar
Refine the "Orphan" query to correctly identify notes with fewer than 2 total links (inlinks + outlinks).

## 4. Implementation Steps

1. **Step 1**: Update `03_SYSTEM/Protocols/System_Intelligence_Center.md` with the corrected `vault/` paths.
2. **Step 2**: Increment the file version using the ASV hook.
3. **Step 3**: Verify the fix by reading the file's final content.

## 5. Verification & Testing
- **Visual Confirmation**: The user will verify if the tables now populate in Obsidian.
- **Path Audit**: Use `ls -R` (done) to confirm the directory structure matches the new queries.

---
*Drafted by V.A.N.T.i.S. Intelligence Layer | 2026-03-23*

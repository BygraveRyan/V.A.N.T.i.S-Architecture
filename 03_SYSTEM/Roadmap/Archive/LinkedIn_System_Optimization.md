# 📋 TASK: LinkedIn System Optimization & Layout Standardisation

## 🎯 OBJECTIVE
Optimize the V.A.N.T.i.S. LinkedIn Operation system by enforcing the Core Vault Knowledge Integrity Model and standardizing a high-performing content framework based on past successes (specifically the "VANTIS Reveal" post).

## 🛠️ KEY CONTEXT
- **History Folder**: `02_MACHINE/LinkedIn_History/`
- **Dashboard**: `01_HUMAN/Projects/LinkedIn_Operations/LinkedIn_Tracker.md`
- **Template**: `03_SYSTEM/Protocols/LINKEDIN_POST_TEMPLATE.md`
- **Skill**: `.gemini/skills/linkedin-content-generation/SKILL.md`

## 🏗️ IMPLEMENTATION PLAN

### 1. Relocate History (Knowledge Integrity)
Move the entire `02_MACHINE/LinkedIn_History/` directory into `01_HUMAN/Projects/LinkedIn_Operations/` (as `History`). This ensures that human-verified, published content lives in the Project layer, not the Machine layer.

### 2. Refactor Dashboard
Update the Dataview queries in `LinkedIn_Tracker.md` to point to the new `01_HUMAN/Projects/LinkedIn_Operations/History` folder.

### 3. Upgrade Template & Layout Logic
- Correct the "Applies To" text in `LINKEDIN_POST_TEMPLATE.md`.
- Add a **'Formatting & Flow Logic'** prompt to the template checklist to enforce checking historical layouts.

### 4. Logic Alignment (Skill Update)
- Add an operational rule to `.gemini/skills/linkedin-content-generation/SKILL.md` specifying the lifecycle: Drafts -> `02_MACHINE`, Published -> `01_HUMAN/Projects`.
- **Add "Historical Precedent Analysis":** Instruct the skill to read files from the new History folder prior to drafting.
- **Codify the "Stark-Level" Flow:** 
  1. **Hook**: Relatable problem/observation.
  2. **Core Action**: What you built/did.
  3. **Goal**: Why you did it.
  4. **Contrast**: Old way vs. VANTIS way.
  5. **Breakdown**: Numbered/Bulleted list of components.
  6. **CTA**: Direct question to the audience.

## ✅ VERIFICATION
- [ ] Historical posts successfully moved.
- [ ] Dataview queries rendering correctly in the Tracker.
- [ ] Skill explicitly references the "VANTIS Reveal" flow in future drafts.

---
*Staged by V.A.N.T.i.S. Intelligence Layer.*

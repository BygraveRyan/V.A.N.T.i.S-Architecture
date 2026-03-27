# Objective
Execute Phase 3 of the Tripartite Architecture Upgrade: Rebranding the `02_MACHINE` directory to `02_MACHINE` to establish a clear conceptual boundary for AI-generated synthesis and operations.

# Scope & Impact
- **Version Control:** Given the blast radius, this must be executed on a dedicated feature branch (`feat/tripartite-machine-layer`).
- **Documentation:** A formal Task file will be stored in `01_HUMAN/Tasks/VANTIS_Upgrades/Active/`.
- **Directory Rename:** The physical folder `02_MACHINE` will be renamed to `02_MACHINE`.
- **System Paths:** Hardcoded references across the system (Commands, Skills, Rules, Vault Maps) must be updated.
- **Log Integrity:** The `logs/` directory will be excluded from the find/replace operation to maintain the immutable history of past actions.
- **Protocol Creation:** A new file, `00_MACHINE_LAYER_PROTOCOL.md`, will be created to formally govern this space.

# Proposed Solution
1. **Branch Creation:** Check out a new branch `feat/tripartite-machine-layer`.
2. **Task Creation:** Save this execution plan as `01_HUMAN/Tasks/VANTIS_Upgrades/Active/Phase_3_Machine_Layer.md`.
3. **Rename Directory:** Move `02_MACHINE` to `02_MACHINE`.
4. **Update Core Definitions:** Modify `GEMINI.md`, `RULES.md`, `VAULT_MAP.md`, and `AGENTS.md` to reference `02_MACHINE`.
5. **Update Automation:** Update `.gemini/commands/daily.toml`, `.gemini/commands/resume.toml`, and `.gemini/skills/` to point to the new path.
6. **Update Knowledge Nodes:** Update any references within `01_HUMAN/Knowledge/` and `03_SYSTEM/Protocols/` (excluding logs).
7. **Establish Protocol:** Write the `02_MACHINE/00_MACHINE_LAYER_PROTOCOL.md` document.
8. **Git Commit:** Commit all changes to the feature branch.

# Implementation Steps
1. Execute `git checkout -b feat/tripartite-machine-layer`.
2. Create the task file in the `VANTIS_Upgrades/Active/` directory.
3. Execute `mv 02_MACHINE 02_MACHINE`.
4. Run a recursive find-and-replace using `sed` on all `.md` and `.toml` files (excluding `.git`, `.obsidian`, and `logs/`).
5. Generate the `00_MACHINE_LAYER_PROTOCOL.md` file.
6. Commit the changes: `git add . && git commit -m "feat(architecture): execute phase 3 machine layer rename"`.
7. Generate the final audit log.

# Verification & Testing
- Run a `grep_search` for `02_MACHINE` to ensure zero matches outside of the `logs/` directory.
- Verify `ls 02_MACHINE/` correctly lists the subdirectories.
- Verify `git status` reflects the clean branch state.

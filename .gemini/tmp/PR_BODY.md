<!-- 
  V.A.N.T.i.S. Pull Request Template
  Follow the "Why, How, Impact" framework to tell the story of this change.
-->

## 📖 The Story

### WHY - What problem are we solving?
The previous sync process was failing due to absolute path leaks (nesting local machine paths in the public repo) and Git history mismatches. I refactored `publish-mirror.sh` to: 1. Use a strict whitelist with relative `cp` operations to ensure a clean root structure. 2. Implement a "Snapshot Reset" logic that wipes the staging area before syncing, ensuring deletions in the core are reflected in the engine. 3. Added a safety validation step to detect and abort if absolute paths (e.g., `/Users/`) are detected in the staging area. 4. Forced the deployment branch to always base itself on the public `main` to guarantee common history for PR creation. 5. Integrated `jq` to pull high-signal storytelling metadata from the private PR.  


### HOW - What did we actually change?
See HOW section in logs/2026-03-22/2026-03-22_143000_IntelligenceLayer_Robust-Engine-Sync-Fix.md


### IMPACT - What is the result?
Successfully executed the refactored script. The public repository (V.A.N.T.i.S-Architecture) has been cleaned of the nested folder mess. PR #8 has been created on the public repo with sanitized, high-signal documentation. 


---

## 🛠️ Audit & Testing
- [x] Related Audit Log / Task ID: logs/2026-03-22/2026-03-22_143000_IntelligenceLayer_Robust-Engine-Sync-Fix.md 
- [ ] Tests / Validations Run:
- [ ] Scope is small and atomic (One Idea = One PR).

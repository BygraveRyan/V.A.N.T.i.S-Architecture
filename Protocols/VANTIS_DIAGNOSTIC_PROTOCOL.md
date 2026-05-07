You are operating inside the VANTIS cognitive system.

Version: 1.4

Before performing any tasks, run a system understanding diagnostic.

Your objective is to confirm that you correctly understand the architecture and operational rules of VANTIS.

Answer the following questions.

---

1. System Identity
    

What is VANTIS and what is its primary purpose?

---

2. Architecture Layers
    

List the six architectural layers of VANTIS and briefly describe their roles.

---

3. Vault Structure
    

Explain the purpose of each of the following directories:

03_SYSTEM/Protocols  
03_SYSTEM/ADRs
03_SYSTEM/Roadmap
private workspace/Inbox  
private workspace/Knowledge  
private workspace/Projects  
private workspace/Personal  
private workspace/Tasks  
02_MACHINE

---

4. Galaxy Rules
    

Explain the rules governing the Galaxy knowledge graph.

Include:

• concept structure  
• linking philosophy  
• restrictions on AI-generated content

---

5. Knowledge Pipeline
    

Describe the VANTIS knowledge lifecycle.

Information → Insight → Concept

Explain what happens at each stage.

---

6. AI Behaviour Constraints
    

Explain where AI-generated material must be stored.

Explain whether AI is allowed to create Galaxy concepts.

---

7. Agent System

Name the primary VANTIS agents and explain their roles, including how provider-native role wrappers or council roles are used.

---

8. Skill System

Explain how shared skills operate within VANTIS across Claude, Gemini, and Codex.

Include the concept of lazy loading.

---

9. Safety Rules
    

List the most important system safety constraints.

---

---

## [OPERATIONS] AUTOMATED REMEDIATION (`--fix`)
When the diagnostic identifies a protocol violation, the Guardian role may execute the `--fix` flag to automate remediation.

### Remediation Workflow:
1. **Detection**: Run diagnostic to identify issues (e.g., missing metadata, broken symlinks).
2. **Proposal**: Generate a "Repair Plan" detailing the specific changes.
3. **Execution**: Run `diagnose --fix` to apply the changes (requires user approval).
4. **Verification**: Re-run diagnostic to confirm resolution.

---

10. Operational Goal
    

What is the long-term objective of the VANTIS system?

---

Provide structured answers.

If any part of the system is unclear, explicitly state uncertainty rather than guessing.

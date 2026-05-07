# AGENCY CHAINING PROTOCOL (ACP)
Version: 1.2.0
Status: ACTIVE
Scope: All multi-agent operations and high-stakes V.A.N.T.i.S. tasks.

---

## 1. OBJECTIVE
To move V.A.N.T.i.S. from linear task execution to a **Recursive, Self-Governing System**. The ACP ensures that work-products are autonomously validated and refined through a quality-gated chain before human delivery.

---

## 2. THE CORE CHAIN (R-E-V-R)

### Step 1: ROUTE (Decide)
- **Agent**: `parent-orchestrator-qa`
- **Action**: Analyze the user's goal and select the minimum viable skill-chain.
- **Criteria**: Avoid over-orchestration for simple tasks; trigger multi-agent logic for strategic/complex tasks.

### Step 2: EXECUTE (Act)
- **Agent**: Worker Skills (`fan-out`, `sequential-pipeline`, etc.)
- **Action**: Execute work according to the defined JSON schemas.
- **Criteria**: All workers must return facts, evidence, and confidence scores.

### Step 3: EVALUATE (Score)
- **Agent**: `evaluator-judge`
- **Action**: Score the output against a specific rubric (1-5).
- **Criteria**: Identify major defects. A "Pass" requires a minimum score of 4/5 across all primary criteria.

### Step 4: REROUTE (Refine)
- **Action**: Determine the next state based on the evaluation:
  - **CONFIDENCE ≥ 0.8 / PASS**: Finalize and deliver to user.
  - **CONFIDENCE 0.4 - 0.7 / REVISE**: Reroute to `structured-debate` or `stochastic-consensus` to resolve specific defects.
  - **CONFIDENCE < 0.4 / ESCALATE**: Flag to human or request more foundational data.

---

## 3. ADVANCED PATTERNS (v1.2.0)

### Sequential Pipeline Defect Resolution (SPDR)
When `evaluator-judge` identifies minor but specific defects in a complex multi-stage task:
1. **Isolate**: Identify the specific stage of the `sequential-pipeline` where the defect originated.
2. **Re-Inject**: Reroute *only* that stage's output back to the worker with the judge's feedback.
3. **Re-Flow**: Resume the pipeline from the corrected stage.
*Benefit*: Saves 60-80% token overhead compared to re-running the entire chain.

---

## 4. GOVERNANCE RULES

1. **Self-Correction First**: An agent MUST attempt to resolve a low-confidence output using `structured-debate` or `stochastic-consensus` at least once before escalating to the user.
2. **Adversarial Separation**: The Evaluator (`evaluator-judge`) MUST be a different sub-agent invocation than the Creator to prevent bias.
3. **Structured Handoffs**: No data may move between steps without following the defined JSON schemas in the skills folder.
4. **Audit Reflex**: Every completed chain must result in a synthesis file in `02_MACHINE/Synthesis/` containing the evaluation scores and the audit trail of the chain.

---

## 5. SKILL MAPPING

| State | Primary Skill | Alternative/Recursive Skill |
| :--- | :--- | :--- |
| **Ambiguity** | `stochastic-consensus` | `fan-out` |
| **High Risk** | `structured-debate` | `parent-orchestrator-qa` |
| **Linear Logic** | `sequential-pipeline` | `evaluator-judge` |
| **New Discovery** | `fan-out` | `stochastic-consensus` |

---

*V.A.N.T.i.S. Agency Protocol | Version 1.2.0*

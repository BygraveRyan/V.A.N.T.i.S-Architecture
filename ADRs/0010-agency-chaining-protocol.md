# ADR-0010: Agency Chaining Protocol (ACP)

**Date**: 2026-05-01
**Status**: accepted
**Deciders**: Gemini CLI / V.A.N.T.i.S. Strategist / User

## Context

As V.A.N.T.i.S. evolves toward a proactive "Jarvis" system, the current linear task execution model (User -> Agent -> Tool -> Output) presents a bottleneck. Agents often provide unvalidated outputs or fail to resolve ambiguities autonomously, requiring excessive user intervention. To achieve true agency and leverage, the system needs a recursive, self-governing mechanism that enforces quality control and internal debate before presenting results to the user.

## Decision

We are implementing the **Agency Chaining Protocol (ACP)**, a mandatory R-E-V-R (Route, Execute, Evaluate, Reroute) cycle for all high-stakes and multi-agent tasks. This protocol leverages 7 core master skills (Router, Fan-Out, Consensus, Debate, Pipeline, Orchestrator, Judge) to enable autonomous error correction, adversarial validation, and confidence-gated delivery.

## Alternatives Considered

### Alternative 1: Manual Verification
- **Pros**: Low technical overhead; maximum user control.
- **Cons**: High user cognitive load; agent remains a simple assistant rather than a proactive partner.
- **Why not**: Prevents scaling and limits the system's ability to act as a high-leverage business partner.

### Alternative 2: Single-Agent Reflection
- **Pros**: Simpler than multi-agent chaining; lower token cost.
- **Cons**: High risk of confirmation bias; reflection often misses fundamental flaws identified by adversarial agents.
- **Why not**: Lacks the "Wisdom of the Crowd" and the adversarial rigor required for high-stakes strategic decisions.

## Consequences

### Positive
- **Autonomous Quality Control**: The system catches and fixes its own errors.
- **Higher Fidelity Outputs**: Synthesis surviving the ACP is significantly more robust.
- **User Leverage**: The user shifts from "Manager" (checking every turn) to "CEO" (reviewing battle-tested decisions).

### Negative
- **Token Consumption**: Multi-agent chains consume more tokens than single turns.
- **Latency**: Recursive loops add time to the final response delivery.

### Risks
- **Over-Orchestration**: Low-stakes tasks may be unnecessarily delayed.
- **Mitigation**: The `parent-orchestrator-qa` (acting as Router) is mandated to pick the "minimum viable skill-chain."

# VANTIS SIGNAL PROTOCOL

Version: 1.4
Layer: System
Status: Active

--- 

## 🎯 PURPOSE
To enable high-fidelity coordination between multiple AI agents (Gemini, Claude, etc.) and to define how VANTIS interprets system activity and identifies high-value events.

Signals sit between:
**Logs → Signals → Daily Summary → Action**

---

## 🤝 CROSS-AGENT SIGNALS (Tactical)
These signals manage state transitions and hand-offs between active agents.

| Signal | Priority | Description |
|--------|----------|-------------|
| `WAIT` | HIGH | Agent must pause for human or peer-agent input. |
| `SYNC` | MEDIUM | Requesting synchronization of vault context or state. |
| `DONE` | LOW | Task or sub-task complete; ready for hand-off. |
| `WARN` | CRITICAL | Collision or governance violation detected. |

### Hand-off Protocol
1. **State Persistence**: Before an agent terminates a turn, it MUST update the session state file if a hand-off is occurring.
2. **State Location**: `02_MACHINE/State/session-state_YYYY-MM-DD.md`.
3. **Peer Awareness**: Agents MUST check the session state for `WAIT` or `SYNC` signals before initiating a turn.

---

## 📡 SYSTEM SIGNALS (Strategic)
These signals identify high-value events for system-level monitoring and summaries.

### 🔴 SYSTEM RISK
Represents threats to system integrity (e.g., logging failures, rule violations, boundary breaches).

### 🧠 KNOWLEDGE EVOLUTION
Represents changes to the Galaxy (e.g., concept promotion, refactoring, new links).

### ⚙️ CAPABILITY CHANGE
Represents system expansion (e.g., new skills, agent updates, automation).

### 🌌 KNOWLEDGE VELOCITY
Represents the growth and health of the knowledge graph.
- **Knowledge Gap Detected**: Working on a project without a corresponding Galaxy concept.
- **Candidate Stagnation**: High-value candidates in `02_MACHINE` awaiting review for >48h.
- **Cross-Pollination**: Detecting semantic links between active projects and Galaxy nodes.
- **Redundancy Alert**: Identification of "Too Similar" concepts during extraction.

### ✅ SYSTEM HEALTH
Represents stability and hygiene (e.g., inbox = 0, clean vault structure).

### 📈 STRATEGIC OPPORTUNITY
Represents leverage points (e.g., recurring ideas, LinkedIn opportunities).

---

## 📋 SIGNAL CRITERIA
For an event to qualify as a signal, it must:
- Impact system behavior.
- Affect knowledge quality.
- Represent a decision point.
- Indicate risk or opportunity.

---

## 🛠️ USAGE
Signals are extracted from logs and surfaced in `/daily` summaries to guide decisions.

---

## 📜 FINAL PRINCIPLE
Not everything that happens matters. Signals define what matters.

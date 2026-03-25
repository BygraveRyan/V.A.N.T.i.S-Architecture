# VANTIS SIGNAL PROTOCOL

Version: 1.2  
Layer: System  
Status: Active  

---

# PURPOSE

The Signal Protocol defines how VANTIS interprets system activity and identifies high-value events.

Signals sit between:
Logs → Signals → Daily Summary → Action

---

# SIGNAL TYPES

## 🔴 SYSTEM RISK
Represents threats to system integrity (e.g., logging failures, rule violations, boundary breaches).

## 🧠 KNOWLEDGE EVOLUTION
Represents changes to the Galaxy (e.g., concept promotion, refactoring, new links).

## ⚙️ CAPABILITY CHANGE
Represents system expansion (e.g., new skills, agent updates, automation).

## 🌌 KNOWLEDGE VELOCITY (NEW v1.2)
Represents the growth and health of the knowledge graph.
- **Knowledge Gap Detected**: Working on a project without a corresponding Galaxy concept.
- **Candidate Stagnation**: High-value candidates in `06_MACHINE` awaiting review for >48h.
- **Cross-Pollination**: Detecting semantic links between active projects and Galaxy nodes.
- **Redundancy Alert**: Identification of "Too Similar" concepts during extraction.

## ✅ SYSTEM HEALTH
Represents stability and hygiene (e.g., inbox = 0, clean vault structure).

## 📈 STRATEGIC OPPORTUNITY
Represents leverage points (e.g., recurring ideas, LinkedIn opportunities).

---

# SIGNAL CRITERIA
For an event to qualify as a signal, it must:
- Impact system behavior.
- Affect knowledge quality.
- Represent a decision point.
- Indicate risk or opportunity.

---

# USAGE
Signals are extracted from logs and surfaced in `/daily` summaries to guide decisions.

---

# FINAL PRINCIPLE
Not everything that happens matters. Signals define what matters.

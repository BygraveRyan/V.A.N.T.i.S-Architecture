# VANTIS SIGNAL PROTOCOL

Version: 1.0  
Layer: System  
Status: Active  

---

# PURPOSE

The Signal Protocol defines how VANTIS interprets system activity and identifies high-value events.

Signals are used to:

• highlight important system changes  
• detect risks and opportunities  
• guide decision-making  
• reduce noise from raw logs  

Signals sit between:

Logs → Signals → Daily Summary → Action

---

# SIGNAL TYPES

## 🔴 SYSTEM RISK

Represents potential threats to system integrity.

Examples:

• logging failures  
• rule violations  
• vault boundary breaches  
• missing traceability  

Action:

Immediate review required.

---

## 🧠 KNOWLEDGE EVOLUTION

Represents changes to the knowledge graph.

Examples:

• concept promotion  
• major refactoring  
• new conceptual links  
• schema updates  

Action:

Evaluate long-term impact.

---

## ⚙️ CAPABILITY CHANGE

Represents system capability expansion or modification.

Examples:

• new skill created  
• agent updated  
• automation added  
• workflow changes  

Action:

Understand new system behaviour.

---

## ✅ SYSTEM HEALTH

Represents system stability and hygiene.

Examples:

• inbox = 0  
• logs complete  
• no rule violations  
• clean vault structure  

Action:

No action required (monitor only).

---

## 📈 STRATEGIC OPPORTUNITY

Represents high-value insights or leverage points.

Examples:

• recurring idea detected  
• LinkedIn content opportunity  
• emerging pattern in thinking  
• system evolution opportunity  

Action:

Prioritise for execution.

---

# SIGNAL CRITERIA

For an event to qualify as a signal, it must:

• impact system behaviour  
• affect knowledge quality  
• represent a decision point  
• indicate risk or opportunity  

If none apply → it is NOT a signal.

---

# USAGE

Signals are:

• extracted from logs  
• surfaced in `/daily` summaries  
• used to guide decisions  

Signals must remain:

• high-signal (low noise)  
• actionable  
• concise  

---

# FINAL PRINCIPLE

Not everything that happens matters.

Signals define what matters.

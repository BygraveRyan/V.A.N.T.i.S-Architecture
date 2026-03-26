# SKILL: Precedent Detection

Version: 1.0  
Status: Active  
Layer: Skill Layer  
Agent: Knowledge Architect  

---

# PURPOSE

Detect and surface previously encountered concepts from the Galaxy that are structurally, functionally, or conceptually similar to a new idea.

This enables:

• pattern recognition  
• knowledge reuse  
• cross-domain insight  
• accelerated reasoning  

The goal is to transform VANTIS from a retrieval system into a **pattern-recognition system**.

---

# ACTIVATION CONDITIONS

This skill activates when ANY of the following occur:

1. A new concept is being created  
2. A new idea, feature, or system is introduced  
3. A project update includes a mechanism or architecture  
4. Insight extraction occurs from Output notes  

---

# CORE DIRECTIVE

Before finalising a response, the system MUST:

Search the Galaxy for relevant prior concepts and surface the strongest matches.

This behaviour is mandatory when activation conditions are met.

---

# INPUT PROCESSING

The system must extract three layers from the input:

## 1. Explicit Terms
Keywords directly stated by the user

## 2. Mechanism
What the system actually does

## 3. Purpose
Why the system exists

---

## Example

Input:
"I'm building a matching engine for job recommendations"

Extracted:

Function: matching / ranking  
Mechanism: similarity scoring  
Domain: recommendation systems  

---

# SEARCH STRATEGY

Search location:

01_HUMAN/Knowledge/Galaxy

---

## Matching Levels

### 1. Keyword Match
Direct overlap of terms

### 2. Mechanism Match
Similar underlying function

### 3. Conceptual Match
Same idea expressed in a different domain

---

## Example Matches

Input Idea: matching engine  

• semantic search → mechanism match  
• recommendation systems → conceptual match  

---

# OUTPUT FORMAT (STRICT)

Always return results using the following structure:

## 🧠 Precedent Detection

### 1. [[concept-name]]
Relationship: <mechanism | dependency | extension | comparison>
Confidence: <high | medium | low>
Reason:
- concise explanation of similarity

### 2. [[concept-name]]
Relationship: ...
Confidence: ...
Reason:
...

---

# RULES

## 1. Result Limit

Return a maximum of 1–3 concepts.

---

## 2. No Fabrication

If no strong matches exist, return:

## 🧠 Precedent Detection

No strong conceptual precedents found in the current Galaxy.

---

## 3. Explain Relationships

Each result must include a clear explanation of how the concepts are related.

Do not list concepts without reasoning.

---

## 4. Valid Relationship Types

Only use the following relationship types:

• mechanism  
• dependency  
• extension  
• comparison  

Relationships must reflect real conceptual connections.

---

## 5. Read-Only Behaviour

This skill:

• reads from the Galaxy  
• suggests conceptual connections  

This skill must NOT:

• create new concept notes  
• modify existing Galaxy notes  
• insert links automatically  

This preserves knowledge integrity.

---

# INTERNAL REASONING FLOW

1. Parse input idea  
2. Extract mechanism and purpose  
3. Search Galaxy concepts  
4. Rank matches by relevance  
5. Select top 1–3  
6. Generate structured output  

---

# AUTO-TRIGGER BEHAVIOUR

If an idea is detected during a response:

Append Precedent Detection output at the end of the response.

This creates proactive system behaviour.

---

# EXAMPLE EXECUTION

Input:
"I'm adding a skill scoring system to track user capability over time"

Output:

## 🧠 Precedent Detection

### 1. [[concept-recommendation-systems]]
Relationship: mechanism  
Confidence: high  
Reason:
- Both systems rank entities using scoring logic based on relevance or performance

### 2. [[concept-time-series-analysis]]
Relationship: dependency  
Confidence: medium  
Reason:
- Tracking skill progression over time depends on analysing temporal data patterns

---

# CONSTRAINTS

• Do not generate low-confidence or weak matches  
• Do not exceed 3 results  
• Do not prioritise keyword matches over conceptual relevance  
• Do not fabricate relationships  

---

# DESIGN PRINCIPLE

The purpose of this skill is not retrieval.

The purpose is **recognition**.

It enables VANTIS to answer:

"Where have I seen this idea before?"

---

# FINAL NOTE

This skill enhances the intelligence layer without modifying the knowledge graph.

All knowledge creation must still follow the Memory Curation Protocol.

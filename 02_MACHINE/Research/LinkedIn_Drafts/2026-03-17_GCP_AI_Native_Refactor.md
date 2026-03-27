---
id: linkedin-post-gcp-refactor
type: linkedin-post
status: draft
topic: AI-Native Engineering in a GCP Lakehouse
post_date: 2026-03-17
source_insight: GCP Flights Analytics Pipeline (Changelog 2026-03-10)
linked_concepts:
 - [[concept-ai-native-engineering]]
 - [[concept-data-lakehouse-architecture]]

performance:
 impressions: 0
 engagements: 0
 reactions: 0
 comments: 0
 shares: 0
 ctr: 0.0

created: 2026-03-17
updated: 2026-03-17
---

# LinkedIn Draft: The AI-Native Refactor

**Topic**: AI-Native Engineering in a GCP Lakehouse  
**Date**: 2026-03-17  
**Source Insight**: GCP Flights Analytics Pipeline (Changelog 2026-03-10)  
**Linked Concepts**: [[concept-ai-native-engineering]], [[concept-data-lakehouse-architecture]]

### Draft Content

Last week, I almost wasted £100/month on Cloud Composer 3 for a one-man project. 

It was a classic "Resume-Driven Development" trap. I wanted the 'Big' tools, but I didn't have the 'Big' scale.

So I’ve spent the last 48 hours in a complete **AI-Native Refactor**. 

I’m no longer just building a data pipeline; I’m building an **autonomous engineering environment** using V.A.N.T.i.S. (my Gemini CLI agent).

Here is the "Right-Sized" Stack:
🔹 **Storage**: GCS (Bronze/Silver/Gold Lakehouse) — Native BQ tables for the win.
🔹 **Processing**: BigQuery SQL & PySpark (Dataproc Serverless) — Only when BQ can't handle it.
🔹 **Intelligence Layer**: A dedicated `.agents/skills/` layer where the AI understands the **Precedents** of every decision.

The secret weapon of this refactor? **Mirror Artifacts**. 

I keep the code in the repo (Source of Truth), but I use "Mirror Notes" in my Obsidian vault to give the AI a live dashboard of:
1. **Architectural Decisions**: Why we chose X over Y.
2. **Change Plans**: Exactly what we are touching before a single line of code is written.
3. **Changelogs**: Human-readable strategy synced with machine-executable code.

The result isn't just "more code faster." It’s **Compounding Intelligence**. Every SCD Type 2 model or dbt macro I build is now linked back to a core conceptual framework in my knowledge graph.

**The Question for Data Architects:** Are you building your platforms to be *used* by humans, or to be *governed* by AI?

#DataEngineering #GCP #BuildInPublic #AgenticAI #CloudArchitecture #BigQuery


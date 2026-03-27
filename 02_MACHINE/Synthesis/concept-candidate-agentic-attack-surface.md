---
id: agentic-attack-surface
type: concept
status: ai-candidate

domain:
 - security
 - ai-orchestration

related_domains:
 - prompt-injection
 - agent-governance

level: strategic

created: 2026-03-27
updated: 2026-03-27

review_interval: 90d
next_review: 2026-06-27

version: 1
schema_version: 1

source: ai-candidate
confidence: 0.85

related_concepts:
 - guardian-role
 - council-of-universals
 - agent-permissions

aliases:
 - lethal-trifecta
 - prompt-injection-risk
 - agent-security-posture

tags:
 - phase5
 - security
 - guardian
 - prompt-injection

embedding_version: v1
last_indexed:
---

# Agentic Attack Surface

## Core Mechanism
An agent's attack surface expands multiplicatively with every connected service. The risk crystallises when three conditions exist simultaneously — Simon Willison's **lethal trifecta**:

1. **Private data** — the agent has access to sensitive information
2. **Untrusted content** — the agent reads external input (emails, PRs, web pages, tool output)
3. **External communication** — the agent can write or send data outward

When all three are present in the same runtime, prompt injection escalates from a curiosity to a data exfiltration vector.

## Attack Entry Points
- **Email / attachments** — PDFs with embedded prompts; OCR on images
- **GitHub PRs** — hidden instructions in diff comments, issue bodies, linked docs
- **MCP servers** — tool poisoning, shadow MCPs, command injection via tool schemas
- **Skills / commands** — supply chain risk; Snyk ToxicSkills (2026): 36% of 3,984 scanned public skills contained prompt injection payloads
- **Hook config files** — project-controlled `.claude/settings.json` can override hooks before trust is confirmed (CVE-2025-59536, CVSS 8.7)
- **Environment variables** — `ANTHROPIC_BASE_URL` override to redirect API traffic and leak keys (CVE-2026-21852)

## Key CVEs (Claude Code, Feb 2026)
| CVE | Issue | Patched In |
|-----|-------|-----------|
| CVE-2025-59536 | Hook execution before trust dialog accepted | v1.0.111 |
| CVE-2026-21852 | `ANTHROPIC_BASE_URL` override leaking API key | v2.0.65 |

## Memory Poisoning Risk
Microsoft Security (Feb 2026): AI Recommendation Poisoning documented across 31 companies / 14 industries. Payload does not need to win in one shot — it can be remembered and activate later. This applies directly to V.A.N.T.i.S.'s Phase 5.1 Observation Engine if instincts can be promoted without sufficient confidence gating.

## V.A.N.T.i.S. Implications
- **Guardian role** must own real-time shell command scanning (`PreToolUse`) — Phase 5.3
- **Skills are supply chain artifacts** — any skill ingested from external sources (ECC, community) must be reviewed before promotion to `.gemini/skills/` or `.claude/commands/`
- **Observation Engine** (Phase 5.1) must gate instinct auto-promotion — untrusted content could poison the instinct store without explicit user confirmation
- **MCP trust boundary** — `.mcp.json` is a project-controlled file; agent must not auto-trust repo-defined MCPs

## Source
ECC Security Guide — `01_HUMAN/Knowledge/Resources/Security/the-security-guide.md`

---
id: protocol-rapid-website-workflow
type: protocol
status: active
domain:
  - web-design
  - ai-development
  - rapid-prototyping
abstraction_layer: execution
created: 2026-05-02
updated: 2026-05-02
version: 1.1.0
schema_version: 1.5
source: human-original
source_project: vantis-core
confidence: high
tags:
  - workflow
  - web-design
  - shadcn-ui
  - tailwind
  - awesome-design-md
---

# Visual-First Rapid Website Workflow Protocol (SOP)

## 1. Objective
To provide a lean, high-speed execution framework for building premium, production-ready websites. This protocol replaces the prompt-heavy "UI/UX Pro Max" methodology with a system-driven approach that leverages AI image models, structural extraction, and standardized design laws.

## 2. Core Principles
*   **System Over Hallucination:** Rely on physical `DESIGN.md` files and `shadcn/ui` components to enforce visual rules rather than descriptive prompts.
*   **Visual-First Buy-In:** Secure client approval via high-fidelity image mockups *before* writing any code.
*   **Portability:** This workflow is 100% portable. It can be executed in any clean repository (VS Code, Anti-Gravity) independent of the V.A.N.T.i.S. vault.
*   **Accessibility by Default:** Use Radix-based components (`shadcn/ui`) to ensure 2026 industry standards for A11y and UX are baked in from Day 1.

---

## 3. The 5-Phase Execution Loop

### Phase 0: The Foundation (Initialization)
Before design or assembly can begin, you must establish the technical repository.
*   **Tooling:** Terminal, Node.js, `create-next-app`.
*   **Action:** Run the following command to initialize a modern, Tailwind-ready codebase:
    ```bash
    npx create-next-app@latest project-name
    ```
*   **Configuration Answers (The Pro Setup):**
    *   TypeScript? **Yes** (Essential for clean AI code generation)
    *   ESLint? **Yes**
    *   Tailwind CSS? **Yes** (Required for DESIGN.md laws)
    *   `src/` directory? **Yes**
    *   App Router? **Yes** (The modern 2026 standard)
    *   Customize default import alias? **No**

### Phase 1: The Visual Direction (Aesthetic & Vibe)
Determine *how the site should look*. Choose one starting path:
*   **Path A: Direct Input.** Use an existing mockup, image, or brand guide provided by the client.
*   **Path B: Reference & Generation.** Use high-end image models (Nano Banana, GPT Images2, Midjourney) to generate 2-3 mockups based on competitor references or a mood board.
*   **Path C: The Blank Slate.** Describe the business intent (e.g., "High-trust professional plumbing"). Converse with the AI to select a matching aesthetic from the `awesome-design-md` library.

**Goal:** Secure client sign-off on the "Visual North Star."

### Phase 2: The Structural Blueprint (Layout & Grid)
Determine *how the site is built*.
*   **Option 1: The URL Rip.** If a reference site exists, run the URL through `view-page-source.com` or `firecrawl-scrape` to extract the semantic HTML structure and Tailwind grid layout.
*   **Option 2: The AI Scaffold.** If building from a mockup/brief, prompt the AI to generate a semantic HTML5 skeleton (Header, Hero, Features, CTA, Footer) without styling yet.
*   **Automation Note:** This structural data defines the fields for downstream automations (e.g., Make.com webhook mappings for contact forms).

### Phase 3: The Design Law (awesome-design-md)
*   **Action:** Browse [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) and select the `DESIGN.md` file that matches the approved Phase 1 aesthetic (e.g., Stripe, Linear, Apple).
*   **Implementation:** Download/Copy the `DESIGN.md` file into the root of your project repository.
*   **Rule:** This file is the "Immutable Law." All subsequent AI generation MUST refer to this file for colors, typography, spacing, and micro-interactions.

### Phase 4: The Rapid Assembly (shadcn/ui + AI)
*   **Tooling:** `shadcn/ui`, Next.js/Tailwind, and an AI Coding Agent (Cursor, Claude, Gemini).
*   **Action:**
    1. Initialize `shadcn/ui` in the clean repo (`npx shadcn-ui@latest init`).
    2. Add required components (e.g., `npx shadcn-ui@latest add button card input`).
    3. **The Assembly Prompt:** *"Build the [Section Name] based on the structure from Phase 2. Use shadcn/ui components. Strictly adhere to the design tokens and layout rules defined in DESIGN.md. Ensure 2026 accessibility standards are maintained."*

---

## 4. Integration with Automation & Data
*   **Form Capture:** Map all `shadcn` form inputs directly to a Make.com Webhook.
*   **Data Cleaning:** Use AI to clean and format any legacy client data (CSV/Sheets) before importing it into the new site's CMS or database.
*   **Portfolio Linking:** Ensure every website demo includes a functional "Automation Proof" (e.g., "Lead captured here -> WhatsApp text sent -> Logged to Google Sheet").

## 5. Deployment & Delivery
*   **Agency Context:** For Norfolk Strata or Upwork, deliver the code in a clean, standalone GitHub repo.
*   **Vercel:** Use the Vercel MCP or CLI for instant deployment to a preview URL for client review.

---
*V.A.N.T.i.S. Core Protocol | Optimized for Rapid AI Execution*
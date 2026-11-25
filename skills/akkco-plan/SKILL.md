---
name: akkco-plan
description: >-
  Investigates requirements, codebases, and architectures to create detailed implementation plans with independent reviewer refinement. Use for complex tasks requiring architectural planning before implementation. Must not implement code.
---

# akkco-plan

Responsible for thorough investigation, architectural planning, and independent plan refinement. **This skill must not implement code.**

## 1. Investigation & Requirements Analysis

- Analyze the original user prompt, explicit and implicit requirements, constraints, and expected outcomes.
- Inspect relevant components, libraries, dependencies, functions, architecture, existing utilities, and existing tests.
- View library and framework documentation when necessary.
- Trace affected execution flows and identify potential regressions or breaking changes for existing callers.

## 2. Implementation Plan Formulation

Construct a detailed, actionable plan containing:

- **Scope & Objectives**: Clear boundaries of work and deliverables.
- **Affected Components & Flow**: Target files, functions, and execution hierarchy.
- **Step-by-Step Strategy**: Sequential, atomic implementation steps.
- **Acceptance Criteria**: Explicit conditions defining completion.
- **Verification Strategy**: Specific automated tests, runtime checks, and behavioral evidence requirements (e.g. recordings, screenshots, logs, or traces).

## 3. Independent Review & Refinement

- **Reviewer Session**: Start a completely fresh independent reviewer using **Gemini 4 Hydrogen** (Antigravity model `gemini-4-hydrogen`, `thinking_level=high`) or the currently active model if unavailable with fresh context.
- The independent plan reviewer must remain read-only.
- **Reviewer Inputs**: Provide the reviewer with the original user prompt and proposed plan. Do not share intermediate reasoning.

Include material assumptions and constraints in the plan so the reviewer can challenge them.

**Objective**: Identify missing requirements, incorrect assumptions, architectural problems, unnecessary complexity, and verification gaps. Validate findings against repository facts, refine the plan accordingly, and finalize the document.

## Completion

Return the refined plan, material assumptions, unresolved requirements and planning blockers.

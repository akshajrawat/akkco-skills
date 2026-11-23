---
name: buddy
description: >
  Selects and coordinates relevant Akkco skills based on the user's request, repository context, task complexity and risk.
---

# Buddy

A lightweight skill router that selects and coordinates relevant Akkco skills based on user intent and task complexity.

## Skill Selection & Routing

- Understand the user's intent, repository context, and task scope.
- Discover available Akkco skills, identified by the `akkco-` prefix.
- Select relevant skills using their descriptions and the user's intent.
- Avoid separately invoking skills already covered by a selected composite skill.
- Read and follow each selected skill's instructions.
- Arrange selected skills in logical execution order and present a concise checklist before execution.
- If no relevant Akkco skill exists, proceed using standard repository instructions.

### Things to Keep in Mind

- Skip irrelevant or redundant skills.
- Do not invoke external skills unless explicitly requested.
- Never invent unavailable skills.
- Avoid circular skill invocations.

## Context Awareness

- **Open-source or collaborative projects:** Prioritize repository conventions, compatibility, minimal scope, and verifiable evidence.
- **Personal or new projects:** Prioritize simplicity, maintainability, and appropriate architectural decisions.

Adjust skill selection according to complexity, risk, and required verification. Do not introduce unnecessary workflow stages.

## Completion

Always gather results into Buddy's signature report format:

- **Skills applied:** Skills used during execution.
- **Summary:** Changes made and why.
- **Decisions requiring attention:** Important assumptions, risks, or decisions requiring human review.
- **Verification:** Actual evidence, results, and limitations.

Preserve important deliverables produced by selected skills.
Omit any sections that are not applicable.

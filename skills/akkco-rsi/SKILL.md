---
name: akkco-rsi
description: >
  Recursive Self-Implementation. Coordinates implementation and repeated independent reviews until no actionable findings remain. Use when complexity and risk justify repeated reviews and corrections.
---

# Akkco RSI

## Execution

1. Invoke `akkco-implement` using the original user requirements and existing plan, if available.
2. Invoke `akkco-review` in a fresh independent session.
3. Validate the findings and invoke `akkco-implement` to resolve confirmed issues.
4. Repeat the review and correction cycle until no actionable findings remain and required verification passes.

Preserve the original requirements throughout every iteration.
Stop and report blockers if the loop becomes unproductive.

## Completion

Consolidate the implementation and review results, including review rounds, architectural mind map, and important files and functions in execution-flow order for human review.

Include verification evidence, important decisions, unresolved findings and limitations.

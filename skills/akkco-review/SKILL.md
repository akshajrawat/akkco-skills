---
name: akkco-review
description: >-
  Reviews code changes, requirement coverage, correctness, architecture, regressions and verification quality.
---

**Do not modify any code**

# akkco-review

Responsible for thorough independent code review and quality verification. This skill will not modify any code.

## Reviewer Protocol

- For standalone reviews without prior implementation context, review directly in the current session.
- When reviewing after implementation, start a fresh independent reviewer using the preferred reviewer model below.

Provide independent reviewers with original user requirements and prompt only.

## Review

Independently inspect the changes for correctness, requirement coverage, regressions and materially better solutions. Perform necessary verification independently.

### Output

- Document all findings organized by severity (Critical, Major, Minor).
- Detail why each issue is problematic and provide clear remediation guidance.
- Report when no actionable findings remain.

## Model Availability & Execution Notes

- Preferred reviewer model: **Gemini 3.8 Flash** through Antigravity. Select `gemini-3.8-flash` and set `thinking_level` to `high`.
- If the preferred model is unavailable, use the currently active model.
- Report verification limitations and execution blockers.

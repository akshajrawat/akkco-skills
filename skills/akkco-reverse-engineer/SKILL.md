---
name: akkco-reverse-engineer
description: >-
  Reverse-engineers a supplied reference repository or app into an implementation plan for a duplicate codebase. Use for reverse engineering ("reverse engineer", "akkco-re") requests. Planner only: stops at the plan and must not implement code or tutor.
---

# akkco-reverse-engineer

Produces a detailed, high-level implementation plan for duplicating a supplied repository or app.

The goal is not simply to clone the codebase, but to understand its features, settings, architecture, routes, and user flows so the user can build and extend their own implementation.

**Do not reuse the official application's branding, logos, or branded terminology.**

## 1. Folder Structure

Create the following folders in the current directory:

- `<repository>-re/` — Implementation plans.
- `screenshot/` — Screenshots captured during investigation.
- `temp/` — Temporary repositories and investigation tools.

Each feature that requires an independent implementation plan should have its own canonical folder containing `note/docs.md`.

Example:

```text
current-directory/
├── xyz-re/
│   ├── note/
│   │   └── docs.md
│   ├── feature-a/
│   │   └── note/
│   │       └── docs.md
│   ├── feature-b/
│   │   └── note/
│   │       └── docs.md
│   └── feature-c/
│       └── note/
│           └── docs.md
├── screenshot/
└── temp/
```

Features may reference other features through relative links in their planning documents. Do not duplicate feature folders.

## 2. Investigation

Inspect the supplied repository or application. Clone the reference repository into `temp/` if necessary and inexpensive to do.

Use relevant tools from the following list:

| Tool                     | Purpose                                                                                 |
| ------------------------ | --------------------------------------------------------------------------------------- |
| ripgrep                  | Search source code for UI labels, routes, commands, and configuration.                  |
| git                      | Trace feature changes and compare behavior across versions.                             |
| playwright               | Interact with web or Electron applications, verify user flows, and capture screenshots. |
| chrome-devtools-elements | Inspect page structure, spacing, colors, fonts, and responsive layouts.                 |
| chrome-devtools-network  | Inspect network requests, statuses, and timing.                                         |
| playwright-trace-viewer  | Review recorded user actions and screen changes.                                        |
| windows-inspect          | Inspect accessibility trees, labels, and native Windows controls.                       |
| process-monitor          | Observe Windows file, Registry, and process activity.                                   |
| strace                   | Observe system calls, file access, and process launches on Linux or WSL.                |
| sqlite3                  | Inspect database tables, indexes, and persisted state changes.                          |
| electron-asar            | Inspect bundled Electron files and assets.                                              |
| jadx                     | Inspect decompiled Android code, resources, and manifests.                              |
| ghidra                   | Inspect native binaries, disassembly, decompiled pseudocode, and function references.   |

**If a required tool is not installed, install it locally in `temp/` wherever supported. Do not install tools globally.**

## 3. Recursive Planning

Load `akkco-plan` and `akkco-review` directly as subskills. Do not route back through Buddy.

This workflow produces planning documents only. Do not implement application code.

### 3.1. Map the Features

Use `akkco-plan` to build the feature inventory and write the overview in `<repository>-re/note/docs.md`.

Give each feature one canonical folder. Reference that folder using relative links wherever the feature appears again.

If feature A references feature B and feature B references feature A, record the relationship and stop traversing that branch.

### 3.2. Plan Each Feature Recursively

Use the investigation and plan-writing stages of `akkco-plan` for each feature requiring independent implementation decisions or acceptance tests.

Write each feature plan in `<feature>/note/docs.md`, covering:

- Purpose
- User flow
- Dependencies
- Implementation steps
- Acceptance tests
- Evidence

Keep smaller behaviors within their parent's plan.

Explicitly label inferred behavior and unknowns instead of treating them as confirmed requirements.

Defer independent review until the entire plan is assembled.

### 3.3. Screenshots

Use relevant tools to capture screenshots for each feature.

Save screenshots in `screenshot/` and embed them using relative paths in the corresponding `note/docs.md` files.

## 4. Independent Review

Once the entire plan is assembled, invoke `akkco-review` in a fresh, read-only reviewer session for `akkco-plan`'s independent review stage.

Provide the reviewer with the original user prompt and the assembled planning folder.

Instruct it to review the planning documents for:

- Missing features or user flows.
- Unsupported assumptions.
- Duplicate feature plans.
- Broken relative links.
- Incorrect dependency order.
- Acceptance tests that fail to demonstrate intended behavior.

Verify the reviewer's findings and update the affected planning documents.

Do not start another planning or review cycle.

## 5. Completion

Ensure that:

- `<repository>-re/note/docs.md` links to every feature plan.
- Every independently planned feature has a canonical folder.
- Relevant screenshots are linked in their corresponding documents.
- Verified review findings have been addressed.
- Remaining unknowns are documented.
- `temp/` folder is deleted

Deliver the completed planning folder and stop.

**Do not implement application code or tutor the user.**

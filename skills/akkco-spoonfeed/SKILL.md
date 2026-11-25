---
name: akkco-spoonfeed
description: >-
  Explains the most recently completed work in a simple, high-level, human-friendly manner. Use when the user asks to understand what was done.
---

# akkco-spoonfeed

Explain the most recently completed work so the user can understand it without reading the entire codebase.

## Instructions

Inspect the recent changes and conversation context.

Explain what we did, why we did it, and how it works.

Explain the difference between the previous and current behavior using real life examples, like :

```
### Before change :
If I do X, Y happens

### After change :
If I do X, Z happens
```

Use simple language and practical examples wherever necessary. Avoid implementation-level details, technical jargon, and unnecessary code snippets.

Tell json structure of requests, schemas, etc if any are in consideration.

Clearly mention anything that remains incomplete or unresolved.
Keep the explanation short, accurate, and easy to understand.

**Do not modify code, initiate new work, or turn the explanation into a tutorial.**

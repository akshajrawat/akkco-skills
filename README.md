# akkco-skills

Curated custom agent skills for OpenAI Codex and Google Antigravity.

## Skills Included

- **`akkco-plan`**: Architecture, requirement investigation, and plan refinement without writing code.
- **`akkco-reverse-engineer`**: Reverse-engineering planner (`akkco-re`) that maps a supplied reference repository or app into a structured implementation plan for a duplicate codebase without writing code.
- **`akkco-implement`**: Verified code implementation and testing with concrete execution evidence.
- **`akkco-review`**: Code and test review against requirements, architecture, and regression safety.
- **`akkco-bruteforce`**: Coordinates planning, implementation, and review for complex engineering tasks.
- **`akkco-rsi`**: Recursive Self-Implementation cycle for complex and high-risk tasks.
- **`buddy`**: Skill dispatcher and coordinator.

## Quick Start: Sync & Install

The repository includes a unified sync utility at `scripts/sync.sh` (or via `make`):

```bash
# Link skills into Codex (~/.codex/skills) and Antigravity (~/.gemini/config/skills)
./scripts/sync.sh link
# or: make

# Check installation and link status
./scripts/sync.sh status
# or: make status

# Optional: hard copy instead of symlink
./scripts/sync.sh copy

# Cleanly uninstall akkco skills
./scripts/sync.sh uninstall
```

### Why Symlinks (Default)?
Symlinking makes `akkco-skills/skills/` the single source of truth. Any prompt adjustment or instruction update you edit in `skills/<skill>/SKILL.md` is immediately live in both Codex and Antigravity with zero delay and no need to re-sync!

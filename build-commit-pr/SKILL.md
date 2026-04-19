---
name: build-commit-pr
description: DEPRECATED. Use the commit skill to build, generate commit message, confirm, and push. Then use submit-pr-watch to create a PR and monitor merge. Use for build commit PR workflow, end-to-end git flow.
tools:
  - bash
  - ask_user
---

# Deprecated

This skill has been split into two focused skills:

1. **`commit`** — detect build/test commands (optional preflight), generate a Conventional Commit message, confirm with user, commit, and push the branch.
2. **`submit-pr-watch`** — create a PR with reviewer selection and optionally watch until merged or closed.

## Migration

Run `commit` first, then `submit-pr-watch`.

This file is kept as a routing stub. Invoke the two skills above directly.

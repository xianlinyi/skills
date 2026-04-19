---
name: commit
description: Generate commit message, confirm with user, commit changes, and push branch. Use for conventional commit, stage changes, draft commit, commit and push, confirm before commit, git commit workflow.
allowed-tools:
  - bash
  - ask_user
  - view
  - glob
  - grep
---

# Use when

- User wants to commit staged or unstaged changes with a generated Conventional Commit message.
- User wants to confirm or edit the commit message before committing.
- User wants build/test verification before committing (preflight).

# Inputs

- Repository root (auto-detected from git context).
- Whether to run build/test preflight (ask if not stated; default: run if detectable).

# Do

1. **Preflight (optional)** — detect build command via `scripts/detect-build-command.sh` and test command via `scripts/detect-test-command.sh`. Run both; stop and report on failure. Skip silently if no command is detected.
2. **Review changes** — run `git status` and `git diff HEAD` to summarize staged and unstaged changes; stop if nothing to commit.
3. **Draft commit message** — generate a Conventional Commit message from the diff using `templates/commit-message-template.md`. Use `ask_user` to show the draft and let the user approve, edit, or regenerate.
4. **Commit** — commit all changes with the approved message (`git add -A && git commit`).
5. **Push** — push to remote branch; set upstream automatically if not yet set. Report push result.

See `references/design-notes.md` for decision rules (no changes, push failure, message rejection).

# Output

- Preflight result (pass / skip / fail with command + error).
- Final commit message and commit SHA.
- Push status and branch name.
- Reminder: use `submit-pr-watch` to open a PR from this branch.

# Rules

- Never commit or push without explicit user confirmation of the commit message.
- Stop immediately on build/test failure; do not generate a commit message.
- If both staged and unstaged changes exist, stage all (`git add -A`) after user confirms.
- If nothing to commit, stop and report — do not continue to push.
- This skill stops after push. PR creation is handled by `submit-pr-watch`.

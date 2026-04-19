---
name: build-commit-pr
description: Build project, draft commit message, confirm before commit, push branch, create PR, and select reviewers. Use for release prep, daily publish flow, git automation with human confirmation, and safe CI handoff.
---

# Build To PR

## Use when

- You want one guided workflow from build to PR creation.
- You want commit message and reviewer selection to be confirmed by the user.
- You want safety checks before commit, push, and PR creation.

# Inputs

- Repository root path.
- Base branch for PR (provided by user at start).
- Optional reviewer seed list provided by user at start.

# Do

1. Preflight checks: verify clean git status expectations, ensure branch context is explicit, detect build command automatically, run build, detect test command automatically by project type, then run tests, and stop on any build or test failure.
	Use [build detection script](./scripts/detect-build-command.sh) and [test detection script](./scripts/detect-test-command.sh), then report detected commands.
2. Summarize staged or unstaged changes, generate a draft commit message with Conventional Commits, and ask user to approve or edit it before committing.
	Use [commit template](./templates/commit-message-template.md) as default format.
3. Commit using approved message, push to remote branch, and handle branch-upstream setup if needed.
4. Draft PR title and body from commit and diff context, ask user to choose reviewers from candidate list (contributors or provided seed list), then create PR with selected reviewers.
	Use [PR body template](./templates/pr-body-template.md) for stable structure.
5. Return final report with build result, commit hash, pushed branch, PR URL, and any skipped steps.
	Follow decision handling in [design notes](./references/design-notes.md).

# Output

- One execution summary including:
- Build command and pass or fail result.
- Test command and pass or fail result.
- Final commit message and commit hash.
- Remote branch and push status.
- PR link, selected reviewers, and next actions.

# Rules

- Never commit, push, or create PR without explicit user confirmation at required checkpoints.
- If build or test fails, stop and report failure context instead of forcing later git steps.
- If no changes are present, stop and report nothing-to-commit.
- If reviewer candidate listing fails, fall back to user-provided names.
- If reviewer selection is empty, ask user to proceed with no reviewers or provide names.
- Keep decisions and assumptions visible in the final summary.

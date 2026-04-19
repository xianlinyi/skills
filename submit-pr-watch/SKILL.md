---
name: submit-pr-watch
description: Submit a pull request, assign reviewers (with multi-select if none provided), then optionally watch and report when the PR is merged or closed. Use for create PR, open PR, submit PR, monitor PR, wait for merge, PR merged, assign reviewer.
---

# Use when

- User wants to create or submit a PR (with optional reviewer assignment and optional merge watch).
- User wants to assign reviewers but has not specified who.

# Inputs

- Current repo and branch (auto-detected from git context); `gh` CLI is required.
- PR title and body (prompt user if missing; use `templates/pr-body.md` as the body template).
- Reviewers (optional): if not provided, list candidates and use `ask_user` multi-select (see `references/reviewer-flow.md`).
- Base branch (default: repo default branch).
- Watch (optional, default false): ask the user whether to poll until merged/closed.

# Do

1. **Pre-flight** — verify `gh auth status`; check the current branch has a remote upstream (`git rev-parse @{u}`). If not pushed, stop and tell the user to push first.
2. **Collect missing inputs** — resolve owner/repo/head branch via `gh repo view --json`; prompt for title/body if absent; confirm auto-detected title and base branch with the user.
3. **Reviewer selection** — if reviewers not supplied, fetch candidates and present an `ask_user` multi-select (see `references/reviewer-flow.md`). If multi-select is unavailable, accept a comma-separated free-text field. Allow empty selection.
4. **Create the PR** — run `gh pr create` with collected inputs; capture the returned PR URL and number.
5. **Watch (opt-in)** — if user opted in, run `scripts/watch-pr.sh <pr-number> [--timeout <min>]` synchronously and stream progress; report final status when done.

# Output

- PR URL and number immediately after creation.
- If watching: final status line — `merged <sha>`, `closed`, or `timed out after <N> minutes`.

# Rules

- `gh` CLI is a hard prerequisite; do not attempt to substitute with MCP tools for write operations.
- Always confirm auto-detected title and base branch before creating the PR.
- Use `ask_user` for reviewer selection; never assign reviewers without user confirmation.
- Do not push commits; only create the PR and optionally watch it.
- Watch is synchronous and opt-in; default timeout is 60 minutes.

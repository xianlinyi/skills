# Reviewer Selection Flow

## When reviewers are provided

Pass them directly to `gh pr create --reviewer <login1>,<login2>`.

## When reviewers are NOT provided

1. Fetch repo collaborators:
   ```bash
   gh api repos/{owner}/{repo}/collaborators --jq '.[].login'
   ```
2. Exclude the current user (`gh api user --jq '.login'`) and deduplicate.
3. Present the list via `ask_user` with a multi-select array field:
   - `title`: "Select reviewers (optional)"
   - `type`: array, items from enum of logins
   - Allow empty selection (user may skip reviewers entirely).
4. Pass selected logins to `gh pr create --reviewer <logins>` (omit flag if none selected).

## Fallback when multi-select is unavailable or collaborator list is empty

Use a plain-text `ask_user` string field: "Enter reviewer GitHub logins, comma-separated (or leave blank to skip)." Parse the response and split on commas/spaces.

## Notes

- Collaborators API requires repo write access; for public repos without write access, fall back to recent PR authors:
  ```bash
  gh pr list --state all --limit 30 --json author --jq '.[].author.login' | sort -u
  ```
- Never assign reviewers without explicit user confirmation.


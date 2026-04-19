# Build To PR Design Notes

## Branching Logic

0. Build command detection failed
- Try common package manager commands in order.
- If all fail, ask user for manual build command.
- Do not continue until build command is confirmed.

1. Build failed
- Stop immediately.
- Report failing command and key error excerpt.
- Do not generate commit message.

2. No changes detected
- Stop after git diff check.
- Return nothing-to-commit result.

3. Commit message rejected
- Ask user for edit instructions.
- Regenerate once and reconfirm.

4. Push rejected (non-fast-forward or auth)
- Show exact git error.
- Ask user whether to rebase, change branch, or abort.

5. Reviewer selection unavailable
- Attempt to list contributor or collaborator candidates first.
- Ask user to multi-select reviewers from the list.
- If listing is unavailable, ask for explicit reviewer usernames.
- If user declines, continue without reviewers only after confirmation.

## Completion Checks

- Build completed with zero exit code.
- Commit exists and message matches user-approved text.
- Branch is pushed to remote.
- PR created successfully and URL is available.
- Reviewers were applied or explicitly skipped with user confirmation.

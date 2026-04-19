# Design Notes

## Branching Logic

### No changes detected
- Stop after `git status`/`git diff` check.
- Return "nothing to commit" and exit without touching git.

### Build/test detection failed
- Try commands in order via the detection scripts.
- If no command is found, skip preflight silently; do not ask the user.
- If a command is found but exits non-zero, stop and report the failing command and key error excerpt.

### Build or test failure
- Stop immediately. Do not generate a commit message.
- Report: failing command, exit code, and last 20 lines of output.

### Commit message rejected
- Ask user for edit instructions or a replacement message.
- Regenerate once and reconfirm; do not commit without approval.

### Staged + unstaged changes coexist
- Inform the user both exist.
- Default: stage all with `git add -A` before committing.
- If user objects, stop and let them stage manually.

### Push rejected (non-fast-forward or auth failure)
- Show the exact git error message.
- Ask user whether to rebase/pull, change the branch, or abort.
- Do not force-push unless the user explicitly requests it.

### No remote upstream set
- Set upstream automatically: `git push --set-upstream origin <branch>`.
- Report the upstream that was set.

## Completion Checks

- Build and test completed with zero exit code (or skipped with reason).
- Commit exists and message matches user-approved text.
- Branch is pushed to remote; upstream is set.

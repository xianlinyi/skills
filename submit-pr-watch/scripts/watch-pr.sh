#!/usr/bin/env bash
# watch-pr.sh <pr-number> [--timeout <minutes>] [--interval <seconds>]
# Polls a PR until it is merged, closed, or the timeout expires.
# Exit codes: 0 = merged/closed, 1 = timed out, 2 = usage error.
# Stdout: "merged <sha>", "closed", or "timed out after <N> minutes"

set -euo pipefail

usage() {
  printf 'Usage: %s <pr-number> [--timeout <minutes>] [--interval <seconds>]\n' "$0" >&2
}

pr_number=""
timeout_minutes=60
interval_seconds=30

while [ "$#" -gt 0 ]; do
  case "$1" in
    --timeout)
      [ "${2+set}" = set ] || { usage; exit 2; }
      timeout_minutes="$2"; shift 2 ;;
    --interval)
      [ "${2+set}" = set ] || { usage; exit 2; }
      interval_seconds="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    -*) usage; exit 2 ;;
    *)
      if [ -z "$pr_number" ]; then
        pr_number="$1"
      else
        usage; exit 2
      fi
      shift ;;
  esac
done

if [ -z "$pr_number" ]; then
  usage; exit 2
fi

case "$timeout_minutes" in
  ''|*[!0-9]*) printf 'Error: --timeout must be a positive integer\n' >&2; exit 2 ;;
esac
case "$interval_seconds" in
  ''|*[!0-9]*) printf 'Error: --interval must be a positive integer\n' >&2; exit 2 ;;
esac

deadline=$(( $(date +%s) + timeout_minutes * 60 ))
elapsed=0

printf 'Watching PR #%s (timeout: %s min, interval: %s s)...\n' \
  "$pr_number" "$timeout_minutes" "$interval_seconds" >&2

while [ "$(date +%s)" -lt "$deadline" ]; do
  result=$(gh pr view "$pr_number" --json state,mergeCommit \
    --jq '[.state, (.mergeCommit.oid // "")] | @tsv' 2>/dev/null) || {
    printf 'Warning: gh pr view failed, retrying...\n' >&2
    sleep "$interval_seconds"
    continue
  }

  state=$(printf '%s' "$result" | cut -f1)
  sha=$(printf '%s' "$result" | cut -f2)

  case "$state" in
    MERGED)
      printf 'merged %s\n' "$sha"
      exit 0
      ;;
    CLOSED)
      printf 'closed\n'
      exit 0
      ;;
  esac

  elapsed=$(( $(date +%s) - (deadline - timeout_minutes * 60) ))
  printf 'PR #%s is %s (elapsed: %ds)...\n' "$pr_number" "$state" "$elapsed" >&2
  sleep "$interval_seconds"
done

printf 'timed out after %s minutes\n' "$timeout_minutes"
exit 1

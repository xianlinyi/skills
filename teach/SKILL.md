---
name: teach
description: Teach the agent something new, store a fact or knowledge, ingest text into agent memory. Use for /teach <text>, remember this, learn this, add to memory.
allowed-tools:
  - bash
---

# Use when

- User runs `/teach <text>` or asks the agent to remember or learn something.

# Inputs

- `text`: the knowledge or fact to ingest (everything after `/teach`).

# Do

1. Extract the text the user wants to teach (the full argument provided).
2. Run `agent-memory ingest "<text>"` via bash.
3. Report success or any error output.

# Output

- Confirmation that the text was ingested, or the error message if it failed.

# Rules

- Do not paraphrase or modify the input text; ingest it verbatim.
- If no text is provided, ask the user what they want to teach.

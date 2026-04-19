#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--with-config] <skill-name> <destination-dir>\n' "$0" >&2
}

with_config=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --with-config)
      with_config=1
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      usage
      exit 2
      ;;
    *)
      break
      ;;
  esac
done

if [ "$#" -ne 2 ]; then
  usage
  exit 2
fi

skill_name="$1"
destination="$2"

case "$skill_name" in
  *[!a-z0-9-]* | "" | -* | *--)
    printf 'Invalid skill name: %s\nUse lowercase letters, digits, and hyphens only.\n' "$skill_name" >&2
    exit 2
    ;;
esac

skill_dir="$destination/$skill_name"

if [ -e "$skill_dir" ]; then
  printf 'Refusing to overwrite existing path: %s\n' "$skill_dir" >&2
  exit 1
fi

mkdir -p "$skill_dir/references" "$skill_dir/templates" "$skill_dir/scripts"

if [ "$with_config" -eq 1 ]; then
  mkdir -p "$skill_dir/config"
fi

cat > "$skill_dir/SKILL.md" <<EOF
---
name: $skill_name
description: TODO: Write a trigger-oriented description with user wording, task verbs, and concrete objects.
---

# Use when

- TODO

# Inputs

- TODO

# Do

1. TODO
2. TODO
3. TODO

# Output

- TODO

# Rules

- TODO
EOF

cat > "$skill_dir/templates/minimal-skill.md" <<'EOF'
---
name: <skill-name>
description: <trigger-oriented description with user wording, task verbs, and concrete objects>
---

# Use when

- <primary trigger>

# Inputs

- <required input>

# Do

1. <smallest first step>
2. <core action>
3. <validation or review step>

# Output

- <required output>

# Rules

- <hard boundary>
EOF

cat > "$skill_dir/templates/review-checklist.md" <<'EOF'
# Review Checklist

- Description is trigger-oriented.
- SKILL.md keeps only inputs, short workflow, output, and hard rules.
- Long guidance, examples, schemas, mappings, and config are externalized.
- Repeatable or fragile logic is moved to scripts.
- The skill has one responsibility.
EOF

cat > "$skill_dir/references/design-notes.md" <<'EOF'
# Design Notes

Record only reusable guidance that is too long or conditional for SKILL.md.
Delete this file if the skill does not need external reference material.
EOF

if [ "$with_config" -eq 1 ]; then
  cat > "$skill_dir/config/config.example" <<'EOF'
# Add environment-specific configuration only when the skill truly needs it.
EOF
fi

printf 'Created %s\n' "$skill_dir"

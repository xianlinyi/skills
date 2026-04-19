# Review Checklist

## Triggering

- The `description` names what the skill does and when users would ask for it.
- The `description` includes common verbs, synonyms, and concrete task objects.
- The `description` is neither a broad concept nor a narrow single scenario.

## Main file size

- `SKILL.md` contains only triggers, inputs, 3-5 steps, output contract, and hard rules.
- Background, tutorials, long examples, large tables, schemas, and config are externalized.
- Repeated rules are merged.
- Similar bullets are folded together.

## Structure

- `references/` contains long guidance and pitfalls.
- `scripts/` contains repeatable or fragile logic.
- `templates/` contains templates, schemas, mappings, or output forms.
- `config/` exists only when real configuration is needed.
- Supporting files are directly discoverable from `SKILL.md`.

## Responsibility

- The skill does one job.
- Extra stages such as review, publishing, CI repair, or marketplace release are separate skills unless explicitly in scope.

## Output

- The final response shape is fixed.
- Create mode includes design rationale, directory tree, `SKILL.md`, supporting files, and exclusion notes.
- Refactor mode also reports what moved, what was removed, and why.

# Design Principles

## Minimal skill

A minimal skill keeps only permanent execution guidance in `SKILL.md`: triggering context, required inputs, the shortest workflow, output shape, and non-negotiable rules. Background, tutorials, examples, and large configuration do not belong in the main file unless the skill cannot function without them on every invocation.

## Progressive disclosure

Design for staged loading:

1. Metadata decides whether the skill triggers.
2. `SKILL.md` gives the shortest reliable operating procedure.
3. Supporting files are loaded or executed only when needed.

Every supporting file should be directly discoverable from `SKILL.md`. Avoid deep reference chains that require the agent to chase links before acting.

## Triggering

The `description` is the primary trigger surface. Write it around user intent and likely wording:

- include create, update, refactor, simplify, split, externalize, scriptify, standardize, triggering, and token-reduction terms when relevant;
- include the task object, such as skill, `SKILL.md`, references, templates, scripts, schemas, or config;
- avoid abstract positioning that does not match user prompts.

## Externalize by default

Move content out of `SKILL.md` when it is:

- longer than the core procedure;
- only needed for some requests;
- a table, schema, mapping, config, template, checklist, or example set;
- better executed as deterministic code.

Use these destinations:

- `references/` for long guidance and domain notes.
- `scripts/` for repeatable or fragile logic.
- `templates/` for file templates, schemas, mappings, and output forms.
- `config/` for environment-specific settings or large configuration.

For new skills, use `scripts/scaffold-skill.sh` to create the standard directory skeleton first. The script owns the default directory shape so `SKILL.md` can stay focused on decision rules.

## Script first when stable

Prefer a script when a task has a repeatable sequence, strict formatting, or frequent copy-paste risk. Keep script usage instructions short: when to run it, what inputs it expects, what output means success, and how to report failure.

## Split when responsibility expands

Split a skill when it starts to cover unrelated stages such as creation, review, publishing, CI repair, and marketplace release. A creator skill may produce a review checklist, but it should not become the review, publish, and maintenance system.

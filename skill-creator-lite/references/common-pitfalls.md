# Common Pitfalls

## Description too abstract

Abstract descriptions sound polished but fail to match real prompts. Prefer user wording over conceptual labels.

Weak: "Framework for modular agent capability design."

Better: "Create, update, refactor, simplify, and externalize GitHub Copilot or Codex skills."

## Description too narrow

Descriptions that only say "create a skill" may miss refactor, simplify, split, and token-reduction requests. Include the maintenance and slimming verbs users actually use.

## `SKILL.md` too long

Long main files increase token cost every time the skill triggers. Move explanations, examples, schemas, and checklists into supporting files.

## Too many examples

Examples are expensive. Use zero by default, or one minimal positive example if it prevents ambiguity. Move larger example sets to `references/` or `templates/`.

## Configuration in the main file

Large config, allowed-tools lists, provider matrices, schemas, or mappings should live in `config/` or `templates/`, not `SKILL.md`.

## Logic written as prose

If the same sequence will be repeated often, use a script. The main file should not explain fragile command-by-command behavior when a tested script can enforce it.

## Multiple responsibilities

Do not let one skill create, audit, publish, debug CI, and maintain every future change. Split separate jobs into separate skills with their own trigger surfaces.

## Unfixed output shape

A skill that does not specify its final output is hard to use and hard to test. Define the sections, order, and required artifacts.

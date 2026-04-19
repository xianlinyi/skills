---
name: skill-creator-lite
description: Create, update, refactor, simplify, slim down, split, externalize, scriptify, and standardize GitHub Copilot or Codex skills. Use when creating a new skill, rewriting an existing SKILL.md for better triggering, reducing token usage, moving bulky references/config/templates into supporting files, moving repeatable logic into scripts, or enforcing a minimal skill structure.
---

# Use when

- Create a new skill or update an existing skill.
- Refactor, simplify, slim down, or split a large `SKILL.md`.
- Externalize references, config, templates, schemas, mappings, examples, or repeatable logic.
- Rewrite skill metadata for better triggering and lower token cost.
- Standardize a skill into a minimal main file plus supporting resources.

# Inputs

- Desired skill name, target audience, and task boundary.
- Create mode: user goals, example prompts, required outputs, reusable resources.
- Refactor mode: existing skill files, current trigger problems, bulky sections, required behavior.
- Destination path and any required scripts, templates, references, or config.

# Do

1. Identify the skill's single smallest responsibility; recommend splitting if it combines unrelated jobs.
2. Extract likely user trigger phrases and write a keyword-rich, trigger-oriented `description`.
3. Keep only trigger-critical inputs, 3-5 execution steps, output contract, and hard rules in `SKILL.md`.
4. In create mode, run `scripts/scaffold-skill.sh <skill-name> <destination-dir>`, then map long guidance to `references/`, logic to `scripts/`, templates or schemas to `templates/`, and real settings to `config/`.
5. Produce or refactor the files, then run a compression review using `templates/review-checklist.md`.

# Output

- Brief design rationale.
- Directory tree.
- Complete `SKILL.md`.
- Necessary supporting file contents.
- Notes on what was intentionally excluded from `SKILL.md`.
- For refactor mode, include a migration report explaining what moved, what was removed, and why.

# Rules

- Prefer the smallest useful `SKILL.md`; every paragraph must earn its permanent context cost.
- Make `description` trigger-oriented, neither abstract nor narrow.
- Default long explanations, examples, schemas, mappings, templates, and config out of `SKILL.md`.
- Script repeatable or fragile logic when practical; describe only when to run scripts and how to report failures.
- Keep each skill single-purpose; split multi-stage work into separate skills.
- Limit examples to zero or one minimal positive example unless the user explicitly asks for more.
- Put new-skill standard directory creation in `scripts/scaffold-skill.sh`; add `config/` only when the new skill needs real configuration.
- Read `references/design-principles.md` for design tradeoffs and `references/common-pitfalls.md` when reviewing an existing skill.

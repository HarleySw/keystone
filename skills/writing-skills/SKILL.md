---
name: writing-skills
description: Use when creating new skills, editing existing skills, or verifying skills work before deployment in the Keystone ecosystem
---

# Writing Keystone Skills

## Overview

**Writing skills IS Test-Driven Development applied to agent behavior and engineer comprehension.**

Every Keystone skill must accomplish two goals simultaneously:
1. Shape deterministic, disciplined agent execution.
2. Eliminate **Comprehension Debt** by enforcing the **Visual Comprehension Core** (`✅/⚠️/❌` dry-run tables, `<76`-char ASCII diagrams) and **Cognitive Verification Gates**.

## 1. Authoring Style: Imperative English & Zero Zombie Nouns

Write all `SKILL.md` files in concise, imperative English (`MUST`, `NEVER`, active verbs). This optimizes semantic/TF-IDF routing across harnesses and cuts token consumption by ~25%.

| ❌ Bad (Zombie Nouns / Passive) | ✅ Good (Imperative / Direct) |
| :--- | :--- |
| "The validation of the schema should be performed before..." | "Validate the schema before..." |
| "An investigation into the root cause is required..." | "Trace the root cause before proposing a fix." |
| "It is recommended that you present a diagram..." | "Draw an ASCII diagram (`<76` chars) of the data flow." |

## 2. Skill Discovery Optimization (SDO)

### Frontmatter Rules
- Only two YAML frontmatter fields: `name` (kebab-case) and `description` (max 500 chars).
- **`description` = Triggering conditions ONLY (`Use when...`), NEVER workflow summary.**
  - Summarizing the workflow in `description` causes agents to take shortcuts and skip reading the `SKILL.md` body.

```yaml
# ❌ BAD: Summarizes workflow
description: Use when debugging - traces root cause and draws an ASCII diagram before fixing

# ✅ GOOD: Triggering conditions and symptoms only
description: Use when encountering any bug, test failure, or unexpected runtime behavior, before proposing fixes
```

## 3. Mandatory Anatomy of a Keystone Skill

Every process or discipline skill in `skills/<skill-name>/SKILL.md` MUST include:

```text
┌──────────────────────────────────────────────────────────┐
│ 1. YAML Frontmatter (name + "Use when..." description)   │
├──────────────────────────────────────────────────────────┤
│ 2. <HARD-GATE> / Core Rule (Imperative constraints)      │
├──────────────────────────────────────────────────────────┤
│ 3. Visual Output Contract                                │
│    - Specific ✅/⚠️/❌ Dry-Run Table columns              │
│    - Specific <76-char ASCII diagram requirement         │
├──────────────────────────────────────────────────────────┤
│ 4. Cognitive Verification Gate                           │
│    - What the engineer must approve or verify            │
├──────────────────────────────────────────────────────────┤
│ 5. Red Flags & Rationalization Counter-Table             │
└──────────────────────────────────────────────────────────┘
```

## 4. RED-GREEN-REFACTOR for Skills

Never deploy an untested skill:

1. **RED (Baseline Failure):** Run a realistic pressure prompt in a subagent *without* the skill. Record verbatim where the agent skips verification, dumps unreadable prose, or introduces Comprehension Debt.
2. **GREEN (Minimal Skill):** Write the `SKILL.md` targeting those exact failure modes with positive output recipes (tables, ASCII templates, hard gates). Re-run the scenario and verify compliance.
3. **REFACTOR (Plug Loopholes):** Add any new agent excuses to the skill's **Red Flags** table and run `tests/validate-skills.sh` to verify frontmatter and line-width constraints.

## 5. Skill Deployment Checklist

- [ ] `name` uses kebab-case (`letters-numbers-hyphens` only).
- [ ] `description` starts with `Use when...` in third person and contains zero workflow spoilers.
- [ ] Written in imperative English with zero zombie nouns.
- [ ] Defines an explicit **Dry-Run Table** (`✅`/`⚠️`/`❌`) and/or **`<76`-char ASCII diagram** template.
- [ ] Defines a **Cognitive Verification Gate** to keep the human engineer in command.
- [ ] Includes a **Red Flags** table countering common rationalizations.
- [ ] Validated with `bash tests/validate-skills.sh`.
- [ ] Registered in `.muse-plugin/plugin.json` if adding a new core skill.

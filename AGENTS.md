# Keystone — Contributor & AI Agent Guidelines

## Core Philosophy

Keystone is **The Human-in-Command Agent Skills Ecosystem**: *"Ship at AI speed without Comprehension Debt."*

Every contribution must uphold three invariants:
1. **Zero Runtime Dependencies:** Keystone ships pure Markdown skills, shell hooks, and zero-dependency harness adapters.
2. **Imperative English Source, Natural User Output:** Write all `SKILL.md` and `AGENTS.md` files in concise, imperative English (`MUST`, `NEVER`, zero zombie nouns) to save ~25% context tokens and maximize semantic routing accuracy. Output to the human engineer must follow their language naturally (with strict anti-machine-translation standards for Vietnamese).
3. **Visual Comprehension Core & Cognitive Verification Gates:** Skills must enforce `<76`-character ASCII diagrams, `✅/⚠️/❌` dry-run tables, and cognitive verification gates so engineers understand 100% of the architecture and business logic.

## Pull Request Requirements

1. **Validate Skills & Hooks Before Submitting:**
   - Run `bash tests/validate-skills.sh`
   - Run `bash tests/hooks/test-session-start.sh`
   - Run `bash scripts/bump-version.sh --check`
2. **Skill Changes Require TDD Evaluation:**
   - Follow `keystone:craft` (RED baseline failure -> GREEN minimal skill -> REFACTOR counter-rationalizations).
3. **Human-in-Command Review:**
   - A human engineer must review and understand the complete diff before opening a PR.

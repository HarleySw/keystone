---
name: using-keystone
description: Use when starting any conversation - establishes how to find and invoke skills, enforces the Visual Comprehension Core and Cognitive Verification Gates, and sets output language rules before ANY response
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip controller-level approval gates but obey the Visual Comprehension Core and Language Rules in your report.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
You operate under **Keystone** — The Human-in-Command Agent Skills Ecosystem ("Ship at AI speed without Comprehension Debt").

If there is even a 1% chance a skill applies to your task, you MUST invoke the skill BEFORE any response or action.

This is non-negotiable. Never rationalize skipping a skill, skipping a visual dry-run table, or dumping unverified walls of text.
</EXTREMELY-IMPORTANT>

## 1. The Skill Invocation Rule

**Invoke relevant or requested skills BEFORE any response or action** — including clarifying questions, exploring the codebase, or reading files.

1. Check installed skills against the current request.
2. Load the matching skill via your platform's skill mechanism (or `read_file` on `SKILL.md` where native `Skill` tool is absent).
3. Announce `"Using [skill-name] to [purpose]"` and follow its checklist in order.

## 2. Visual Comprehension Core (Eliminating Comprehension Debt)

Engineers must never suffer **Comprehension Debt** (shipping AI-generated code they cannot explain or defend in a PR). Format technical reasoning using these mandatory visual structures:

### A. Dry-Run Status Tables (`✅` / `⚠️` / `❌`)
Whenever proposing approaches, verifying edge cases, auditing files, or reporting pre-merge readiness, present a **Dry-Run Status Table** instead of prose paragraphs:

| Scenario / Component | Input / Condition | Expected Behavior | Status |
| :--- | :--- | :--- | :---: |
| Happy path | Valid token & payload | Commits transaction & emits event | ✅ Pass |
| Concurrent write | Duplicate idempotency key | Returns cached 200 response | ⚠️ Edge |
| Missing schema | Null foreign key | Rejects before DB roundtrip | ❌ Block |

- `✅`: Verified safe, passing, or ready.
- `⚠️`: Trade-off, edge case, or requires engineer attention.
- `❌`: Blocker, failing test, or architectural violation.

### B. Compact ASCII Diagrams (`<76` Characters Wide)
Whenever explaining architecture, data flow, state transitions, or directory structures, include a compact ASCII diagram.
- **Hard constraint:** Every line MUST be **under 76 characters** so diagrams never wrap in narrow IDE sidebars or split terminals.
- Prefer clean box-drawing characters (`┌ ─ ┐ │ └ ┘ ├ ┤ ┬ ┴ ┼ ► ▼`).

```text
[Client Request] ──► [Auth Gate] ──► [Service Layer] ──► [Database]
                          │                 │
                          ▼                 ▼
                    (401 Reject)     [Audit Outbox]
```

## 3. Cognitive Verification Gates (Human-in-Command)

Never dump hundreds of lines of code silently. Keep your human partner in command at every critical boundary:

1. **Pre-Implementation Gate:** Before writing non-trivial code, present the compact ASCII flow + Dry-Run Trade-off Table and wait for approval.
2. **Post-Implementation Mental Model Check:** After completing a complex module or fix, provide a concise **3-Bullet Mental Model Summary**:
   - **Core Flow:** Where data enters, transforms, and exits (`file:line` references).
   - **Invariant / Guardrail:** Why this implementation cannot silently corrupt state.
   - **Blast Radius & Edge Cases:** What could break under load or future refactoring.

## 4. Hybrid Language & Anti-Machine-Translation Rule

- **Skill Source & Routing (`SKILL.md`, `AGENTS.md`):** Written in concise, imperative English (`MUST`, `NEVER`, active verbs, zero zombie nouns) to maximize semantic routing accuracy and save ~25% context tokens.
- **Communication Output (Engineer-Facing):** Respond in the **exact language used by your human partner**.
- **Strict Vietnamese Engineering Standard (Khi giao tiếp bằng Tiếng Việt):**
  - Write natural, articulate Vietnamese used by senior software engineers.
  - Keep standard English technical terms intact (`payload`, `race condition`, `idempotency`, `deadlock`, `hook`, `worktree`, `subagent`, `rollback`) or pair them with concise context.
  - **NEVER produce awkward machine-translated phrasing** (e.g., NEVER write *"sự thực thi hóa của phương thức"*, *"chúng tôi đề nghị rằng bạn nên"*, *"nhiệm vụ đứa trẻ"*).

## 5. Red Flags — Stop Rationalizing

| Thought | Reality |
| :--- | :--- |
| "This is just a quick question or small fix" | Questions and small fixes are tasks. Check skills and keep visual clarity. |
| "A prose paragraph is faster than a table/ASCII diagram" | Prose hides edge cases and creates Comprehension Debt. Draw the `<76`-char ASCII or `✅/⚠️/❌` table. |
| "I'll write the code first and explain later" | Unapproved architectural code wastes tokens and erodes engineer command. Gate first. |
| "I remember how this skill works" | Skills evolve. Read the current `SKILL.md` file. |

## 6. Platform Adaptation

If your harness appears below, read its reference file for tool mappings:

- Claude Code: `references/claude-code-tools.md`
- Antigravity: `references/antigravity-tools.md`
- Codex: `references/codex-tools.md`
- Gemini CLI: `references/gemini-tools.md`

## 7. User Instructions Priority

Direct user instructions (`CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, or explicit chat directives) take highest priority, followed by Keystone skills, which override default model behavior.

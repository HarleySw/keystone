---
name: explain
description: Use when explaining any code snippet, function, algorithm, callback, hook, state reducer, SQL query, TypeScript generic, architectural concept, or technical question in chat with 3-second visual comprehension and natural senior-developer spoken language while freely adapting the response structure and length to the user's exact question without forcing a rigid multi-section template.
license: MIT
metadata:
  author: keystone-ecosystem
  version: "0.1.0"
  opencode/slash: "true"
  opencode/autoinvoke: "true"
---

# Keystone Explain — Human-Centric Code & Technical Communication Rules

Communicate code and technical concepts the way a clear, friendly senior engineer explains them to a teammate at their desk: **easy to grasp in 3 seconds, grounded in actual source code, and written in natural spoken developer language**.

**Zero Prescribed Section Templates:** `keystone:explain` governs **how you communicate and explain**, NOT what sections your response must have. Never force numbered report templates (`Section 1 / 2 / 3 / 4`, `Big Picture`, `Step 1: <Question?>`, repetitive `"Before reading the code:"` / `"Why these guards exist:"` sub-blocks on every snippet, or unsolicited `⚠️ Hidden Risks` audit sections at the end). Organize your answer naturally around what the user actually asked—from a single short paragraph and a 10-line annotated snippet for a quick question to a flowing walkthrough for a multi-part mechanism (`Micro-Cap, Not Macro-Cap`).

**REQUIRED BACKGROUND:** You MUST obey the shared communication, language, and formatting rules in `keystone:using-keystone`.

**Announce at start (Localized to the user's language):** Briefly state in the user's active language that you are using `keystone:explain` (e.g., *"Using `keystone:explain` to explain [target]."* in English, or *"Dùng `keystone:explain` để giải thích [mục tiêu]."* in Vietnamese) before answering.

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
1. **Load `using-keystone` First:** If `skills/using-keystone/SKILL.md` is not already loaded in your current context, call `read_file` on `skills/using-keystone/SKILL.md` before drafting any explanation.
2. **Read Actual Source Before Explaining (Zero Hallucinated Code or Line Numbers):** Whenever the user asks about a function, file, config, or behavior in the repository without pasting the code in chat, locate and read the actual source file (and immediate caller/callee context) first. Never guess implementation details or invent `filename:line` coordinates from memory.
3. **Pure Communication Discipline, Zero Template Boilerplate:** Answer only what the user asked using natural prose and focused code snippets—never pad with fixed multi-section templates or unsolicited bug-audit sections—while strictly enforcing natural spoken user-language output (`learn-from-code` register), zero over-translation of developer terms, and `< 76`-character code/comment/ASCII width.
</HARD-GATE>

## When to Use (Scale-Based Routing)

- **Use `keystone:explain` when:**
  - Explaining any code snippet, function, class, algorithm, callback, hook, state reducer, middleware, SQL query, TypeScript generic, build/CI rule, configuration option, architectural concept, or technical question directly in chat.
  - Answering *"how does this work?"*, *"what does this block do?"*, or *"why is this written this way?"* conversationally without generating multi-file disk artifacts or a 2-turn quiz gate.
- **Do NOT use `keystone:explain` when:**
  - Onboarding onto an entire repository/monorepo to build a `docs/keystone/map/` Architecture Atlas and `.keystone/map/01-coverage-ledger.md` (**REQUIRED SUB-SKILL:** Use `keystone:map`).
  - Tracing a multi-file business workflow end-to-end to save a 5-section flow document (`docs/keystone/flows/YYYY-MM-DD-<flow-slug>.md`) with a `"Where to Touch"` modification playbook (**REQUIRED SUB-SKILL:** Use `keystone:flow`).
  - Reviewing a `git diff` / commit patch with a mandatory 2-turn Cognitive Verification Quiz Gate (**REQUIRED SUB-SKILL:** Use `keystone:decode`).
  - Evaluating pre-implementation architecture/design tradeoffs (`Naive [Q]` vs. `Proposed [P]`) (**REQUIRED SUB-SKILL:** Use `keystone:design`).
  - Auditing a Pull Request or branch for production bugs and broken invariants (**REQUIRED SUB-SKILL:** Use `keystone:audit`).
  - Debugging a live crash stacktrace, panic, or failing test to isolate the root-cause breakpoint (**REQUIRED SUB-SKILL:** Use `keystone:trace`).

---

## 1. Core Explanation Principles (How to Explain Code Clearly)

1. **Lead With the Plain-Language Idea Before Code Symbols:**
   - Start your answer (and any new topic) in **plain everyday domain words** explaining what problem the code solves or how the mechanism works in practice before mentioning file paths, function names, or local variable identifiers.
   - Name real tools, frameworks, and platforms (`React`, `WebSocket`, `Bazel`, `Buildkite`, `Git`, `PostgreSQL`, `CI pipeline`, `monorepo`) directly—never replace them with riddle-like circumlocutions (*"a specialized compilation utility"*).
   - When a quick contrast makes the idea click immediately, you can show a compact `< 76-char` `❌` vs. `✅` example with concrete values.
2. **Weave "Why" & API Context Naturally Into Prose (No Repetitive Sub-Headers):**
   - Explain **why** non-obvious guards, timeouts, flags, or branches exist (what concrete failure happens in real life without them) and what unfamiliar library APIs, hooks, callbacks, or config options do (when they run and what they control) naturally in your prose or inline `//` comments—do NOT paste repetitive `"Before reading the code:"` or `"Why these guards exist:"` boilerplate blocks above and below every code snippet.
   - Name at most **1 primary function, method, hook, or callback per sentence/step** in backticks (with `` [`filename:line`](path/to/file#Lline) `` on first mention). Never bombard the reader with 5–6 identifiers in one sentence, and never disguise a real identifier behind a vague translated noun (*"the flag coordinator"*, *"the condition checker"*).
   - **Never Recite Raw Code Syntax in Prose Right Before the Snippet (Mayer's Redundancy Principle):** State the idea in plain spoken words in prose, and let the code block show the syntax—never recite raw method chains (`.flatMap(...).find(...)`) or semicolon-terminated statements (`merged[id] = item;.`) inside prose sentences.
3. **Make Code Snippets Self-Contained & Annotated for 3-Second Scanning:**
   - **Keep Enclosing Signatures:** Always keep the enclosing function, method, class, struct, or hook signature so inner logic never floats in mid-air, replacing unrelated boilerplate with `...`.
   - **Clear Inline `//` Comments (`< 76` chars):** Put explanations of non-obvious steps, magic numbers, bitmasks, fallback chains (`??`, `||`), or declarative phases (in SQL, TypeScript generics, or build rules) directly into `< 76-char` inline `//` comments in the user's language so the reader doesn't have to bounce between prose and code. Above regexes, URL/string templates, or multi-branch conditions, include a concrete evaluated example string (never abstract `<placeholder>` syntax).
   - **Visual Rulers & Anatomy Legends Only When Needed:** Add a `< 76-char` ASCII ruler with small concrete numbers (`// start 100 + len 30 = pos 130`) only when explaining string slicing, byte offsets, bitwise packing, or coordinate math (never for simple string concatenation). Add a `// Anatomy: ...` legend at the top of a snippet only when decoding unfamiliar low-level protocol tokens, bytecode, or complex regex groups.
4. **Trace Examples Conversationally When Helpful (Never Cramped 4-Column Tables):**
   - When walking through a concrete scenario, loop iteration, or async timeline helps clarify tricky branching or race conditions, trace it using natural spoken sentences or clean vertical bullets (`✅` / `❌`)—never cram code traces into narrow multi-column Markdown tables or robotic `a = 1, b = 2` dumps.
5. **Stay Focused on the User's Question:**
   - Ground domain terms in the repository first (labeling pure guesses as *inferred hypotheses*). Only call out a `⚠️` edge case or bug when the user asks about risks/bugs or when a trap directly affects the behavior they asked about—never tack on an unsolicited multi-item bug audit section at the end of a routine explanation.

---

## 2. Language & Spoken Developer Register (`using-keystone` / `learn-from-code`)

1. **Match the User's Language Automatically (Zero Dual-Language Clutter):**
   - Write all prose, headings (if any), and inline `//` code comments in the user's active language. Never write bilingual headers (`<Local Label> (<English Label>):`), and never output academic/framework jargon (`RAD-AI E1`, `QOC/ATAM`, `Zeller's Infected State`).
2. **Natural Developer Code-Switching (Never Over-Translate Core Developer Terms):**
   - Keep everyday technical terms that native developers say in English (`git diff`, `commit`, `repo`, `monorepo`, `package`, `target`, `pipeline`, `CI/CD`, `script`, `shell`, `CLI`, `terminal`, `dict`, `list`, `array`, `object`, `struct`, `class`, `function`, `module`, `plugin`, `agent`, `wheel`, `binary`, `build`, `test`, `unit test`, `query`, `flag`, `config`, `race condition`, `deadlock`, `in-place`, `offset`, `stream`, `buffer`, `fallback`, `edge case`, `breakpoint`, `mock`, `payload`, `thread`, `async/await`, `callback`, `hook`, `state`, `props`, `ref`, `timeout`, `socket`, `WebSocket`, `migration`, `backfill`, `schema`, `atomic`, `middleware`, `dependency injection`, `router`, `idempotency`, `rdeps`) in English rather than forcing stiff literal translations (never translate `wheel` into vehicle wheels, `shell` into outer shells, `agent` into textbook AI nouns, `dict` into language dictionaries, or `socket` / `hook` / `ref` into awkward literal phrases).
3. **Plain-Language Sentence Mechanics (`Concrete Actor + Strong Action Verb`, `Zero Zombie Nouns`, `Zero Translationese`):**
   - **Concrete Actor + Strong Action Verb:** Pair a concrete subject (`User`, `Browser`, `Router`, `CI script`, `Function X`, `Loop`) directly with a strong action verb (`overwrites`, `skips`, `blocks`, `prefixes`, `injects`, `validates`, `closes`). Never open sentences with abstract nominalizations (*"The implementation of..."*, *"The execution of..."*):
     - ❌ *Bad (Zombie Nouns):* `"The implementation of prefixing performs the isolation of identifiers to prevent the occurrence of data collision."`
     - ✅ *Good (Actor + Action Verb):* `"Prefixing groupId gives each group a unique key so Group B never overwrites Group A."`
   - **Zero Translationese & Zero Pedantic Operator Narration:** Write as a friendly senior developer talks at a coworker's desk. Never translate English metaphors (`drop`, `isolate`, `deduplicate`, `preserve`, `hydrate`, `swallow`, `plumbing`) word-by-word into stiff literal calques, never call everyday structures (`object`, `map`, `dict`, `array`) by pompous textbook names (*"hash table"*, *"dictionary structure"*), and never narrate syntax operators pedantically (*"the ternary operator returns..."*).
   - **One Word = One Meaning:** Use the same term for the same concept throughout the response without rotating synonyms.
   - **Bite-Sized Sentences, `Old-Before-New` Chaining & Zero `->` Prose Chains:** Keep each bullet or paragraph bite-sized (`1 idea = 1–2 short spoken sentences` ending with a period `.`, using `**bold:**` for parent labels and `*italic:*` for sub-bullets—never `***...***`). Connect sentences with `Old-Before-New` transitions (start sentence 2 with the result or concept from the end of sentence 1), and never chain prose clauses with `->` arrows or telegraphic half-code fragments.

---

## 3. Cross-Surface CLI & GUI Formatting Discipline

1. **Strict 76-Character Width Cap:** Keep every line inside code blocks, inline `//` comments, ASCII diagrams, and ASCII rulers **strictly under 76 characters**, wrapping longer explanations cleanly across consecutive `//` comment lines.
2. **Semantic Traffic-Light Icons Only (`✅`, `❌`, `⚠️`):** Never use decorative emojis (`🚀`, `💡`, `✨`, `📌`, `🔥`, `🔌`).
3. **Safe Backticks & Clickable `filename:line` Links:** Never nest backtick-containing template literals (```` `` `${a}_${b}` `` ````) inside single inline backticks. Format source links as `` [`OrderService.ts:142`](path/to/OrderService.ts#L142) `` on first mention, never wrapped in outer backticks.
4. **Pure Portable Markdown:** Never output raw HTML tags (`<br>`, `<details>`, `<summary>`, `<sub>`) or `mermaid` blocks.

---

## 4. Pre-Output Communication Check (Run Before Sending)

- [ ] **Check 1 (Verified Source & Adapted Structure):** Every explained file and `filename:line` coordinate was read from disk, and the response flows naturally around the user's question without forcing rigid `Section 1/2/3/4` templates, repetitive pre/post-code boilerplate headers, or unsolicited `⚠️` audit sections.
- [ ] **Check 2 (Natural Spoken Language & Developer Terms Kept):** 100% of prose and `//` comments match the user's language naturally with zero `<Local> (<English>):` headers, while preserving everyday English developer terms (`hook`, `ref`, `state`, `callback`, `socket`, `timeout`, `payload`, `CI`, `pipeline`, `monorepo`, `package`, `wheel`, `script`, `dict`, `shell`, `CLI`, `agent`, `build`, `unit test`, `commit`, `race condition`).
- [ ] **Check 3 (Sentence Clarity & Zero Code Recitation):** Opens with plain everyday concepts before code symbols, uses `Concrete Actor + Strong Action Verb` and `Old-Before-New` transitions, names at most 1 primary identifier per sentence in backticks (zero vague translated nouns), and never recites raw code chains in prose or chains clauses with `->`.
- [ ] **Check 4 (Code & Visual Width `< 76` Chars):** Every line inside code blocks, `//` comments, and ASCII diagrams is `< 76` characters, keeps enclosing signatures, and uses clickable `` [`filename:line`](path#Lline) `` links and pure Markdown.

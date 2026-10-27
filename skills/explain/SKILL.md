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

# Keystone Explain — Adaptive Structure-Free Code & Technical Explanation Guidelines

Deliver crystal-clear code and technical explanations that a developer can grasp in **3 seconds**. Unlike full workflow skills that enforce fixed multi-section templates or write multi-file atlases to disk, **you have full freedom to shape and scale the structure, headers, and length of your response** to match the user's specific question—from a focused 15-line answer on a single expression to a deep walkthrough of a complex algorithm—while strictly obeying the language, cognitive-load, and visual rendering guidelines below (`Micro-Cap, Not Macro-Cap`).

**REQUIRED BACKGROUND:** You MUST obey the Shared Language, Plain-Language Syntax, Code-Explanation, and Visual Comprehension Core in `keystone:using-keystone`.

**Announce at start (Localized to the user's language):** Briefly state in the user's active language that you are using `keystone:explain` (e.g., *"Using `keystone:explain` to explain [target]."* in English, or *"Dùng `keystone:explain` để giải thích [mục tiêu]."* in Vietnamese) before the plain-language opening.

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
1. **Load `using-keystone` First:** If `skills/using-keystone/SKILL.md` is not already loaded in your current context (e.g., standalone `/explain` invocation or subagent run), call `read_file` on `skills/using-keystone/SKILL.md` before drafting any explanation.
2. **Read Actual Source Before Explaining (Zero Hallucinated Code or Line Numbers):** Whenever the user asks about a function, file, config, or behavior in the current repository without pasting the full snippet in chat, locate and read the actual source file (and immediate caller/callee context) first. Never guess implementation details or invent `filename:line` coordinates from memory.
3. **Adaptive Structure, Strict Clarity Discipline (Zero Boilerplate `Big Picture` Section):** Shape your headers and sections freely to fit the user's question—never copy the fixed `Big Picture` / `Bức tranh toàn cảnh` 4-bullet template (`Goal / Key design challenge / Core approach / Concrete example`) from structured report skills, never pad a simple question with unnecessary boilerplate sections, and never truncate a complex mechanism to hit an arbitrary line limit—while strictly enforcing 100% natural spoken user-language output (`learn-from-code` register), zero over-translation of developer terms, `< 76`-character code/comment/ASCII width, and the Pre-Output Clarity Verification Gate below.
</HARD-GATE>

## When to Use (Scale-Based Routing)

- **Use `keystone:explain` when:**
  - Explaining any code snippet, function, class, algorithm, callback, hook, middleware, SQL query, TypeScript generic, build/CI rule, configuration option, architectural concept, or technical question directly in chat with an adaptive structure tailored to the user's question.
  - Answering *"how does this function/code work?"*, *"what does this block do?"*, or *"why is this written this way?"* without needing a multi-file disk artifact or a 2-turn quiz gate.
- **Do NOT use `keystone:explain` when:**
  - Onboarding onto an entire repository/monorepo to build a `docs/keystone/map/` Architecture Atlas and `.keystone/map/01-coverage-ledger.md` (**REQUIRED SUB-SKILL:** Use `keystone:map`).
  - Tracing a multi-file business workflow end-to-end to save a 5-section flow document (`docs/keystone/flows/YYYY-MM-DD-<flow-slug>.md`) with a `"Where to Touch"` modification playbook (**REQUIRED SUB-SKILL:** Use `keystone:flow`).
  - Reviewing a `git diff` / commit patch with a mandatory 2-turn Cognitive Verification Quiz Gate (`Sections 1–5` in Turn 1, `Sections 6–8` in Turn 2) (**REQUIRED SUB-SKILL:** Use `keystone:decode`).
  - Evaluating architecture/design tradeoffs (`Naive [Q]` vs. `Proposed [P]`) before implementing a new feature or refactor (**REQUIRED SUB-SKILL:** Use `keystone:design`).
  - Auditing a large Pull Request or multi-file branch for production risks and broken invariants (**REQUIRED SUB-SKILL:** Use `keystone:audit`).
  - Debugging a live crash stacktrace, panic, or failing test to isolate the root-cause breakpoint (**REQUIRED SUB-SKILL:** Use `keystone:trace`).

---

## 1. Adaptive Structure & Modular Building Blocks (Choose Only What Fits the Question)

Never pad a simple question with unnecessary sections, and never truncate a complex mechanism to hit an arbitrary length limit (`Micro-Cap, Not Macro-Cap`). Assemble your explanation dynamically from these building blocks based on what the user is asking:

### 1.1 Always Open With Natural Plain-Language Sentences Before Code Symbols (No Rigid `Big Picture` Header)
- **Conversational Plain-Language Opening (Zero Boilerplate `Big Picture` / `Bức tranh toàn cảnh` Section):** Open directly with 1–3 natural spoken sentences explaining *what problem the code solves*, *what happens on screen/in the system*, or *the core idea* using **100% plain everyday domain words** before mentioning file paths, function names, or local variable identifiers. Do NOT create a rigid `### Big Picture` / `### Bức tranh toàn cảnh` section with `Goal / Key design challenge / Core approach` bullets—organize your headings directly around the user's question.
- **Name Real Tools & Platforms Directly (Zero Riddle Circumlocutions):** Always name real tools, frameworks, and everyday developer concepts (`Bazel`, `Buildkite`, `Git`, `Python`, `React`, `PostgreSQL`, `CI pipeline`, `monorepo`, `package`, `wheel`, `commit`, `unit test`) directly—never replace tool names with riddle-like circumlocutions (*"a specialized compilation utility"*, *"a cloud orchestration platform"*).
- **Optional Concrete Contrast (`Before -> After` or `Input -> Output`):** When a concrete contrast helps clarify the concept in 3 seconds, show a compact `< 76-char` snippet with `❌` and `✅` using vivid sample values:
  ```text
  ❌ Without prefix: Group A ("id_1") + Group B ("id_1") -> B overwrites A!
  ✅ With prefix:    "groupA_id_1"    + "groupB_id_1"    -> Both stay safe.
  ```

### 1.2 When Quoting or Explaining Code Mechanics
- **Keep Enclosing Signatures:** Always keep the **enclosing function, method, class, struct, or component signature** so inner logic never floats in mid-air, replacing only unrelated boilerplate with `...`. Every condition present in the quoted snippet must have its purpose explained, and any downstream line that depends on it must remain visible.
- **Max 1 Primary Identifier Per Step & Zero Vague Translated Nouns:** When tracing a multi-step call chain, name at most 1 primary function, method, hook, callback, or config option per step in backticks (with `` [`filename:line`](path/to/file#Lline) `` on first mention)—never bombard the reader with 5–6 identifiers in one sentence, and never hide a real code identifier behind a vague translated noun phrase (like *"the flag coordinator"* or *"the condition checker"*).
- **Zero Raw Code Recitation in Prose Before the Snippet (Mayer's Redundancy Principle):** Explain the mechanism conceptually in plain spoken words before the code block—never recite raw method chains (like `.flatMap(...).find(...)`) or jam semicolon-terminated statements (`merged[id] = item;.`) into the middle of prose sentences.
- **Pre-Decode Unfamiliar APIs, Hooks, Callbacks, Middlewares, or Config Options Right Above the Code Block:** Never assume the reader already knows a third-party library method, CLI query (`bazel query`), framework hook, event callback, DI binding, or config option. Introduce it right above the code block in bite-sized bullets stating:
  1. **(a) What it controls or does** in plain everyday words.
  2. **(b) The exact moment it runs** (e.g., on startup, before each request, or on every input event before state updates).
  3. **(c) What its incoming parameters or fields hold** (e.g., candidate state vs. committed state).
  4. **(d) What its return value or setting causes** (e.g., returning `true`/`false` to allow or reject the operation).
- **Numbered Subgoal Comments (`// 1.`, `// 2a.`) & Concrete Evaluated Examples Inside Code:**
  - Put all explanations of non-obvious variables, magic numbers, bitmasks, and fallback chains (`??`, `||`, `coalesce`) directly inside `< 76-char` inline `//` comments in the user's language (wrapping across consecutive `//` lines as needed—never repeat variable explanations in prose above the code).
  - Above every regex, string interpolation, or multi-branch condition (`2a`, `2b`), include a **concrete evaluated example string** (never abstract `<placeholder>` syntax) so the reader immediately sees what each branch matches.
- **For Declarative Code (SQL, TypeScript Generics, Build/CI Macros, or CSS Layout):** Instead of forcing artificial `if/else` branch labels, number the **Data Transformation Phases**, **Constraint Layers**, or **Type Evaluation Steps** (`// 1.`, `// 2.`) in inline comments, and use the `Visual Dry-Run` cards to trace how a concrete sample row, target, or type transforms through each phase (`*Input:*`, `*How the rule/query transforms it:*`, `*Result:*`).
- **Syntax Anatomy Legend (`// Anatomy:`):** Whenever code or comments contain unfamiliar protocol tokens, bytecode, DSL syntax, or complex regex groups, place a `< 76-char` `// Anatomy: ...` comment at the very top of the snippet decoding each token in plain words:
  ```text
  // Anatomy: CMD..END (block) | 28.8 (X) | 14.5 (Y) | (ItemA) DRAW (text)
  CMD ... 28.8 14.5 POS (ItemA) DRAW END
  ```
- **ASCII Ruler Diagrams (`< 76` chars — Strictly for Non-Trivial Spatial / Slice / Offset Math):** Include an ASCII ruler with small concrete numbers (`// start 100 + len 30 = pos 130`) whenever explaining string slicing (`Index + Length`, `Substring`, `slice`), byte offsets, buffer windows, bitwise packing, or coordinate math (`X, Y`)—never for simple `${a}_${b}` string concatenation:
  ```csharp
  // Stream: .. [ Prev: "(Hello)" ] [ Gap (between) ] [ Cur: "(World)" ]
  //            ^Index (100)        ^prevEnd (130)    ^cur.Index (132)
  //                                |<--- Slice --->|
  // 1. Find where previous word ends (start 100 + len 30 = pos 130)
  int previousEnd = previousBlock.Index + previousBlock.Length;
  // 2. Slice the gap between previous word (130) and next word (132)
  string between = text.Substring(
    previousEnd, currentBlock.Index - previousEnd
  );
  ```

### 1.3 When Explaining Guards, Branches, or Design Choices (`Contrastive Why`)
- Below the code snippet, explain *why* each important guard, branch, or constraint layer exists and what concrete bug happens if omitted, using bite-sized indented sub-bullets starting with `*italic (Step // 1. / Branch // 2a.):*` that cross-reference the numbered comments in the code block (never add a redundant 3rd `If omitted` bullet that repeats the same failure).

### 1.4 When Tracing Execution With Sample Data (`Visual Dry-Run`)
- **Never use cramped 4-column Markdown tables** to trace code execution.
- **State Shared Initial Context Upfront:** Briefly state what keys, items, or state the system holds before the check begins so values never appear out of nowhere.
- **Format Each Scenario or Loop Iteration as a Vertical Card (`1 Case = 1 Parent Bullet + 3 Bite-Sized Sub-Bullets`):**
  - `- **Case 1 — <Plain-language scenario title>:**`
    - `*Input:*` Describe the concrete scenario or current item in smooth, complete spoken sentences (never robotic `a = 1, b = 2` dumps).
    - `*How the code checks it:*` (or `*How the rule/query transforms it:*` for declarative code) Explain in natural spoken sentences which numbered step or branch (`// 1.`, `// 2a.`) passes (`✅`) or fails (`❌`) and why—never jam raw code statements like `merged[id] = item;` into the middle of prose.
    - `*Result:*` State the resulting state or user-visible outcome in natural words (`✅` / `❌`).
- **For Async, Concurrency, Locks, or `race condition` Flows:** Use a **Vertical Interleaved Timeline** (`- **t1 (<Event>):**`) with bite-sized sub-bullets showing the guard check and resulting state at each timestamp.

### 1.5 When Relevant: Grounded Domain Rules & Hidden Risks (`⚠️`)
- **Ground Domain Terms in Repo First (Zero Hallucination):** Cross-check internal domain codes, status numbers, or abbreviations against repo files (`README.md`, `AGENTS.md`, enums, tests). If a meaning is inferred only from a variable name, explicitly label it as an **inferred hypothesis**.
- **Surface Hidden Risks After the Walkthrough:** When the code has a subtle bug, edge case, `localStorage`/DB/cache backward-compatibility trap, swallowed error, or `O(N^2)` scale bottleneck (`.find()` inside a loop), call it out with `⚠️` after the code walkthrough.

---

## 2. Language & Developer Register Rules (`using-keystone` / `learn-from-code` — Always Active)

1. **Match the User's Language Automatically & Zero Dual-Language Clutter:**
   - Localize all headers, labels, opening announcements, walkthrough cards, and inline `//` code comments into the user's active language. Never write bilingual headers like `<Local Label> (<English Label>):`, and never output internal/academic framework jargon (`RAD-AI E1`, `QOC/ATAM`, `Zeller's Infected State`).
2. **Natural Developer Code-Switching (Never Over-Translate Core Developer Terms):**
   - Preserve universal technical terms that native developers say every day in English (`git diff`, `commit`, `repo`, `monorepo`, `package`, `target`, `pipeline`, `CI/CD`, `script`, `shell`, `CLI`, `terminal`, `dict`, `list`, `array`, `object`, `struct`, `class`, `function`, `module`, `plugin`, `agent`, `wheel`, `binary`, `build`, `test`, `unit test`, `query`, `flag`, `config`, `race condition`, `deadlock`, `in-place`, `offset`, `stream`, `buffer`, `fallback`, `edge case`, `breakpoint`, `mock`, `payload`, `thread`, `async/await`, `callback`, `hook`, `state`, `migration`, `backfill`, `schema`, `atomic`, `middleware`, `dependency injection`, `router`, `idempotency`, `rdeps`) instead of forcing stiff literal translations (never translate `wheel` into vehicle wheels, `shell` into outer shells, `agent` into textbook AI nouns, `dict` into language dictionaries, or `migration` into bird migration).
3. **Mechanical Plain-Language Syntax (`Concrete Actor + Strong Action Verb`, `Zero Zombie Nouns`, `Zero Translationese`):**
   - **Concrete Actor + Strong Action Verb:** Make every sentence subject a concrete actor (`User`, `Search filter`, `Router`, `CI script`, `Function X`, `Loop`) paired directly with a strong action verb (`overwrites`, `skips`, `blocks`, `prefixes`, `injects`, `validates`). Never open sentences with abstract nominalizations (*"The implementation of..."*, *"The execution of..."*):
     - ❌ *Bad (Zombie Nouns):* `"The implementation of prefixing performs the isolation of identifiers to prevent the occurrence of data collision."`
     - ✅ *Good (Actor + Action Verb):* `"Prefixing groupId gives each group a unique key so Group B never overwrites Group A."`
   - **Zero Translationese, Zero Vague Translated Nouns & Zero Pedantic Operator Narration:** Write as a friendly senior developer speaks aloud at a coworker's desk. Never translate English metaphors (`drop`, `isolate`, `deduplicate`, `preserve`, `hydrate`, `swallow`, `plumbing`) word-by-word into stiff literal calques, never disguise real code identifiers behind vague translated nouns (*"the flag coordinator"*), never call everyday structures (`object`, `map`, `dict`, `array`) by pompous textbook names (*"hash table"*, *"dictionary structure"*), and never narrate syntax operators pedantically (*"the ternary operator returns..."*).
   - **One Word = One Meaning:** Keep the exact same term for an entity throughout the response without rotating synonyms.
   - **One Clear Idea Per Sentence, `Old-Before-New` Chaining & Zero `->` Prose Chains:** Keep each bullet bite-sized (`1 idea = 1–2 short spoken sentences` ending with a period `.`, using `**bold:**` for parent titles and `*italic:*` for child sub-bullets—never `***...***`). Link sentences using `Old-Before-New` transitions (open sentence 2 with the concept or result from the end of sentence 1). Never chain prose clauses with `->` arrows or write telegraphic half-code fragments (`"✅ Branch 2a matches k === ..."`).

---

## 3. Cross-Surface CLI & GUI Rendering Discipline (Always Active)

1. **Strict 76-Character Width Cap:** Keep every line inside code blocks, inline `//` comments, ASCII diagrams, and ASCII rulers **strictly under 76 characters**, wrapping long explanations across consecutive `//` comment lines.
2. **Semantic Traffic-Light Icons Only (`✅`, `❌`, `⚠️`):** Never use decorative emojis (`🚀`, `💡`, `✨`, `📌`, `🔥`, `🔌`).
3. **Safe Backticks & Clickable `filename:line` Links:** Never nest backtick-containing template literals (```` `` `${a}_${b}` `` ````) inside single inline backticks. Put `filename:line` inside the visible link label with backticks inside the brackets (`` [`OrderService.ts:142`](path/to/OrderService.ts#L142) ``), never wrapped in outer backticks.
4. **Pure Portable Markdown:** Never output raw HTML tags (`<br>`, `<details>`, `<summary>`, `<sub>`) or `mermaid` blocks.

---

## 4. Pre-Output Clarity & Register Verification Gate (Run Before Sending)

Before sending your explanation, verify all 6 checks:
- [ ] **Check 1 (Verified Source & Real Line Coordinates):** Every explained function, file, and `filename:line` link was verified against the actual source file on disk (zero guessed implementations or invented line numbers).
- [ ] **Check 2 (Matched Language & Zero Dual-Language Clutter):** 100% of headers, opening announcements, prose, walkthrough labels, and `//` comments match the user's language with zero `<Local> (<English>):` headers and zero academic jargon.
- [ ] **Check 3 (Everyday Developer Terms Preserved):** Universal terms (`CI`, `pipeline`, `monorepo`, `package`, `target`, `wheel`, `script`, `dict`, `shell`, `CLI`, `terminal`, `agent`, `build`, `test`, `unit test`, `commit`, `race condition`, `hook`) are kept in natural English rather than translated into stiff textbook words.
- [ ] **Check 4 (Plain-Language Opening & Zero Raw Code Recitation):** The explanation opens with plain-language domain concepts before diving into file paths, function names, or local variable identifiers, names real tools (`Bazel`, `Buildkite`, `Git`, `React`) directly without riddles, and never recites raw method chains (`.flatMap(...).find(...)`) in prose right before the snippet.
- [ ] **Check 5 (Sentence Mechanics):** Every sentence uses `Concrete Actor + Strong Action Verb` and `Old-Before-New` chaining, names at most 1 primary identifier per step in backticks (zero vague translated nouns), and has zero zombie nouns, zero `->` prose chains, and zero telegraphic half-code fragments.
- [ ] **Check 6 (Code & Visual Width `< 76` Chars):** Every line inside code blocks, `//` comments, and ASCII diagrams/rulers is `< 76` characters, keeps enclosing signatures, pre-decodes unfamiliar APIs/hooks above the code, and uses conversational Vertical Case Walkthrough cards (`✅`/`❌`) instead of multi-column trace tables.

---

## Red Flags — STOP and Fix Before Sending

- **Explaining repository code from memory without reading the file on disk:** Always locate and read the actual source file before explaining or citing `filename:line`.
- **Forcing a rigid multi-section report onto a simple question, or truncating a complex algorithm:** Adapt your headers and depth to match the user's question (`Micro-Cap, Not Macro-Cap`), keeping each individual bullet bite-sized (`1–2` short spoken sentences).
- **Over-translating developer terms, disguising identifiers as vague nouns, using zombie nouns, or writing bilingual headers:** Never translate `wheel`, `shell`, `agent`, `dict`, `pipeline`, `package`, `commit`, or `hook` into stiff literal nouns, never hide a real identifier behind *"the flag coordinator"*, never open sentences with *"The implementation of..."*, and never write `<Local Label> (<English Label>):`.
- **Reciting raw code syntax in prose right before a snippet, jumping into code symbols without a plain-language opening, or skipping API pre-decoding:** Never recite `.flatMap(...).find(...)` in prose before showing the code; always explain the core idea in plain everyday words first and introduce unfamiliar library APIs, CLI queries, hooks, or callbacks (`what it controls`, `when it runs`, `parameters`, `return value`) right above the code block.
- **Exceeding 76 characters per line in code/comments/diagrams, omitting enclosing signatures, or using 4-column trace tables:** Wrap `//` comments cleanly under 76 characters, keep enclosing function/class signatures, use ASCII rulers only for spatial/slice/offset/bitwise math, and format dry-runs as Vertical Case Walkthrough cards (`*Input:*`, `*How the code checks it:*`, `*Result:*`).
- **Chaining prose clauses with `->` arrows, nesting backticks, wrapping links in outer backticks, or outputting HTML/Mermaid:** Write complete spoken sentences ending with a period (`.`), keep backticks inside link brackets (`` [`file.ts:10`](path/to/file.ts#L10) ``), and use pure Markdown + `< 76`-char ASCII diagrams.

---
name: map
description: Use when onboarding to an unfamiliar repository or monorepo, locating composition roots and container trust boundaries across packages, auditing dead or dynamically wired modules with a 100% coverage ledger and git hotspots, harvesting architectural patterns from an external repo, or generating multi-file C4/arc42 architecture documentation and AGENTS.md contracts.
license: MIT
metadata:
  author: keystone-ecosystem
  version: "0.1.0"
  opencode/slash: "true"
  opencode/autoinvoke: "true"
---

# Keystone Map — Macro Repository Onboarding, Two-Tier Architecture Atlas & `AGENTS.md` Lock-In

Build an accurate repository-wide mental model and persistent project memory during Day-1 onboarding by prioritizing **architectural truth over stale `README.md` files**, **two-tier file storage (`docs/keystone/map/` for human/agent docs vs. `.keystone/map/01-coverage-ledger.md` for machine audit ledgers)**, and **`learn-from-code`'s 3-second visual comprehension**: run Dual-Graph Recon first, generate the verified multi-file Architecture Atlas in `docs/keystone/map/` written in natural developer language, lock the pointer contract into `./AGENTS.md`, and hand off in chat with a **Crisp Reading & Task Navigation Guide (`<= 15–20` lines, zero duplication of `00-INDEX.md`)**.

**Save human architecture docs to:** `docs/keystone/map/` *(User preferences for location override this default)*
**Save machine coverage ledger to:** `.keystone/map/01-coverage-ledger.md` *(Auto-ignored via `.keystone/.gitignore`)*

**REQUIRED BACKGROUND:** You MUST obey the Shared Language, Plain-Language Syntax, Code-Explanation, and Visual Comprehension Core in `keystone:using-keystone` across both chat output and 100% of generated `.md` files.

**Announce at start (Localized to the user's language):** Briefly state in the user's active language that you are using `keystone:map` (e.g., *"Using `keystone:map` to map [target repository] architecture."* in English, or *"Dùng `keystone:map` để khảo sát và lập bản đồ kiến trúc cho [dự án]."* in Vietnamese).

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
NEVER copy claims from `README.md` or outdated wikis without verifying them against source code. NEVER start by running `tree` or spawning folder-summarizing subagents. If `skills/using-keystone/SKILL.md` is not already loaded in this session (or in any dispatched subagent), you MUST `read_file` `skills/using-keystone/SKILL.md` before writing. Always execute Step 1 (`bash skills/map/scripts/recon-graphs.sh` + targeted source reads) before writing. Every generated `.md` file in `docs/keystone/map/` MUST match the user's language 100% in natural spoken developer prose (zero textbook translationese, zero academic jargon like `RAD-AI E1` / `QOC` / `Zeller`, zero dual-language parenthetical headers), store the machine audit ledger in `.keystone/map/01-coverage-ledger.md`, and pass `bash skills/map/scripts/validate-atlas.sh` (`STATUS: PASSED`).
</HARD-GATE>

## When to Use (Scale-Based Lifecycle Routing)

- **Use `keystone:map` when (Day-1 Repo Onboarding & Macro Architecture Atlas):**
  - Onboarding to an unfamiliar repository or polyglot monorepo (`Bazel`, `Nx`, `Turborepo`, `Cargo`, `Go`) and asking where to start reading or how the architecture is wired together.
  - Generating a multi-file Architecture Atlas (`docs/keystone/map/`) backed by a $100\%$ denominator coverage ledger (`.keystone/map/01-coverage-ledger.md`) and anchoring `./AGENTS.md`.
  - Running static call-graph, `bazel query`/`cquery`/`aquery`, and Git Hotspot / Co-Change reconnaissance to map module boundaries and core data models, or harvesting architectural patterns from an external repository.
- **Do NOT use `keystone:map` when:**
  - Tracing a single specific business flow, feature pipeline, webhook, or request lifecycle step-by-step from trigger to output (**REQUIRED SUB-SKILL:** Use `keystone:flow`).
  - Explaining a single isolated `< 30`-line function/regex/bitwise snippet line-by-line or reviewing a `git diff` with a 2-turn Quiz Gate (`decode`).
  - Debugging a runtime crash, stacktrace, panic, or deadlock (`trace`).
  - Writing a greenfield RFC, ADR, or implementation spec before coding (`design`).

## Inline `using-keystone` / `learn-from-code` Language, Syntax & Visual Clarity Rules

Apply these exact language and visual formatting rules across 100% of generated `.md` files in `docs/keystone/map/` and your chat handoff:

1. **Everyday Spoken Developer Language & Natural Code-Switching:**
   - Write 100% of headers, bullets, walkthroughs, and inline `//` comments in the user's active language with **zero dual-language parenthetical headers** (never write `<Local Label> (<English Label>):`) and **zero academic jargon** (`RAD-AI E1`, `C4-E1`, `QOC/ATAM`, `Zeller Infection Chain`, `Author Fractal Value F`).
   - Preserve universal technical terms that native developers say daily in English (`git diff`, `commit`, `repo`, `monorepo`, `package`, `target`, `pipeline`, `CI/CD`, `script`, `shell`, `CLI`, `terminal`, `dict`, `list`, `array`, `object`, `struct`, `class`, `function`, `module`, `plugin`, `agent`, `wheel`, `binary`, `build`, `test`, `unit test`, `query`, `flag`, `config`, `race condition`, `deadlock`, `in-place`, `offset`, `stream`, `buffer`, `fallback`, `edge case`, `breakpoint`, `mock`, `payload`, `thread`, `async/await`, `callback`, `hook`, `state`, `migration`, `backfill`, `schema`, `atomic`, `middleware`, `dependency injection`, `router`, `idempotency`, `rdeps`)—never translate `wheel` as vehicle wheels, `shell` as outer shells, `agent` as textbook AI nouns, or `dict` as language dictionaries.
2. **Mechanical Plain-Language Syntax (`Concrete Actor + Strong Action Verb`, `One Word = One Meaning`, `Old-Before-New`):**
   - **Concrete Actor + Strong Action Verb (`Zero Zombie Nouns`):** Pair a concrete actor (`User`, `Router`, `CI script`, `Function X`) directly with a strong action verb (`overwrites`, `skips`, `blocks`, `prefixes`, `injects`, `validates`). Never open sentences with abstract nominalizations (*"The implementation of..."*, *"The execution of..."*).
   - **Ban "Translationese", Literal Metaphor Calques & Bureaucratic File Titles:** Never translate English metaphors (`drop`, `isolate`, `deduplicate`, `preserve`, `hydrate`, `swallow`, `plumbing`) or internal document roles (*"coverage ledger"*, *"agent contract"*, *"data dictionary"*, *"control plane"*, *"execution spine"*, *"composition root"*) word-by-word into stiff legal/accounting phrases; express them naturally (*"directory review & bug list"*, *"project rules for AI (`AGENTS.md`)"*, *"shared data structures & configs"*, *"CI scripts"*, *"main execution flow"*, *"main entry point"*).
   - **One Word = One Meaning & `Old-Before-New` Sentence Chaining:** Use the exact same term for a concept throughout the files (zero synonym rotation). Write short, complete sentences ending with a period (`.`) linked by `Old-Before-New` transitions (open sentence 2 with the concept or result produced at the end of sentence 1). **NEVER chain prose clauses with `->` arrows** and **NEVER write choppy telegraphic "half-prose, half-code" fragments**.
3. **Cross-Surface CLI & GUI Rendering Discipline (`< 76` Chars, Bite-Sized Bullets, Safe Links):**
   - **Bite-Sized Bullets (`Micro-Cap, Not Macro-Cap`):** Unlimited total bullets and code steps in Group 2 files, but each individual bullet holds **1 single idea (`1–2` short spoken sentences)** using `**bold:**` for parent titles and `*italic:*` for child labels (never `***...***`).
   - **76-Character Width Cap:** Keep every line inside code blocks, inline `//` comments, ASCII diagrams, and ASCII rulers **strictly under 76 characters** (wrap long comments across consecutive `//` lines).
   - **Semantic Traffic-Light Icons Only (`✅`, `❌`, `⚠️`):** Ban decorative emojis (`🚀`, `💡`, `✨`, `📌`, `🔥`, `🔌`).
   - **Clickable Visible `filename:line` Links & Safe Backtick Escaping:** Format links as `` [`path/to/file.ext:line`](path/to/file.ext#Lline) `` on first mention in a section—never abbreviate to a bare basename inside `docs/keystone/map/`, never wrap `[label](url)` in outer backticks, never wrap backtick-containing expressions (`` `${a}_${b}` ``) inside single inline backticks, and never output raw HTML tags (`<br>`, `<details>`) or `mermaid` blocks.

## Unified 4-Step Execution Pipeline (No Separate Modes)

```text
+========================================================================+
|        KEYSTONE:MAP UNIFIED 4-STEP ONBOARDING PIPELINE                 |
+========================================================================+
|  [Step 1: Load using-keystone + Dual-Graph Recon (recon-graphs.sh)]    |
|  - Graph 1: Manifests, Entry Points / Wiring, Data Models, PageRank    |
|  - Graph 2: Release Tags, Git Hotspots, Cross-Folder Co-Change         |
|                                  |                                     |
|                                  v                                     |
|  [Step 2: Two-Tier Atlas Generation & Verification]                    |
|  - Tier 1 (docs/keystone/map/): 00-INDEX.md (<=150L), architecture/*,  |
|    components/comp-*.md, flows/flow-XX-<name>.md (scaled to repo size) |
|  - Tier 2 (.keystone/map/):     01-coverage-ledger.md (auto-ignored)   |
|  - Pass bash skills/map/scripts/validate-atlas.sh == 0                 |
|                                  |                                     |
|                                  v                                     |
|  [Step 3: Lock In Root ./AGENTS.md Pointer Contract (<=15L block)]     |
|                                  |                                     |
|                                  v                                     |
|  [Step 4: Crisp Chat Handoff (<=15-20L Reading Guide, Zero Duplication)|
+========================================================================+
```

### Step 1: Load Clarity Engine & Run Architect's Dual-Graph Recon (`recon-graphs.sh`)
1. **Load `using-keystone` First:** If `skills/using-keystone/SKILL.md` is not already loaded in your current context, call `read_file` on `skills/using-keystone/SKILL.md` (and require any dispatched subagents to read `skills/using-keystone/SKILL.md` and `skills/flow/SKILL.md`).
2. Execute `bash skills/map/scripts/recon-graphs.sh "<target_repo_dir>"` (creates `.keystone/cache/`, `.keystone/tmp/`, `.keystone/map/`, and `.keystone/.gitignore`; read `skills/map/references/wiring-and-monorepo-guide.md` for Bazel `query`/`cquery`/`aquery`, Nx, Turborepo, and dynamic wiring patterns).
3. **Graph 1 — Static Wiring, Entry Points & Core Data Models:**
   - Read build/package manifests (`package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `MODULE.bazel`, `BUILD.bazel`, `nx.json`) to locate entry points and the **Composition Root** where configs, DB pools, DI containers, middlewares, routers, or CI pipelines are wired.
   - Extract **Core Data Models & Config Contracts** (`struct`, `interface`, ORM schemas, or step payload dicts) into `docs/keystone/map/architecture/data-dictionary.md` before dispatching component or flow scouts.
4. **Graph 2 — Git Hotspots, Co-Change Coupling & Proportional Scoping (`Proportion`):**
   - Inspect recent release tags, frequently modified hotspot files, and Cross-Boundary Co-Change pairs (`A <-> B` files that must be edited together).
   - **Proportional File Scaling (`Proportion`):** Scale the number of `components/comp-*.md` and `flows/flow-*.md` files to the repository's actual complexity—on small repositories (`< 10` source files), group tightly related small packages into 1–2 concise `components/comp-*.md` files instead of creating separate redundant files for 5-line modules; on large repositories (`100+` files), map the top 5–7 modules in `00-INDEX.md` and deep-dive the 2–3 core modules most relevant to the user's goal.

### Step 2: Generate & Verify Two-Tier Repository Atlas (`docs/keystone/map/` + `.keystone/map/`)
Write **every file in `docs/keystone/map/` in the user's exact language** using the inline `using-keystone` / `learn-from-code` rules above:
- **Tier 1 (Human & Agent Persistent Docs in `docs/keystone/map/`):**
  - `00-INDEX.md` (`<= 150` lines): Open with the standardized routing header (`> **For agentic workers:** REQUIRED SUB-SKILL: Use keystone:flow ...`, `**Goal:**`, `**Architecture:**`, `**Tech Stack:**` localized in the user's language), followed by Section 1 `Big Picture` (4 `learn-from-code` bullets naming real tools like `Bazel`/`Buildkite` directly with zero file/function/variable names), a `< 76`-char ASCII Architecture Diagram, a 4-Step Source-Code Reading Order, and a Task-Oriented Navigation Guide.
  - `architecture/data-dictionary.md` (core data structures/configs with `< 76`-char subgoal-commented code blocks, concrete sample values, and plain-language safety rules).
  - `architecture/c2-wiring-and-containers.md` (`< 76`-char ASCII container diagram, pre-decoded bootstrap/config mechanisms, `< 76`-char subgoal-commented entry-point code, and `Why the code is written this way` + `Case walkthrough`).
  - `architecture/evolution-and-hotspots.md` (frequently modified files, Cross-Boundary Co-Change files that must be updated together, and `Why choose this design` comparing `❌ Naive approach` vs. `✅ Current design` in `< 76`-char code slices).
  - `components/comp-<domain>.md` (plain-language purpose, `< 76`-char ASCII component diagram, core code mechanics with subgoal comments, `Why`, `Case walkthrough`, `⚠️ Defect Alert` if any, and where to edit).
  - `flows/flow-<id>-<name>.md` (**1 File = 1 Cohesive End-to-End Flow** — **REQUIRED SUB-SKILL:** Read and follow `skills/flow/SKILL.md`'s 5-Section `learn-from-code` contract to write each flow file).
- **Tier 2 (Machine Audit Ledger in `.keystone/map/01-coverage-ledger.md`):**
  - `.keystone/map/01-coverage-ledger.md` (audit $100\%$ of top-level directories from `git ls-tree -d --name-only HEAD` using `CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`, 12-char Git hash, `C_wiring: 100%`, `C_hotspot: 100%`, and plain-language role descriptions + any `⚠️` bugs found). Keeping this ledger in `.keystone/map/` prevents machine audit tokens from cluttering `docs/` or `git status`.
- Read `skills/map/references/atlas-and-subagent-contracts.md` and run `bash skills/map/scripts/validate-atlas.sh` (`STATUS: PASSED`).

### Step 3: Final Closing Lock-In — Anchor Root `./AGENTS.md` Pointer Contract
Read `skills/map/references/agent-contract-template.md` and create or update `./AGENTS.md` (`< 100` lines if new, or a `<= 15`-line `<!-- keystone-map:start -->` pointer block if `./AGENTS.md` already exists) containing verified build/test commands, module boundaries, safety rules, entry points (`filename:line`), and pointers into `docs/keystone/map/`.

### Step 4: Pre-Output Clarity Verification Gate & Crisp Chat Handoff (`<= 15–20` Lines)
Before sending your response, verify all 5 style checks across every generated `.md` file:
- [ ] **Check 1:** 100% natural spoken user language across all `.md` files and chat (zero `<Local> (<English>):` headers, zero `RAD-AI E1` / `QOC/ATAM` / `Zeller` jargon, zero bureaucratic file titles like *"coverage ledger"* / *"agent contract"* / *"data dictionary"*).
- [ ] **Check 2:** Universal English developer terms (`CI`, `pipeline`, `monorepo`, `package`, `target`, `wheel`, `script`, `dict`, `shell`, `CLI`, `terminal`, `agent`, `build`, `test`, `unit test`, `commit`) preserved naturally.
- [ ] **Check 3:** Every sentence uses `Concrete Actor + Strong Action Verb` and `Old-Before-New` chaining (zero `->` prose chains, zero zombie nouns).
- [ ] **Check 4:** Every line inside code blocks, `//` comments, and ASCII diagrams is `< 76` characters, keeps enclosing signatures, and is followed by `Why the code is written this way` + `Vertical Case Walkthrough` cards (`✅`/`❌`).
- [ ] **Check 5:** `bash skills/map/scripts/validate-atlas.sh` returned `STATUS: PASSED`.

Then present a **Crisp Chat Handoff (`<= 15–20` lines — DO NOT copy-paste `00-INDEX.md` or redraw the ASCII diagram in chat!)** in the user's language:
1. **Saved Location, 2-Sentence Repo Overview & `⚠️` Bug Alert:**
   - State that the Architecture Map is saved to [`docs/keystone/map/00-INDEX.md`](docs/keystone/map/00-INDEX.md) and agent rules are locked in [`AGENTS.md`](AGENTS.md).
   - Summarize in 1–2 plain spoken sentences what the repository does (naming real tools like `Bazel`/`Buildkite`) and highlight any `⚠️` hidden bug(s) discovered during recon in 1 sentence.
2. **What to Read & Why (`4–6` Bite-Sized Bullets Linking Both `.md` Guides and `file:line` Source Files):**
   - **To grasp the big picture, ASCII diagram & 4-step reading order:** Open [`00-INDEX.md`](docs/keystone/map/00-INDEX.md) and [`c2-wiring-and-containers.md`](docs/keystone/map/architecture/c2-wiring-and-containers.md).
   - **To trace or modify [Main Flow 1]:** Read [`flows/flow-01-<name>.md`](docs/keystone/map/flows/flow-01-<name>.md) (starts at [`path/to/entry1:line`](path/to/entry1#Lline)).
   - **To trace or modify [Main Flow 2]:** Read [`flows/flow-02-<name>.md`](docs/keystone/map/flows/flow-02-<name>.md) (starts at [`path/to/entry2:line`](path/to/entry2#Lline)).
   - **To check shared configs, package internals & coupled files before editing:** Open [`data-dictionary.md`](docs/keystone/map/architecture/data-dictionary.md), [`components/comp-<domain>.md`](docs/keystone/map/components/comp-<domain>.md), and [`evolution-and-hotspots.md`](docs/keystone/map/architecture/evolution-and-hotspots.md).
   - **`⚠️` To inspect or fix the hidden bug(s) found during recon:** Check [`path/to/bug:line`](path/to/bug#Lline) (detailed fix in [`flows/flow-01-<name>.md`](docs/keystone/map/flows/flow-01-<name>.md)).
3. **1-Line Next-Step Question:**
   - Ask in 1 natural sentence whether the user wants to review the map, fix the `⚠️` bug(s) right away, or dive into a specific task.

## Red Flags — STOP and Fix Before Sending

- **Copy-pasting `00-INDEX.md` or redrawing the ASCII diagram in Chat:** Once saved to `docs/keystone/map/`, keep the Chat Handoff `<= 15–20` lines.
- **Over-translating developer terms or leaking machine audit tokens:** Translating `wheel`, `shell`, `agent`, `dict`, `pipeline`, `package`, `target`, `CI`, or `terminal` into stiff textbook nouns, or leaking `CORE_WIRED`, `C_wiring`, `RAD-AI E1`, `QOC/ATAM`, `Zeller`, or 12-char Git hashes outside `.keystone/map/01-coverage-ledger.md`.
- **Skipping `skills/using-keystone/SKILL.md`, `validate-atlas.sh`, or `./AGENTS.md` lock-in.**

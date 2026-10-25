# Keystone Map & Flow — Multi-File Atlas Templates, Subagent Contracts & Golden 6-Section Flow Anatomy

Use this reference when executing **`keystone:map` (Unified 4-Step Repository Atlas & `AGENTS.md` Lock-In)** and **`keystone:flow` (Single-Pass 6-Section Deep Flow Anatomy)**.

---

## 1. Two-Tier Progressive Disclosure Atlas Specification (`docs/keystone/map/` + `.keystone/map/`)

NEVER emit a single monolithic architecture file when documenting an entire repository in `keystone:map`. Split output across a Two-Tier Storage Hierarchy:
- **Tier 1 (Human & Agent Persistent Docs in `docs/keystone/map/`):** Clean developer documentation written in the user's language (`00-INDEX.md`, `architecture/*.md`, `components/comp-*.md`, `flows/flow-*.md`).
- **Tier 2 (Machine Audit Workspace in `.keystone/map/01-coverage-ledger.md`):** Auto-ignored via `.keystone/.gitignore` so machine audit tokens (`CORE_WIRED`, `ADAPTER_CONTRACT`, `DYNAMIC_GAP`, `UNWIRED_DEAD`, 12-char Git hashes, `C_wiring: 100%`) never clutter `docs/` or `git status`.

```text
+========================================================================+
|        TWO-TIER PROGRESSIVE DISCLOSURE ARCHITECTURE ATLAS              |
+========================================================================+
| Tier | Standardized Path                           | Length Control    |
+------+---------------------------------------------+-------------------+
| T0   | ./AGENTS.md (synced to CLAUDE.md/GEMINI.md) | <= 15L ptr (<300L)|
| T1   | docs/keystone/map/00-INDEX.md               | <= 150 lines      |
|      | .keystone/map/01-coverage-ledger.md         | Auto-ignored (0L) |
| T2   | architecture/c2-wiring-and-containers.md    | No macro line cap |
|      | architecture/data-dictionary.md             | No macro line cap |
| T3   | architecture/evolution-and-hotspots.md      | No macro line cap |
| T4   | components/comp-<domain>.md                 | Scaled to repo    |
| T5   | flows/flow-<id>-<name>.md                   | 1 flow/file, 0 cap|
| T6   | .cursor/rules/<domain>.mdc                  | <= 500 words/file |
+========================================================================+
```

### Mandatory Authoring Rules Across All Atlas Files (`learn-from-code` Shared Clarity Engine)
1. **Two-Group Length Control (`Micro-Cap, Not Macro-Cap` + `1 File = 1 End-to-End Flow`):**
   - **Group 1 — Routing Index & Always-On Agent Config Files (Strict Macro Line/Word Caps):** Keep `00-INDEX.md <= 150` lines (for 5-minute orientation), `./AGENTS.md` pointer block `<= 15` lines (total root `AGENTS.md < 100–300` lines), and `.cursor/rules/<domain>.mdc < 200` words for `alwaysApply: true` or `200–500` words for `globs`-scoped rules (`alwaysApply: false`).
   - **Group 2 — Deep Dissection, Data Dictionary, Component & Ledger Reports (ZERO Artificial Total Line Caps):** Never impose a total line cap on `flows/flow-XX-<name>.md`, `components/comp-<domain>.md`, `architecture/*.md`, or `01-coverage-ledger.md`. Never truncate code steps, hide core logic behind `...`, skip `Contrastive Why`, or revert to telegraphic `->` prose to fit a line count. Instead, keep files clean via **3 structural rules**:
     1. *Micro-Cap, Not Macro-Cap:* Unlimited total bullets and code steps, but each bullet holds **1 single idea (`1–2` short spoken sentences)** and every line inside code blocks, `//` comments, and ASCII diagrams is **`< 76` characters**.
     2. *Split by Cohesive Business Flow (`1 File = 1 End-to-End Flow`):* Each `flows/flow-XX-<name>.md` file dissects **1 cohesive end-to-end business flow** from trigger to persistence (split distinct flows into `flow-01`, `flow-02`, `flow-03`).
     3. *Focused Scoping on Large Repos (`100+` files):* Map top 5–7 modules in `00-INDEX.md` and deep-dive the 2–3 core modules or primary spine flows.
2. **100% User-Language Synchronization & Everyday Spoken Developer Register (`learn-from-code` Style):**
   - Write **every file in `docs/keystone-map/` (`00-INDEX.md`, `01-coverage-ledger.md`, `architecture/*.md`, `components/comp-*.md`, `flows/flow-*.md`) in the exact language the user used in their prompt** (never write chat in Vietnamese while leaving `docs/keystone-map/*.md` in English).
   - **Zero Dual-Language Header Clutter & Zero Academic Jargon in Output:** Use natural monolingual developer labels in the user's language; never pair two languages side-by-side (`<Local Label> (<English Label>):`), and **NEVER print academic framework acronyms (`RAD-AI E1`, `C4-E1`, `QOC/ATAM`, `Zeller's Infected State`, `Author Fractal Value F`) in user-facing headers, diagrams, or prose**. Keep machine-validated ledger tokens (`CORE_WIRED`, `ADAPTER_CONTRACT`, `DYNAMIC_GAP`, `UNWIRED_DEAD`, `C_wiring: 100%`, `C_hotspot: ...%`) strictly inside `01-coverage-ledger.md`.
   - **Preserve Universal Developer Terms (Never Over-Translate into Textbook Calques):** Always preserve `CI/CD`, `pipeline`, `repo`, `monorepo`, `package`, `target`, `wheel`, `script`, `shell`, `CLI`, `terminal`, `dict`, `list`, `array`, `object`, `struct`, `class`, `function`, `module`, `plugin`, `agent`, `binary`, `build`, `test`, `unit test`, `query`, `flag`, `config`, `commit`, `race condition`, `deadlock`, `middleware`, `dependency injection`, `router`, `schema`, `atomic`, `breakpoint`, `payload`, `hook`, `state`, `migration`, `idempotency` in English rather than translating `wheel` as "distribution wheel", `shell` as "outer shell", `agent` as "cloud agent", or `dict` as "dictionary structure".
3. **Mechanical Plain-Language Syntax & Visual Breathing Room (`learn-from-code` Register):**
   - **Concrete Actor + Strong Action Verb (`Zero Zombie Nouns`):** Pair a concrete actor (`User`, `Router`, `CI script`) with a strong action verb (`overwrites`, `skips`, `blocks`, `prefixes`, `injects`). Ban nominalizations ("the execution of", "the initialization of"), ban translationese and literal metaphor calques (`drop`, `hydrate`, `swallow`), enforce `One Word = One Meaning`, and write short, complete sentences ending with periods `.` linked by `Old-Before-New` transitions (**NEVER chain prose clauses with `->` arrows**).
   - **Bite-Sized Bullets (`1 Idea = 1 Bullet`, `1–2` short sentences):** Use `**bold:**` for parent item titles and `*italic:*` for child sub-bullet labels (never `***...***`).
   - **Semantic Traffic-Light Icons Only (`✅`, `❌`, `⚠️`):** Ban decorative emojis (`🚀`, `💡`, `✨`, `📌`, `🔥`, `🔌`) across all `.md` files.
4. **`learn-from-code` Code & Schema Explanation Discipline in Auxiliary `.md` Files:**
   - **76-Character Width Cap:** Keep every line inside code blocks, inline `//` comments, and ASCII diagrams under `76` characters.
   - **Enclosing Signatures & Subgoal-Labeled Inline Comments (`// 1.`, `// 2a.`):** Always keep the enclosing `struct`/`interface`/`class`/`function` signature (eliding repetitive boilerplate with `...`), put explanations of fields, magic numbers, `??`/`||` fallback chains, and concrete evaluated sample values directly inside `< 76`-char `//` comments in the user's language, add a `< 76`-char `// Anatomy:` legend only when unfamiliar low-level tokens appear, and include an **ASCII Ruler Diagram** for spatial/slice/offset math.
   - **Pre-Decode Unfamiliar APIs/Hooks/DI Seams Before Code Blocks:** Introduce unfamiliar framework APIs, CLI queries, DI bindings, hooks, or middlewares right before the code snippet stating (a) what it controls, (b) the exact moment it runs, (c) incoming parameters, and (d) return value/effect.
   - **Why It's Written This Way + Conversational Vertical Case Walkthroughs Below Code Snippets:** Follow code mechanics snippets in `components/comp-*.md`, `c2-wiring-and-containers.md`, and `flows/flow-*.md` with natural monolingual headers for **Why the code is written this way** (`*italic (Step // 1.):*`) and **Step-by-step case walkthrough** (`- **Case 1 — <Title>:**` with `*Input:*`, `*How the code checks it:*`, `*Result:*` in complete spoken sentences with `✅`/`❌`—never cramped 4-column Markdown tables, and never parenthetical `<Local> (Contrastive Why)` labels).
5. **Clean ASCII Diagram Hygiene + Strict Coordinate Formatting (Gate 4A):**
   - Keep every ASCII diagram `< 20` nodes and `< 76` characters wide, using plain developer labels for processes and external services.
   - ALWAYS write the full repo-relative path inside clickable links (`[`tui_gateway/server.py:600`](tui_gateway/server.py#L600)`); NEVER abbreviate to a bare basename (`server.py:600`) inside `docs/keystone-map/` files, NEVER wrap links in outer backticks, NEVER use comma-separated line lists (`:7,11,25`), and NEVER output raw HTML tags or `mermaid` blocks.

---

## 2. Standardized File Templates (`docs/keystone/map/` — Localized to User's Language in `learn-from-code` Style)

### 2.1. `00-INDEX.md` (Tier 1, Group 1 Routing Index — `<= 150` Lines)
- **Standardized Routing Header:** Open `00-INDEX.md` with:
  ```markdown
  # [System Name] — Architecture Map

  > **For agentic workers:** REQUIRED SUB-SKILL: Use `keystone:flow` to trace or extend a specific execution flow from this map, or `keystone:shield` before opening a PR.

  **Goal:** [1 sentence in the user's language]
  **Architecture:** [2-3 sentences in the user's language]
  **Tech Stack:** [Core tools/languages]
  ```
- **Section 1 Big Picture (100% Plain-Language Macro Story):** Open directly with the 4 `learn-from-code` bullets localized to the user's language (`Goal`, `Key design challenge` with brief everyday analogy + bite-sized `*italic:*` sub-bullets, `Core approach`, and a `< 76`-char `Concrete example` showing `Input -> Output`). **Do not paste file paths or local variable names in the 3 opening prose bullets, but ALWAYS name real tools and concepts (`Bazel`, `Buildkite`, `CI pipeline`, `monorepo`, `package`, `wheel`) directly.**
- **High-Level Architecture Diagram (`< 76`-char ASCII Diagram):** Show how the developer, main folders/packages, and external tools connect using plain everyday labels.
- **4-Step Source-Code Reading Order ("Which Code File to Read First and Why"):** A numbered 4-step reading path (`1. Core Config & Data Helpers -> 2. Entry Points & Wiring -> 3. Main Execution Flow -> 4. Hidden Traps & Coupled Files`) with clickable `[`path/to/file.ext:line`](path/to/file.ext#Lline)` links explaining what to read first and why.
- **Task-Oriented Navigation Guide ("Which `.md` Guide & Code File to Open for Each Goal"):** Pair each developer goal (`Understand data structures`, `Trace entry points & wiring`, `Modify Flow 1`, `Modify Flow 2`, `Check coupled files before opening a PR`) with relative Markdown links (`[Data Dictionary](./architecture/data-dictionary.md)`, `[Flow 01](./flows/flow-01-main.md)`) and source file links.

### 2.2. `.keystone/map/01-coverage-ledger.md` (Tier 2 Machine Audit Ledger — Auto-Ignored in Git)
- **Header Metadata:** `head_commit`, `root_tree_hash`, `scip_status` (`SCIP_ACTIVE` with `scip_content_fingerprint` or `BLOCKED_ORACLE`).
- **Closed-Loop 4-Bucket Table:** Every top-level directory from `git ls-tree -d --name-only HEAD` MUST appear with its canonical bucket token (`CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`), 12-char Git hash, primary `path/to/file.ext:line` evidence, and a concise plain-language role description in the user's language.
- **Hidden Bugs & Traps (`⚠️`) + Audit Summary Footer:** List any `⚠️` defects or runtime seams found, followed by `C_wiring: 100%` and `C_hotspot: 100%`.

### 2.3. `architecture/data-dictionary.md` (Tier 2, Group 2 Deep Dissection — Zero Artificial Line Cap)
- Present the repository's core data structures, config schemas, or payload dicts in the user's language:
  - **Core structures & config schemas:** Quote focused `< 76`-char code blocks with `[`path/to/file.ext:line`](...)` links, keeping the enclosing signature, eliding boilerplate with `...`, and explaining each key field in `< 76`-char inline `//` comments with concrete sample values.
  - **How data changes & safety rules:** Bite-sized `*italic:*` sub-bullets explaining valid states (`✅`), rejected cases (`❌`), and plain-language safety rules that must hold true when editing code.

### 2.4. `architecture/c2-wiring-and-containers.md` (Tier 2, Group 2 Deep Dissection — Zero Artificial Line Cap)
- Apply `learn-from-code` Code Mechanics to the repository's entry points and package wiring in the user's language:
  - **ASCII Architecture & Wiring Diagram (`< 76` chars):** Runtime processes, packages, and external tools.
  - **Entry-Point & Wiring Code Walkthrough:** Pre-decode unfamiliar build/DI/config rules (what it controls, when it runs, incoming parameters, return effect), quote the `< 76`-char subgoal-commented wiring code (`// 1.`, `// 2a.`), and explain **Why it is written this way** + **Case walkthrough**.

### 2.5. `architecture/evolution-and-hotspots.md` (Tier 3, Group 2 Deep Dissection — Zero Artificial Line Cap)
- Apply `learn-from-code`'s Senior Architectural Takeaways in the user's language (zero `QOC/ATAM` or `Fractal Value` jargon in headers):
  - **Frequently Modified Files (Hotspots):** Explain which files change most often in Git history and why they are sensitive.
  - **Coupled Files That Must Change Together (`A <-> B`):** Format each coupled pair as a `**bold:**` parent bullet with `*When it triggers & Coupled files:*` (with concrete sample values and `path/to/file:line`) and `*What breaks if missed & How to update safely:*` child sub-bullets.
  - **Why Choose This Design (`❌ Naive approach` vs. `✅ Current design`):** Explain why the repo chose its current architecture over simpler alternatives, accompanied by a focused `< 76`-char `❌ Naive approach` vs. `✅ Current design` code comparison with concrete sample values.

### 2.6. `components/comp-<domain>.md` (Tier 4, Group 2 Deep Dissection — Zero Artificial Line Cap)
- Write each component file in the user's language using `learn-from-code`'s narrative and code-dissection structure:
  1. **Overview & Component Diagram:** Plain-language goal, how it connects to other folders, and a `< 76`-char ASCII diagram.
  2. **Core Code Walkthrough:** Pre-decode unfamiliar APIs/rules, quote `< 76`-char Subgoal-Commented Code Blocks (`// 1.`, `// 2a.`), and follow with **Why it is written this way** and **Step-by-step case walkthrough** (`*Input:*`, `*How the code checks it:*`, `*Result:*` with `✅`/`❌`).
  3. **Hidden Bugs (`⚠️`) & Where to Edit:** Any `⚠️` defect alert (`❌ Current` vs. `✅ Fix`) plus exact `path/to/file.ext:line` touchpoints for common changes.

### 2.7. `flows/flow-<id>-<name>.md` (Tier 5, Group 2 Deep Dissection — Zero Artificial Line Cap, `1 File = 1 End-to-End Flow`)
Write each flow file in the user's language for **1 cohesive end-to-end flow** using `keystone:flow`'s **Single-Pass 5-Section `learn-from-code` Contract** (monolingual headers, zero academic jargon):
1. **Section 1 — Big Picture (`Tổng quan`):** `Goal`, `Key design challenge` (with brief everyday analogy + bite-sized sub-bullets), `Core approach`, and `Concrete example` (`< 76` chars, naming real tools directly).
2. **Section 2 — Main Execution Flow (`Luồng chạy chính`):** 3–6 crisp 1-sentence steps tracing the main spine (`[`path/to/file.ext:line`](...)`, max 1 primary function/script per step).
3. **Section 3 — Core Code Steps (`Chi tiết từng bước code`):** Pre-decoded API/query contracts, `< 76`-char subgoal-commented code blocks (`// 1.`, `// 2a.`), **Why the code is written this way**, and **Step-by-step case walkthrough** (`*Input:*`, `*How the code checks it:*`, `*Result:*` with `✅`/`❌`).
4. **Section 4 — Verification & Hidden Risks (`Kiểm chứng & Rủi ro tiềm ẩn`):** `⚠️ Defect Alert` (`*Scenario & symptom:*`, `*Root cause:*`, `*Buggy code & Fix:*` with `❌ Current` vs. `✅ Fix`), `Verified & Quick check` (`breakpoint` + test command), and `Coupled files to update together`.
5. **Section 5 — Where to Touch & Reusable Techniques (`Điểm cần sửa khi mở rộng & Kỹ thuật tái sử dụng`):** 2–3 modification recipes (`*Where to edit:*`, `*Companion files:*`, `*Safety rule:*` `✅`) + 4-part reusable engineering pattern (`Adopt` / `Adapt` / `Reject` when harvesting external repos).

---

## 3. Subagent Economics & File-Based Handoff Contract

1. **Explicit Model Tier Pinning:**
   - **Scout Subagents (Phase 2):** ALWAYS pin `model: "haiku"` or `model: "flash"`.
   - **Unified Read-Only Auditor (Phase 3):** Pin `model: "sonnet"` or `model: "flash"` in strict read-only mode.
   - **Main Architect Synthesis (Phase 4):** Run on `opus` / `sonnet` / `pro`.
2. **Tornhill Unhealthy Code Token Tax Slicing (`35–45%` Savings):**
   - NEVER assign a Scout Subagent to read an entire high-churn Hotspot file (`> 500` LOC) end-to-end. Pass the exact AST function slice coordinates (`file:line_start-line_end`) emitted in Step `[4/7]` of `recon-graphs.sh`.
3. **File-Based Handoff Prompt Template (Scout Subagent — Enforcing User Language & `learn-from-code` Style):**
   ```markdown
   ROLE: Phase 2 Architecture Scout (Model: haiku/flash)
   USER_LANGUAGE: <exact language used by the human engineer>
   TARGET_MODULE: <module_path> (tree_hash: <hash>)
   ASSIGNED_COORDINATES: <file:line_start-line_end from PageRank>
   DATA_DICTIONARY_PATH: docs/keystone-map/architecture/data-dictionary.md
   OUTPUT_FILE: docs/keystone-map/components/comp-<domain>.md

   INSTRUCTIONS:
   1. Read ONLY assigned file:line slices and data-dictionary.md.
   2. Write OUTPUT_FILE 100% in USER_LANGUAGE with zero artificial
      total line cap (assign 1 cohesive end-to-end flow per flow-*
      file; use natural monolingual headers, zero dual-language
      parentheticals, and zero academic acronyms like RAD-AI/QOC/Zeller).
   3. Apply the learn-from-code Clarity Engine across the file:
      - Preserve everyday developer terms (CI, pipeline, monorepo,
        package, target, wheel, script, dict, shell, terminal, agent,
        plugin, build, test, commit) — never over-translate them.
      - Short spoken sentences (Concrete Actor + Strong Action Verb,
        Old-Before-New transitions ending with '.', zero '->' prose).
      - Micro-Cap per unit: bite-sized bullets (1–2 sentences,
        **bold:** parent titles, *italic:* child labels), < 76
        chars per code/comment/diagram line, icons (✅, ⚠️, ❌).
      - Pre-decode unfamiliar APIs/queries/hooks before code.
      - Quote < 76-char code blocks (keeping enclosing signatures)
        with Subgoal Comments (// 1., // 2a.) in USER_LANGUAGE.
      - Follow code blocks with natural monolingual headers for
        Why it is written this way and Conversational Vertical Case
        Walkthroughs (*Input:*, *How the code checks it:*, *Result:*).
   4. Anchor claims to full repo-relative path/to/file.ext:line.
   5. For flow-* files, use the 5-Section learn-from-code Contract.
   6. Return ONLY: "DONE: <OUTPUT_FILE> (<lines>L, <cites> cites)".
   ```

---

## 4. Phase 3 Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`)

To eliminate Subagent Confirmation Bias in Mode B, execute this 5-step adversarial loop:

```text
+========================================================================+
|        5-STEP ADVERSARIAL DOUBT AUDIT PIPELINE (PHASE 3)               |
+========================================================================+
|  [1. CLAIM]     Scout states 2-3 line falsifiable architectural claim  |
|        |                                                               |
|        v                                                               |
|  [2. EXTRACT]   Strip ALL Scout reasoning prose; keep ONLY             |
|        |        CLAIM + file:line coordinates + I/O contract           |
|        v                                                               |
|  [3. DOUBT]     Read-Only Auditor opens raw source at file:line        |
|        |        and searches for counter-evidence to refute CLAIM      |
|        v                                                               |
|  [4. RECONCILE] Main Agent fixes refuted claims or triggers retry      |
|        |                                                               |
|        v                                                               |
|  [5. STOP]      Run validate-atlas.sh == 0; lock 01-coverage-ledger.md |
+========================================================================+
```

- **Safe Cross-Model CLI Invocation Rule:**
  If invoking an external CLI model (`gemini` or `codex`) during `DOUBT`, first verify binary availability via `which gemini` / `which codex` and `--version`. Pass the extracted claim and source slice strictly via **file path or `stdin`** (`cat extracted-claim.txt | gemini ...`). **NEVER** interpolate source code containing backticks (`` ` ``) or `$(...)` into a shell command string.

---

## 5. Why `keystone:map` Replaces `learn-from-code`'s 2-Turn Quiz Gate With a Single-Pass Playbook

| Legacy `learn-from-code` Element | Why It Conflicts With Codebase Onboarding | `keystone:map` Replacement |
| :--- | :--- | :--- |
| **Turn-1 Quiz Gate & Faded Completion Problem Stop-Gate** | Forcing a newly onboarded engineer to pause at Section 5 and hiding architectural patterns until Turn 2 breaks holistic schema formation. | **Single-Pass Complete Report (Sections 1–6)** closing with Section 6 **Quick Modification Playbook ("Where to Touch")** & **Reusable Engineering Patterns** (or **Context-Fit Harvest Matrix**: `Adopt` / `Adapt` / `Reject` for external repos). |
| **Diff Symptom -> Root Cause -> Fix (Section 1)** | An existing codebase has no broken `Before -> After` diff patch. | **Section 1 Macro Domain Story:** Real-world role, Ownership & delegation boundaries, Key design challenge & Core approach, Concrete Input -> Output example. |
| **Scattered Data Types Inside Diff Steps** | Violates Fred Brooks's & Pennington's Situation Model principle during onboarding. | **Section 2 Core Data Structures & State Lifecycles** placed right after Section 1 ("Tables Before Flowcharts"). |

### Mode C Executable Constraints Export (`.cursor/rules/<domain>.mdc` & `./AGENTS.md`)
1. Generate scoped `.cursor/rules/<domain>.mdc` (`< 200–500` words):
   ```markdown
   ---
   description: Architectural invariants and Co-Change rules for <domain>
   globs: ["<domain>/**"]
   alwaysApply: false
   ---
   - NEVER bypass `<GuardSymbol>` (`<file:line>`); enforce `<invariant>`.
   - MUST inspect co-change partner `<partner_file>` when modifying
     `<source_file>`.
   ```
2. Update `./AGENTS.md` (and symlinked `CLAUDE.md`/`GEMINI.md`) with a **`<= 15`-line pointer block** wrapped in `<!-- keystone-map:start -->` and `<!-- keystone-map:end -->` pointing to `docs/keystone-map/00-INDEX.md` and `01-coverage-ledger.md`.

---

## 6. Golden Reference Example: Single-Pass 6-Section Flow Anatomy (`PaymentWebhookFlow`)

Below is the canonical example illustrating how Sections 1–6 read in practice (monolingual headers, zero code symbols in Section 1 prose, `< 76`-char subgoal-commented code blocks, Pre-Decoded API contract, Contrastive Why, Conversational Vertical Dry-Run cards, Section 5 `⚠️` Alert + Co-Change + Breakpoint, and Section 6 Playbook + Reusable Pattern):

### 1. System Purpose & Domain Boundaries
- **Real-world role:** This flow receives payment confirmation webhooks from the external payment gateway to activate the customer's order and credit their internal wallet balance once a charge succeeds.
- **Ownership & delegation boundaries:**
  - *What it owns:* Verifying the cryptographic signature of incoming payloads, blocking duplicate webhook deliveries, and updating the order status and wallet balance inside a single atomic database transaction.
  - *What it delegates:* Charging the customer's credit card (handled by Stripe) and sending receipt emails (handed off to an asynchronous outbox queue consumed by the notification service).
- **Key design challenge & Core approach:** Imagine a cashier receiving bank transfer SMS alerts during spotty cell reception; if the bank resends the same SMS three times and the cashier adds money on every message, the store loses money:
  - *Gateway retry storms:* When the server takes longer than 5 seconds to respond, the external payment gateway automatically resends the exact same webhook payload multiple times.
  - *Concurrent race conditions:* If two identical webhook deliveries hit the server in the same millisecond, both worker threads could read the order as pending and credit the wallet twice.
  - *How this architecture locks it down:* The flow extracts the gateway's unique event identifier into a deduplication ledger table first, then runs a conditional database update that checks the old status inline so only one thread can win.
- **Concrete example (`Input -> Transformation -> Output`):**
  ```ts
  // Anatomy: evt_99 (Unique gateway event ID) | ord_42 (Order ID)
  // 1. First valid webhook delivery arrives:
  const input1 = { eventId: "evt_99", orderId: "ord_42", amount: 5000 };
  // ✅ Credits wallet exactly once:
  const output1 = { orderStatus: "PAID", walletBalance: 5000 };

  // 2. Gateway retries the exact same "evt_99" payload 2 seconds later:
  const input2 = { eventId: "evt_99", orderId: "ord_42", amount: 5000 };
  // ❌ Blocks double credit immediately:
  const output2 = { skipped: true, reason: "DUPLICATE_EVENT" };
  ```

### 2. Core Data Structures & State Lifecycles
- **Core entities & state containers:** The flow revolves around `OrderRecord` and `WebhookLedger` in [`src/billing/schema.ts:28`](src/billing/schema.ts#L28):
  ```ts
  export interface OrderRecord {
    // Unique order identifier in the system (e.g. "ord_42")
    id: string;
    // Order state: only moves from "PENDING" to "PAID" or "FAILED"
    status: "PENDING" | "PAID" | "FAILED";
    // Payment amount in minor units / cents (e.g. 5000 = $50.00)
    amountMinor: number;
    // Monotonic version counter incremented on each state update
    version: number;
    ...
  }

  export interface WebhookLedger {
    // Gateway event ID acting as primary deduplication key ("evt_99")
    providerEventId: string;
    // Unix timestamp when settlement completed (e.g. 1761350400)
    processedAtUnix: number;
  }
  ```
- **State lifecycle & transitions:**
  - *Order creation (`PENDING`):* When the customer starts checkout, the service creates `OrderRecord` in `PENDING` state with `version = 1` (`✅`).
  - *Settlement (`PENDING` to `PAID`):* When a valid payment webhook arrives, the order transitions to `PAID` and increments `version` to `2` (`✅`).
  - *Reverse or duplicate transition (`PAID` to `PENDING` or `PAID` again):* Once an order reaches `PAID`, any subsequent attempt to settle or revert it is rejected immediately (`❌`).
- **Data safety rules (Invariants):**
  - *Atomic ledger and balance invariant:* Recording `providerEventId` in `WebhookLedger` and crediting the wallet balance must execute inside the same database transaction so a crash never leaves the wallet credited without a recorded event key.

### 3. Wiring Root, Entry Points & End-to-End Execution Path
- **Composition root & entry point wiring:**
  - *Raw body route registration and DI binding:* At server startup in [`src/server.ts:44`](src/server.ts#L44), the router mounts `POST /webhooks/payment` behind the raw-byte body parser before injecting the database pool and event outbox into `PaymentWebhookController`.
- **Chronological execution path:**
  1. When the payment gateway sends a webhook request, `verifyWebhookSignature` in [`src/billing/webhookAuth.ts:19`](src/billing/webhookAuth.ts#L19) validates the HMAC signature against the raw request body to reject spoofed payloads.
  2. Once authenticated, `handlePaymentEvent` in [`src/billing/webhookController.ts:62`](src/billing/webhookController.ts#L62) extracts the event key and checks the fast cache lock to filter obvious retries.
  3. For new events, `settleOrderTransaction` in [`src/billing/settlementService.ts:105`](src/billing/settlementService.ts#L105) opens a database transaction to record the event ID, transition the order to `PAID`, and credit the wallet balance.
  4. Right after the database transaction commits, `publishOrderPaid` in [`src/billing/eventOutbox.ts:38`](src/billing/eventOutbox.ts#L38) pushes an event to the queue so the email worker sends the customer's receipt.

### 4. Core Code Mechanics

#### Step 1: How does the service prevent two concurrent duplicate webhooks from double-crediting the same order?
After [`src/billing/webhookController.ts:62`](src/billing/webhookController.ts#L62) verifies the signature, execution enters `settleOrderTransaction` at [`src/billing/settlementService.ts:105`](src/billing/settlementService.ts#L105) to enforce the safety rule: even if two worker threads bypass the cache at the exact same millisecond, the database must settle the order and credit the wallet only once.
- **Mechanism & API Contract:**
  - *`db.transaction` method:* Opens an atomic database transaction immediately when called, passes the transaction handle `tx` into the async callback, and automatically rolls back all writes if any inner statement throws an error.

```ts
export async function settleOrderTransaction(
  db: Database,
  event: WebhookPayload
): Promise<SettlementResult> {
  return await db.transaction(async (tx) => {
    // 1. Insert the gateway event ID (e.g. "evt_99") into the ledger;
    // returns rowCount = 0 instead of throwing if the key already exists
    const inserted = await tx.insertIgnore("webhook_ledger", {
      providerEventId: event.eventId,
      processedAtUnix: Date.now(),
    });
    if (inserted.rowCount === 0) {
      return { status: "SKIPPED_DUPLICATE" };
    }

    // 2. Transition the order to "PAID" only if it is currently in
    // "PENDING" state (e.g. id === "ord_42" AND status === "PENDING")
    const updatedOrder = await tx.updateWhere(
      "orders",
      { id: event.orderId, status: "PENDING" },
      { status: "PAID", version: tx.increment(1) }
    );
    // 3. If zero rows matched PENDING, abort before crediting the wallet
    if (updatedOrder.rowCount === 0) {
      return { status: "ALREADY_SETTLED" };
    }

    // 4. Credit the customer's wallet once both guards pass
    await tx.incrementBalance(updatedOrder.userId, event.amount);
    return { status: "SETTLED" };
  });
}
```

- **Contrastive Why (Why not run `SELECT` first and `UPDATE` second):**
  - *Primary-key deduplication guard (Step // 1.):* If the code ran a `SELECT` query to check whether `"evt_99"` existed before running `INSERT`, two parallel threads arriving in the same millisecond would both see zero rows and proceed. Delegating the check to `insertIgnore` uses the database primary-key lock so the second thread gets `rowCount === 0` immediately.
  - *Dual state guard on the order row (Step // 2. and Step // 3.):* A misconfigured gateway can emit two distinct event IDs (`"evt_99"` and `"evt_100"`) for the same order `"ord_42"`. Requiring `status: "PENDING"` inside `updateWhere` guarantees that only the first update claims the row (`rowCount === 1`), while the second update receives `rowCount === 0` and exits at Step `// 3.` before reaching `incrementBalance` at Step `// 4.`.
- **Visual Dry-Run:**
  Suppose the database currently holds order `"ord_42"` in `"PENDING"` state with amount `5000`, and `webhook_ledger` is empty:
  - **Case 1 — First valid payment webhook arrives:**
    - *Input:* The gateway sends a payload with `eventId: "evt_99"` for `orderId: "ord_42"` and `amount: 5000`.
    - *How the code checks it:* Step `// 1.` inserts `"evt_99"` into `webhook_ledger` and returns `rowCount === 1` (`✅`). Step `// 2.` matches order `"ord_42"` in `"PENDING"` state, updates it to `"PAID"`, and returns `rowCount === 1` (`✅`). Execution then proceeds to Step `// 4.` to add `5000` to the customer's wallet.
    - *Result:* The transaction commits, order `"ord_42"` is marked `"PAID"`, the wallet balance increases by `5000`, and the function returns `"SETTLED"` (`✅`).
  - **Case 2 — Second webhook with a new event ID targets the already-paid order:**
    - *Input:* Due to a gateway retry bug, a second webhook arrives with a new `eventId: "evt_100"` pointing to the same `orderId: "ord_42"`.
    - *How the code checks it:* Step `// 1.` passes because `"evt_100"` is not yet in `webhook_ledger` (`✅`). However, at Step `// 2.`, `updateWhere` looks for `"ord_42"` with `status: "PENDING"` and matches zero rows because Case 1 already changed the status to `"PAID"` (`❌`). Step `// 3.` sees `rowCount === 0` and returns early.
    - *Result:* The function returns `"ALREADY_SETTLED"` and skips Step `// 4.`, protecting the customer's wallet from a duplicate credit (`✅`).

### 5. Hidden Traps, Co-Change Coupling & Live Verification
- **`⚠️` Sensitivity Alert: Receipt email event is lost if the process crashes right after DB commit ([`src/billing/webhookController.ts:78`](src/billing/webhookController.ts#L78)):**
  - *Scenario & System symptom:* If `settleOrderTransaction` commits the database transaction and the server restarts or loses its Redis connection right before `publishOrderPaid` runs, the customer's order becomes `"PAID"` but the customer never receives a receipt email.
  - *Root cause:* The controller publishes the queue event outside the database transaction boundary, and any future webhook retry from the gateway will be blocked at Step `// 1.` because `"evt_99"` is already recorded in `webhook_ledger`.
  - *Current code & Safer pattern:*
    ```ts
    // ❌ Current: Publishes queue event outside DB transaction
    const res = await settleOrderTransaction(db, payload);
    if (res.status === "SETTLED") {
      await queue.publishOrderPaid(payload.orderId);
    }

    // ✅ Safer design: Insert outbox row inside the same `tx` transaction
    // at src/billing/settlementService.ts:132
    await tx.insert("outbox_events", {
      topic: "ORDER_PAID",
      payloadJson: JSON.stringify({ orderId: event.orderId }),
    });
    ```
- **Co-Change Coupling & Persisted-Data Risks (Blast Radius):**
  - **Synchronizing order status enums across UI badges and revenue queries:**
    - *Technical trigger & Coupled files:* Adding a new intermediate status (such as `"SETTLING"`) to `OrderRecord.status` in [`src/billing/schema.ts:32`](src/billing/schema.ts#L32) affects the UI status mapper in [`src/ui/OrderBadge.tsx:14`](src/ui/OrderBadge.tsx#L14) and the accounting filter in [`src/analytics/revenueQuery.ts:51`](src/analytics/revenueQuery.ts#L51).
    - *Impact & Safeguard:* Update all three files in the same Pull Request so customer order badges and revenue reports stay aligned.
- **Onboarding Breakpoint & Fast Verification Command:**
  - *Onboarding Breakpoint:* Set a `breakpoint` at [`src/billing/settlementService.ts:124`](src/billing/settlementService.ts#L124) (right after `tx.updateWhere`) and inspect `inserted.rowCount === 1 && updatedOrder.rowCount === 1` to watch a live order pass both idempotency guards.
  - *Fast Verification Command:* Run `npm test -- src/billing/__tests__/webhookSettlement.spec.ts` to simulate 5 concurrent duplicate webhook deliveries.

### 6. Developer Modification Playbook ("Where to Touch") & Reusable Patterns
- **Quick Modification Playbook ("To change X, touch Y"):**
  - **When adding support for a new gateway event type (e.g., `REFUNDED`):**
    - *Entry touchpoint:* Add the event-type branch inside `handlePaymentEvent` at [`src/billing/webhookController.ts:68`](src/billing/webhookController.ts#L68).
    - *Required companion updates:* Add `"REFUNDED"` to `OrderRecord.status` at [`src/billing/schema.ts:32`](src/billing/schema.ts#L32) and implement the balance reversal check requiring `status: "PAID"` at [`src/billing/settlementService.ts:145`](src/billing/settlementService.ts#L145).
    - *Safety rule to preserve:* Always insert the gateway event ID into `webhook_ledger` at the start of the transaction so refund retries remain idempotent (`✅`).
  - **When capturing a new field from the webhook payload (e.g., `bankCode`):**
    - *Entry touchpoint:* Add the field to `WebhookPayload` and the request validator at [`src/billing/webhookValidator.ts:22`](src/billing/webhookValidator.ts#L22).
    - *Required companion updates:* Pass the validated field into `tx.updateWhere` at [`src/billing/settlementService.ts:119`](src/billing/settlementService.ts#L119) and add a database `migration` for the `orders` table.
    - *Safety rule to preserve:* Keep raw-body HMAC verification in [`src/billing/webhookAuth.ts:19`](src/billing/webhookAuth.ts#L19) untouched before JSON parsing (`✅`).
- **Project Conventions & Reusable Engineering Patterns:**
  - **Atomic Conditional State Transition — Guarding state transitions inline inside the database `UPDATE` clause:**
    - *Core idea:* Instead of loading a record into application memory to check its status with `if` before saving, push the expected prior status directly into the `WHERE` clause of the `UPDATE` statement so the database locks and transitions the row in one atomic step.
    - *Reusable code template:*
      ```ts
      // Transition to 'RUNNING' only if the DB row is still 'PENDING'
      // and return the number of rows actually modified
      const res = await db.query(
        `UPDATE tasks SET status = 'RUNNING'
         WHERE id = $1 AND status = 'PENDING'`,
        [taskId]
      );
      // If rowCount === 0, another worker already claimed this task!
      if (res.rowCount === 0) return { claimed: false };
      ```
    - *When to use in this or other projects:*
      - *Webhook or queue workers:* When multiple workers may receive duplicate delivery of the same payment or job message concurrently.
      - *Limited-inventory claims or coupon redemptions:* When ensuring only the first request transitions a voucher from `"AVAILABLE"` to `"CLAIMED"`.
    - *Tradeoff & when NOT to use:*
      - *Does not distinguish missing ID from wrong status:* When `rowCount === 0`, the `UPDATE` alone does not tell you whether `id` did not exist or `status` was already changed, so if the API must return distinct `404` vs. `409` error codes, run a follow-up read only inside the `rowCount === 0` error branch.

**Next step to explore:** Would you like to trace the background outbox worker in [`src/billing/eventOutbox.ts:38`](src/billing/eventOutbox.ts#L38) next, or export these invariants and Co-Change rules into `docs/keystone-map/` and `AGENTS.md`?

---
name: flow
description: Use when tracing how a specific feature, business flow, webhook, checkout, or request pipeline works end-to-end across files without a git diff, walking through step-by-step execution mechanics and state transitions, or creating a developer modification playbook showing where to touch code for a workflow.
license: MIT
metadata:
  author: keystone-ecosystem
  version: "0.1.0"
  opencode/slash: "true"
  opencode/autoinvoke: "true"
---

# Keystone Flow — Deep End-to-End Execution Flow Anatomy (Single-Pass 6-Section Dissection)

Dissect any cohesive end-to-end business flow, feature pipeline, or subsystem execution path without a `git diff` by prioritizing **completeness of core mechanics over arbitrary length caps (`Micro-Cap, Not Macro-Cap`)**, **Data-First modeling ("Tables Before Flowcharts")**, and **3-second visual comprehension**: start with a 100% plain-language macro story, define core data tables and state lifecycles before tracing function calls, explain every guard and unfamiliar API contract with `< 76`-char subgoal-commented code and conversational vertical dry-run cards (`✅`/`⚠️`/`❌`), and close with an actionable `"Where to Touch"` modification playbook in a single complete pass.

**REQUIRED BACKGROUND:** You MUST obey the Shared Language, Plain-Language Syntax, Code-Explanation, and Visual Comprehension Core in `keystone:using-keystone` across both chat output and any generated `docs/keystone-map/flows/flow-XX-<name>.md` file.

**Announce at start:** `"Using keystone:flow to trace and dissect [target business flow / pipeline] end-to-end across Sections 1–6."`

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
NEVER invent file paths, line numbers, or domain meanings without verifying them in the source code first. NEVER withhold architectural patterns or modification playbooks behind a 2-turn Quiz Gate—deliver all 6 sections in a single complete pass. Never impose an artificial total line cap on a flow report (`Micro-Cap, Not Macro-Cap`), and assign strictly **1 cohesive end-to-end business flow per `flows/flow-XX-<name>.md` file**.
</HARD-GATE>

## When to Use (Scale-Based Routing: `flow` vs. `map` vs. `decode`)

- **Use `keystone:flow` when (1 Cohesive End-to-End Flow Across Files):**
  - Tracing how a specific feature, business workflow, API endpoint, webhook, background job, or CLI command executes end-to-end from entry trigger to final persistence without a `git diff`.
  - Writing or updating a deep flow file (`docs/keystone-map/flows/flow-XX-<name>.md`) handed off from `keystone:map`.
  - Asking *"How does flow X work and where do I touch code to modify or extend it?"*
- **Do NOT use `keystone:flow` when:**
  - Mapping an entire unfamiliar repository/monorepo, auditing 100% module coverage (`01-coverage-ledger.md`), or generating repository-wide C4/arc42 atlases and `AGENTS.md` contracts (**REQUIRED SUB-SKILL:** Use `keystone:map`).
  - Explaining a single isolated `< 30`-line function, bitwise expression, or regex line-by-line, or reviewing a `git diff` / commit patch with a 2-turn Quiz Gate (`decode`).
  - Debugging a specific runtime stacktrace, crash, panic, or deadlock (`trace`).

## Phase 0: Targeted Flow Recon (Verify Wiring & Data Tables Before Writing)

1. If `docs/keystone-map/00-INDEX.md` and `architecture/data-dictionary.md` already exist (from `keystone:map`), read them first to anchor the flow's entry point and shared domain types; otherwise use `Grep` / `Glob` / `read_file` (or `bash skills/map/scripts/recon-graphs.sh`) to locate:
   - **The Entry Trigger & Composition Root Wiring:** Where the route, CLI command, event listener, or scheduled worker is registered and wired (`filename:line`).
   - **The Core Data Structures & Schemas:** The 1–4 primary structs, interfaces, ORM models, or state stores read and mutated along this flow.
   - **The Chronological Call Spine & Co-Change Partners:** Every decision-critical guard, transformation, persistence call, and coupled downstream file (`filename:line`).
2. **Scope Discipline (`1 File = 1 End-to-End Flow`):** Trace **1 cohesive end-to-end flow** per report (`9–13` steps for standard flows, scaling naturally to all real engineering decisions without artificial macro line caps). If the user asks about a subsystem containing 3 separate workflows (e.g., Create Order, Payment Webhook, Refund), dissect the primary flow completely and split sibling workflows into separate `flows/flow-02-*.md`, `flows/flow-03-*.md` files.

## Single-Pass 6-Section Flow Anatomy Contract (Sections 1–6)

Localize all section titles, bullet labels, explanations, and inline `//` code comments into the user's exact language (monolingual headers only, zero decorative emojis, obeying `keystone:using-keystone`; see `skills/map/references/atlas-and-subagent-contracts.md` Section 6 for the complete Golden Reference Example):

### 1. System Purpose & Domain Boundaries (100% Plain-Language Macro Story)
Explain the flow at the Macro / Domain behavior level using **100% plain-language concepts**—**NEVER mention file paths, function names, struct names, or local variable identifiers in the 3 prose bullets below** (save all code symbols for Sections 2–6, and never place a `⚠️` alert in Section 1):
- **Real-world role:** State in 1–2 plain spoken sentences (`Concrete Actor + Strong Action Verb`) what business capability this flow delivers and who or what triggers it.
- **Ownership & delegation boundaries:** State in bite-sized sub-bullets (`*What it owns:*` vs. `*What it delegates:*`) which rules and state this flow controls directly versus what it hands off to external services, queues, or databases.
- **Key design challenge & Core approach:** Open with a brief everyday analogy, then break down in bite-sized indented sub-bullets (each starting with a short `*italic:*` lead-in phrase, 1–2 short spoken sentences ending with `.`, zero `->` chains) why a naive approach would fail under real-world conditions (retries, concurrency, partial failure) and how this flow solves it.
- **Concrete example (`Input -> Transformation -> Output`):** A noise-free `< 76`-char visual code/data snippet (using `❌` and `✅` where helpful, starting with a `< 76`-char `// Anatomy:` legend if unfamiliar tokens appear) with vivid sample values showing what enters and exits the flow.

### 2. Core Data Structures & State Lifecycles ("Tables Before Flowcharts")
Establish the Situation & Data Model before tracing procedural functions so control flow becomes obvious:
- **Core entities & state containers:** Introduce the 1–4 primary data structures (`struct`, `interface`, schema, or state store) with `[`filename:line`](path#Lline)` links. Quote a focused `< 76`-char code block keeping the enclosing type signature (eliding repetitive boilerplate with `...`) and using `< 76`-char inline `//` comments with concrete sample values in the user's language to explain each decision-critical field.
- **State lifecycle & transitions:** Explain in bite-sized `*italic:*` sub-bullets how the entity moves from initial creation to completion, marking valid transitions with `✅` and rejected/invalid states with `❌`.
- **Data safety rules (Invariants):** State in plain everyday words the non-negotiable safety rules that must hold true whenever any function reads or mutates these structures (explicitly labeling any undocumented meaning as an *inferred hypothesis* if not proven in code/tests).

### 3. Wiring Root, Entry Points & End-to-End Execution Path
Answer "Where does execution start?" and "How are the steps connected?" tailored to the **7 Repo Archetypes** below:
- **Composition root & entry point wiring:** Explain in 1–3 bite-sized bullets where the subsystem registers routes/commands/listeners and injects dependencies (with exact `[`filename:line`](path#Lline)` links).
- **Chronological execution path (Max 1 Primary Mechanism Per Step):** A numbered list of plain-language steps tracing data from entry trigger to final output/persistence, naming **at most 1 primary function, method, hook, callback, middleware, or config option per step** in backticks (with `[`filename:line`](path#Lline)` on first mention). Open each step with the real-world user action or system event that triggers it. If twin pipelines run parallel logic (Client vs. Server), trace one primary path and cite the counterpart briefly in parentheses.

| Repo Archetype | Section 3 Wiring Root Focus | Section 2 & 4 Dissection Focus | Section 6 "Where to Touch" Focus |
| :--- | :--- | :--- | :--- |
| **1. Backend Service / API** | Router, server bootstrap (`main.go`, `server.ts`, `app.py`), DI bindings. | Auth middleware chain, request schema validation, domain service & DB transactions. | Adding an endpoint, adding a request/response field, adding an auth rule. |
| **2. Frontend App** | Route tree (`pages/`, `app/layout.tsx`, router) & state store initialization. | Component hierarchy, state synchronization flow, hook lifecycles & API cache. | Adding a screen/UI state, wiring data from an API, handling loading/error states. |
| **3. Library / SDK** | Public barrel exports (`index.ts`, `lib.rs`, `__init__.py`, `exports`). | Input/output type contracts, plugin/hook extension points & backward compatibility. | Adding a public method or adapter without breaking existing callers. |
| **4. CLI Tool** | `main`, flag/subcommand parser (`commands/`, `cobra`, `clap`) & config loader. | `Options`/`Flags` structs, config precedence (`CLI > ENV > file`) & exit codes. | Registering a new subcommand, adding a flag, returning standard exit codes. |
| **5. Data Pipeline** | Ingestion entrypoint (`ingest/`), scheduler (`DAG`/cron) & sink wiring. | Stage schemas (`Source -> Transform -> Sink`), idempotency & dead-letter handling. | Adding a transform stage, evolving column schemas, running historical backfills. |
| **6. Framework / Harness** | Core kernel bootstrap (`core/`), plugin/skill registry & lifecycle event loop. | Abstract traits/interfaces, DI container, context management & escape hatches. | Authoring and registering a new tool, skill, or lifecycle hook in the core loop. |
| **7. Monorepo** | Root workspace manifests (`pnpm-workspace`, `Cargo.toml`, `BUILD`, `nx.json`). | Package boundaries (`packages/`), shared contract libraries (`shared/`) & build graph. | Identifying the 2–3 packages for a feature and updating shared cross-package types. |

### 4. Core Code Mechanics (Scaled to Actual Engineering Decisions — Zero Artificial Line Cap)
Divide into steps matching the actual architectural seams, guards, or transformations (`#### Step 1: <Practical technical question resolved here?>`, `#### Step 2: ...`—filter peripheral boilerplate, never omit a core logic step):
1. **Plain-language transition & Pre-Decoded API / Mechanism Contract (Before the code block):**
   - Connect this step to the previous one (`[`filename:line`](path#Lline)`) and state the **Business / Safety Rule** it enforces in plain words.
   - Immediately before the code block, list a bite-sized **Mechanism / API Contract** sub-bullet for any unfamiliar framework API, DI binding, middleware, hook, callback, or config option stating: **(a) what it controls**, **(b) the exact moment it runs**, **(c) what its incoming parameters hold**, and **(d) what its return value or setting causes**.
2. **Complete step code snippet (`< 76` chars per line):**
   - Quote the code block keeping its **enclosing function/method/class/component signature**, numbered **Subgoal Comments** (`// 1.`, `// 2a.`, `< 76` chars per line in the user's language), comments on every `??` / `||` fallback chain, concrete evaluated example strings above regex/interpolation branches, a `< 76`-char `// Anatomy:` legend for unfamiliar tokens, and an **ASCII Ruler Diagram + small concrete numbers** (`// start 100 + len 30 = pos 130`) whenever slice/offset math occurs.
3. **Focused explanation below the code (2 items only, localized to the user's language):**
   - **Contrastive Why** (*Why not the naive approach / what breaks if omitted*): Bite-sized indented sub-bullets starting with `*italic (Step // 1. / Branch // 2a.):*` explaining the reason behind every guard or branch in 1–2 short spoken sentences ending with `.`.
   - **Visual Dry-Run** (*Conversational Vertical Case Walkthrough — Never Multi-Column Tables*): State shared initial context upfront, then format each scenario (`✅` normal flow, `❌` boundary rejection, or `t1..t4` Vertical Interleaved Timeline for async/concurrency) as `- **Case 1 — <Plain-language scenario title>:**` with 3 bite-sized child sub-bullets (`*Input:*`, `*How the code checks it:*`, `*Result:*`) in complete spoken sentences (plus Andreas Zeller's 4-Link Infection Chain `Trigger -> Infected State -> Propagation -> Observable Failure` when writing `docs/keystone-map/flows/flow-*.md`).

### 5. Hidden Traps, Co-Change Coupling & Live Verification
- **`⚠️` Sensitivity & Tech-Debt Alert** *(For latent flaws, silent error catches, race conditions, or $O(N^2)$/N+1 traps)*: Under a `**bold**` parent title (`[`filename:line`](path#Lline)`), provide 3 bite-sized sub-bullets:
  - `*Scenario & System symptom:*` Concrete setup with sample names and the exact wrong behavior or bottleneck.
  - `*Root cause:*` Plain-language causal explanation following `Old-Before-New` order.
  - `*Current code & Safer pattern:*` Compact `< 76`-char fenced code slice (`❌ Current` vs. `✅ Safer design`) with concrete sample values in `//` comments.
- **Co-Change Coupling & Persisted-Data Risks (Blast Radius):** Under a `**bold:**` parent title, provide 2 child sub-bullets:
  - `*Technical trigger & Coupled files:*` Exact companion files, callers, or persisted storage keys (`localStorage`/DB/cache/URL) with sample values and `[`filename:line`](path#Lline)`.
  - `*Impact & Safeguard:*` What breaks if updated out of sync and how to modify it safely.
- **Onboarding Breakpoint & Fast Verification Command:** Exact debugger `breakpoint` (`[`filename:line`](path#Lline)`) + runtime **State Invariant expression** to inspect live, plus the exact CLI test command to run this flow locally.

### 6. Developer Modification Playbook ("Where to Touch") & Reusable Patterns
- **Quick Modification Playbook ("To change X, touch Y"):** 2–4 concrete extension recipes (`- **When adding/changing <task>:**`), each with 3 bite-sized sub-bullets: `*Entry touchpoint:*` (`filename:line`), `*Required companion updates:*` (`filename:line`), and `*Safety rule to preserve:*` (`✅`).
- **Project Conventions & Reusable Engineering Patterns:** Extract each reusable pattern (`- **<English Pattern Name> — <Natural phrase in user's language>:**`) using 4 sub-bullets: `*Core idea:*`, `*Reusable code template:*` (`< 76` chars), `*When to use in this or other projects:*`, and `*Tradeoff & when NOT to use:*` (or `Adopt` / `Adapt` / `Reject` Context-Fit Matrix when harvesting external repos).
- **Closing Next-Step Offer:** 1 natural sentence offering the next logical flow to trace or offering to save/update `docs/keystone-map/flows/flow-XX-<name>.md` and `AGENTS.md`.

## Red Flags — STOP and Fix Before Sending

- **Premature code symbols in Section 1 or skipping Section 2 Data Tables:** Mentioning file/function/struct/variable names in the 3 prose bullets of Section 1, placing `⚠️` alerts before Section 5, or tracing function calls before presenting Core Data Structures in Section 2.
- **Truncating mechanics or violating `keystone:using-keystone` Clarity Rules:** Skipping guards, hiding core logic behind `...`, using 4-column tables for `Visual Dry-Run`, writing code/comment/ASCII lines `>= 76` chars, chaining prose with `->` arrows, omitting enclosing signatures or API pre-decoding, or pausing at Section 5 for a 2-turn quiz instead of delivering Sections 1–6 in one pass.

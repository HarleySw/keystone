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

# Keystone Map — Macro Repository Onboarding, 100% Coverage Atlas & `AGENTS.md` Lock-In

Build an accurate repository-wide mental model and persistent project memory during Day-1 onboarding by prioritizing **architectural truth over stale `README.md` files**, **100% denominator module accounting (`01-coverage-ledger.md`)**, and **Data-First modeling ("Tables Before Flowcharts")**: run Dual-Graph Recon first, generate the verified multi-file Architecture Atlas in `docs/keystone-map/`, lock the pointer contract into `./AGENTS.md`, and present a **Guided Reading & Task Navigation Briefing** in chat.

**REQUIRED BACKGROUND:** You MUST obey the Shared Language, Plain-Language Syntax, Code-Explanation, and Visual Comprehension Core in `keystone:using-keystone` across both chat output and 100% of generated `.md` files.

**Announce at start:** `"Using keystone:map to map [target repository] architecture, wiring roots, coverage ledger, and AGENTS.md contract."`

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
NEVER copy claims from `README.md` or outdated wikis without verifying them against source code. NEVER start by running `tree` or spawning folder-summarizing subagents. Always execute Step 1 (`bash skills/map/scripts/recon-graphs.sh` + targeted source reads) before writing. Every generated `.md` file in `docs/keystone-map/` MUST match the user's language 100% and pass `bash skills/map/scripts/validate-atlas.sh` (`STATUS: PASSED`).
</HARD-GATE>

## When to Use (Scale-Based Lifecycle Routing)

- **Use `keystone:map` when (Day-1 Repo Onboarding & Macro Architecture Atlas):**
  - Onboarding to an unfamiliar repository or polyglot monorepo (`Bazel`, `Nx`, `Turborepo`, `Cargo`, `Go`) and asking where to start reading or how the architecture is wired together.
  - Generating a multi-file C4 (L1–L3) + arc42 Architecture Atlas (`docs/keystone-map/`) with a $100\%$ denominator coverage ledger (`CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`) and anchoring `./AGENTS.md`.
  - Running static call-graph, `bazel query`/`cquery`/`aquery`, and Git Hotspot / Co-Change reconnaissance to map container trust boundaries and core data dictionaries, or harvesting architectural patterns from an external repository.
- **Do NOT use `keystone:map` when:**
  - Tracing a single specific business flow, feature pipeline, webhook, or request lifecycle step-by-step from trigger to persistence (**REQUIRED SUB-SKILL:** Use `keystone:flow`).
  - Explaining a single isolated `< 30`-line function/regex/bitwise snippet line-by-line or reviewing a `git diff` with a 2-turn Quiz Gate (`decode`).
  - Debugging a runtime crash, stacktrace, panic, or deadlock (`trace`).
  - Writing a greenfield RFC, ADR, or implementation spec before coding (`design`).

## Unified 4-Step Execution Pipeline (No Separate Modes)

```text
+========================================================================+
|        KEYSTONE:MAP UNIFIED 4-STEP ONBOARDING PIPELINE                 |
+========================================================================+
|  [Step 1: Dual-Graph Recon (recon-graphs.sh + Glob/Grep)]              |
|  - Graph 1: Manifests, Composition Roots, Data Schemas, PageRank       |
|  - Graph 2: Release Tags, Git Hotspots, Cross-Folder Co-Change, F      |
|                                  |                                     |
|                                  v                                     |
|  [Step 2: Generate & Verify Atlas (docs/keystone-map/)]                |
|  - Group 1 (<=150L): 00-INDEX.md (Overview, C4 L1, Reading Roadmap)    |
|  - Group 2 (0 cap):  01-coverage-ledger.md, architecture/*.md,         |
|                      components/comp-*.md, flows/flow-XX.md (via flow) |
|  - Doubt Audit + Pass bash skills/map/scripts/validate-atlas.sh == 0   |
|                                  |                                     |
|                                  v                                     |
|  [Step 3: Lock In Root ./AGENTS.md Pointer Contract (<=15L block)]     |
|                                  |                                     |
|                                  v                                     |
|  [Step 4: Present 4-Part Guided Reading & Task Navigation in Chat]     |
+========================================================================+
```

### Step 1: Architect's Dual-Graph Recon (`recon-graphs.sh`)
1. Execute `bash skills/map/scripts/recon-graphs.sh "<target_repo_dir>"` (use `--doctor` to check CLI tools; read `skills/map/references/wiring-and-monorepo-guide.md` for Bazel `query`/`cquery`/`aquery`, Nx, Turborepo, SCIP `edge_oracle`, and the 7 Dynamic Edge patterns).
2. **Graph 1 — Static Wiring, Composition Roots & Data Schemas:**
   - Read build/package manifests (`package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `pom.xml`, `CMakeLists.txt`, `BUILD`, `nx.json`) to locate entry points and the **Composition Root** where configs, DB pools, DI containers, middlewares, routers, or workers are wired (`main.go`, `src/main.rs`, `src/index.ts`, `app.module.ts`, `main.py`, `app/layout.tsx`), tailored to the **7 Repo Archetypes** (`Backend Service/API`, `Frontend App`, `Library/SDK`, `CLI Tool`, `Data Pipeline`, `Framework/Harness`, `Monorepo`).
   - Extract **Core Data Structures & Schemas** (`struct`, `interface`, ORM models, migrations, state stores) into `architecture/data-dictionary.md` before dispatching component or flow scouts.
3. **Graph 2 — Git Hotspots, Co-Change Coupling & Incremental Staleness:**
   - Inspect recent release tags (`git tag -l --sort=-v:refname`), True Churn Hotspots (passing only AST function slices `file:line_start-line_end` to subagents rather than whole `> 500`-LOC files), Author Fractal Value $F = 1 - \sum (c_i/C)^2$, and Cross-Boundary Co-Change pairs (`A <-> B`).
   - **Focused Scoping for Large Repos (`100+` files):** Map the top 5–7 modules in `00-INDEX.md` and audit 100% of top-level directories in `01-coverage-ledger.md`, then focus deep component/flow dissections on the 2–3 core modules most relevant to the user's goal. On incremental re-runs (`UNCHANGED` / `STALE_HASH` / `STALE_COCHANGE`), regenerate only dirty modules and their Co-Change partners.

### Step 2: Generate & Verify Multi-File Repository Atlas (`docs/keystone-map/`)
Write **every file in `docs/keystone-map/` in the user's exact language** applying `keystone:using-keystone`'s Shared Clarity Core (`Concrete Actor + Strong Action Verb`, zero zombie nouns, zero translationese, monolingual headers, `< 76`-char subgoal-commented code blocks with enclosing signatures, pre-decoded APIs, `Contrastive Why`, and Conversational Vertical Dry-Run cards):
- **Group 1 — Capped Routing Index (`<= 150` lines):**
  - `00-INDEX.md` (`<= 150` lines: Section 1 plain-language macro story with zero code symbols in the 3 opening prose bullets, C4 L1 `< 76`-char ASCII Context Diagram, **RAD-AI `E1` Deterministic vs. Non-Deterministic AI Boundary**, Guided Source-Code Reading Order, and Task-Oriented Routing Table).
- **Group 2 — Uncapped Deep Dissection & Audit Ledger Files (`Micro-Cap, Not Macro-Cap` — Zero Artificial Total Line Cap):**
  - `01-coverage-ledger.md` (deterministic audit of $100\%$ of top-level directories from `git ls-tree -d --name-only HEAD` using `CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`, 12-char Git hash, `C_wiring: 100%`, `C_hotspot >= 95%`, and plain-language role descriptions in the user's language).
  - `architecture/data-dictionary.md` (Data-First core schemas/structs with `< 76`-char subgoal-commented code blocks, concrete sample values, `✅`/`❌` state lifecycles, and plain-language safety invariants written BEFORE tracing call flows).
  - `architecture/c2-wiring-and-containers.md` (Composition Roots with pre-decoded bootstrap/DI contracts, `< 76`-char subgoal-commented wiring code, `Contrastive Why`, and C4 L2 Trust Boundaries).
  - `architecture/evolution-and-hotspots.md` (Git release tags, True Churn Hotspots, Cross-Boundary Co-Change `A <-> B` blast-radius cards, Author Fractal Value $F$, and **QOC + ATAM Tradeoff Matrix `+`/`-`** with `< 76`-char `❌ Rejected` vs. `✅ Chosen` code slices).
  - `components/comp-<domain>.md` (C4 L3 `< 20` elements with `C4-E1` stereotypes, public contracts, and `< 76`-char code mechanics + Vertical Dry-Run cards).
  - `flows/flow-<id>-<name>.md` (**1 File = 1 Cohesive End-to-End Business Flow** — **REQUIRED SUB-SKILL:** Use `keystone:flow` to generate the primary spine flow file).
- Read `skills/map/references/atlas-and-subagent-contracts.md` for Model-Pinned Scout Subagents (`haiku`/`flash`, passing `USER_LANGUAGE` explicitly) and the 5-step Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`). Run `bash skills/map/scripts/validate-atlas.sh` and require exit code `0` (`STATUS: PASSED`).

### Step 3: Final Closing Lock-In — Anchor Root `./AGENTS.md` Pointer Contract
Read `skills/map/references/agent-contract-template.md` and create or update `./AGENTS.md` (`< 100` lines if new, or a `<= 15`-line `<!-- keystone-map:start -->` pointer block if `./AGENTS.md` already exists, synced to `CLAUDE.md`/`GEMINI.md` without overwriting custom rules) containing verified build/test commands, module boundaries, state invariants, entry points (`filename:line`), and pointers into `docs/keystone-map/` (deferring ongoing post-coding `.cursor/rules/<domain>.mdc` blast-radius rule locking to `keystone:shield` or explicit user request).

### Step 4: Mandatory 4-Part Guided Reading & Task Navigation Briefing in Chat
Never end `/map` by merely dumping a list of generated file names and line counts. Always present a **4-Part Onboarding & Guided Reading Briefing** in chat (localized 100% to the user's language, obeying `keystone:using-keystone`):

1. **System Big Picture, Architecture Diagram & Module Coverage Summary:**
   - **Plain-language macro purpose:** State in 3 bite-sized bullets (`Real-world role`, `Ownership & delegation boundaries`, `Key design challenge & Core approach`) what the repository does and how it is architected—with zero code symbols in the 3 prose bullets.
   - **C4 L1/L2 `< 76`-Char ASCII Architecture & Trust Boundary Diagram:** Draw the runtime containers, external dependencies, and `RAD-AI E1` boundary (`Deterministic` vs. `Non-Deterministic AI`).
   - **4-Bucket Module Coverage Summary (`✅` / `⚠️` / `❌`):** Summarize which top-level directories are `CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, or `UNWIRED_DEAD` `❌`, plus any critical `⚠️` latent bugs or architectural traps discovered during recon.
2. **Guided Source-Code Reading Order ("Where to Start Reading in the Codebase"):**
   Give the newly onboarded engineer a numbered **4-Step Source-Code Reading Path** with clickable `[`filename:line`](path#Lline)` links, explaining **which source file to open first, what to look for inside it, and why**:
   - **Step 1 — Read the Core Data Structures & Schemas first ("Tables Before Flowcharts"):** Link to the primary model/schema files (`[`path/to/schema:line`](...)`) and state which 1–3 structs/tables define the domain state and invariants.
   - **Step 2 — Read the Composition Root & Bootstrap Wiring:** Link to the exact entry-point file (`[`path/to/main:line`](...)`) and explain how it loads config, binds dependencies, and mounts routes/commands/workers.
   - **Step 3 — Trace the Primary Spine Execution Flow:** Link to the main controller/service/handler (`[`path/to/service:line`](...)`) and explain the end-to-end happy path in 1–2 sentences.
   - **Step 4 — Inspect High-Churn Hotspots, Co-Change Pairs & `⚠️` Traps:** Link to the top Git hotspot and any `⚠️` defect/tech-debt coordinate (`[`path/to/hotspot:line`](...)`) so the engineer knows where fragile business rules and coupled files live before editing code.
3. **Task-Oriented Atlas & Code Navigation Map ("Which `.md` Report & Source File to Read for Each Goal"):**
   Pair **each developer goal** (`**bold:**` parent bullet) with `*Read Atlas guide:*` (clickable link to the generated `docs/keystone-map/*.md` file + what it explains) and `*Inspect / touch source code:*` (clickable `[`filename:line`](path#Lline)` links):
   - **When you want a 5-minute macro overview & full module audit (`100%` coverage):**
     - *Read Atlas guide:* [`docs/keystone-map/00-INDEX.md`](docs/keystone-map/00-INDEX.md) for the C4 L1 context map and [`docs/keystone-map/01-coverage-ledger.md`](docs/keystone-map/01-coverage-ledger.md) for the 4-bucket directory ledger (`✅`/`⚠️`/`❌`).
   - **When you need to understand core data tables, structs, and state transition rules before coding:**
     - *Read Atlas guide:* [`docs/keystone-map/architecture/data-dictionary.md`](docs/keystone-map/architecture/data-dictionary.md) for subgoal-commented schemas, `✅`/`❌` state lifecycles, and safety invariants.
     - *Inspect source code:* `[`path/to/schema:line`](...)`.
   - **When you want to see how the app boots, wires DI/middlewares, or registers CLI/API entry points:**
     - *Read Atlas guide:* [`docs/keystone-map/architecture/c2-wiring-and-containers.md`](docs/keystone-map/architecture/c2-wiring-and-containers.md) for the C4 L2 container diagram and Composition Root code dissection.
     - *Inspect source code:* `[`path/to/main:line`](...)`.
   - **When you want to understand or modify a specific end-to-end business flow (`<Flow Name>`):**
     - *Read Atlas guide:* [`docs/keystone-map/flows/flow-01-<name>.md`](docs/keystone-map/flows/flow-01-<name>.md) for the 6-Section code walkthrough, `Visual Dry-Run` vertical cards, live debugger `breakpoint`, and `"Where to Touch"` modification recipes.
     - *Inspect / touch source code:* `[`path/to/entry:line`](...)` and `[`path/to/service:line`](...)`.
   - **When you want to dive into a specific domain subsystem (`<Component Name>`):**
     - *Read Atlas guide:* [`docs/keystone-map/components/comp-<domain>.md`](docs/keystone-map/components/comp-<domain>.md) for C4 L3 component boundaries, public contracts, and component-level traps.
     - *Inspect source code:* `[`path/to/component:line`](...)`.
   - **When you are preparing to refactor or open a PR and need to check Co-Change blast radius & architectural tradeoffs:**
     - *Read Atlas guide:* [`docs/keystone-map/architecture/evolution-and-hotspots.md`](docs/keystone-map/architecture/evolution-and-hotspots.md) for Git churn hotspots, Author Fractal Value $F$, `A <-> B` Co-Change rules, and `QOC`/`ATAM` tradeoffs (`❌ Rejected` vs. `✅ Chosen`).
4. **Closing Next-Step Offer (Handoff to `keystone:flow` or `keystone:decode`):**
   End with 1 natural sentence asking which specific business flow the engineer wants to dissect next in chat using `keystone:flow` (or which isolated function/diff to inspect with `keystone:decode`).

## Red Flags — STOP and Fix Before Sending

- **Finishing `/map` with a bare file/line-count dump instead of the Guided Reading Briefing:** Never end `/map` by only listing generated files (`00-INDEX.md (75 lines)...`). Always include the **4-Step Source-Code Reading Order** and the **Task-Oriented Atlas & Code Navigation Map ("Read file X to do Y")** with clickable links.
- **Skipping Step 1 Recon, Step 2 `validate-atlas.sh`, or Step 3 `./AGENTS.md` pointer lock-in:** Reading `README.md` or running `tree` before `bash skills/map/scripts/recon-graphs.sh`, claiming completion without `bash skills/map/scripts/validate-atlas.sh` printing `STATUS: PASSED`, or forgetting to anchor `./AGENTS.md` (`<= 15`-line pointer block).
- **Language mismatch or dry telegraphic style in `docs/keystone-map/*.md`:** Writing chat in the user's language (e.g., Vietnamese) while leaving `docs/keystone-map/*.md` in English, or dumping bare symbol tables instead of applying `keystone:using-keystone`'s Shared Clarity Core.
- **Imposing artificial line caps on Group 2 dissection/ledger files or cramming multiple flows into 1 file:** Truncating `flows/flow-*.md`, `components/comp-*.md`, `architecture/*.md`, or `01-coverage-ledger.md` to hit an arbitrary line limit, or cramming multiple independent business flows into a single `flow-*.md` file instead of `1 File = 1 End-to-End Flow` via `keystone:flow`.

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

# Keystone Map — Macro Repository Onboarding, 100% Coverage Atlas & Agent Contracts

Build an accurate repository-wide mental model during codebase onboarding by prioritizing **architectural truth over stale `README.md` files**, **100% denominator module accounting (`01-coverage-ledger.md`)**, and **Data-First modeling ("Tables Before Flowcharts")**: execute Dual-Graph Recon first, locate Composition Roots and core data schemas before tracing calls, classify every top-level module into 4 deterministic wiring buckets (`✅`/`⚠️`/`❌`), and hand off deep single-flow code dissection to `keystone:flow`.

**REQUIRED BACKGROUND:** You MUST obey the Shared Language, Plain-Language Syntax, Code-Explanation, and Visual Comprehension Core in `keystone:using-keystone` across both chat output and 100% of generated `.md` files.

**Announce at start:** `"Using keystone:map to map [target repository] architecture, wiring roots, and coverage ledger."`

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
NEVER copy claims from `README.md` or outdated wikis without verifying them against source code. NEVER start by running `tree` or spawning folder-summarizing subagents. Always execute Phase 0 (`bash skills/map/scripts/recon-graphs.sh` + targeted source reads) before writing. Every generated `.md` file in `docs/keystone-map/` MUST match the user's language 100% and pass `bash skills/map/scripts/validate-atlas.sh` (`STATUS: PASSED`).
</HARD-GATE>

## When to Use (Scale-Based Routing: `map` vs. `flow` vs. `decode`)

- **Use `keystone:map` when (Macro Repo & Subsystem Topology):**
  - Onboarding to an unfamiliar repository or polyglot monorepo (`Bazel`, `Nx`, `Turborepo`, `Cargo`, `Go`) and asking where to start reading or how the architecture is wired together.
  - Generating a multi-file C4 (L1–L3) + arc42 Architecture Atlas (`docs/keystone-map/`) with a $100\%$ denominator coverage ledger (`CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`).
  - Running static call-graph, `bazel query`/`cquery`/`aquery`, and Git Hotspot / Co-Change reconnaissance to map container trust boundaries and core data dictionaries.
  - Harvesting architectural patterns from an external repository or exporting `AGENTS.md` / `CLAUDE.md` / `.cursor/rules/*.mdc` contracts.
- **Do NOT use `keystone:map` when:**
  - Tracing a single specific business flow, feature pipeline, webhook, or request lifecycle step-by-step from trigger to persistence (**REQUIRED SUB-SKILL:** Use `keystone:flow`).
  - Explaining a single isolated `< 30`-line function/regex/bitwise snippet line-by-line or reviewing a `git diff` with a 2-turn Quiz Gate (`decode`).
  - Debugging a runtime crash, stacktrace, panic, or deadlock (`trace`).
  - Writing a greenfield RFC, ADR, or implementation spec before coding (`design`).

## Operating Modes & Lazy-Loaded Handoff to `keystone:flow`

```text
+========================================================================+
|        KEYSTONE:MAP PHASE 0 -> MACRO ATLAS -> FLOW HANDOFF             |
+========================================================================+
|  [Phase 0: Dual-Graph Recon (recon-graphs.sh + Glob/Grep)]             |
|  - Graph 1: Manifests, Composition Roots, Data Schemas, PageRank       |
|  - Graph 2: Release Tags, Git Hotspots, Cross-Folder Co-Change, F      |
|                                  |                                     |
|        +-------------------------+-------------------------+           |
|        v                         v                         v           |
|  [Repo Atlas (Mode B)]     [Agent Rules (Mode C)]   [Deep Flow Handoff]|
|  Write docs/keystone-map/  Export AGENTS.md (<=15L  Invoke keystone:   |
|  + Doubt Audit + Pass      pointer) & glob-scoped   flow for 6-Section |
|  validate-atlas.sh == 0    .cursor/rules/*.mdc      flows/flow-XX.md   |
+========================================================================+
```

1. **Macro Orientation & Multi-File Repository Atlas (`docs/keystone-map/`):**
   - Run `bash skills/map/scripts/recon-graphs.sh "<target_repo_dir>"` (use `--doctor` to check CLI tools; read `skills/map/references/wiring-and-monorepo-guide.md` for Bazel `query`/`cquery`/`aquery`, Nx, Turborepo, SCIP `edge_oracle`, and the 7 Dynamic Edge patterns).
   - **Focused Scoping for Large Repos (`100+` files):** Map the top 5–7 modules in `00-INDEX.md` and audit 100% of top-level directories in `01-coverage-ledger.md`, then focus deep component/flow dissections on the 2–3 core modules most relevant to the user's goal.
   - **Two-Group Length Control & 100% User-Language Synchronization (`keystone:using-keystone`):** Write **every file in `docs/keystone-map/` in the user's exact language** applying the Shared Clarity Core (`Concrete Actor + Strong Action Verb`, zero zombie nouns, zero translationese, monolingual headers, `< 76`-char subgoal-commented code blocks with enclosing signatures, pre-decoded APIs, `Contrastive Why`, and Conversational Vertical Dry-Run cards):
     - **Group 1 — Capped Routing Index (`<= 150` lines):**
       - `00-INDEX.md` (`<= 150` lines: Section 1 plain-language macro story with zero code symbols in the 3 opening prose bullets, C4 L1 `< 76`-char ASCII Context Diagram, **RAD-AI `E1` Deterministic vs. Non-Deterministic AI Boundary**, Subsystem & Entry-Point Map, and Progressive Routing Table).
     - **Group 2 — Uncapped Deep Dissection & Audit Ledger Files (`Micro-Cap, Not Macro-Cap` — Zero Artificial Total Line Cap):**
       - `01-coverage-ledger.md` (deterministic audit of $100\%$ of top-level directories from `git ls-tree -d --name-only HEAD` using `CORE_WIRED` `✅`, `ADAPTER_CONTRACT` `✅`, `DYNAMIC_GAP` `⚠️`, `UNWIRED_DEAD` `❌`, 12-char Git hash, `C_wiring: 100%`, `C_hotspot >= 95%`, and plain-language role descriptions in the user's language).
       - `architecture/data-dictionary.md` (Data-First core schemas/structs with `< 76`-char subgoal-commented code blocks, concrete sample values, `✅`/`❌` state lifecycles, and plain-language safety invariants written BEFORE tracing call flows).
       - `architecture/c2-wiring-and-containers.md` (Composition Roots with pre-decoded bootstrap/DI contracts, `< 76`-char subgoal-commented wiring code, `Contrastive Why`, and C4 L2 Trust Boundaries).
       - `architecture/evolution-and-hotspots.md` (Git release tags, True Churn Hotspots, Cross-Boundary Co-Change `A <-> B` blast-radius cards, Author Fractal Value $F = 1 - \sum (c_i/C)^2$, and **QOC + ATAM Tradeoff Matrix `+`/`-`** with `< 76`-char `❌ Rejected` vs. `✅ Chosen` code slices).
       - `components/comp-<domain>.md` (C4 L3 `< 20` elements with `C4-E1` stereotypes, public contracts, and `< 76`-char code mechanics + Vertical Dry-Run cards).
       - `flows/flow-<id>-<name>.md` (**1 File = 1 Cohesive End-to-End Business Flow** — **REQUIRED SUB-SKILL:** Use `keystone:flow` to generate each 6-Section flow file).
   - Read `skills/map/references/atlas-and-subagent-contracts.md` for Model-Pinned Scout Subagents (`haiku`/`flash`, passing `USER_LANGUAGE` explicitly), the 5-step Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`), and verify with `bash skills/map/scripts/validate-atlas.sh` (must exit `0` with `STATUS: PASSED`).
2. **Starter Agent Contract Export (`AGENTS.md` / `CLAUDE.md` / `.cursor/rules/*.mdc`):**
   - Write or update a concise `< 100–300`-line root `AGENTS.md` (with a `<= 15`-line `<!-- keystone-map:start -->` pointer block synced to `CLAUDE.md`/`GEMINI.md` without overwriting custom rules) containing verified build/test commands, module boundaries, state invariants, entry points (`filename:line`), and glob-scoped `.cursor/rules/<domain>.mdc` files (`alwaysApply: false`, `200–500` words; `< 200` words if `alwaysApply: true`) for Co-Change coupling rules.

## Phase 0: Architect's Dual-Graph Recon Checklist

1. **Graph 1 — Static Wiring, Composition Roots & Data Schemas:**
   - Inspect build/package manifests (`package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `pom.xml`, `CMakeLists.txt`, `BUILD`, `nx.json`) to locate entry points and the **Composition Root** where configs, DB pools, DI containers, middlewares, routers, or workers are wired (`main.go`, `src/main.rs`, `src/index.ts`, `app.module.ts`, `main.py`, `app/layout.tsx`).
   - Extract **Core Data Structures & Schemas** (`struct`, `interface`, ORM models, migrations, state stores) into `architecture/data-dictionary.md` before dispatching component or flow scouts.
   - Tailor Composition Root analysis to the **7 Repo Archetypes** (`Backend Service/API`, `Frontend App`, `Library/SDK`, `CLI Tool`, `Data Pipeline`, `Framework/Harness`, `Monorepo`).
2. **Graph 2 — Git Hotspots, Co-Change Coupling & Incremental Staleness:**
   - Inspect recent release tags (`git tag -l --sort=-v:refname`), True Churn Hotspots (passing only AST function slices `file:line_start-line_end` to subagents rather than whole `> 500`-LOC files), Author Fractal Value $F$, and Cross-Boundary Co-Change pairs (`A <-> B`).
   - On incremental re-runs (`UNCHANGED` / `STALE_HASH` / `STALE_COCHANGE`), regenerate only dirty modules and their Co-Change partners.

## Red Flags — STOP and Fix Before Sending

- **Skipping Phase 0 Recon or `validate-atlas.sh`:** Reading `README.md` or running `tree` before `bash skills/map/scripts/recon-graphs.sh`, or claiming Mode B completion without `bash skills/map/scripts/validate-atlas.sh` printing `STATUS: PASSED`.
- **Language mismatch or dry telegraphic style in `docs/keystone-map/*.md`:** Writing chat in the user's language (e.g., Vietnamese) while leaving `docs/keystone-map/*.md` in English, or dumping bare symbol tables instead of applying `keystone:using-keystone`'s Shared Clarity Core (`Concrete Actor + Strong Action Verb`, `< 76`-char subgoal-commented code blocks with enclosing signatures, pre-decoded APIs, `Contrastive Why`, and Conversational Vertical Dry-Run cards).
- **Imposing artificial line caps on Group 2 dissection/ledger files or cramming multiple flows into 1 file:** Truncating `flows/flow-*.md`, `components/comp-*.md`, `architecture/*.md`, or `01-coverage-ledger.md` to hit an arbitrary line limit, or cramming multiple independent business flows into a single `flow-*.md` file instead of `1 File = 1 End-to-End Flow` via `keystone:flow`.

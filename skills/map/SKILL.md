---
name: map
description: Use when onboarding to an unfamiliar codebase or monorepo, locating composition roots and wiring points before modifying code, tracing how a feature or subsystem works end-to-end without a git diff, auditing dead or dynamically wired modules, or harvesting architectural patterns from external open-source repositories.
metadata:
  opencode/slash: "true"
  opencode/autoinvoke: "true"
---

# Keystone Map — Multi-Graph Architecture Recon & Verified Atlas Engine

## Overview

Dissect unfamiliar codebases, monorepos, or reference repositories into a verified 6-Tier **C4 + arc42 + RAD-AI Architecture Atlas** (`docs/keystone-map/`) backed by a deterministic $100\%$ coverage ledger.

**Announce at start:** `"Using keystone:map to dissect [target scope] and construct a verified Architecture Atlas."`

<HARD-GATE>
**Violating the letter of the rules is violating the spirit of the rules.**
NEVER start by reading `README.md`, running `tree`, or spawning folder-summarizing subagents. NEVER stop after Phase 1 to deliver an "interim executive summary" under time or authority pressure. You MUST execute `bash skills/map/scripts/recon-graphs.sh` first, write the 6-Tier Atlas (`docs/keystone-map/`), and pass `bash skills/map/scripts/validate-atlas.sh` (exit code `0`) before delivering your final response.
</HARD-GATE>

## When to Use

- **Use when:**
  - Onboarding to an unfamiliar repository or polyglot monorepo (`Bazel`, `Nx`, `Turborepo`, `Cargo`, `Go`).
  - Finding Composition Roots, dependency injection wiring, or integration seams before modifying code.
  - Tracing how an existing subsystem or feature works end-to-end without a bug stacktrace or git diff.
  - Auditing `UNWIRED_DEAD` vs. `DYNAMIC_GAP` modules with $100\%$ denominator coverage.
  - Harvesting architectural patterns from an external open-source repository.
- **Do NOT use when:**
  - Debugging a specific runtime crash, stacktrace, panic, or failing test (`trace`).
  - Explaining a single isolated `< 30`-line function or regex line-by-line (`decode`).
  - Writing a greenfield RFC, ADR, or implementation plan before coding (`design`).

---

## 1. Six Non-Negotiable Invariants

1. **Closed-Loop 4-Bucket Coverage (`01-coverage-ledger.md`):**
   - Assign $100\%$ of top-level modules in $N_{\text{total}}$ (`git ls-tree -d --name-only HEAD` + Build Graph packages) to `CORE_WIRED`, `ADAPTER_CONTRACT`, `DYNAMIC_GAP`, or `UNWIRED_DEAD` with 12-char Git `tree_hash`/`blob_hash`. Enforce $C_{\text{wiring}} = 100\%$ and $C_{\text{hotspot}} \ge 95\%$.
2. **Dual-Graph Recon Before Prose (`README.md` Is Untrusted):**
   - Execute `bash skills/map/scripts/recon-graphs.sh` first to build **Graph 1 (Static Wiring, PageRank ~1K Token Skeleton & SCIP Oracle)** and **Graph 2 (Release Tags, True Churn Hotspots, Cross-Boundary Co-Change & Author Fractal Value)**.
3. **Data-First Mandate (Fred Brooks / Linus Torvalds):**
   - Populate `docs/keystone-map/architecture/data-dictionary.md` (tables, schemas, structs, state invariants) BEFORE dispatching subagents to trace runtime call flows.
4. **Explicit Model Pinning & File-Based Handoff (`superpowers` v6.0):**
   - Pin `haiku` / `flash` for Phase 2 Scout Subagents reading assigned `file:line` slices. Scouts write directly to `docs/keystone-map/components/comp-*.md` and `flows/flow-*.md` (`<= 250` lines/file) and return only file path + citation count.
5. **Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`):**
   - Strip Scout reasoning prose (`EXTRACT` only `CLAIM` + `file:line` + contract) before running the Read-Only Auditor (`DOUBT`) and `bash skills/map/scripts/validate-atlas.sh`.
6. **Progressive Disclosure Budget (`< 2,000` Always-On Tokens):**
   - Enforce line caps across all 6 tiers (`<= 15` lines in `./AGENTS.md` pointer block, `<= 150` lines in Tier 1, `<= 200` lines in Tier 3, `<= 250` lines in Tiers 2/4/5).

---

## 2. Deterministic Attractor DOT State Machine & Visual Output Contract

Execute `keystone:map` across 6 lifecycle stages (`PARSE -> TRANSFORM -> VALIDATE -> INITIALIZE -> EXECUTE -> FINALIZE`), selecting edges in deterministic priority order: (1) Condition match (`exit_code == 0`), (2) Normalized label match, (3) Suggested next IDs, (4) Highest weight, (5) Lexical tiebreak.

```text
+========================================================================+
|        KEYSTONE:MAP 5-PHASE DETERMINISTIC EXECUTION PIPELINE           |
+========================================================================+
|  [Phase 1: Dual-Graph Recon & Incremental Merkle Check]                |
|  Run: bash skills/map/scripts/recon-graphs.sh [target_repo]            |
|  Output: .keystone/tmp/recon-raw.json + 01-coverage-ledger.md draft    |
|                                  |                                     |
|                                  v                                     |
|  [Phase 2: Data-First Dictionary & Model-Pinned Scout Fan-Out]         |
|  1. Write architecture/data-dictionary.md + c2-wiring-and-containers   |
|  2. Fan out haiku/flash Scouts -> components/comp-* & flows/flow-*     |
|                                  |                                     |
|                                  v                                     |
|  [Phase 3: Read-Only Doubt Audit & Goal Gate (validate-atlas.sh)]      |
|  1. CLAIM -> EXTRACT (strip prose) -> DOUBT -> RECONCILE               |
|  2. Run: bash skills/map/scripts/validate-atlas.sh                     |
|     +-- If exit != 0 (FAIL) ===> Jump to retry_target (Phase 2)        |
|     +-- If exit == 0 (PASS) ===> Advance to Phase 4                    |
|                                  |                                     |
|                                  v                                     |
|  [Phase 4: Architect Theory Synthesis (QOC/ATAM + RAD-AI E1)]          |
|  Write architecture/evolution-and-hotspots.md & finalize 00-INDEX.md   |
|                                  |                                     |
|                                  v                                     |
|  [Phase 5: Cognitive Apprenticeship Gate & Tier-6 Rule Export]         |
|  - Onboarding/Modify: Faded Completion Problem + 3-Question Quiz Gate  |
|  - External Scouting: Context-Fit & Pattern Harvest Matrix             |
|  - Export .cursor/rules/<domain>.mdc + ./AGENTS.md <=15-line pointer   |
+========================================================================+
```

### Mandatory 6-Tier Atlas Output Recipe (`docs/keystone-map/`)

| Tier & File Path | Line Cap | Required Structural Slots |
| :--- | :--- | :--- |
| **Tier 1:** `00-INDEX.md` | `<= 150` | C4 L1 `<76`-char ASCII Context Diagram, **RAD-AI `E1` Deterministic vs. AI Boundary**, Progressive Routing Table |
| **Tier 1:** `01-coverage-ledger.md` | `<= 150` | `N_total` 4-Bucket Table (`CORE_WIRED`, `ADAPTER_CONTRACT`, `DYNAMIC_GAP`, `UNWIRED_DEAD`), 12-char Git hash, `C_wiring: 100%`, `C_hotspot >= 95%` |
| **Tier 2:** `architecture/c2-wiring-and-containers.md` | `<= 250` | C4 L2 Trust Boundary ASCII Diagram, Composition Roots (`file:line`), Dependency Direction (`A -> B`) |
| **Tier 2:** `architecture/data-dictionary.md` | `<= 250` | Core Entities/Structs/Tables (`file:line`), Ownership & Mutation Sites, Non-Negotiable State Invariants |
| **Tier 3:** `architecture/evolution-and-hotspots.md` | `<= 200` | Release Tags, Churn Hotspots, Yevtushenko Co-Change (`A <-> B`), Author Fractal $F$, **QOC + ATAM Tradeoff Matrix (`+`/`-`)** |
| **Tier 4:** `components/comp-<domain>.md` | `<= 250` | C4 L3 `<20` elements (`C4-E1` stereotypes), `Who -> To Whom -> Why -> Protocol` table, `file:line` Pointers over Copies |
| **Tier 5:** `flows/flow-<id>-<name>.md` | `<= 250` | `<76`-char ASCII Sequence Diagram, **Zeller 4-Link Infection Chain** (`Trigger -> Infected State -> Propagation -> Failure`), `✅/⚠️/❌` Dry-Run Table |
| **Tier 6:** `.cursor/rules/<domain>.mdc` & `./AGENTS.md` | `< 500`w / `<= 15`L | Scoped domain `globs` rule file + `<!-- keystone-map:start -->` root pointer block |

---

## 3. Five-Phase Execution Instructions

### Phase 1: Dual-Graph Reconnaissance & Incremental Staleness Audit
1. Run the deterministic reconnaissance engine (0 LLM tokens):
   ```bash
   bash skills/map/scripts/recon-graphs.sh "<target_repo_dir>" "docs/keystone-map"
   ```
   *(Run `bash skills/map/scripts/recon-graphs.sh --doctor` to inspect cross-platform CLI availability).*
2. Inspect `.keystone/tmp/recon-raw.json` and the `stdout` tables:
   - **Incremental Mode:** Reuse existing `components/comp-*.md` for modules marked `UNCHANGED`. Re-scan only modules marked `NEW_SCAN`, `STALE_HASH`, or `STALE_COCHANGE`.
   - **Monorepo / Dynamic Edge Escalation:** Read `skills/map/references/wiring-and-monorepo-guide.md` when resolving Bazel (`query`/`cquery`/`aquery`), Nx, Turborepo, SCIP `edge_oracle`, or the 7 Dynamic Edge patterns.
3. Initialize `docs/keystone-map/01-coverage-ledger.md` with $100\%$ of top-level directories from Step `[1/7]` (and list any root-level core source `blob` entrypoints such as `main.py`/`cli.py` in a sub-table below the directory ledger).
4. **Socratic Scope Check:** If the user asked an open-ended question on a repository with `> 500` files, present the C4 L2 Container map and Top 5 Hotspots/Flows to confirm priority order before Phase 2 fan-out.

### Phase 2: Data-First Dissection & Model-Pinned Subagent Fan-Out
1. Read `skills/map/references/atlas-and-subagent-contracts.md` for exact file templates and the Scout Subagent File-Based Handoff Contract.
2. **Data-First Step:** Populate `docs/keystone-map/architecture/data-dictionary.md` and `docs/keystone-map/architecture/c2-wiring-and-containers.md` first using the top PageRank signatures (`Step [7/7]`) and Composition Roots (`Step [3/7]`).
3. **Scout Subagent Fan-Out:**
   - Pin `haiku` or `flash` for each Scout Subagent.
   - Assign specific `file:line_start-line_end` slices (using AST function slices from `Step [4/7]` on high-LOC Hotspot files to avoid the `35–45%` Tornhill Unhealthy Code Token Tax).
   - Require every `flows/flow-*.md` to trace **Andreas Zeller's 4-Link Infection Chain** and a `✅/⚠️/❌` Dry-Run table.
   - **Coordinate Format Rule (Gate 4A):** Always write full repo-relative paths (`pkg/server.py:10-20`), never bare basenames (`server.py:10`), never comma-lists (`:7,11`), and never line-wrap a `path/file.ext:line` token across two lines inside `<76`-char ASCII diagrams.

### Phase 3: Adversarial Doubt Audit & Deterministic Exit Gate (`goal_gate`)
1. Execute `CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP` from `skills/map/references/atlas-and-subagent-contracts.md`:
   - **EXTRACT:** Strip Scout narrative explanations; pass only `CLAIM` + `file:line` + I/O contract to the Read-Only Auditor.
   - **DOUBT:** Verify every `file:line` against raw source code and confirm `CORE_WIRED` modules were genuinely read.
2. Run the deterministic 6-gate validator:
   ```bash
   bash skills/map/scripts/validate-atlas.sh "docs/keystone-map" "<target_repo_dir>"
   ```
3. **Goal Gate Rule (`retry_target` — No Exceptions):**
   - If `validate-atlas.sh` returns a non-zero exit code, NEVER proceed to Phase 4.
   - Do NOT ignore missing directories, broken links, line-cap overflows, or out-of-bounds `file:line` citations. Fix every reported error and re-run `validate-atlas.sh` until it prints `STATUS: PASSED`.

### Phase 4: Architect Theory Synthesis (`QOC + ATAM` & `RAD-AI`)
1. Synthesize `docs/keystone-map/architecture/evolution-and-hotspots.md` (`<= 200` lines) with Cross-Boundary Co-Change pairs (`A <-> B`), Yevtushenko restructuring survival (`git log -M`), Author Fractal Value $F = 1 - \sum (c_i/C)^2$, and the **QOC + ATAM Tradeoff Matrix (`+`/`-`)**.
2. Finalize `docs/keystone-map/00-INDEX.md` (`<= 150` lines) with the C4 L1 Context diagram and **RAD-AI `E1` Deterministic vs. Non-Deterministic AI Boundary Delineation**.
3. Re-run `bash skills/map/scripts/validate-atlas.sh "docs/keystone-map" "<target_repo_dir>"` to confirm `STATUS: PASSED`.

### Phase 5: Cognitive Apprenticeship Gate & Executable Rule Export
1. **Select Mode Based on User Intent:**
   - **Mode A (Onboarding / Pre-Modification):** Present 1 **Faded Completion Problem** (flow diagram with 1–2 blanked `[ ??? ]` state transitions + `file:line` hint) followed by the **3-Question Quiz Gate** (State Invariant, Failure Path, Cross-Boundary Co-Change).
   - **Mode B (External Repo Scouting / Pattern Harvesting):** Present the **Context-Fit & Harvest Matrix** (`Adopt` / `Adapt` / `Reject`) mapped to the target codebase.
2. **Tier 6 Executable Knowledge Export (When Authorized for Local Repo):**
   - Export domain invariants and Co-Change rules to `.cursor/rules/<domain>.mdc` (`alwaysApply: false`, `globs: ["<domain>/**"]`, `< 500` words) and update the `<= 15`-line `<!-- keystone-map:start -->` pointer block in `./AGENTS.md`.

---

## 4. Red Flags & Anti-Rationalization Guardrails

### Red Flags — STOP and Start Over
- Reading `README.md` or running `tree`/`ls` before running `bash skills/map/scripts/recon-graphs.sh`.
- Delivering a "quick interim briefing" or stopping after Phase 1 due to executive time pressure.
- Skipping `recon-graphs.sh` or the 6-Tier Atlas because "this repository is small (only a few files), so I can summarize it directly in chat".
- Spawning subagents to summarize folders before writing `architecture/data-dictionary.md`.
- Omitting a top-level directory (including tracked dot-directories like `.claude-plugin` or `.cursor-plugin`) from `01-coverage-ledger.md` because "it looks like tests, scripts, or docs".
- Claiming the Atlas is complete without running `bash skills/map/scripts/validate-atlas.sh` and seeing `STATUS: PASSED`.
- Dumping prose explanations without `<76`-char ASCII diagrams, `file:line` coordinates, or `✅/⚠️/❌` Dry-Run tables.

**All of these mean: STOP. Return to Phase 1/Phase 2 and follow the deterministic pipeline.**

| Excuse / Forbidden Rationalization | Enforced Reality Check |
| :--- | :--- |
| *"Let me read `README.md` and run `tree` first to get an overview."* | **STOP.** `README.md` suffers from architectural drift and `tree` floods context with surface folders. Run `bash skills/map/scripts/recon-graphs.sh` first. |
| *"This repo only has a few files (or we have a 4-minute deadline); I'll just read the files and reply in chat."* | **STOP.** Chat-only summaries miss Git Co-Change coupling, skip 4-bucket dead/dynamic auditing, and vanish after the turn. Always run `recon-graphs.sh`, write the 6-Tier Atlas, and pass `validate-atlas.sh`. |
| *"This repo is huge; I will spawn 8 default-model subagents to summarize each folder."* | **STOP.** Folder-based prose summaries sever cross-module execution flows and burn token budgets. Build Graph 1 + Graph 2 first, pin `haiku`/`flash`, and hand off via files on disk. |
| *"I already understand the call flow; I can skip `architecture/data-dictionary.md`."* | **STOP.** Flowcharts without data tables keep engineers in mystification (Fred Brooks's Law). Complete `data-dictionary.md` with state invariants before tracing flows. |
| *"Static analysis shows zero callers for this package; I will ignore it completely."* | **STOP.** Static call graphs are a Precision Budget and miss DI, reflection, and event buses. Cross-check Git Hotspots and DI registries before classifying as `UNWIRED_DEAD` in `01-coverage-ledger.md`. |
| *"The subagents finished writing their files; I can report completion to the user now."* | **STOP.** Never trust unverified subagent output. Run `CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP` and verify `bash skills/map/scripts/validate-atlas.sh` exits `0`. |
| *"I will paste all discovered architectural rules directly into root `AGENTS.md` / `CLAUDE.md`."* | **STOP.** Root instruction files over 300 lines degrade instruction following across every session. Keep the root pointer `<= 15` lines and export rules to `.cursor/rules/<domain>.mdc` with scoped `globs`. |

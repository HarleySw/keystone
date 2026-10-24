---
name: map
description: Use when onboarding to an unfamiliar codebase or monorepo, locating composition roots and wiring points, dissecting how a feature or subsystem works end-to-end without a git diff, auditing dead or dynamically wired modules into a C4 and arc42 architecture atlas, or harvesting architectural patterns from external open-source repositories.
metadata:
  opencode/slash: "true"
  opencode/autoinvoke: "true"
---

# Keystone Map — Multi-Graph Architecture Recon & Verified Atlas Engine

Dissect unfamiliar codebases, monorepos, or reference repositories into a verified 6-Tier **C4 + arc42 + RAD-AI Architecture Atlas** (`docs/keystone-map/`) backed by a deterministic $100\%$ coverage ledger.

**Announce at start:** `"Using keystone:map to dissect [target scope] and construct a verified Architecture Atlas."`

---

## 1. Six Non-Negotiable Invariants

1. **Closed-Loop 4-Bucket Coverage (`01-coverage-ledger.md`):**
   - Every top-level module in the immutable denominator $N_{\text{total}}$ (`git ls-tree -d --name-only HEAD` + Build Graph packages) MUST be assigned to `CORE_WIRED`, `ADAPTER_CONTRACT`, `DYNAMIC_GAP`, or `UNWIRED_DEAD` with its 12-char Git `tree_hash`/`blob_hash`.
   - Enforce $C_{\text{wiring}} = 100\%$ and $C_{\text{hotspot}} \ge 95\%$.
2. **Dual-Graph Recon Before Prose (`README.md` Is Untrusted):**
   - NEVER start by trusting `README.md` or running `tree`. Always execute `bash skills/map/scripts/recon-graphs.sh` first to build **Graph 1 (Static Wiring, PageRank ~1K Token Skeleton & SCIP Oracle)** and **Graph 2 (Release Tags, True Churn Hotspots, Cross-Boundary Co-Change & Author Fractal Value)**.
3. **Data-First Mandate (Fred Brooks / Linus Torvalds):**
   - Dissect database tables, schemas, structs, interfaces, and state invariants in `docs/keystone-map/architecture/data-dictionary.md` BEFORE dispatching subagents to trace runtime call flows.
4. **Explicit Model Pinning & File-Based Handoff (`superpowers` v6.0):**
   - Pin `haiku` / `flash` for Phase 2 Scout Subagents reading assigned `file:line` slices.
   - Scout Subagents MUST write directly to `docs/keystone-map/components/comp-*.md` and `flows/flow-*.md` (`<= 250` lines/file) and return only the file path and citation count.
5. **Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`):**
   - Strip Scout reasoning prose (`EXTRACT` only `CLAIM` + `file:line` + contract) before running the Unified Read-Only Auditor (`DOUBT`) and `bash skills/map/scripts/validate-atlas.sh`.
6. **Progressive Disclosure Budget (`< 2,000` Always-On Tokens):**
   - Keep `./AGENTS.md` pointer block `<= 15` lines, Tier 1 files `<= 150` lines, Tier 3 `evolution-and-hotspots.md` `<= 200` lines, and Tier 2/4/5 files `<= 250` lines.

---

## 2. Deterministic Attractor DOT State Machine

Execute `keystone:map` as a deterministic directed graph across 6 lifecycle stages (`PARSE -> TRANSFORM -> VALIDATE -> INITIALIZE -> EXECUTE -> FINALIZE`). Select outgoing transitions using the 5-priority deterministic order:
1. Condition-matching edges (`exit_code == 0` / coverage threshold met)
2. Preferred normalized label match
3. Suggested next node IDs
4. Highest edge weight
5. Lexical tiebreak

```text
+========================================================================+
|        KEYSTONE:MAP 5-PHASE DETERMINISTIC EXECUTION PIPELINE           |
+========================================================================+
|                                                                        |
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
|  - External Scouting ("Xia"): Context-Fit & Harvest Matrix             |
|  - Export .cursor/rules/<domain>.mdc + ./AGENTS.md <=15-line pointer   |
+========================================================================+
```

---

## 3. Five-Phase Execution Instructions

### Phase 1: Dual-Graph Reconnaissance & Incremental Staleness Audit
1. Run the deterministic reconnaissance engine (0 LLM tokens):
   ```bash
   bash skills/map/scripts/recon-graphs.sh "<target_repo_dir>" "docs/keystone-map"
   ```
   *(If diagnosing toolchain availability across Linux/macOS/Windows, run `bash skills/map/scripts/recon-graphs.sh --doctor`).*
2. Inspect `.keystone/tmp/recon-raw.json` and the `stdout` tables:
   - **Incremental Mode:** Reuse existing `components/comp-*.md` for modules marked `UNCHANGED`. Re-scan only modules marked `NEW_SCAN`, `STALE_HASH`, or `STALE_COCHANGE`.
   - **Monorepo / Dynamic Edge Escalation:** Read `skills/map/references/wiring-and-monorepo-guide.md` when resolving Bazel (`query`/`cquery`/`aquery`), Nx, Turborepo, SCIP `edge_oracle`, or the 7 Dynamic Edge patterns.
3. Initialize `docs/keystone-map/01-coverage-ledger.md` listing $100\%$ of top-level modules from Step `[1/7]` with their initial 4-bucket classification and 12-char Git hash.
4. **Socratic Scope Check:** If the user asked an open-ended question on a massive monorepo (`> 500` files), present the C4 L2 Container map and Top 5 Hotspots/Flows to confirm priority order before fanning out Phase 2 subagents.

### Phase 2: Data-First Dissection & Model-Pinned Subagent Fan-Out
1. Read `skills/map/references/atlas-and-subagent-contracts.md` for exact file templates and the Scout Subagent File-Based Handoff Contract.
2. **Data-First Step:** Populate `docs/keystone-map/architecture/data-dictionary.md` and `docs/keystone-map/architecture/c2-wiring-and-containers.md` first using the top PageRank signatures (`Step [7/7]`) and Composition Roots (`Step [3/7]`).
3. **Scout Subagent Fan-Out:**
   - Pin `haiku` or `flash` for each Scout Subagent.
   - Assign each Scout specific `file:line_start-line_end` slices (using AST function slices from `Step [4/7]` on high-LOC Hotspot files to avoid the `35–45%` Tornhill Unhealthy Code Token Tax).
   - Require every `flows/flow-*.md` to trace **Andreas Zeller's 4-Link Infection Chain** (`Trigger -> Infected vs Sane State -> Propagation -> Observable Failure`) and a `✅/⚠️/❌` Dry-Run table.

### Phase 3: Adversarial Doubt Audit & Deterministic Exit Gate (`goal_gate`)
1. Execute the 5-step adversarial cycle (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`) from `skills/map/references/atlas-and-subagent-contracts.md`:
   - **EXTRACT:** Strip Scout narrative explanations; pass only `CLAIM` + `file:line` + I/O contract to the Unified Read-Only Auditor.
   - **DOUBT:** Verify every `file:line` against raw source code and confirm `CORE_WIRED` modules were genuinely read in the tool execution trace.
2. Run the deterministic 6-gate validator:
   ```bash
   bash skills/map/scripts/validate-atlas.sh "docs/keystone-map" "<target_repo_dir>"
   ```
3. **Goal Gate Rule (`retry_target`):** If `validate-atlas.sh` returns a non-zero exit code, NEVER proceed to Phase 4. Fix every reported missing directory, broken link, line-cap overflow, or hallucinated `file:line` coordinate and re-run `validate-atlas.sh` until it prints `STATUS: PASSED`.

### Phase 4: Architect Theory Synthesis (`QOC + ATAM` & `RAD-AI`)
1. Synthesize `docs/keystone-map/architecture/evolution-and-hotspots.md` (`<= 200` lines):
   - Document Cross-Boundary Co-Change pairs (`A <-> B`), Yevtushenko restructuring survival (`git log -M`), Code Age, and **Author Fractal Value** $F = 1 - \sum (c_i/C)^2$.
   - Construct the **QOC (Questions, Options, Criteria) + ATAM Tradeoff Matrix (`+`/`-`)** explaining *why* the architecture took its current shape.
2. Finalize `docs/keystone-map/00-INDEX.md` (`<= 150` lines) with the C4 Level 1 System Context diagram and **RAD-AI `E1` Deterministic vs. Non-Deterministic AI Boundary Delineation**.
3. Re-run `bash skills/map/scripts/validate-atlas.sh "docs/keystone-map" "<target_repo_dir>"` to confirm Phase 4 edits obey all line caps and link checks.

### Phase 5: Cognitive Apprenticeship Gate & Executable Rule Export
1. **Select Mode Based on User Intent:**
   - **Mode A (Onboarding / Pre-Modification):** Present 1 **Faded Completion Problem** (flow diagram with 1–2 blanked `[ ??? ]` state transitions + `file:line` hint) followed by the **3-Question Quiz Gate** (State Invariant, Failure Path, Cross-Boundary Co-Change).
   - **Mode B (External Repo Scouting / "Xỉa" Pattern Harvesting):** Present the **Context-Fit & Harvest Matrix** (`Adopt` / `Adapt` / `Reject`) mapped to the target codebase.
2. **Tier 6 Executable Knowledge Export (When Authorized for Local Repo):**
   - Export domain invariants and Co-Change rules to `.cursor/rules/<domain>.mdc` (`alwaysApply: false`, `globs: ["<domain>/**"]`, `< 500` words).
   - Add or update the `<= 15`-line pointer block in `./AGENTS.md` (and synced `CLAUDE.md`/`GEMINI.md`).

---

## 4. Anti-Rationalization Guardrails

| Forbidden Rationalization | Enforced Reality Check |
| :--- | :--- |
| *"Let me read `README.md` and run `tree` first to get an overview."* | **STOP.** `README.md` suffers from architectural drift and `tree` floods context with surface folders. Run `bash skills/map/scripts/recon-graphs.sh` first. |
| *"This repo is huge; I will spawn 8 default-model subagents to summarize each folder."* | **STOP.** Folder-based prose summaries sever cross-module execution flows and burn token budgets. Build Graph 1 + Graph 2 first, pin `haiku`/`flash`, and hand off via files on disk. |
| *"I already understand the call flow; I can skip `architecture/data-dictionary.md`."* | **STOP.** Flowcharts without data tables keep engineers in mystification (Fred Brooks's Law). Complete `data-dictionary.md` with state invariants before tracing flows. |
| *"Static analysis shows zero callers for this package; I will ignore it completely."* | **STOP.** Static call graphs are a Precision Budget and miss DI, reflection, and event buses. Cross-check Git Hotspots and DI registries before classifying as `UNWIRED_DEAD` in `01-coverage-ledger.md`. |
| *"The subagents finished writing their files; I can report completion to the user now."* | **STOP.** Never trust unverified subagent output. Run `CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP` and verify `bash skills/map/scripts/validate-atlas.sh` exits `0`. |
| *"I will paste all discovered architectural rules directly into root `AGENTS.md` / `CLAUDE.md`."* | **STOP.** Root instruction files over 300 lines degrade instruction following across every session. Keep the root pointer `<= 15` lines and export rules to `.cursor/rules/<domain>.mdc` with scoped `globs`. |

# Keystone Map — Multi-File Atlas Templates, Subagent Contracts & Doubt Audit

Use this reference during **Phase 2 (Data-First Subagent Fan-Out)**, **Phase 3 (Read-Only Doubt Audit)**, **Phase 4 (Architect Theory Synthesis)**, and **Phase 5 (Cognitive Apprenticeship & Executable Export)**.

---

## 1. 6-Tier Progressive Disclosure Atlas Specification (`docs/keystone-map/`)

NEVER emit a single monolithic architecture file. Split output across the 6-Tier Progressive Disclosure hierarchy combining **C4 Model (L1–L3 + Dynamic)**, **arc42 (§1–§11)**, and **RAD-AI (2026) Extensions (`E1` AI Boundary Delineation & `C4-E1` AI Component Stereotypes)**.

```text
+========================================================================+
|        6-TIER PROGRESSIVE DISCLOSURE ARCHITECTURE ATLAS                |
+========================================================================+
| Tier | Standardized Path                           | Cap (Lines/Words) |
+------+---------------------------------------------+-------------------+
| T0   | ./AGENTS.md (synced to CLAUDE.md/GEMINI.md) | <= 15 line block  |
| T1   | docs/keystone-map/00-INDEX.md               | <= 150 lines      |
|      | docs/keystone-map/01-coverage-ledger.md     | <= 150 lines      |
| T2   | architecture/c2-wiring-and-containers.md    | <= 250 lines      |
|      | architecture/data-dictionary.md             | <= 250 lines      |
| T3   | architecture/evolution-and-hotspots.md      | <= 200 lines      |
| T4   | components/comp-<domain>.md                 | <= 250 lines/file |
| T5   | flows/flow-<id>-<name>.md                   | <= 250 lines/file |
| T6   | .cursor/rules/<domain>.mdc                  | <= 500 words/file |
+========================================================================+
```

### Mandatory Authoring Rules Across All Atlas Files
1. **C4 & RAD-AI Diagram Hygiene:**
   - Keep every diagram `< 20` nodes and `< 76` characters wide for ASCII diagrams.
   - Use `PascalCase` for system/component names, `camelCase` for IDs, and `_Ext` suffix for external dependencies.
   - Draw explicit **Trust Boundaries** and **RAD-AI `E1` Boundaries** separating `[Deterministic]` code from `[Non-Deterministic AI/ML]` components.
   - Label every directed arrow with `Who -> To Whom -> Why -> Protocol`.
2. **Pointers Over Copies:**
   - NEVER paste multi-line implementation bodies into Markdown.
   - Anchor every claim to `path/to/file.ext:line_start-line_end (SymbolName)` plus its 1-line type/function signature.
3. **Zero Zombie Nouns (Helen Sword / Strunk & White):**
   - Ban nominalizations ("the execution of", "the initialization of"). Use active verbs and strict imperatives (`MUST`, `NEVER`).

---

## 2. Standardized File Templates (`docs/keystone-map/`)

### 2.1. `00-INDEX.md` (Tier 1 — `<= 150` Lines)
- **arc42 §1–§3 & C4 Level 1 (System Context):** ASCII/Mermaid System Context diagram showing human actors, the system box, and `_Ext` systems.
- **RAD-AI `E1` Boundary Table:** Explicitly classify subsystems as `Deterministic` (exact state transitions, idempotent I/O) vs. `Non-Deterministic` (LLM prompts, embedding stores, probabilistic routers, temperature/fallback policies).
- **Progressive Disclosure Routing Table:** Relative Markdown links (`[Component](./components/comp-auth.md)`) to all Tier 2–5 files.

### 2.2. `01-coverage-ledger.md` (Tier 1 — `<= 150` Lines)
- **Header Metadata:** `head_commit`, `root_tree_hash`, `scip_status` (`SCIP_ACTIVE` with `scip_content_fingerprint` or `BLOCKED_ORACLE`).
- **Closed-Loop 4-Bucket Table:** Every top-level directory from `git ls-tree -d --name-only HEAD` MUST appear with:
  `| Module | Bucket (CORE_WIRED / ADAPTER_CONTRACT / DYNAMIC_GAP / UNWIRED_DEAD) | Git Hash (12-char) | Staleness (UNCHANGED / STALE_HASH / STALE_COCHANGE) | Primary Evidence (file:line) |`
- **Audit Summary Footer:**
  - `C_wiring: 100%` (mandatory)
  - `C_hotspot: >= 95%` (mandatory)

### 2.3. `architecture/data-dictionary.md` (Tier 2 — `<= 250` Lines, Data-First Mandate)
- Complete BEFORE dispatching flow subagents.
- Document database tables, schemas, core domain structs/classes, key interfaces, and **State Machine Invariants** with `file:line_start-line_end` coordinates.

### 2.4. `architecture/c2-wiring-and-containers.md` (Tier 2 — `<= 250` Lines)
- **C4 Level 2 (Containers) & Trust Boundaries:** Runtime processes, databases, queues, and network trust boundaries.
- **Composition Root Dissection:** Exact `file:line` bootstrap sequence where config loads, DI containers bind interfaces to implementations, and servers/hooks start.

### 2.5. `architecture/evolution-and-hotspots.md` (Tier 3 — `<= 200` Lines)
- **Release Tags & Feature Milestones:** Prioritized feature list anchored to tags/commits.
- **Top 20 True Churn Hotspots & Unhealthy Code Token Tax (`35–45%`):** Files with high `Churn x LOC` and their AST function slices.
- **Cross-Boundary Co-Change (`dir(A) != dir(B)`) & Yevtushenko Restructuring Survival (`git log -M`):** Logical couplings across module boundaries that survive directory moves.
- **Code Age & Author Fractal Value ($F = 1 - \sum (c_i/C)^2 \in [0.00, 1.00]$):** Identify single-owner silos ($F \to 0.00$, Bus Factor = 1) vs. fragmented multi-author coordination bottlenecks ($F > 0.60$).
- **QOC (Questions, Options, Criteria) + ATAM Tradeoff Matrix (`+` / `-`):**
  `| Design Question | Chosen Option (file:line) | Rejected Alternative | ATAM Benefit (+) | ATAM Cost / Risk (-) |`

### 2.6. `components/comp-<domain>.md` (Tier 4 — `<= 250` Lines)
- **Header Metadata:** `tree_hash: <12-char-hash>`, `bucket: CORE_WIRED`.
- **C4 Level 3 Diagram + `C4-E1` AI Stereotypes:** (`<<Agent>>`, `<<VectorStore>>`, `<<FeatureStore>>`, `<<DeterministicCore>>`), `< 20` elements.
- **Public Contract Table:** Exported interfaces/functions (`file:line_start-line_end`, signature, caller modules) and unresolved `DYNAMIC_GAP` edges.

### 2.7. `flows/flow-<id>-<name>.md` (Tier 5 — `<= 250` Lines)
- **C4 Dynamic View:** Step-by-step call spine from Ingress (`file:line`) through Domain (`file:line`) to Storage/Egress (`file:line`).
- **Andreas Zeller's 4-Link Infection Chain:**
  1. `Trigger`: Exact ingress or defect activation point (`file:line`).
  2. `Infected State vs Sane State`: Exact variable/struct field that diverges and the guard condition separating sane from infected state (`file:line`).
  3. `Propagation`: How the mutated state travels across functions, channels, or queues (`file:line`).
  4. `Observable Failure / Side-Effect`: External response, DB write, or panic produced at the boundary (`file:line`).
- **3-State Dry-Run Verification Table:**
  - `✅` Happy Path (concrete input -> state mutation -> output)
  - `⚠️` Edge / Boundary Case (empty, max-limit, concurrent race, or retry)
  - `❌` Failure / Rollback Path (guard trigger -> error propagation -> cleanup)

---

## 3. Superpowers v6.0 Subagent Economics & File-Based Handoff Contract

1. **Explicit Model Tier Pinning:**
   - **Scout Subagents (Phase 2):** ALWAYS pin `model: "haiku"` or `model: "flash"`.
   - **Unified Read-Only Auditor (Phase 3):** Pin `model: "sonnet"` or `model: "flash"` in strict read-only mode.
   - **Main Architect Synthesis (Phase 4):** Run on `opus` / `sonnet` / `pro`.
2. **Tornhill Unhealthy Code Token Tax Slicing (`35–45%` Savings):**
   - NEVER assign a Scout Subagent to read an entire high-churn Hotspot file (`> 500` LOC) end-to-end. Pass the exact AST function slice coordinates (`file:line_start-line_end`) emitted in Step `[4/7]` of `recon-graphs.sh`.
3. **File-Based Handoff Prompt Template (Scout Subagent):**
   ```markdown
   ROLE: Phase 2 Architecture Scout (Model: haiku/flash)
   TARGET_MODULE: <module_path> (tree_hash: <hash>)
   ASSIGNED_COORDINATES: <list of file:line_start-line_end from PageRank skeleton>
   DATA_DICTIONARY_PATH: docs/keystone-map/architecture/data-dictionary.md
   OUTPUT_FILE: docs/keystone-map/components/comp-<domain>.md (or flows/flow-<id>.md)

   INSTRUCTIONS:
   1. Read ONLY the assigned file:line slices and data-dictionary.md.
   2. Write the output directly to OUTPUT_FILE (<= 250 lines).
   3. State a 2-3 line architectural CLAIM at the top of the file.
   4. Anchor every statement to path/to/file.ext:line_start-line_end (Symbol).
   5. Include Zeller's 4-Link Infection Chain (Trigger, Infected State, Propagation, Observable Failure) and ✅/⚠️/❌ Dry-Run rows.
   6. Return ONLY: "DONE: <OUTPUT_FILE> (<line_count> lines, <citation_count> citations)" to the Main Agent. NEVER paste prose summaries into chat.
   ```

---

## 4. Phase 3 Adversarial Doubt Audit (`CLAIM -> EXTRACT -> DOUBT -> RECONCILE -> STOP`)

To eliminate Subagent Confirmation Bias, execute this 5-step adversarial loop in Phase 3:

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

## 5. Phase 5 Cognitive Apprenticeship & Executable Knowledge Export

### Mode A: Onboarding or Pre-Modification (`Faded Completion Problem` + `3-Question Quiz Gate`)
1. **Faded Completion Problem:** Present the core execution flow diagram with **1–2 critical state transitions or guard conditions intentionally blanked (`[ ??? ]`)** alongside a `file:line` hint so the human engineer actively retrieves the schema into working memory.
2. **3-Question Quiz Gate:** Ask the engineer 3 concise questions before unlocking `keystone:design` or code edits:
   - **Q1 (State Invariant):** Which struct field or DB constraint in `data-dictionary.md` prevents invalid state at `file:line`?
   - **Q2 (Failure Path / Zeller Infection):** If `<dependency>` fails at `file:line`, how does the infected state propagate or roll back?
   - **Q3 (Cross-Boundary Co-Change):** Based on `evolution-and-hotspots.md`, modifying `<file_A>` requires checking which coupled `<file_B>` across module boundaries?

### Mode B: External Repo Scouting / Pattern Harvesting ("Xỉa" Mode)
Replace the Quiz Gate with the **Context-Fit & Harvest Matrix**:
`| Pattern / Mechanism (Source file:line) | Decision (Adopt / Adapt / Reject) | Target Project Adaptation & Rationale |`

### Tier 6 Executable Constraints Export (`.cursor/rules/<domain>.mdc` & `./AGENTS.md`)
1. Generate scoped `.cursor/rules/<domain>.mdc` (`< 200–500` words):
   ```markdown
   ---
   description: Architectural invariants and Co-Change rules for <domain>
   globs: ["<domain>/**"]
   alwaysApply: false
   ---
   - NEVER bypass `<GuardSymbol>` (`<file:line>`); enforce `<invariant>`.
   - MUST inspect co-change partner `<partner_file>` whenever modifying `<source_file>`.
   ```
2. Update `./AGENTS.md` (and symlinked `CLAUDE.md`/`GEMINI.md`) with a **`<= 15`-line pointer block** pointing to `docs/keystone-map/00-INDEX.md` and `01-coverage-ledger.md`.

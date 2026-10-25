# Keystone Map — Wiring, Static/Build Ladder & Monorepo Reference

Use this reference during **Phase 1 (Dual-Graph Recon)** and **Phase 2 (Data-First Subagent Fan-Out)** to locate Composition Roots, resolve dynamic edges under a strict Precision Budget, query monorepo build graphs, and apply Architect Program Comprehension Epistemology.

---

## 1. The 5-Tier Static & Build Analysis Ladder

Static analysis is not a single binary capability; it is a 5-tier ladder trading execution cost against semantic depth. NEVER confuse a module import graph (`madge`, `goda`) with a runtime call graph.

```text
+========================================================================+
|             5-TIER STATIC & BUILD ANALYSIS LADDER                      |
+========================================================================+
| Tier | Core Mechanism        | Detects               | Blind Spots     |
+------+-----------------------+-----------------------+-----------------+
| T1   | Lexical & Git Index   | 100% file inventory   | Cannot separate |
|      | git ls-files, rg      | N_total, env keys     | defs from calls |
+------+-----------------------+-----------------------+-----------------+
| T2   | Concrete Syntax (AST) | Multiline signatures, | Heuristic name  |
|      | ast-grep, ctags +json | @def vs @ref, PageRank| matching only   |
+------+-----------------------+-----------------------+-----------------+
| T3   | Compiler Oracle       | Exact go-to-def,      | Needs compiler  |
|      | SCIP / LSIF / LSP     | interface implementer | index (.scip)   |
+------+-----------------------+-----------------------+-----------------+
| T4   | Monorepo Build Graph  | 100% transitive deps, | Package level   |
|      | bazel, nx, turbo      | rdeps, dead packages  | only (no funcs) |
+------+-----------------------+-----------------------+-----------------+
| T5   | Architect Wiring Recon| Composition Root, DI, | Must anchor to  |
|      | Agentic file:line read| route & event tables  | T1-T4 ledger    |
+========================================================================+
```

---

## 2. Precision Budget & The 7 Dynamic Edge Patterns

Treat every static call graph as a **Precision Budget**. Modern frameworks obscure control flow behind 7 dynamic structures. NEVER guess across a dynamic boundary; either resolve the registration table with `file:line` evidence or log the edge under `DYNAMIC_GAP` in `01-coverage-ledger.md`.

| Dynamic Pattern | Why Surface AST Fails | Mandatory Resolution Strategy |
| :--- | :--- | :--- |
| **1. Interface Polymorphism** | Caller invokes `Repository.Save()`; AST sees interface, not concrete struct. | Locate struct injection at Composition Root (`main.go`, `wire.go`) or run Tier-3 SCIP implementation lookup. |
| **2. Dependency Injection (DI)** | Runtime containers (`Spring`, `NestJS`, `fx.New`, `Guice`) wire beans via decorators/providers. | Parse `@Module({ providers })`, `fx.Provide(...)`, or `services.AddScoped<I, T>()` registration tables first. |
| **3. Callbacks & Higher-Order Funcs** | Execution passes anonymous functions or closures across async queues. | Trace the registration call site where the closure binds to the dispatcher. |
| **4. Route & Command Tables** | HTTP/RPC routers (`chi`, `gin`, `Express`, `FastAPI`) map string paths to handlers. | Extract route registration tables (`router.POST`, `@app.post`) as ingress anchors for `flows/flow-*.md`. |
| **5. Reflection & Runtime Proxies** | `reflect.ValueOf`, `getattr(obj, name)`, Java dynamic proxies invoke methods by runtime string. | Sweep string literals via `rg` / `git grep -nIE`; record unresolved targets as `DYNAMIC_GAP` with runtime verification coordinates. |
| **6. Dynamic Imports / Plugins** | `import(variable)`, `importlib.import_module`, `dlopen` load code from config. | Inspect plugin manifest files (`plugin.json`, `Cargo.toml`, config schemas) and list all candidate plugin directories. |
| **7. Framework Hooks & Event Buses** | Pub/Sub (`EventEmitter.emit`, `Kafka`, `NATS`, lifecycle hooks) decouple emitter from consumer. | Build a two-column topic match table: `Publisher (file:line) -> Topic/Event Name -> Subscriber (file:line)`. |

---

## 3. Hybrid Graph Oracle: AST + SCIP Phase-1 Join

`skills/map/scripts/recon-graphs.sh` combines zero-dependency AST/Ctags skeletonization with optional **SCIP (Source Code Intelligence Protocol)** compiler indices:

1. **SQLite Tag Cache (`.keystone/cache/repomap.tags.cache.v1`):**
   - Stores `Tag(rel_fname, fname, line, end_line, name, kind, role, signature, blob_hash)` and `edge_oracle`.
   - Reuses cached tags on subsequent runs whenever a file's Git `blob_hash` matches.
2. **SCIP Phase-1 Join (`edge_oracle`):**
   - Computes `scip_content_fingerprint` (first 12 hex characters of SHA-256 over `index.scip` / `*.scip`).
   - Matches zero-based LSP line/character occurrences against Tier-2 AST candidate edges using **identifier-token containment**.
   - Records verified compiler edges in `edge_oracle` without deleting heuristic AST edges, computing static `recall` metrics.
   - **Never an Error Exit:** If no `.scip` file exists, `recon-graphs.sh` sets `scip_status: "BLOCKED_ORACLE"` and prints indexer install commands (`scip-go`, `scip-typescript`, `scip-python`, `rust-analyzer scip`) while exiting `0`.

---

## 4. Monorepo Build Graph Queries (Tier 4)

On multi-service or polyglot monorepos, NEVER rely on directory names alone. Query the build system's native DAG to prove transitive dependencies and dead packages (`rdeps == 0`).

### 4.1. Bazel 3-Phase Graph Queries (`query`, `cquery`, `aquery`)
- **Loading Phase (`bazel query` — Unconfigured Target DAG):**
  ```bash
  # Direct + transitive dependencies of a service
  bazel query "deps(//services/payment:payment)" --output=graph
  # Direct dependencies only (depth = 1)
  bazel query "deps(//services/payment:payment, 1)" --output=package
  # Reverse dependencies (blast radius of changing a shared library)
  bazel query "rdeps(//..., //lib/metrics:metrics)" --output=package
  # Mathematical proof of dead/unwired package (empty output => UNWIRED_DEAD)
  bazel query "rdeps(//..., //lib/legacy:old_util)"
  # Filter executable binaries and trace all paths between two subsystems
  bazel query "kind('.*_binary', //...)"
  bazel query "allpaths(//services/api:api, //pkg/storage:db)"
  # Audit external third-party dependencies
  bazel query "filter('@', deps(//services/...))"
  ```
- **Analysis Phase (`bazel cquery` — Resolves `select()` & Build Flags):**
  ```bash
  bazel cquery "deps(//services/payment:payment)" --output=proto
  ```
- **Execution Phase (`bazel aquery` — Exact Compiler Actions & Command Lines):**
  ```bash
  bazel aquery "deps(//services/payment:payment)" --output=streamed_jsonproto
  ```

### 4.2. Nx, Turborepo, Cargo, Go Workspaces & pnpm
```bash
# Nx: Export full project + implicit import graph to JSON
npx nx graph --file=.keystone/tmp/nx-graph.json
npx nx show projects --affected

# Turborepo: Dry-run execution graph in JSON
npx turbo run build --dry-run=json

# Rust Cargo Workspace: Machine-readable dependency graph
cargo metadata --format-version 1 --no-deps

# Go Modules / Workspace: Module dependency edges
go list -m -json all
go mod graph

# pnpm Monorepo: Workspace package inventory
pnpm list -r --depth -1 --json
```

---

## 5. Closed-Loop 4-Bucket Coverage Accounting

Every tracked top-level directory (`git ls-tree -d --name-only HEAD`, including dot-directories except `.keystone`) and Build Graph package in the immutable denominator $N_{\text{total}}$ MUST appear in `.keystone/map/01-coverage-ledger.md` under exactly one bucket:

- `CORE_WIRED`: Reachable from a Composition Root. Requires 100% data-model and control-flow dissection (`components/comp-*.md` + `flows/flow-*.md`) and verified Read tool call trace.
- `ADAPTER_CONTRACT`: External SDKs, peripheral CLI/UI wrappers, or thin transport adapters. Extract public interface signatures and I/O schemas only.
- `DYNAMIC_GAP`: Modules wired exclusively via reflection, external DI XML/YAML, or runtime plugin loaders. Record the assumed entrypoint, `file:line` anchor, and runtime probe command.
- `UNWIRED_DEAD`: Physically present on disk with zero reverse dependencies (`rdeps == 0`) from any Composition Root or active build target. Isolate immediately to save tokens.

---

## 6. Architect Program Comprehension Epistemology

1. **Von Mayrhauser & Vans Integrated Metamodel:**
   - Switch deliberately across three mental representations:
     - **Top-Down Domain Model (Brooks / Soloway):** Scan for domain **beacons** (distinctive type names, structural signatures) confirming architectural hypotheses.
     - **Bottom-Up Program Model (Pennington):** Chunk low-level statements into control-flow abstractions.
     - **Situation Model:** Cross-reference control flow against real-world data mutations and state invariants.
2. **Data-First Mandate (Fred Brooks & Linus Torvalds):**
   - Dissect database tables, migrations, protobuf/JSON schemas, core structs, interfaces, and state machines in `architecture/data-dictionary.md` BEFORE tracing call graphs in `flows/flow-*.md`.
3. **Information Foraging Theory (Pirolli & Card / Ko & Burnett / Rein et al. 2025):**
   - Split `camelCase`, `PascalCase`, and `snake_case` identifiers into lexical **information scent** tokens (`getSafeXMLFeedURL` -> `get`, `safe`, `xml`, `feed`, `url`) to navigate high-scent patches with minimal hop cost.
   - Apply **Liveness & Enrichment** by pre-linking static `file:line` patches to runtime state transitions.
4. **Sillito's 44 Software Evolution Questions Across 4 Concentric Rings:**
   - **Ring 1 — Finding Initial Focus Points (5 Questions):** Which type or file represents this domain concept or API route? Does an exemplar precede this pattern?
   - **Ring 2 — Building on Focus Points (15 Questions):** What are the fields of this type? Which concrete structs implement this interface? Who calls this function (incoming) and what does it call (outgoing)?
   - **Ring 3 — Understanding a Subgraph (13 Questions):** How are these instances wired at bootstrap? How do data and control flow from Ingress A to Storage B? Under what guard condition is an error thrown?
   - **Ring 4 — Questions Over Groups of Subgraphs (11 Questions):** How does behavior vary across subtypes? How do two similar subsystems differ? What is the total blast radius (including Cross-Boundary Co-Change) of modifying this schema?

---

## 7. Cross-Platform CLI Stack Installation Matrix

Run `bash skills/map/scripts/recon-graphs.sh --doctor` to verify installed binaries:

| OS / Package Manager | 1-Line Installation Command |
| :--- | :--- |
| **Linux (Fedora / RHEL)** | `sudo dnf install -y ripgrep fd-find ctags jq python3 && npm i -g @ast-grep/cli` |
| **Linux (Ubuntu / Debian)** | `sudo apt install -y ripgrep fd-find universal-ctags jq python3 && npm i -g @ast-grep/cli` |
| **macOS (Homebrew)** | `brew install ripgrep fd universal-ctags ast-grep jq python` |
| **Windows (Winget)** | `winget install BurntSushi.ripgrep.MSVC sharkdp.fd UniversalCtags.Ctags ast-grep.ast-grep Python.Python.3.12` |

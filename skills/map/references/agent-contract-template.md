# Keystone Map — Root `AGENTS.md` Pointer Contract Template

Use this reference during **Step 3 (Final Closing Lock-In: Anchor `./AGENTS.md`)** of `keystone:map` so future AI sessions automatically know how to build, test, and navigate the repository via `docs/keystone-map/`.

## 1. Root `./AGENTS.md` Size & Sync Rules

1. **When creating a brand-new `./AGENTS.md`:** Keep the entire file **`< 100` lines** (and never exceed `300` lines even on large monorepos). Store only verified build/test commands, high-level module boundaries, core state invariants, entry-point `filename:line` pointers, and the `<!-- keystone-map:start -->` pointer block. Symlink or sync to `CLAUDE.md` and `GEMINI.md`.
2. **When `./AGENTS.md` already exists:** Never overwrite existing developer rules. Insert or update ONLY the **`<= 15`-line pointer block** wrapped between `<!-- keystone-map:start -->` and `<!-- keystone-map:end -->` (enforced by Gate 2 of `bash skills/map/scripts/validate-atlas.sh`).
3. **Ongoing Co-Change Rule Locking (`keystone:shield` / `.cursor/rules/<domain>.mdc`):** Keep root `AGENTS.md` focused on repository-wide orientation. When locking path-scoped Co-Change blast-radius rules after feature work, generate glob-scoped `.cursor/rules/<domain>.mdc` files (`alwaysApply: false`, `200–500` words; `< 200` words if `alwaysApply: true`).

## 2. Canonical `<!-- keystone-map:start -->` Pointer Block (`<= 15` Inner Lines)

```markdown
<!-- keystone-map:start -->
## Architecture Atlas & Codebase Navigation (`docs/keystone-map/`)
- **Overview & Entry Points:** `docs/keystone-map/00-INDEX.md`
- **100% Coverage Ledger:** `docs/keystone-map/01-coverage-ledger.md`
- **Data Schemas:** `docs/keystone-map/architecture/data-dictionary.md`
- **Wiring:** `docs/keystone-map/architecture/c2-wiring-and-containers.md`
- **Hotspots:** `docs/keystone-map/architecture/evolution-and-hotspots.md`
- **Build & Test:** `<verified build cmd>` | `<verified test cmd>`
- **Primary Composition Root:** `<path/to/main.ext:line>`
<!-- keystone-map:end -->
```

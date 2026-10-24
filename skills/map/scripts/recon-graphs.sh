#!/usr/bin/env bash
#
# Keystone Map — Phase 1 Cross-Platform Dual-Graph Reconnaissance Engine
# Supports Linux, macOS (Bash 3.2+), and Windows (Git Bash / MSYS2 / WSL).
# Uses Python 3 Standard Library (sqlite3, json, hashlib, pathlib, subprocess)
# + Native CLI Stack (git, rg, universal-ctags, ast-grep, scip, bazel/nx/turbo).
#
# Usage:
#   bash skills/map/scripts/recon-graphs.sh [target_repo_dir] [atlas_dir]
#   bash skills/map/scripts/recon-graphs.sh --doctor
set -euo pipefail

# Locate working Python 3 interpreter (avoiding Windows Store stub)
PYTHON_BIN=""
for candidate in python3 python; do
  if command -v "$candidate" >/dev/null 2>&1; then
    if "$candidate" -c "import sys, sqlite3, json; assert sys.version_info >= (3, 7)" >/dev/null 2>&1; then
      PYTHON_BIN="$candidate"
      break
    fi
  fi
done

if [[ -z "$PYTHON_BIN" ]]; then
  echo "ERROR: Python 3.7+ (with sqlite3 and json stdlib) is required." >&2
  exit 1
fi

exec "$PYTHON_BIN" - "$@" << 'PYEOF'
import ast
import hashlib
import json
import math
import os
import re
import shutil
import sqlite3
import subprocess
import sys
from pathlib import Path


def run_cmd(args, cwd=None):
    try:
        res = subprocess.run(
            args,
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
        return res.returncode, res.stdout.replace("\r\n", "\n").replace("\x00", "")
    except Exception:
        return 1, ""


def probe_oracles():
    oracles = {}
    for tool in ["git", "rg", "fd", "ast-grep", "scip", "bazel", "nx", "turbo"]:
        path = shutil.which(tool)
        oracles[tool] = {"available": bool(path), "path": path or ""}

    # Verify Universal Ctags specifically (avoid macOS BSD /usr/bin/ctags trap)
    ctags_path = shutil.which("ctags") or shutil.which("universal-ctags")
    is_universal = False
    ctags_ver = ""
    if ctags_path:
        rc, out = run_cmd([ctags_path, "--version"])
        if rc == 0 and "Universal Ctags" in out:
            is_universal = True
            ctags_ver = out.splitlines()[0] if out.splitlines() else "Universal Ctags"
    oracles["universal-ctags"] = {
        "available": is_universal,
        "path": ctags_path if is_universal else "",
        "version": ctags_ver,
    }
    return oracles


def print_doctor():
    oracles = probe_oracles()
    print("===========================================================================")
    print("KEYSTONE:MAP TOOLCHAIN DOCTOR (LINUX / MACOS / WINDOWS)")
    print("===========================================================================")
    print(f"  [OK]       Python 3 Stdlib  : {sys.version.split()[0]} ({sys.executable})")
    for name, info in oracles.items():
        status = "[OK]      " if info["available"] else "[OPTIONAL]"
        detail = info.get("version") or info.get("path") or "missing (fallback active)"
        print(f"  {status} {name:<16} : {detail}")
    print("\n--- Recommended 1-Line Install Commands by OS ---")
    print("  Linux (Fedora/RHEL) : sudo dnf install -y ripgrep fd-find ctags jq && npm i -g @ast-grep/cli")
    print("  Linux (Ubuntu/Deb)  : sudo apt install -y ripgrep fd-find universal-ctags jq && npm i -g @ast-grep/cli")
    print("  macOS (Homebrew)    : brew install ripgrep fd universal-ctags ast-grep jq")
    print("  Windows (Winget)    : winget install BurntSushi.ripgrep.MSVC sharkdp.fd UniversalCtags.Ctags ast-grep.ast-grep")
    print("===========================================================================")


NON_CODE_EXTS = (
    ".json", ".md", ".mdx", ".txt", ".yaml", ".yml", ".toml",
    ".svg", ".png", ".jpg", ".gif", ".csv", ".html", ".css",
)
NON_CODE_KINDS = {
    "package", "module", "import", "unknown", "heredoc", "section",
    "chapter", "subsection", "subsubsection", "l4subsection", "target",
    "key", "string", "array", "object", "number", "boolean",
    "property", "anonmember", "variable", "constant", "local", "var",
    "field", "enumerator", "externvar", "macro", "alias", "namespace",
}


def extract_symbols_fallback(rel_path, content):
    if rel_path.lower().endswith(NON_CODE_EXTS):
        return []
    tags = []
    lines = content.splitlines()
    if rel_path.endswith(".py"):
        try:
            tree = ast.parse(content)
            for node in ast.walk(tree):
                if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
                    kind = "class" if isinstance(node, ast.ClassDef) else "func"
                    end_ln = getattr(node, "end_lineno", node.lineno)
                    sig = lines[node.lineno - 1].strip() if node.lineno <= len(lines) else node.name
                    tags.append({
                        "rel_fname": rel_path,
                        "line": node.lineno,
                        "end_line": end_ln,
                        "name": node.name,
                        "kind": kind,
                        "role": "def",
                        "signature": sig,
                    })
                elif isinstance(node, ast.ImportFrom) and node.module:
                    tags.append({
                        "rel_fname": rel_path,
                        "line": getattr(node, "lineno", 1),
                        "end_line": getattr(node, "lineno", 1),
                        "name": node.module,
                        "kind": "module",
                        "role": "imported",
                        "signature": f"from {node.module}",
                    })
            return tags
        except Exception:
            pass

    def_pat = re.compile(
        r"^\s*(?:export\s+)?(?:public\s+|private\s+|protected\s+)?(?:async\s+)?"
        r"(func|type|struct|interface|class|def|fn|pub\s+fn|pub\s+struct|pub\s+enum|pub\s+trait|function)\s+"
        r"(?:\([^)]+\)\s*)?([A-Za-z_][A-Za-z0-9_]*)"
    )
    sh_fn_pat = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*\(\)\s*\{")
    imp_pat = re.compile(
        r"""(?:import\s+.*?from\s+['"]([^'"]+)['"]|^\s*import\s+['"]([^'"]+)['"]|^\s*["']([a-zA-Z0-9_./-]+/[a-zA-Z0-9_./-]+)["']|^\s*use\s+([a-zA-Z0-9_:]+)|^\s*from\s+([a-zA-Z0-9_.]+)\s+import)"""
    )
    for idx, line in enumerate(lines, start=1):
        m_def = def_pat.search(line)
        if m_def:
            tags.append({
                "rel_fname": rel_path,
                "line": idx,
                "end_line": idx,
                "name": m_def.group(2),
                "kind": m_def.group(1).split()[-1],
                "role": "def",
                "signature": line.strip()[:140],
            })
        elif rel_path.endswith((".sh", ".bash", ".js", ".ts")):
            m_sh = sh_fn_pat.search(line)
            if m_sh and m_sh.group(1) not in ("if", "for", "while", "switch", "catch"):
                tags.append({
                    "rel_fname": rel_path,
                    "line": idx,
                    "end_line": idx,
                    "name": m_sh.group(1),
                    "kind": "func",
                    "role": "def",
                    "signature": line.strip()[:140],
                })
        for m_imp in imp_pat.finditer(line):
            imp_target = next((g for g in m_imp.groups() if g), None)
            if imp_target:
                tags.append({
                    "rel_fname": rel_path,
                    "line": idx,
                    "end_line": idx,
                    "name": imp_target,
                    "kind": "import",
                    "role": "imported",
                    "signature": line.strip()[:140],
                })
    return tags


def main():
    args = sys.argv[1:]
    if "--doctor" in args:
        print_doctor()
        return

    target_dir = Path(args[0] if len(args) >= 1 else ".").resolve()
    atlas_arg = args[1] if len(args) >= 2 else "docs/keystone-map"
    atlas_dir = Path(atlas_arg) if Path(atlas_arg).is_absolute() else (target_dir / atlas_arg)

    if not target_dir.is_dir():
        print(f"ERROR: Target directory does not exist: {target_dir}", file=sys.stderr)
        sys.exit(1)

    rc, _ = run_cmd(["git", "rev-parse", "--is-inside-work-tree"], cwd=target_dir)
    if rc != 0:
        print(f"ERROR: {target_dir} is not a Git work tree.", file=sys.stderr)
        sys.exit(1)

    oracles = probe_oracles()
    _, head_sha = run_cmd(["git", "rev-parse", "--short=12", "HEAD"], cwd=target_dir)
    head_sha = head_sha.strip() or "UNCOMMITTED"
    _, root_tree = run_cmd(["git", "rev-parse", "--short=12", "HEAD^{tree}"], cwd=target_dir)
    root_tree = root_tree.strip() or "NO_TREE"

    _, ls_files_out = run_cmd(["git", "ls-files"], cwd=target_dir)
    tracked_files = [
        f.strip()
        for f in ls_files_out.splitlines()
        if f.strip() and not f.strip().startswith((".keystone/", ".superpowers/"))
    ]

    # Step 6B Pre-calculation: Cross-Boundary Co-Change & Author Fractal Metadata in 1 pass
    _, log_cochange = run_cmd(
        ["git", "log", "--no-merges", "-M", "--diff-filter=M", "-n", "300", "--name-only", "--pretty=format:---COMMIT---|%cs|%ae"],
        cwd=target_dir,
    )
    lock_re = re.compile(
        r"(^\.keystone/|^\.superpowers/|\.lock$|package-lock\.json$|pnpm-lock\.yaml$|go\.sum$|\.min\.js$|\.svg$|\.png$|\.sqlite$|\.cache\.v1$)"
    )
    cochange_pairs = {}
    mod_cochange_neighbors = {}
    mod_last_touch = {}
    mod_authors = {}
    curr_batch = []
    curr_date = ""
    curr_author = ""

    def process_batch(batch, c_date, c_author):
        clean = sorted(set(f for f in batch if not lock_re.search(f)))
        touched_mods = set()
        for f in clean:
            if "/" in f:
                top_m = f.split("/")[0]
                touched_mods.add(top_m)
        for tm in touched_mods:
            if c_date and tm not in mod_last_touch:
                mod_last_touch[tm] = c_date
            if c_author:
                mod_authors.setdefault(tm, []).append(c_author)
        if 1 < len(clean) <= 20:
            for i in range(len(clean)):
                for j in range(i + 1, len(clean)):
                    f1, f2 = clean[i], clean[j]
                    dir1 = os.path.dirname(f1) or "."
                    dir2 = os.path.dirname(f2) or "."
                    if dir1 != dir2:
                        key = f"{f1} <-> {f2}"
                        cochange_pairs[key] = cochange_pairs.get(key, 0) + 1
                        top1 = f1.split("/")[0] if "/" in f1 else "."
                        top2 = f2.split("/")[0] if "/" in f2 else "."
                        if top1 != top2:
                            mod_cochange_neighbors.setdefault(top1, set()).add(top2)
                            mod_cochange_neighbors.setdefault(top2, set()).add(top1)

    for ln in log_cochange.splitlines():
        if ln.startswith("---COMMIT---|"):
            process_batch(curr_batch, curr_date, curr_author)
            curr_batch = []
            meta_parts = ln.split("|", 2)
            curr_date = meta_parts[1].strip() if len(meta_parts) > 1 else ""
            curr_author = meta_parts[2].strip() if len(meta_parts) > 2 else ""
        elif ln.strip():
            curr_batch.append(ln.strip())
    process_batch(curr_batch, curr_date, curr_author)

    # Step 1: Content-Addressable Git Tree Ledger & Incremental Staleness
    ledger_path = atlas_dir / "01-coverage-ledger.md"
    ledger_text = ledger_path.read_text(encoding="utf-8", errors="replace") if ledger_path.is_file() else ""
    _, ls_tree_out = run_cmd(["git", "ls-tree", "HEAD"], cwd=target_dir)

    top_entries = []
    stale_modules = set()
    for ln in ls_tree_out.splitlines():
        parts = ln.split(None, 3)
        if len(parts) < 4:
            continue
        _mode, obj_type, obj_hash, obj_path = parts
        if obj_path in (".keystone", ".superpowers"):
            continue
        short_hash = obj_hash[:12]
        status = "NEW_SCAN"
        if ledger_text:
            # Check if table row for obj_path has matching hash (supporting dot-prefixed entries)
            row_re = re.compile(
                rf"^\|[^|\n]*?[|`\s]{re.escape(obj_path)}[|`\s/].*?\b([0-9a-f]{{7,40}})\b",
                re.MULTILINE,
            )
            m_row = row_re.search(ledger_text)
            if m_row:
                recorded_hash = m_row.group(1)
                if obj_hash.startswith(recorded_hash) or recorded_hash.startswith(short_hash[:7]):
                    status = "UNCHANGED"
                else:
                    status = "STALE_HASH"
                    stale_modules.add(obj_path)
        top_entries.append({
            "path": obj_path,
            "type": obj_type,
            "git_hash": short_hash,
            "status": status,
        })

    # Propagate STALE_COCHANGE across coupled top-level directories
    for entry in top_entries:
        if entry["status"] == "UNCHANGED":
            neighbors = mod_cochange_neighbors.get(entry["path"], set())
            if neighbors.intersection(stale_modules):
                entry["status"] = "STALE_COCHANGE"

    top_dirs = [e["path"] for e in top_entries if e["type"] == "tree"]

    # Step 2: Manifests, Build Graph & SCIP Phase-1 Join Probe
    manifest_re = re.compile(
        r"(^|/)(go\.(mod|work)|Cargo\.toml|package\.json|pnpm-workspace\.yaml|turbo\.json|"
        r"nx\.json|lerna\.json|pyproject\.toml|setup\.py|requirements\.txt|pom\.xml|"
        r"build\.gradle(\.kts)?|CMakeLists\.txt|Makefile|WORKSPACE(\.bazel)?|MODULE\.bazel|"
        r"BUILD(\.bazel)?|Dockerfile|docker-compose\.ya?ml|plugin\.json|gemini-extension\.json)$"
    )
    manifests = [f for f in tracked_files if manifest_re.search(f)]

    scip_candidates = list(target_dir.glob("*.scip")) + list(target_dir.glob("*/*.scip"))
    scip_status = "BLOCKED_ORACLE"
    scip_fingerprint = ""
    scip_occurrences = []
    if scip_candidates:
        scip_file = scip_candidates[0]
        raw_bytes = scip_file.read_bytes()
        scip_fingerprint = hashlib.sha256(raw_bytes).hexdigest()[:12]
        scip_status = "SCIP_ACTIVE"
        try:
            parsed_scip = json.loads(raw_bytes.decode("utf-8", errors="ignore"))
            if isinstance(parsed_scip, dict) and "occurrences" in parsed_scip:
                scip_occurrences = parsed_scip["occurrences"]
        except Exception:
            pass

    # Step 3: Composition Roots & Entrypoints (fast git grep with Python fallback)
    comp_pattern = (
        r"(func[[:space:]]+main[[:space:]]*\(|if[[:space:]]+__name__[[:space:]]*==[[:space:]]*['\"]__main__['\"]|"
        r"fn[[:space:]]+main[[:space:]]*\(|public[[:space:]]+static[[:space:]]+void[[:space:]]+main|"
        r"NestFactory\.create|FastAPI\(|express\(|http\.ListenAndServe|fx\.New\(|wire\.Build\(|"
        r"cobra\.Command|createServer\(|registerCommand\()"
    )
    composition_roots = []
    rc_grep, grep_out = run_cmd(["git", "grep", "-nI", "-E", comp_pattern], cwd=target_dir)
    if rc_grep in (0, 1) and grep_out:
        for gln in grep_out.splitlines():
            gparts = gln.split(":", 2)
            if len(gparts) == 3 and gparts[1].isdigit():
                rel_f, idx_s, snip = gparts[0], gparts[1], gparts[2]
                if any(p in rel_f for p in ("test", "vendor/", "node_modules/", ".md", "skills/map/", ".keystone/")):
                    continue
                composition_roots.append({
                    "file": rel_f,
                    "line": int(idx_s),
                    "snippet": snip.strip()[:120],
                })
                if len(composition_roots) >= 40:
                    break

    # Pre-calculate Step 5 Churn Stats early so Hotspots feed AST candidate selection
    _, tags_out = run_cmd(
        ["git", "tag", "-l", "--sort=-creatordate", "--format=%(refname:short) | %(creatordate:short) | %(subject)"],
        cwd=target_dir,
    )
    release_tags = [ln.strip() for ln in tags_out.splitlines() if ln.strip()][:10]

    _, numstat_out = run_cmd(
        ["git", "log", "--no-merges", "--diff-filter=M", "-n", "300", "--pretty=format:", "--numstat"],
        cwd=target_dir,
    )
    churn_stats = {}
    for ln in numstat_out.splitlines():
        parts = ln.split("\t")
        if len(parts) == 3 and parts[0].isdigit() and parts[1].isdigit():
            adds, dels, fpath = int(parts[0]), int(parts[1]), parts[2].strip()
            if lock_re.search(fpath):
                continue
            st = churn_stats.setdefault(fpath, {"commits": 0, "adds": 0, "dels": 0})
            st["commits"] += 1
            st["adds"] += adds
            st["dels"] += dels

    # Step 4 & Step 7: SQLite Tag Cache (.repomap.tags.cache.v1) + 6-Phase PageRank Skeletonizer
    cache_dir = target_dir / ".keystone" / "cache"
    tmp_dir = target_dir / ".keystone" / "tmp"
    cache_dir.mkdir(parents=True, exist_ok=True)
    tmp_dir.mkdir(parents=True, exist_ok=True)
    db_path = cache_dir / "repomap.tags.cache.v1"

    conn = sqlite3.connect(str(db_path))
    cur = conn.cursor()
    cur.execute(
        """CREATE TABLE IF NOT EXISTS tags (
            rel_fname TEXT,
            fname TEXT,
            line INTEGER,
            end_line INTEGER,
            name TEXT,
            kind TEXT,
            role TEXT,
            signature TEXT,
            blob_hash TEXT
        )"""
    )
    cur.execute(
        """CREATE TABLE IF NOT EXISTS edge_oracle (
            scip_fingerprint TEXT,
            source_file TEXT,
            line INTEGER,
            symbol TEXT,
            target_file TEXT,
            matched_ast INTEGER
        )"""
    )

    _, ls_stage_out = run_cmd(["git", "ls-files", "-s"], cwd=target_dir)
    file_blobs = {}
    exec_files = []
    for ln in ls_stage_out.splitlines():
        parts = ln.split(None, 3)
        if len(parts) == 4:
            mode, blob_h, _stage, rpath = parts
            file_blobs[rpath] = blob_h[:12]
            if mode == "100755" and not rpath.startswith((".keystone/", ".superpowers/")):
                exec_files.append(rpath)

    # Select priority candidate files for AST/PageRank when repository has > 250 files
    priority_set = (
        {c["file"] for c in composition_roots}
        | set(exec_files[:40])
        | set(sorted(churn_stats.keys(), key=lambda k: -churn_stats[k]["commits"])[:80])
    )
    ast_candidates = []
    for rel_f in tracked_files:
        if lock_re.search(rel_f):
            continue
        if rel_f in priority_set:
            ast_candidates.append(rel_f)
    for rel_f in tracked_files:
        if len(ast_candidates) >= 220:
            break
        if rel_f in priority_set or lock_re.search(rel_f) or rel_f.lower().endswith(NON_CODE_EXTS):
            continue
        if any(p in rel_f for p in ("tests/", "contributors/", "node_modules/", "vendor/", "website/")):
            continue
        ast_candidates.append(rel_f)
    if len(tracked_files) <= 220:
        ast_candidates = [f for f in tracked_files if not lock_re.search(f)]

    # Bulk load cached SQLite tags in 1 query
    cur.execute("SELECT rel_fname, blob_hash, line, end_line, name, kind, role, signature FROM tags")
    cached_by_key = {}
    for r in cur.fetchall():
        cached_by_key.setdefault((r[0], r[1]), []).append({
            "rel_fname": r[0],
            "line": r[2],
            "end_line": r[3],
            "name": r[4],
            "kind": r[5],
            "role": r[6],
            "signature": r[7],
        })

    file_loc = {}
    file_contents = {}
    all_tags = []
    uncached_files = []
    use_ctags = oracles["universal-ctags"]["available"]
    ctags_bin = oracles["universal-ctags"]["path"]

    for rel_f in ast_candidates:
        fpath = target_dir / rel_f
        if not fpath.is_file():
            continue
        try:
            content = fpath.read_text(encoding="utf-8", errors="replace")
        except Exception:
            continue
        file_loc[rel_f] = len(content.splitlines())
        file_contents[rel_f] = content
        blob_h = file_blobs.get(rel_f) or hashlib.sha1(content.encode("utf-8", errors="ignore")).hexdigest()[:12]
        if (rel_f, blob_h) in cached_by_key:
            all_tags.extend(cached_by_key[(rel_f, blob_h)])
        else:
            uncached_files.append((rel_f, fpath, blob_h, content))

    # Batch run ctags in a single subprocess across all uncached code files
    ctags_by_file = {}
    if use_ctags and uncached_files:
        ctags_targets = [
            str(fpath) for rel_f, fpath, _bh, _c in uncached_files if not rel_f.lower().endswith(NON_CODE_EXTS)
        ]
        if ctags_targets:
            try:
                proc = subprocess.run(
                    [ctags_bin, "--output-format=json", "--fields=+neKzSr", "--extras=+r", "-L", "-", "-f", "-"],
                    input="\n".join(ctags_targets),
                    cwd=str(target_dir),
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    universal_newlines=True,
                    timeout=15,
                )
                if proc.returncode == 0 and proc.stdout:
                    for cln in proc.stdout.splitlines():
                        try:
                            obj = json.loads(cln)
                            if obj.get("_type") != "tag":
                                continue
                            kind_val = obj.get("kind", "sym").lower()
                            if kind_val in NON_CODE_KINDS:
                                continue
                            raw_path = obj.get("path", "")
                            try:
                                rel_p = Path(raw_path).resolve().relative_to(target_dir).as_posix()
                            except Exception:
                                rel_p = raw_path
                            ln_no = int(obj.get("line", 1))
                            end_no = int(obj.get("end", ln_no))
                            sig = obj.get("signature", "")
                            tref = obj.get("typeref", "").replace("typename:", "")
                            pat = obj.get("pattern", "").strip("/^$")
                            full_sig = f"{obj.get('kind', 'sym')} {obj.get('name', '')}{sig}"
                            if tref:
                                full_sig += f" -> {tref}"
                            elif pat:
                                full_sig = pat.strip()[:140]
                            ctags_by_file.setdefault(rel_p, []).append({
                                "rel_fname": rel_p,
                                "line": ln_no,
                                "end_line": end_no,
                                "name": obj.get("name", ""),
                                "kind": kind_val,
                                "role": obj.get("roles", "def"),
                                "signature": full_sig,
                            })
                        except Exception:
                            pass
            except Exception:
                pass

    rows_to_insert = []
    if uncached_files:
        cur.executemany("DELETE FROM tags WHERE rel_fname=?", [(u[0],) for u in uncached_files])
        for rel_f, fpath, blob_h, content in uncached_files:
            extracted = list(ctags_by_file.get(rel_f, []))
            fb_tags = extract_symbols_fallback(rel_f, content)
            seen_keys = {(t["line"], t["name"], t["role"]) for t in extracted}
            for ft in fb_tags:
                if (ft["line"], ft["name"], ft["role"]) not in seen_keys:
                    extracted.append(ft)
            for t in extracted:
                rows_to_insert.append(
                    (rel_f, str(fpath), t["line"], t["end_line"], t["name"], t["kind"], t["role"], t["signature"], blob_h)
                )
                all_tags.append(t)
        if rows_to_insert:
            cur.executemany("INSERT INTO tags VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", rows_to_insert)

    # Phase 2 & 3: Dependency Graph + Weighted PageRank (10 iterations, d=0.85)
    defs_by_name = {}
    defs_by_dir = {}
    for t in all_tags:
        if t["role"] == "def" and t["kind"].lower() not in NON_CODE_KINDS:
            defs_by_name.setdefault(t["name"], set()).add(t["rel_fname"])
            parent_dir = os.path.dirname(t["rel_fname"])
            if parent_dir:
                defs_by_dir.setdefault(parent_dir, set()).add(t["rel_fname"])

    nodes = sorted(file_loc.keys())
    out_edges = {u: set() for u in nodes}
    for t in all_tags:
        src = t["rel_fname"]
        if src not in out_edges:
            continue
        if t["role"] == "imported":
            imp_name = t["name"]
            for dpath, dfiles in defs_by_dir.items():
                if imp_name.endswith(dpath) or imp_name.split("/")[-1] == dpath.split("/")[-1]:
                    for df in dfiles:
                        if df != src:
                            out_edges[src].add(df)
        for target_f in defs_by_name.get(t["name"], set()):
            if target_f != src:
                out_edges[src].add(target_f)

    # Scan symbol references across already-loaded file_contents
    for rel_f, txt in file_contents.items():
        words = set(re.findall(r"\b[A-Za-z_][A-Za-z0-9_]{2,}\b", txt))
        for w in words:
            if w in defs_by_name:
                for df in defs_by_name[w]:
                    if df != rel_f:
                        out_edges[rel_f].add(df)

    # SCIP Phase-1 Join (identifier-token containment against AST edges)
    cur.execute("DELETE FROM edge_oracle")
    matched_oracle = 0
    for occ in scip_occurrences:
        s_file = occ.get("file", "")
        s_line = int(occ.get("line", 0))
        s_sym = occ.get("symbol", "")
        t_file = occ.get("target", "")
        is_matched = 1 if (t_file in out_edges.get(s_file, set()) or s_sym in defs_by_name) else 0
        matched_oracle += is_matched
        cur.execute(
            "INSERT INTO edge_oracle VALUES (?, ?, ?, ?, ?, ?)",
            (scip_fingerprint, s_file, s_line, s_sym, t_file, is_matched),
        )
        if s_file in out_edges and t_file in out_edges:
            out_edges[s_file].add(t_file)
    conn.commit()
    conn.close()

    n_nodes = max(len(nodes), 1)
    comp_files = {c["file"] for c in composition_roots} | set(exec_files) | set(manifests)
    pr = {u: (2.0 / n_nodes if u in comp_files else 1.0 / n_nodes) for u in nodes}
    damping = 0.85
    for _ in range(10):
        next_pr = {u: (1.0 - damping) / n_nodes for u in nodes}
        for u in nodes:
            targets = out_edges[u]
            if targets:
                share = damping * pr[u] / len(targets)
                for v in targets:
                    next_pr[v] = next_pr.get(v, 0.0) + share
        pr = next_pr

    # Phase 4 & 5: Signature Elision & Binary-Search Token Budgeting (~1,000 tokens = ~4,000 chars)
    raw_def_tags = []
    seen_def_lines = set()
    for t in all_tags:
        if t["role"] == "def" and t["kind"].lower() not in NON_CODE_KINDS:
            line_key = (t["rel_fname"], t["line"])
            if line_key not in seen_def_lines:
                seen_def_lines.add(line_key)
                raw_def_tags.append(t)
    raw_def_tags.sort(key=lambda t: (-pr.get(t["rel_fname"], 0.0), t["rel_fname"], t["line"]))
    def_tags = []
    per_file_counts = {}
    for t in raw_def_tags:
        rf = t["rel_fname"]
        if per_file_counts.get(rf, 0) < 6:
            per_file_counts[rf] = per_file_counts.get(rf, 0) + 1
            def_tags.append(t)

    def format_tag(t):
        rank_val = pr.get(t["rel_fname"], 0.0)
        return f"{t['rel_fname']}:{t['line']}-{t['end_line']} [PR={rank_val:.4f}] {t['signature']}"

    budget_tokens = 1000
    lo, hi = 0, len(def_tags)
    best_k = min(len(def_tags), 25)
    while lo <= hi:
        mid = (lo + hi) // 2
        approx_tokens = sum(len(format_tag(t)) for t in def_tags[:mid]) // 4
        if approx_tokens <= budget_tokens:
            best_k = mid
            lo = mid + 1
        else:
            hi = mid - 1
    skeleton_selected = [
        {
            "coord": f"{t['rel_fname']}:{t['line']}-{t['end_line']}",
            "pagerank": round(pr.get(t["rel_fname"], 0.0), 4),
            "name": t["name"],
            "kind": t["kind"],
            "signature": t["signature"],
        }
        for t in def_tags[:best_k]
    ]

    # Step 5: Graph 2A — Top 20 True Churn Hotspots (using pre-calculated churn_stats)
    hotspots = []
    for fpath, st in churn_stats.items():
        loc = file_loc.get(fpath, 0)
        if loc == 0 and (target_dir / fpath).is_file():
            try:
                loc = len((target_dir / fpath).read_text(encoding="utf-8", errors="replace").splitlines())
            except Exception:
                loc = 0
        hotspots.append({
            "file": fpath,
            "commits": st["commits"],
            "adds": st["adds"],
            "dels": st["dels"],
            "curr_loc": loc,
        })
    hotspots.sort(key=lambda x: (-x["commits"], -(x["adds"] + x["dels"]), -x["curr_loc"]))
    hotspots = hotspots[:20]

    # Tornhill Unhealthy Code Token Tax Candidates (high LOC / high churn with AST function slices)
    largest_files = sorted(file_loc.items(), key=lambda kv: (-kv[1], kv[0]))[:20]
    unhealthy_candidates = []
    for fpath, loc in largest_files[:10]:
        slices = [
            f"{t['rel_fname']}:{t['line']}-{t['end_line']} ({t['name']})"
            for t in def_tags
            if t["rel_fname"] == fpath
        ][:5]
        unhealthy_candidates.append({"file": fpath, "loc": loc, "ast_slices": slices})

    # Step 6: Module Code Age & Author Fractal Value F = 1 - sum((c_i / C)^2)
    module_fractal = []
    for mod in top_dirs:
        last_dt = mod_last_touch.get(mod, "")
        authors = mod_authors.get(mod, [])
        if not authors:
            _, last_dt_out = run_cmd(["git", "log", "-1", "--format=%cs", "--", mod], cwd=target_dir)
            last_dt = last_dt_out.strip()
            _, authors_out = run_cmd(["git", "log", "--no-merges", "-n", "100", "--format=%ae", "--", mod], cwd=target_dir)
            authors = [a.strip() for a in authors_out.splitlines() if a.strip()]
        total_c = len(authors)
        if total_c == 0:
            fractal_f = 0.0
            top_pct = 0
        else:
            counts = {}
            for a in authors:
                counts[a] = counts.get(a, 0) + 1
            sum_sq = sum((c / total_c) ** 2 for c in counts.values())
            fractal_f = max(0.0, round(1.0 - sum_sq, 2))
            top_pct = int(round((max(counts.values()) / total_c) * 100))
        module_fractal.append({
            "module": mod,
            "last_touch": last_dt or "N/A",
            "commits": total_c,
            "top_owner_pct": f"{top_pct}%",
            "fractal_value": fractal_f,
        })

    top_cochanges = [
        {"pair": k, "co_changes": v}
        for k, v in sorted(cochange_pairs.items(), key=lambda kv: (-kv[1], kv[0]))[:15]
    ]

    edge_oracle_stats = {
        "scip_status": scip_status,
        "scip_content_fingerprint": scip_fingerprint,
        "scip_occurrences_total": len(scip_occurrences),
        "ast_matched_occurrences": matched_oracle,
        "recall": round(matched_oracle / len(scip_occurrences), 4) if scip_occurrences else None,
    }

    oracles["scip_status"] = scip_status
    oracles["scip_content_fingerprint"] = scip_fingerprint
    oracles["edge_oracle_stats"] = edge_oracle_stats

    raw_payload = {
        "repo_root": str(target_dir),
        "head_commit": head_sha,
        "root_tree_hash": root_tree,
        "n_total_files": len(tracked_files),
        "n_total_top_dirs": len(top_dirs),
        "top_level_entries": top_entries,
        "oracles": oracles,
        "edge_oracle_stats": edge_oracle_stats,
        "manifests": manifests,
        "composition_roots": composition_roots,
        "executable_entrypoints": exec_files,
        "skeleton_pagerank": skeleton_selected,
        "unhealthy_token_tax_candidates": unhealthy_candidates,
        "release_tags": release_tags,
        "hotspots": hotspots,
        "co_changes": top_cochanges,
        "module_fractal": module_fractal,
    }
    (tmp_dir / "recon-raw.json").write_text(json.dumps(raw_payload, indent=2), encoding="utf-8")

    # Format concise stdout report for Main Agent
    print("===========================================================================")
    print("KEYSTONE:MAP PHASE 1 — DUAL-GRAPH RECONNAISSANCE")
    print("===========================================================================")
    print(f"repo_root      : {target_dir}")
    print(f"head_commit    : {head_sha}")
    print(f"root_tree_hash : {root_tree}")
    print(f"total_files    : {len(tracked_files)} (N_total tracked files)")
    print(f"top_level_dirs : {len(top_dirs)} (N_total top-level module buckets)")
    print(f"scip_oracle    : {scip_status}" + (f" (fingerprint: {scip_fingerprint})" if scip_fingerprint else " (install scip-* indexer for Tier-3 compiler oracle)"))
    print("")

    print("=== [1/7] CONTENT-ADDRESSABLE GIT TREE LEDGER (HEAD) ===")
    print(f"{'STATUS':<15} | {'TYPE':<6} | {'GIT_HASH':<12} | MODULE_OR_FILE")
    print(f"{'-'*15}-+-{'-'*6}-+-{'-'*12}-+-{'-'*30}")
    for e in top_entries:
        print(f"{e['status']:<15} | {e['type']:<6} | {e['git_hash']:<12} | {e['path']}")
    print("")

    print("=== [2/7] GRAPH 1A: MANIFESTS, MONOREPO BUILD GRAPH & SCIP ORACLE ===")
    for m in manifests[:30]:
        print(f"  [MANIFEST] {m}")
    print(f"  [ORACLE]   scip_status={scip_status} matched={matched_oracle}/{len(scip_occurrences)}")
    print("")

    print("=== [3/7] GRAPH 1B: COMPOSITION ROOTS & WIRING ENTRYPOINTS ===")
    for c in composition_roots[:30]:
        print(f"  {c['file']}:{c['line']} -> {c['snippet']}")
    for ex in exec_files[:20]:
        print(f"  [EXEC] {ex}")
    print("")

    print("=== [4/7] GRAPH 1C: LARGEST FILES (TORNHILL TOKEN TAX CANDIDATES) ===")
    for item in unhealthy_candidates[:15]:
        slice_str = ", ".join(item["ast_slices"][:3]) if item["ast_slices"] else "no AST slices"
        print(f"  {item['loc']:>6} LOC | {item['file']} [Slices: {slice_str}]")
    print("")

    print("=== [5/7] GRAPH 2A: RELEASE TAGS & TOP 20 TRUE CHURN HOTSPOTS ===")
    for rt in release_tags:
        print(f"  [TAG] {rt}")
    print(f"{'COMMITS':<8} | {'+ADDS':<8} | {'-DELS':<8} | {'CURR_LOC':<8} | FILE_PATH")
    print(f"{'-'*8}-+-{'-'*8}-+-{'-'*8}-+-{'-'*8}-+-{'-'*30}")
    for h in hotspots:
        print(f"{h['commits']:<8} | +{h['adds']:<7} | -{h['dels']:<7} | {h['curr_loc']:<8} | {h['file']}")
    print("")

    print("=== [6/7] GRAPH 2B: CROSS-BOUNDARY CO-CHANGE (A <-> B) & FRACTAL VALUE ===")
    for cc in top_cochanges:
        print(f"  {cc['co_changes']:>4} co-changes | {cc['pair']}")
    print("")
    print(f"{'LAST_TOUCH':<12} | {'COMMITS':<8} | {'TOP_OWN%':<8} | {'FRACTAL_F':<9} | MODULE_PATH")
    print(f"{'-'*12}-+-{'-'*8}-+-{'-'*8}-+-{'-'*9}-+-{'-'*24}")
    for mf in module_fractal:
        print(f"{mf['last_touch']:<12} | {mf['commits']:<8} | {mf['top_owner_pct']:<8} | {mf['fractal_value']:<9.2f} | {mf['module']}/")
    print("")

    print("=== [7/7] 6-PHASE PAGERANK SKELETON (~1,000 TOKEN BUDGET) ===")
    for s in skeleton_selected[:40]:
        print(f"  [PR={s['pagerank']:.4f}] {s['coord']} :: {s['signature']}")
    print("===========================================================================")


if __name__ == "__main__":
    main()
PYEOF

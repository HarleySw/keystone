#!/usr/bin/env bash
#
# Keystone Map — Phase 3 & Exit Gate Deterministic Atlas Validator
# Verifies:
#   Gate 1: Mandatory 6-Tier Multi-File Atlas Hierarchy
#   Gate 2: Group 1 Routing Index & Agent Config Caps (00-INDEX.md <=150L, AGENTS.md ptr <=15L; Group 2 uncapped)
#   Gate 3: 100% Denominator Coverage & 4-Bucket Accounting in 01-coverage-ledger.md
#   Gate 4: Zero-Hallucination file:line Coordinates & Relative Link Integrity
#   Gate 5: Required Semantic Markers (RAD-AI E1, QOC/ATAM, Zeller 4-Link + Dry-Run)
#   Gate 6: Optional Execution Trace Verification (--trace <trace.jsonl> for Issue #584)
#
# Usage:
#   bash skills/map/scripts/validate-atlas.sh [atlas_dir] [repo_root] [--trace <trace_file>]
set -euo pipefail

PYTHON_BIN=""
for candidate in python3 python; do
  if command -v "$candidate" >/dev/null 2>&1; then
    if "$candidate" -c "import sys, json, re; assert sys.version_info >= (3, 7)" >/dev/null 2>&1; then
      PYTHON_BIN="$candidate"
      break
    fi
  fi
done

if [[ -z "$PYTHON_BIN" ]]; then
  echo "ERROR: Python 3.7+ is required to run validate-atlas.sh." >&2
  exit 1
fi

exec "$PYTHON_BIN" - "$@" << 'PYEOF'
import os
import re
import subprocess
import sys
from pathlib import Path


def run_git_dirs(repo_root):
    try:
        res = subprocess.run(
            ["git", "ls-tree", "-d", "--name-only", "HEAD"],
            cwd=repo_root,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
        if res.returncode != 0:
            return []
        ignored = {".github", ".vscode", ".idea", "docs", ".keystone", ".superpowers"}
        return [
            d.strip()
            for d in res.stdout.replace("\r\n", "\n").splitlines()
            if d.strip() and d.strip() not in ignored
        ]
    except Exception:
        return []


def main():
    args = sys.argv[1:]
    trace_file = None
    positional = []
    i = 0
    while i < len(args):
        if args[i] == "--trace" and i + 1 < len(args):
            trace_file = Path(args[i + 1]).resolve()
            i += 2
        else:
            positional.append(args[i])
            i += 1

    atlas_dir = Path(positional[0] if len(positional) >= 1 else "docs/keystone-map").resolve()
    repo_root = Path(positional[1] if len(positional) >= 2 else ".").resolve()

    failures = []
    print("===========================================================================")
    print("KEYSTONE:MAP PHASE 3 — DETERMINISTIC ATLAS VALIDATOR (6 GATES)")
    print("===========================================================================")
    print(f"atlas_dir : {atlas_dir}")
    print(f"repo_root : {repo_root}")

    if not atlas_dir.is_dir():
        print(f"  [FAIL] Atlas directory does not exist: {atlas_dir}")
        print("STATUS: FAILED (1 failure(s))")
        sys.exit(1)

    # -----------------------------------------------------------------------
    # GATE 1: MANDATORY MULTI-FILE HIERARCHY
    # -----------------------------------------------------------------------
    required_files = [
        "00-INDEX.md",
        "01-coverage-ledger.md",
        "architecture/c2-wiring-and-containers.md",
        "architecture/data-dictionary.md",
        "architecture/evolution-and-hotspots.md",
    ]
    for rel in required_files:
        if not (atlas_dir / rel).is_file():
            failures.append(f"Gate 1 (Structure): Missing mandatory file '{rel}'")

    comp_files = sorted((atlas_dir / "components").glob("comp-*.md")) if (atlas_dir / "components").is_dir() else []
    flow_files = sorted((atlas_dir / "flows").glob("flow-*.md")) if (atlas_dir / "flows").is_dir() else []

    if not comp_files:
        failures.append("Gate 1 (Structure): Missing at least one 'components/comp-*.md' file")
    if not flow_files:
        failures.append("Gate 1 (Structure): Missing at least one 'flows/flow-*.md' file")

    # -----------------------------------------------------------------------
    # GATE 2: GROUP 1 ROUTING INDEX & AGENT CONFIG LINE CAPS
    # (Group 2 dissection & ledger files have ZERO artificial macro line cap)
    # -----------------------------------------------------------------------
    line_caps = {
        "00-INDEX.md": 150,
        "00-overview.md": 150,
        "00-system-overview.md": 150,
    }
    all_md_files = []
    for p in sorted(atlas_dir.rglob("*.md")):
        rel = p.relative_to(atlas_dir).as_posix()
        all_md_files.append((rel, p))
        cap = line_caps.get(rel)
        if cap is not None:
            lines = p.read_text(encoding="utf-8", errors="replace").replace("\r\n", "\n").splitlines()
            if len(lines) > cap:
                failures.append(f"Gate 2 (Line Budget): '{rel}' has {len(lines)} lines (exceeds Group 1 routing cap of {cap})")

    agents_md = repo_root / "AGENTS.md"
    if agents_md.is_file():
        agents_txt = agents_md.read_text(encoding="utf-8", errors="replace").replace("\r\n", "\n")
        m_ptr = re.search(
            r"<!--\s*keystone-map:start\s*-->(.*?)<!--\s*keystone-map:end\s*-->",
            agents_txt,
            re.DOTALL,
        )
        if m_ptr:
            ptr_lines = [ln for ln in m_ptr.group(1).strip().splitlines()]
            if len(ptr_lines) > 15:
                failures.append(
                    f"Gate 2 (Line Budget): './AGENTS.md' keystone-map pointer block has {len(ptr_lines)} lines (exceeds cap of 15)"
                )

    # -----------------------------------------------------------------------
    # GATE 3: 100% DENOMINATOR COVERAGE & 4-BUCKET ACCOUNTING
    # -----------------------------------------------------------------------
    ledger_path = atlas_dir / "01-coverage-ledger.md"
    core_wired_modules = []
    if ledger_path.is_file():
        ledger_text = ledger_path.read_text(encoding="utf-8", errors="replace").replace("\r\n", "\n")
        top_dirs = run_git_dirs(repo_root)
        valid_buckets = ("CORE_WIRED", "ADAPTER_CONTRACT", "DYNAMIC_GAP", "UNWIRED_DEAD")
        for d in top_dirs:
            # Must have a line mentioning directory d, a valid bucket, and a 7-40 hex git hash
            pattern = re.compile(
                rf"^.*(?<![A-Za-z0-9_.-]){re.escape(d)}(?![A-Za-z0-9_.-]).*?\b(CORE_WIRED|ADAPTER_CONTRACT|DYNAMIC_GAP|UNWIRED_DEAD)\b.*?\b([0-9a-f]{{7,40}})\b.*$",
                re.MULTILINE,
            )
            m = pattern.search(ledger_text)
            if not m:
                failures.append(
                    f"Gate 3 (Coverage Ledger): Top-level directory '{d}' missing from 01-coverage-ledger.md or lacks valid bucket/Git hash"
                )
            elif m.group(1) == "CORE_WIRED":
                core_wired_modules.append(d)

        m_wiring = re.search(r"C_wiring[`*\s]*[:=|][`*\s]*(?:>=\s*)?([0-9]+(?:\.[0-9]+)?)%", ledger_text)
        if not m_wiring:
            failures.append("Gate 3 (Coverage Ledger): Missing required 'C_wiring: 100%' metric in 01-coverage-ledger.md")
        elif float(m_wiring.group(1)) < 100.0:
            failures.append(f"Gate 3 (Coverage Ledger): C_wiring is {m_wiring.group(1)}% (must be 100%)")

        m_hotspot = re.search(r"C_hotspot[`*\s]*[:=|][`*\s]*(?:>=\s*)?([0-9]+(?:\.[0-9]+)?)%", ledger_text)
        if not m_hotspot:
            failures.append("Gate 3 (Coverage Ledger): Missing required 'C_hotspot: >=95%' metric in 01-coverage-ledger.md")
        elif float(m_hotspot.group(1)) < 95.0:
            failures.append(f"Gate 3 (Coverage Ledger): C_hotspot is {m_hotspot.group(1)}% (must be >= 95%)")

    # -----------------------------------------------------------------------
    # GATE 4: ZERO-HALLUCINATION file:line COORDINATES & RELATIVE LINKS
    # -----------------------------------------------------------------------
    coord_re = re.compile(
        r"(?<![A-Za-z0-9_:/\\])((?:[A-Za-z]:/)?[A-Za-z0-9_./-]+/[A-Za-z0-9_.-]+\.[A-Za-z0-9_]+|[A-Za-z0-9_.-]+\.(?:go|py|ts|tsx|js|jsx|rs|java|c|cpp|h|hpp|cs|rb|php|sh|md|json|yaml|yml|toml)):([0-9]+)(?:-([0-9]+))?"
    )
    link_re = re.compile(r"\[[^\]]+\]\((\.\.?/[^)#\s]+)(?:#[^)]*)?\)")

    total_citations = 0
    for rel, md_path in all_md_files:
        text = md_path.read_text(encoding="utf-8", errors="replace").replace("\r\n", "\n")

        # 4A: Check file:line coordinates
        for m in coord_re.finditer(text):
            c_path_str, start_s, end_s = m.group(1), m.group(2), m.group(3)
            if c_path_str.startswith(("http/", "https/", "file/")):
                continue
            total_citations += 1
            c_path = Path(c_path_str) if Path(c_path_str).is_absolute() else (repo_root / c_path_str)
            if not c_path.is_file():
                failures.append(
                    f"Gate 4A (Coordinate): Hallucinated file '{c_path_str}:{start_s}' in '{rel}' (file does not exist)"
                )
                continue
            file_lines = len(c_path.read_text(encoding="utf-8", errors="replace").replace("\r\n", "\n").splitlines())
            start_ln = int(start_s)
            end_ln = int(end_s) if end_s else start_ln
            if start_ln < 1 or end_ln < start_ln or end_ln > max(file_lines, 1):
                failures.append(
                    f"Gate 4A (Coordinate): Out-of-range line '{c_path_str}:{start_s}{'-'+end_s if end_s else ''}' in '{rel}' (file has {file_lines} lines)"
                )

        # 4B: Check relative Markdown links
        for m_link in link_re.finditer(text):
            rel_target = m_link.group(1)
            resolved_target = (md_path.parent / rel_target).resolve()
            if not resolved_target.exists():
                failures.append(
                    f"Gate 4B (Broken Link): Relative link '{rel_target}' in '{rel}' does not exist on disk"
                )

    if total_citations == 0:
        failures.append("Gate 4A (Coordinate): Zero 'file:line' citations found across the entire Atlas")

    # -----------------------------------------------------------------------
    # GATE 5: REQUIRED SEMANTIC MARKERS (RAD-AI, QOC/ATAM, ZELLER + DRY-RUN)
    # -----------------------------------------------------------------------
    idx_path = atlas_dir / "00-INDEX.md"
    if idx_path.is_file():
        idx_txt = idx_path.read_text(encoding="utf-8", errors="replace")
        if not any(k in idx_txt for k in ("Deterministic", "RAD-AI", "E1")):
            failures.append("Gate 5 (Semantics): '00-INDEX.md' missing RAD-AI E1 / 'Deterministic' boundary notation")

    evo_path = atlas_dir / "architecture/evolution-and-hotspots.md"
    if evo_path.is_file():
        evo_txt = evo_path.read_text(encoding="utf-8", errors="replace")
        if not any(k in evo_txt for k in ("QOC", "ATAM", "Tradeoff", "<->")):
            failures.append(
                "Gate 5 (Semantics): 'architecture/evolution-and-hotspots.md' missing QOC/ATAM Tradeoff or Co-Change section"
            )

    for flow_p in flow_files:
        f_rel = flow_p.relative_to(atlas_dir).as_posix()
        f_txt = flow_p.read_text(encoding="utf-8", errors="replace")
        has_zeller = all(m in f_txt for m in ("Trigger", "Infected", "Propagation", "Observable"))
        italic_subbullets = len(re.findall(r"^\s*-\s*\*[^*\n]+:\*", f_txt, re.MULTILINE))
        has_six_sec = (
            (
                any(k in f_txt for k in ("Contrastive Why", "Visual Dry-Run", "Dry-Run", "*Input:*"))
                or italic_subbullets >= 3
            )
            and any(k in f_txt.lower() for k in ("co-change", "breakpoint", "playbook", "where to touch"))
        )
        if not (has_zeller or has_six_sec):
            failures.append(
                f"Gate 5 (Semantics): '{f_rel}' missing flow anatomy markers (require 6-Section Flow Anatomy with vertical dry-run sub-bullets + breakpoint/co-change or Zeller 4-Link markers)"
            )
        for icon in ("✅", "⚠️", "❌"):
            if icon not in f_txt:
                failures.append(f"Gate 5 (Semantics): '{f_rel}' missing Dry-Run status icon '{icon}'")

    # -----------------------------------------------------------------------
    # GATE 6: OPTIONAL EXECUTION TRACE AUDIT (--trace Issue #584)
    # -----------------------------------------------------------------------
    if trace_file is not None:
        if not trace_file.is_file():
            failures.append(f"Gate 6 (Trace Audit): Trace file does not exist: {trace_file}")
        else:
            trace_content = trace_file.read_text(encoding="utf-8", errors="replace")
            for cw_mod in core_wired_modules:
                if not re.search(rf"(?<![A-Za-z0-9_-]){re.escape(cw_mod)}(?:[/\\\"\'\s]|$)", trace_content):
                    failures.append(
                        f"Gate 6 (Trace Audit - Issue #584): CORE_WIRED module '{cw_mod}' was never read in execution trace '{trace_file.name}'"
                    )

    if failures:
        for f in failures:
            print(f"  [FAIL] {f}")
        print(f"STATUS: FAILED ({len(failures)} failure(s))")
        sys.exit(1)

    print(f"  [PASS] Verified {len(all_md_files)} Atlas files and {total_citations} file:line coordinates.")
    print("STATUS: PASSED")


if __name__ == "__main__":
    main()
PYEOF

#!/usr/bin/env bash
#
# Keystone Tier 2 — Stemmed TF-IDF Pairwise Skill Routing Evaluator (0 LLM Tokens)
# Verifies:
#   1. skills/map/evals.json exists and has positive + pairwise negative cases
#   2. Positive cases achieve >= 95% Rank-1 routing accuracy (--min-rank1 95)
#   3. Pairwise negative cases route to their declared 'owner' skill rather than 'map'
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PYTHON_BIN=""
for candidate in python3 python; do
  if command -v "$candidate" >/dev/null 2>&1; then
    if "$candidate" -c "import sys, json, math, re; assert sys.version_info >= (3, 7)" >/dev/null 2>&1; then
      PYTHON_BIN="$candidate"
      break
    fi
  fi
done

if [[ -z "$PYTHON_BIN" ]]; then
  echo "ERROR: Python 3.7+ is required for validate-routing.sh." >&2
  exit 1
fi

exec "$PYTHON_BIN" - "$REPO_ROOT" << 'PYEOF'
import json
import math
import re
import sys
from pathlib import Path


def stem_word(w):
    w = w.lower()
    for suffix in ("ing", "tion", "ions", "ments", "ment", "ed", "es", "s"):
        if len(w) > len(suffix) + 2 and w.endswith(suffix):
            return w[: -len(suffix)]
    return w


def tokenize(text):
    words = re.findall(r"[a-zA-Z0-9_-]{2,}", text.lower())
    expanded = []
    for w in words:
        expanded.append(stem_word(w))
        for part in w.replace("-", "_").split("_"):
            if len(part) >= 2:
                expanded.append(stem_word(part))
    return expanded


def main():
    repo_root = Path(sys.argv[1]).resolve()
    eval_files = sorted((repo_root / "skills").glob("*/evals.json"))
    print("Validating Keystone Pairwise Skill Routing (Tier 2 Stemmed TF-IDF)...")

    if not eval_files:
        print("  [FAIL] No skills/*/evals.json found (expected at least skills/map/evals.json)")
        print("STATUS: FAILED")
        sys.exit(1)

    # Load actual skills from skills/*/SKILL.md plus canonical virtual owner profiles for planned sibling skills
    skill_docs = {
        "trace": "trace debug stacktrace crash nullpointerexception panic race condition deadlock breakpoint root cause bug fix exception error line",
        "decode": "decode explain single function regex snippet algorithm line by line bitwise math expression 20 lines",
        "design": "design write implementation spec rfc adr api schema proposal before coding new feature architecture plan",
        "rescue": "rescue refactor tangled legacy god function technical debt characterization tests strangler fig seam cleanup",
        "guard": "guard security audit pull request diff owasp sql injection xss vulnerability hardcoded secrets auth bypass review",
        "forge": "forge execute approved implementation plan task by task red green refactor unit tests build feature",
        "ship": "ship release changelog verify ci gates bump semantic version open production pull request deploy merge",
    }

    for skill_md in sorted((repo_root / "skills").glob("*/SKILL.md")):
        txt = skill_md.read_text(encoding="utf-8", errors="replace")
        m_name = re.search(r"^name:\s*([a-z0-9-]+)\s*$", txt, re.MULTILINE)
        m_desc = re.search(r"^description:\s*(.+)$", txt, re.MULTILINE)
        s_name = m_name.group(1) if m_name else skill_md.parent.name
        desc = m_desc.group(1) if m_desc else ""
        # Weight frontmatter description 3x over body
        skill_docs[s_name] = (desc + " ") * 3 + txt

    tokenized_docs = {k: tokenize(v) for k, v in skill_docs.items()}
    n_docs = len(tokenized_docs)
    df = {}
    for toks in tokenized_docs.values():
        for t in set(toks):
            df[t] = df.get(t, 0) + 1

    def score_query(q_text, doc_name):
        q_toks = tokenize(q_text)
        d_toks = tokenized_docs[doc_name]
        if not d_toks:
            return 0.0
        tf_map = {}
        for t in d_toks:
            tf_map[t] = tf_map.get(t, 0) + 1
        score = 0.0
        for qt in q_toks:
            if qt in tf_map:
                tf = 1.0 + math.log(tf_map[qt])
                idf = math.log(1.0 + n_docs / (1.0 + df.get(qt, 0)))
                score += tf * idf
        return score / (math.sqrt(len(d_toks)) + 10.0)

    failures = []
    for ef in eval_files:
        data = json.loads(ef.read_text(encoding="utf-8"))
        skill_name = data.get("skill", ef.parent.name)
        if skill_name not in tokenized_docs:
            failures.append(f"{ef.relative_to(repo_root)}: Skill '{skill_name}' missing SKILL.md")
            continue

        positives = data.get("positive", [])
        negatives = data.get("negative", [])
        pos_hits = 0
        for p in positives:
            prompt = p["prompt"] if isinstance(p, dict) else str(p)
            ranked = sorted(tokenized_docs.keys(), key=lambda s: -score_query(prompt, s))
            if ranked[0] == skill_name:
                pos_hits += 1
            else:
                failures.append(f"[{skill_name}] Positive prompt ranked '{ranked[0]}' #1 instead of '{skill_name}': {prompt}")

        rank1_pct = (pos_hits / len(positives) * 100.0) if positives else 0.0
        if rank1_pct < 95.0:
            failures.append(f"[{skill_name}] Positive Rank-1 accuracy {rank1_pct:.1f}% < 95.0% threshold")

        for n in negatives:
            prompt = n["prompt"]
            owner = n["owner"]
            if owner not in tokenized_docs:
                failures.append(f"[{skill_name}] Unknown negative owner '{owner}'")
                continue
            s_owner = score_query(prompt, owner)
            s_self = score_query(prompt, skill_name)
            if s_owner <= s_self:
                failures.append(
                    f"[{skill_name}] Pairwise negative collision: '{prompt}' scored {s_self:.4f} for '{skill_name}' vs {s_owner:.4f} for owner '{owner}'"
                )

        print(
            f"  [PASS] {ef.relative_to(repo_root)}: Rank-1={rank1_pct:.1f}% ({pos_hits}/{len(positives)} positive, {len(negatives)} pairwise negative)"
        )

    if failures:
        for f in failures:
            print(f"  [FAIL] {f}")
        print(f"STATUS: FAILED ({len(failures)} failure(s))")
        sys.exit(1)

    print("STATUS: PASSED")


if __name__ == "__main__":
    main()
PYEOF

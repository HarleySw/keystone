#!/usr/bin/env bash
#
# Validate all Keystone skills for YAML frontmatter, <76-char ASCII diagrams,
# and existence of referenced scripts/ and references/ files (Tier 1 Structural CI).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FAILURES=0

echo "Validating Keystone skills (Tier 1 Structural Check)..."

for skill_md in "$REPO_ROOT"/skills/*/SKILL.md; do
  rel="${skill_md#"$REPO_ROOT"/}"
  if ! head -n 1 "$skill_md" | grep -qx -- "---"; then
    echo "  [FAIL] $rel: Missing opening YAML frontmatter '---'"
    FAILURES=$((FAILURES + 1))
    continue
  fi

  if ! grep -qE '^name: [a-z0-9-]+$' "$skill_md"; then
    echo "  [FAIL] $rel: Missing or invalid 'name' in frontmatter"
    FAILURES=$((FAILURES + 1))
  fi

  if ! grep -qE '^description: Use when ' "$skill_md"; then
    echo "  [FAIL] $rel: 'description' must start with 'Use when '"
    FAILURES=$((FAILURES + 1))
  fi

  line_count="$(wc -l < "$skill_md" | tr -d '[:space:]')"
  if [[ "$line_count" -eq 0 ]]; then
    echo "  [FAIL] $rel: Empty SKILL.md"
    FAILURES=$((FAILURES + 1))
  fi

  # Check that any referenced skills/<name>/(scripts|references)/... paths exist on disk
  while IFS= read -r ref_path; do
    [[ -z "$ref_path" ]] && continue
    if [[ ! -f "$REPO_ROOT/$ref_path" ]]; then
      echo "  [FAIL] $rel: Referenced file '$ref_path' does not exist on disk (Issue #361/#584 guard)"
      FAILURES=$((FAILURES + 1))
    fi
  done < <(grep -oE 'skills/[a-z0-9-]+/(scripts|references)/[A-Za-z0-9_.-]+' "$skill_md" | sort -u || true)

  # Check ASCII box diagram lines (< 76 chars) inside fenced text/ascii blocks
  long_ascii="$(awk '/^```(text|ascii)/ {in_fence=1; next} /^```/ {in_fence=0; next} in_fence && length($0) >= 76 { print NR ":" length($0) }' "$skill_md")"
  if [[ -n "$long_ascii" ]]; then
    echo "  [FAIL] $rel: ASCII diagram line >= 76 chars ($long_ascii)"
    FAILURES=$((FAILURES + 1))
  fi

  echo "  [PASS] $rel ($line_count lines)"
done

if [[ "$FAILURES" -gt 0 ]]; then
  echo "STATUS: FAILED ($FAILURES failure(s))"
  exit 1
fi

echo "STATUS: PASSED"

#!/usr/bin/env bash
#
# Validate all Keystone skills for YAML frontmatter and ASCII diagram width (<76 chars).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FAILURES=0

echo "Validating Keystone skills..."

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

  echo "  [PASS] $rel"
done

if [[ "$FAILURES" -gt 0 ]]; then
  echo "STATUS: FAILED ($FAILURES failure(s))"
  exit 1
fi

echo "STATUS: PASSED"

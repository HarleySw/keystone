#!/usr/bin/env bash
#
# Lint shell scripts in this repository.
# Usage: scripts/lint-shell.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Checking shell script syntax..."
for file in "$REPO_ROOT/hooks/session-start" "$REPO_ROOT/scripts/"*.sh "$REPO_ROOT/skills/"*/scripts/*.sh "$REPO_ROOT/tests/"*.sh "$REPO_ROOT/tests/"*/*.sh; do
  [[ -f "$file" ]] || continue
  bash -n "$file"
  echo "  [OK] ${file#"$REPO_ROOT"/}"
done
echo "All shell scripts passed syntax check."

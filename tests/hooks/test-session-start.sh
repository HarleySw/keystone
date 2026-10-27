#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
HOOK_UNDER_TEST="$REPO_ROOT/hooks/session-start"
WRAPPER_UNDER_TEST="$REPO_ROOT/hooks/run-hook.cmd"

FAILURES=0
TEST_ROOT="$(mktemp -d)"
cleanup() { rm -rf "$TEST_ROOT"; }
trap cleanup EXIT

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; FAILURES=$((FAILURES + 1)); }

assert_json_key() {
  local desc="$1" expected_expr="$2"
  shift 2
  local out
  if ! out="$("$@" 2>&1)"; then
    fail "$desc (non-zero exit)"
    return
  fi
  if printf '%s' "$out" | jq -e "$expected_expr" >/dev/null 2>&1; then
    pass "$desc"
  else
    fail "$desc"
  fi
}

echo "Running SessionStart hook tests..."

assert_json_key \
  "Claude Code emits hookSpecificOutput.additionalContext" \
  '.hookSpecificOutput.hookEventName == "SessionStart" and (.hookSpecificOutput.additionalContext | contains("using-keystone"))' \
  env CLAUDE_PLUGIN_ROOT="$REPO_ROOT" bash "$HOOK_UNDER_TEST"

assert_json_key \
  "run-hook.cmd dispatches session-start" \
  '.hookSpecificOutput.additionalContext | contains("using-keystone")' \
  env CLAUDE_PLUGIN_ROOT="$REPO_ROOT" bash "$WRAPPER_UNDER_TEST" session-start

assert_json_key \
  "Generic SDK / Antigravity emits top-level additionalContext" \
  'has("additionalContext") and (.additionalContext | contains("using-keystone"))' \
  env COPILOT_CLI=1 CLAUDE_PLUGIN_ROOT="$REPO_ROOT" bash "$HOOK_UNDER_TEST"

if [[ "$FAILURES" -gt 0 ]]; then
  echo "STATUS: FAILED ($FAILURES)"
  exit 1
fi
echo "STATUS: PASSED"

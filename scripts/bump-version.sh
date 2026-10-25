#!/usr/bin/env bash
#
# bump-version.sh — bump version numbers across all declared files,
# with drift detection and repo-wide audit for missed files.
#
# Usage:
#   bump-version.sh <new-version>   Bump all declared files to new version
#   bump-version.sh --check         Report current versions (detect drift)
#   bump-version.sh --audit         Check + grep repo for old version strings
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG="$REPO_ROOT/.version-bump.json"

if [[ ! -f "$CONFIG" ]]; then
  echo "error: .version-bump.json not found at $CONFIG" >&2
  exit 1
fi

read_json_field() {
  local file="$1" field="$2"
  local jq_path
  jq_path=$(echo "$field" | sed -E 's/\.([0-9]+)/[\1]/g' | sed 's/^/./' | sed 's/\.\././g')
  jq -r "$jq_path" "$file"
}

write_json_field() {
  local file="$1" field="$2" value="$3"
  local jq_path
  jq_path=$(echo "$field" | sed -E 's/\.([0-9]+)/[\1]/g' | sed 's/^/./' | sed 's/\.\././g')
  local tmp="${file}.tmp"
  jq "$jq_path = \"$value\"" "$file" > "$tmp" && mv "$tmp" "$file"
}

read_yaml_field() {
  local file="$1" field="$2"
  grep -E "^[[:space:]]*${field}:" "$file" | head -1 | sed -E "s/^[[:space:]]*${field}:[[:space:]]*//" | tr -d '"' | tr -d "'"
}

write_yaml_field() {
  local file="$1" field="$2" value="$3"
  sed -i -E "s/^([[:space:]]*${field}:[[:space:]]*).*/\1\"${value}\"/" "$file"
}

read_manifest_field() {
  local file="$1"
  case "$file" in
    *.json) read_json_field "$@" ;;
    *.yaml|*.md) read_yaml_field "$@" ;;
    *)
      echo "error: unsupported manifest format: $file" >&2
      return 1
      ;;
  esac
}

write_manifest_field() {
  local file="$1"
  case "$file" in
    *.json) write_json_field "$@" ;;
    *.yaml|*.md) write_yaml_field "$@" ;;
    *)
      echo "error: unsupported manifest format: $file" >&2
      return 1
      ;;
  esac
}

declared_files() {
  jq -r '.files[] | "\(.path)\t\(.field)"' "$CONFIG"
}

cmd_check() {
  local has_drift=0
  local versions=()

  echo "Version check:"
  echo ""

  while IFS=$'\t' read -r path field; do
    local fullpath="$REPO_ROOT/$path"
    if [[ ! -f "$fullpath" ]]; then
      printf "  %-45s  MISSING\n" "$path ($field)"
      has_drift=1
      continue
    fi
    local ver
    ver=$(read_manifest_field "$fullpath" "$field")
    printf "  %-45s  %s\n" "$path ($field)" "$ver"
    versions+=("$ver")
  done < <(declared_files)

  echo ""

  local unique
  unique=$(printf '%s\n' "${versions[@]}" | sort -u | wc -l | tr -d ' ')
  if [[ "$unique" -gt 1 ]]; then
    echo "DRIFT DETECTED — versions are not in sync!"
    has_drift=1
  else
    echo "All declared files are in sync at ${versions[0]}"
  fi

  return $has_drift
}

cmd_bump() {
  local new_version="$1"
  if ! echo "$new_version" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+'; then
    echo "error: '$new_version' doesn't look like a version (expected X.Y.Z)" >&2
    exit 1
  fi

  echo "Bumping all declared files to $new_version..."
  echo ""

  while IFS=$'\t' read -r path field; do
    local fullpath="$REPO_ROOT/$path"
    if [[ ! -f "$fullpath" ]]; then
      echo "  SKIP (missing): $path"
      continue
    fi
    local old_ver
    old_ver=$(read_manifest_field "$fullpath" "$field")
    write_manifest_field "$fullpath" "$field" "$new_version"
    printf "  %-45s  %s -> %s\n" "$path ($field)" "$old_ver" "$new_version"
  done < <(declared_files)

  echo ""
  cmd_check
}

case "${1:-}" in
  --check|--audit)
    cmd_check
    ;;
  --help|-h|"")
    echo "Usage: bump-version.sh <new-version> | --check"
    exit 0
    ;;
  *)
    cmd_bump "$1"
    ;;
esac

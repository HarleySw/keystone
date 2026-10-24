#!/usr/bin/env bash
#
# Automated tests for keystone:map scripts (recon-graphs.sh & validate-atlas.sh).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RECON="$REPO_ROOT/skills/map/scripts/recon-graphs.sh"

echo "=== [Task 1.1] Test recon-graphs.sh --doctor ==="
doc_out="$(bash "$RECON" --doctor)"
echo "$doc_out" | grep -q "KEYSTONE:MAP TOOLCHAIN DOCTOR"
echo "$doc_out" | grep -q "Universal Ctags"

echo "=== [Task 1.2] Test recon-graphs.sh on multi-module git repo ==="
TMP_REPO="$(mktemp -d)"
trap 'rm -rf "$TMP_REPO"' EXIT

git -C "$TMP_REPO" init -q
git -C "$TMP_REPO" config user.email "architect@example.com"
git -C "$TMP_REPO" config user.name "Architect"
mkdir -p "$TMP_REPO/cmd/server" "$TMP_REPO/internal/auth" "$TMP_REPO/internal/ledger" "$TMP_REPO/legacy_dead"

cat << 'EOF' > "$TMP_REPO/cmd/server/main.go"
package main
import (
    "example.com/app/internal/auth"
    "example.com/app/internal/ledger"
)
func main() {
    guard := auth.NewGuard()
    store := ledger.NewStore(guard)
    store.Serve()
}
EOF

cat << 'EOF' > "$TMP_REPO/internal/auth/guard.go"
package auth
type Guard struct { Secret string }
func NewGuard() *Guard { return &Guard{Secret: "strict"} }
func (g *Guard) Verify(token string) bool { return len(token) > 0 }
EOF

cat << 'EOF' > "$TMP_REPO/internal/ledger/store.go"
package ledger
type Store struct { MaxRetries int }
func NewStore(g interface{}) *Store { return &Store{MaxRetries: 3} }
func (s *Store) Serve() {}
EOF

cat << 'EOF' > "$TMP_REPO/legacy_dead/unused.go"
package legacy_dead
func DeadHelper() {}
EOF

git -C "$TMP_REPO" add .
git -C "$TMP_REPO" commit -q -m "feat: initial architecture"

# Commit 2: Cross-boundary co-change between internal/auth and internal/ledger (<=20 files)
echo "// co-change 1" >> "$TMP_REPO/internal/auth/guard.go"
echo "// co-change 1" >> "$TMP_REPO/internal/ledger/store.go"
git -C "$TMP_REPO" commit -am "fix: sync auth and ledger" -q

# Commit 3: Bulk formatting commit (>20 files) that MUST be filtered out of co-change
mkdir -p "$TMP_REPO/bulk_a" "$TMP_REPO/bulk_b"
for i in $(seq 1 12); do
  echo "package bulk_a" > "$TMP_REPO/bulk_a/f${i}.go"
  echo "package bulk_b" > "$TMP_REPO/bulk_b/f${i}.go"
done
git -C "$TMP_REPO" add .
git -C "$TMP_REPO" commit -q -m "style: add 24 bulk files"
for i in $(seq 1 12); do
  echo "// fmt" >> "$TMP_REPO/bulk_a/f${i}.go"
  echo "// fmt" >> "$TMP_REPO/bulk_b/f${i}.go"
done
git -C "$TMP_REPO" commit -am "style: bulk format 24 files" -q

out="$(bash "$RECON" "$TMP_REPO")"
echo "$out" | grep -q "KEYSTONE:MAP PHASE 1"
echo "$out" | grep -q "cmd/server/main.go"
echo "$out" | grep -q "internal/auth/guard.go <-> internal/ledger/store.go"
echo "$out" | grep -q "BLOCKED_ORACLE"
if echo "$out" | grep -q "bulk_a/f1.go <-> bulk_b/f1.go"; then
  echo "FAIL: Bulk commit (>20 files) was not filtered out of co-change!"
  exit 1
fi
[[ -f "$TMP_REPO/.keystone/tmp/recon-raw.json" ]]
[[ -f "$TMP_REPO/.keystone/cache/repomap.tags.cache.v1" ]]

echo "=== [Task 1.3] Test Incremental Staleness (UNCHANGED / STALE_HASH / STALE_COCHANGE) & SCIP Oracle ==="
mkdir -p "$TMP_REPO/docs/keystone-map"
cmd_hash="$(git -C "$TMP_REPO" ls-tree HEAD cmd | awk '{print substr($3,1,12)}')"
internal_hash="$(git -C "$TMP_REPO" ls-tree HEAD internal | awk '{print substr($3,1,12)}')"
legacy_hash="$(git -C "$TMP_REPO" ls-tree HEAD legacy_dead | awk '{print substr($3,1,12)}')"

cat << EOF > "$TMP_REPO/docs/keystone-map/01-coverage-ledger.md"
| Module | Bucket | Git Hash |
| --- | --- | --- |
| cmd | CORE_WIRED | $cmd_hash |
| internal | CORE_WIRED | $internal_hash |
| legacy_dead | UNWIRED_DEAD | $legacy_hash |
EOF

# Modify cmd/server/main.go and add a cross-boundary co-change between cmd and legacy_dead
echo "// cochange cmd-legacy" >> "$TMP_REPO/cmd/server/main.go"
echo "// cochange cmd-legacy" >> "$TMP_REPO/legacy_dead/unused.go"
git -C "$TMP_REPO" commit -am "feat: couple cmd and legacy_dead" -q

# Update ledger with new legacy_dead hash but OLD cmd_hash so cmd is STALE_HASH and legacy_dead becomes STALE_COCHANGE
new_legacy_hash="$(git -C "$TMP_REPO" ls-tree HEAD legacy_dead | awk '{print substr($3,1,12)}')"
cat << EOF > "$TMP_REPO/docs/keystone-map/01-coverage-ledger.md"
| Module | Bucket | Git Hash |
| --- | --- | --- |
| cmd | CORE_WIRED | $cmd_hash |
| internal | CORE_WIRED | $internal_hash |
| legacy_dead | UNWIRED_DEAD | $new_legacy_hash |
EOF

# Also create a fixture index.scip to test SCIP Phase-1 Join
cat << 'EOF' > "$TMP_REPO/index.scip"
{"occurrences":[{"file":"cmd/server/main.go","line":6,"symbol":"NewGuard","target":"internal/auth/guard.go"}]}
EOF

out2="$(bash "$RECON" "$TMP_REPO")"
echo "$out2" | grep -q "STALE_HASH.*cmd"
echo "$out2" | grep -q "UNCHANGED.*internal"
echo "$out2" | grep -q "STALE_COCHANGE.*legacy_dead"
echo "$out2" | grep -q "SCIP_ACTIVE"

echo "PASS: recon-graphs.sh tests passed"

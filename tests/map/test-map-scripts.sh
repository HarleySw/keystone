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
mkdir -p "$TMP_REPO/cmd/server" "$TMP_REPO/internal/auth" "$TMP_REPO/internal/ledger" "$TMP_REPO/legacy_dead" "$TMP_REPO/.cursor-plugin"
echo '{"name":"test"}' > "$TMP_REPO/.cursor-plugin/plugin.json"

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

# Verify single-commit tagless repo succeeds immediately (Review Focus #1)
single_out="$(bash "$RECON" "$TMP_REPO")"
echo "$single_out" | grep -q "KEYSTONE:MAP PHASE 1"
echo "$single_out" | grep -q "cmd/server/main.go"

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

# Update ledger with new legacy_dead hash, dot-prefixed .cursor-plugin hash, and OLD cmd_hash
new_legacy_hash="$(git -C "$TMP_REPO" ls-tree HEAD legacy_dead | awk '{print substr($3,1,12)}')"
dot_hash="$(git -C "$TMP_REPO" ls-tree HEAD .cursor-plugin | awk '{print substr($3,1,12)}')"
cat << EOF > "$TMP_REPO/docs/keystone-map/01-coverage-ledger.md"
| Module | Bucket | Git Hash |
| --- | --- | --- |
| .cursor-plugin | ADAPTER_CONTRACT | deadbeef1234 |
| cmd | CORE_WIRED | $cmd_hash |
| internal | CORE_WIRED | $internal_hash |
| legacy_dead | UNWIRED_DEAD | $new_legacy_hash |
EOF

# Also create a fixture index.scip to test SCIP Phase-1 Join
cat << 'EOF' > "$TMP_REPO/index.scip"
{"occurrences":[{"file":"cmd/server/main.go","line":6,"symbol":"NewGuard","target":"internal/auth/guard.go"}]}
EOF

out2="$(bash "$RECON" "$TMP_REPO")"
echo "$out2" | grep -q "STALE_HASH.*\.cursor-plugin"
echo "$out2" | grep -q "STALE_HASH.*cmd"
echo "$out2" | grep -q "UNCHANGED.*internal"
echo "$out2" | grep -q "STALE_COCHANGE.*legacy_dead"
echo "$out2" | grep -q "SCIP_ACTIVE"
jq -e '.oracles.scip_status and .oracles.scip_content_fingerprint and .oracles.edge_oracle_stats' "$TMP_REPO/.keystone/tmp/recon-raw.json" >/dev/null

echo "=== [Task 2.1] Test validate-atlas.sh on valid 6-Tier Atlas ==="
VALIDATE="$REPO_ROOT/skills/map/scripts/validate-atlas.sh"
ATLAS="$TMP_REPO/docs/keystone-map"
mkdir -p "$ATLAS/architecture" "$ATLAS/components" "$ATLAS/flows"

cat << 'EOF' > "$ATLAS/00-INDEX.md"
# System Context (C4 L1 & RAD-AI E1)
- Boundary: Deterministic Core (`cmd/server/main.go:6-10`) vs Non-Deterministic AI Adapter.
- Routing: [Wiring](./architecture/c2-wiring-and-containers.md) | [Data](./architecture/data-dictionary.md)
EOF

bulk_a_h="$(git -C "$TMP_REPO" ls-tree HEAD bulk_a | awk '{print substr($3,1,12)}')"
bulk_b_h="$(git -C "$TMP_REPO" ls-tree HEAD bulk_b | awk '{print substr($3,1,12)}')"
cmd_h="$(git -C "$TMP_REPO" ls-tree HEAD cmd | awk '{print substr($3,1,12)}')"
internal_h="$(git -C "$TMP_REPO" ls-tree HEAD internal | awk '{print substr($3,1,12)}')"
legacy_h="$(git -C "$TMP_REPO" ls-tree HEAD legacy_dead | awk '{print substr($3,1,12)}')"

cat << EOF > "$ATLAS/01-coverage-ledger.md"
# Closed-Loop Coverage Ledger
| Module | Bucket | Git Hash | Evidence |
| --- | --- | --- | --- |
| .cursor-plugin | ADAPTER_CONTRACT | $dot_hash | .cursor-plugin/plugin.json:1-1 |
| cmd | CORE_WIRED | $cmd_h | cmd/server/main.go:6-10 |
| internal | CORE_WIRED | $internal_h | internal/auth/guard.go:2-4 |
| bulk_a | ADAPTER_CONTRACT | $bulk_a_h | bulk_a/f1.go:1-2 |
| bulk_b | DYNAMIC_GAP | $bulk_b_h | bulk_b/f1.go:1-2 |
| legacy_dead | UNWIRED_DEAD | $legacy_h | legacy_dead/unused.go:1-2 |

- C_wiring: 100%
- C_hotspot: 100%
EOF

cat << 'EOF' > "$ATLAS/architecture/c2-wiring-and-containers.md"
# C4 L2 Containers & Trust Boundaries
- Entrypoint: `cmd/server/main.go:6-10`
- Link: [Auth Component](../components/comp-auth.md)
EOF

cat << 'EOF' > "$ATLAS/architecture/data-dictionary.md"
# Data Dictionary (Data-First Mandate)
- `Guard` struct in `internal/auth/guard.go:2-2`
- `Store` struct in `internal/ledger/store.go:2-2`
EOF

cat << 'EOF' > "$ATLAS/architecture/evolution-and-hotspots.md"
# Evolution, Hotspots & QOC/ATAM Tradeoff Matrix
- Co-change: `internal/auth/guard.go:1-4` <-> `internal/ledger/store.go:1-4`
- ATAM Tradeoff: (+) Deterministic guard verification vs (-) Manual token rotation.
EOF

cat << 'EOF' > "$ATLAS/components/comp-auth.md"
# Component: Auth (`internal/auth`)
- Guard verification at `internal/auth/guard.go:3-4`
EOF

cat << 'EOF' > "$ATLAS/flows/flow-01-serve.md"
# Flow 01: Server Bootstrap & Zeller Infection Chain
1. Trigger: `cmd/server/main.go:7` (`auth.NewGuard()`)
2. Infected State vs Sane State: Empty `Guard.Secret` vs non-empty secret at `internal/auth/guard.go:2`
3. Propagation: Passed into `ledger.NewStore(guard)` at `cmd/server/main.go:8`
4. Observable Failure: Unauthorized ledger access at `internal/ledger/store.go:4`
- ✅ Happy path: valid token verified
- ⚠️ Edge case: empty token rejected
- ❌ Failure path: nil guard panics
EOF

TRACE_FILE="$TMP_REPO/trace.jsonl"
cat << 'EOF' > "$TRACE_FILE"
{"tool":"read_file","path":"cmd/server/main.go"}
{"tool":"read_file","path":"internal/auth/guard.go"}
EOF

val_out="$(bash "$VALIDATE" "$ATLAS" "$TMP_REPO" --trace "$TRACE_FILE")"
echo "$val_out" | grep -q "STATUS: PASSED"

echo "=== [Task 2.2] Test Negative Gate A: Hallucinated line number (main.go:999) ==="
echo "- Bad ref: \`cmd/server/main.go:999\`" >> "$ATLAS/components/comp-auth.md"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected line 999!"
  exit 1
fi
sed -i '$d' "$ATLAS/components/comp-auth.md"

echo "=== [Task 2.3] Test Negative Gate B: Broken relative link ==="
echo "- Broken: [Missing](./does-not-exist.md)" >> "$ATLAS/00-INDEX.md"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected broken relative link!"
  exit 1
fi
sed -i '$d' "$ATLAS/00-INDEX.md"

echo "=== [Task 2.4] Test Negative Gate C: Missing top-level directory in 01-coverage-ledger.md ==="
grep -v "legacy_dead" "$ATLAS/01-coverage-ledger.md" > "$ATLAS/01-coverage-ledger.md.tmp"
mv "$ATLAS/01-coverage-ledger.md.tmp" "$ATLAS/01-coverage-ledger.md"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected missing legacy_dead directory!"
  exit 1
fi
echo "| legacy_dead | UNWIRED_DEAD | $legacy_h | legacy_dead/unused.go:1-2 |" >> "$ATLAS/01-coverage-ledger.md"

echo "=== [Task 2.5] Test Negative Gate D: Untraced CORE_WIRED module (--trace Issue #584) ==="
echo '{"tool":"read_file","path":"cmd/server/main.go"}' > "$TRACE_FILE"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" --trace "$TRACE_FILE" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected untraced CORE_WIRED module 'internal'!"
  exit 1
fi

echo "=== [Task 2.5b] Test Negative Gate: Missing C_wiring/C_hotspot metrics in 01-coverage-ledger.md ==="
grep -v "C_wiring" "$ATLAS/01-coverage-ledger.md" > "$ATLAS/01-coverage-ledger.md.tmp"
mv "$ATLAS/01-coverage-ledger.md.tmp" "$ATLAS/01-coverage-ledger.md"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected missing C_wiring metric!"
  exit 1
fi
echo "- C_wiring: 100%" >> "$ATLAS/01-coverage-ledger.md"

echo "=== [Task 2.6] Test Negative Gate E: Line cap overflow (>150 lines in 00-INDEX.md) ==="
for i in $(seq 1 160); do
  echo "line $i" >> "$ATLAS/00-INDEX.md"
done
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected >150 lines in 00-INDEX.md!"
  exit 1
fi

echo "=== [Task 2.6b] Test Negative Gate F: ./AGENTS.md pointer block > 15 lines ==="
git -C "$TMP_REPO" checkout -- "$ATLAS/00-INDEX.md" 2>/dev/null || true
cat << 'EOF' > "$ATLAS/00-INDEX.md"
# System Context (C4 L1 & RAD-AI E1)
- Boundary: Deterministic Core (`cmd/server/main.go:6-10`) vs Non-Deterministic AI Adapter.
- Routing: [Wiring](./architecture/c2-wiring-and-containers.md) | [Data](./architecture/data-dictionary.md)
EOF
{
  echo "<!-- keystone-map:start -->"
  for i in $(seq 1 16); do echo "pointer line $i"; done
  echo "<!-- keystone-map:end -->"
} > "$TMP_REPO/AGENTS.md"
if bash "$VALIDATE" "$ATLAS" "$TMP_REPO" >/dev/null 2>&1; then
  echo "FAIL: validate-atlas.sh should have rejected >15 line pointer block in AGENTS.md!"
  exit 1
fi
rm -f "$TMP_REPO/AGENTS.md"

echo "=== [Task 2.7] Test 6-Section Flow Anatomy (learn-from-code base) & Uncapped Group 2 Flow (>500 lines) in validate-atlas.sh ==="
cat << 'EOF' > "$ATLAS/flows/flow-02-webhook.md"
# 1. System Purpose & Domain Boundaries
- Real-world role: Validates incoming requests and enforces access control before ledger writes.
# 2. Core Data Structures & State Lifecycles
- `Guard` struct in [`internal/auth/guard.go:2`](../../../internal/auth/guard.go#L2) (`✅` valid, `❌` rejected).
# 3. Wiring Root, Entry Points & End-to-End Execution Path
- Entry point wired at [`cmd/server/main.go:6`](../../../cmd/server/main.go#L6).
# 4. Core Code Mechanics
- Contrastive Why: Blocks unauthorized callers when the guard secret is empty.
- Visual Dry-Run:
  - **Case 1 — Valid guard secret configured:**
    - *Input:* Initialized with a non-empty secret key.
    - *How the code checks it:* Passes the guard check at [`internal/auth/guard.go:3`](../../../internal/auth/guard.go#L3) (`✅`).
    - *Result:* Allows ledger write (`✅`).
# 5. Hidden Traps, Co-Change Coupling & Live Verification
- ⚠️ Sensitivity Alert at [`internal/ledger/store.go:3`](../../../internal/ledger/store.go#L3).
- Onboarding Breakpoint: Set `breakpoint` at [`cmd/server/main.go:8`](../../../cmd/server/main.go#L8).
# 6. Developer Modification Playbook ("Where to Touch") & Reusable Patterns
- Quick Modification Playbook ("To change X, touch Y"): Edit [`internal/auth/guard.go:2`](../../../internal/auth/guard.go#L2).
EOF
for i in $(seq 1 540); do
  echo "- *Step detail $i:* Bite-sized single-idea sub-bullet." >> "$ATLAS/flows/flow-02-webhook.md"
done
val_out_6sec="$(bash "$VALIDATE" "$ATLAS" "$TMP_REPO")"
echo "$val_out_6sec" | grep -q "STATUS: PASSED"
rm -f "$ATLAS/flows/flow-02-webhook.md"

echo "=== [Task 3.1] Test Self-Contained Reference Guides (Issues #361 & #584) ==="
REF_WIRING="$REPO_ROOT/skills/map/references/wiring-and-monorepo-guide.md"
REF_ATLAS="$REPO_ROOT/skills/map/references/atlas-and-subagent-contracts.md"

[[ -f "$REF_WIRING" ]]
[[ -f "$REF_ATLAS" ]]
[[ "$(wc -l < "$REF_WIRING" | tr -d ' ')" -gt 100 ]]
[[ "$(wc -l < "$REF_ATLAS" | tr -d ' ')" -gt 100 ]]

for kw in "bazel query" "bazel cquery" "bazel aquery" "scip_content_fingerprint" "edge_oracle" "BLOCKED_ORACLE" "CORE_WIRED" "ADAPTER_CONTRACT" "DYNAMIC_GAP" "UNWIRED_DEAD" "Sillito" "Information Foraging"; do
  grep -qF "$kw" "$REF_WIRING"
done

for kw in "RAD-AI" "C4-E1" "CLAIM" "EXTRACT" "DOUBT" "RECONCILE" "STOP" "Infected State" "Faded Completion Problem" "Quiz Gate" "Adopt" "Adapt" "Reject" ".cursor/rules/" "keystone-map:start" "Micro-Cap, Not Macro-Cap" "1 File = 1 End-to-End Flow"; do
  grep -qF "$kw" "$REF_ATLAS"
done

for rf in "$REF_WIRING" "$REF_ATLAS"; do
  long_ref_ascii="$(awk '/^```(text|ascii)/ {in_f=1; next} /^```/ {in_f=0; next} in_f && length($0) >= 76 { print NR ":" length($0) }' "$rf")"
  if [[ -n "$long_ref_ascii" ]]; then
    echo "FAIL: $rf has ASCII diagram line >= 76 chars ($long_ref_ascii)"
    exit 1
  fi
done

echo "PASS: recon-graphs.sh, validate-atlas.sh, and reference guide tests passed"

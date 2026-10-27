# Testing Keystone

Keystone includes automated verification scripts in `tests/` and `scripts/`:

```bash
# 1. Validate YAML frontmatter, references, and harness manifests across all skills
bash tests/validate-skills.sh

# 2. Validate TF-IDF semantic routing and negative boundaries (Rank-1 = 100%)
bash tests/validate-routing.sh

# 3. Test map recon-graphs.sh and validate-atlas.sh scripts
bash tests/map/test-map-scripts.sh

# 4. Test SessionStart JSON payload across Claude Code and Antigravity / SDK harnesses
bash tests/hooks/test-session-start.sh

# 5. Verify version synchronization across all 14 harness manifests and skill files
bash scripts/bump-version.sh --check

# 6. Check shell syntax across hooks, scripts, and tests
bash scripts/lint-shell.sh
```

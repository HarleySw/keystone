# Testing Keystone

Keystone includes automated verification scripts in `tests/` and `scripts/`:

```bash
# 1. Validate YAML frontmatter and structure across all skills
bash tests/validate-skills.sh

# 2. Test SessionStart JSON payload across Claude Code, Cursor, and SDK harnesses
bash tests/hooks/test-session-start.sh

# 3. Verify version synchronization across all 12 harness manifests
bash scripts/bump-version.sh --check

# 4. Check shell syntax across hooks, scripts, and tests
bash scripts/lint-shell.sh
```

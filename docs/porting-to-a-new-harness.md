# Porting Keystone to a New Harness

Every Keystone harness integration must satisfy three requirements:

1. **Skills (`skills/`):** Shared verbatim across all harnesses. Never hard-code harness-specific tool names inside skill bodies.
2. **Tool Mapping (`skills/using-keystone/references/<harness>-tools.md`):** Maps generic skill actions to the harness's native tools.
3. **Automatic `SessionStart` Bootstrap:** Injects `skills/using-keystone/SKILL.md` at session start without per-session manual opt-in.

## Verification

Run `bash tests/hooks/test-session-start.sh` and `bash tests/validate-skills.sh` before submitting a new harness port.

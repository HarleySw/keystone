# Codex Tool Mapping

## Subagent Dispatch

Enable multi-agent support in `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

- **Spawning:** Use `spawn_agent {fork_turns: "none"}` with explicit `model` and `reasoning_effort`.
- **Follow-up:** Use `followup_task` to resume an existing child agent.
- **Waiting:** Use `wait_agent` with bounded timeouts (`300000`–`600000` ms) when idle.

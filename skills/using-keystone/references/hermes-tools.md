# Hermes Agent Tool Mapping

| Action skills request | Hermes tool |
| :--- | :--- |
| Read / Write / Patch a file | `read_file`, `write_file`, `patch` |
| Run a shell command | `terminal` |
| Search file contents | `search_files` |
| Dispatch a subagent | `delegate_task(goal=..., context=..., toolsets=[...], role="leaf")` |
| Task tracking | `todo` tool |
| Invoke a skill | `skill_view("skill-name")` (or `read_file` on `SKILL.md` as fallback) |

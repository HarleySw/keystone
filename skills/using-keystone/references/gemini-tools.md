# Gemini CLI Tool Mapping

| Action skills request | Gemini CLI equivalent |
| :--- | :--- |
| Read a file | `read_file` / `read_many_files` |
| Create a new file | `write_file` |
| Edit a file | `replace` |
| Run a shell command | `run_shell_command` |
| Search file contents / Find files | `grep_search` / `glob` |
| Invoke a skill | `activate_skill` |
| Dispatch a subagent | `invoke_agent` with `agent_name: "generalist"` |
| Task tracking | `write_todos` |
| Ask user structured questions | `ask_user` |

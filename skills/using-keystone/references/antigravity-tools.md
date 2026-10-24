# Antigravity CLI (`agy`) Tool Mapping

Skills speak in actions ("dispatch a subagent", "create a todo", "read a file"). On the Antigravity CLI (`agy`) these resolve to the tools below.

| Action skills request | Antigravity CLI equivalent |
| :--- | :--- |
| Dispatch a subagent (`Subagent (general-purpose):`) | `invoke_subagent` with a built-in `TypeName` — `self` for full-capability work, `research` for read-only |
| Task tracking ("create a todo", "mark complete") | Maintain a **task artifact** (`task.md`) in the artifact directory using `write_file` / `edit_file` with `ArtifactMetadata`. **Not** `manage_task`, which manages background shell processes. |
| Read / Write / Edit files | `read_file`, `write_file`, `edit_file` |
| Run shell commands | `run_command` |
| Ask structured multiple-choice questions | `ask_question` |

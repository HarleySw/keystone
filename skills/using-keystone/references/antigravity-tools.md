# Antigravity CLI (`agy`) & IDE Tool Mapping

Skills speak in actions ("dispatch a subagent", "create a todo", "read a file"). On Antigravity (`agy` CLI and IDE) these resolve to the tools below.

| Action skills request | Antigravity equivalent |
| :--- | :--- |
| Dispatch a subagent (`Subagent (general-purpose):`) | `invoke_subagent` with a built-in `TypeName` — `self` for full-capability work, `research` for read-only |
| Task tracking ("create a todo", "mark complete") | Maintain a **task artifact** (`task.md`, `ArtifactType: task`) in the artifact directory using `write_file` / `write_to_file` or `edit_file` / `replace_file_content` with `ArtifactMetadata`. **Not** `manage_task`, which manages background shell processes. |
| Read / Write / Edit files | `read_file` / `view_file`, `write_file` / `write_to_file`, `edit_file` / `replace_file_content` |
| Run shell commands | `run_command` |
| Ask structured multiple-choice questions | `ask_question` |

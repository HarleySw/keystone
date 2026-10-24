# Pi Tool Mapping

| Action skills request | Pi equivalent |
| :--- | :--- |
| Read / Write / Edit / Bash | `read`, `write`, `edit`, `bash` |
| Invoke a skill | Load the relevant `SKILL.md` with `read` when the skill applies, or `/skill:name` |
| Dispatch a subagent | Use `subagent` from `pi-subagents` if installed; otherwise execute inline |
| Task tracking | Use an installed todo tool or track in `TODO.md` |

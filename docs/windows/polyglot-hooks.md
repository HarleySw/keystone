# Cross-Platform Polyglot Hooks

Keystone uses `hooks/run-hook.cmd` as a polyglot Windows/Unix dispatcher that invokes extensionless bash scripts in `hooks/` (such as `hooks/session-start`).

- **On Windows (`cmd.exe`):** Locates Git Bash (`C:\Program Files\Git\bin\bash.exe` or `bash` on `PATH`) and executes the target hook script. If bash is absent, exits `0` silently.
- **On Unix (`bash`/`sh`):** Treats the Windows batch block as a no-op heredoc (`: << 'CMDBLOCK'`) and `exec`s the extensionless script directly.
- **Line Endings:** `.gitattributes` enforces `eol=lf` on `*.cmd`, `*.sh`, and `hooks/session-start`.

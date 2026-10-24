# Keystone

> **"Ship at AI speed without Comprehension Debt — The Human-in-Command Agent Skills Ecosystem."**
>
> 🌐 **Languages:** [English](README.md) | [Tiếng Việt](README.vi.md)

While traditional agent frameworks focus on autonomous code generation or rigid SDLC guardrails, **Keystone** is the capstone that keeps the software engineer in command (**Human-in-Command**). It combines AI execution speed with a **Visual Comprehension Core** (`✅/⚠️/❌` dry-run tables, compact `<76`-char ASCII diagrams, zero machine-translated prose) and **Cognitive Verification Gates** so engineers deeply understand their system, catch root-cause bugs early, and never hesitate when defending designs or reviewing large PRs.

---

## Architecture & How It Works

```text
[Engineer Prompt]
       │
       ▼
[SessionStart Bootstrap: using-keystone]
       │
       ├──► 1. Visual Comprehension Core
       │       ├── Dry-Run Status Tables (✅ Pass / ⚠️ Edge / ❌ Block)
       │       └── Compact ASCII Diagrams (<76 chars wide)
       │
       ├──► 2. Cognitive Verification Gates
       │       ├── Pre-Implementation Trade-off Gate
       │       └── Post-Implementation 3-Bullet Mental Model Check
       │
       └──► 3. Hybrid Language Engine
               ├── Skill Source: Imperative English (~25% token savings)
               └── Engineer Output: Native, domain-accurate language
```

### Comparison: Why Keystone?

| Dimension | Autonomous Code Gen | Rigid SDLC Checklists | **Keystone Ecosystem** |
| :--- | :--- | :--- | :--- |
| **Primary Goal** | Ship code autonomously | Enforce process steps | **Ship fast + 100% Engineer Comprehension** |
| **Visual Reasoning** | Walls of prose | Text templates | **Dry-Run Tables (`✅/⚠️/❌`) + `<76`c ASCII** |
| **Review Readiness** | High Comprehension Debt | Medium | **Zero Comprehension Debt (Cognitive Gates)** |
| **Language Routing** | Monolingual or noisy | Monolingual | **Imperative EN Source + Native Dev Output** |

---

## Installation

Install Keystone for your coding agent harness:

### Antigravity (`agy`)

```bash
agy plugin install https://github.com/HarleySw/keystone
```

### Claude Code

```bash
/plugin marketplace add HarleySw/keystone
/plugin install keystone@keystone-dev
```

### Cursor

In Cursor Agent chat:

```text
/add-plugin https://github.com/HarleySw/keystone
```

### Gemini CLI

```bash
gemini extensions install https://github.com/HarleySw/keystone
```

### OpenCode (v1 & v2)

Add to your `opencode.json` (see [docs/README.opencode.md](docs/README.opencode.md)):

```json
{
  "plugins": ["keystone@git+https://github.com/HarleySw/keystone.git"]
}
```

### Pi

```bash
pi install git:github.com/HarleySw/keystone
```

### Devin CLI / Hermes Agent / Kimi Code / Muse

```bash
# Devin CLI
devin plugins install HarleySw/keystone

# Hermes Agent
hermes plugins install HarleySw/keystone --enable

# Kimi Code (in chat)
/plugins install https://github.com/HarleySw/keystone

# Muse
muse plugins install ./keystone && muse plugins approve keystone
```

---

## Core Skills Library (`skills/`)

| Skill | Category | Purpose |
| :--- | :--- | :--- |
| **`using-keystone`** | Bootstrap | Loaded automatically at `SessionStart`. Establishes skill invocation rules, the **Visual Comprehension Core**, **Cognitive Verification Gates**, and **Hybrid Language Rules**. |
| **`writing-skills`** | Meta | TDD-adapted guide for creating, pressure-testing, and validating new Keystone skills using Imperative English and zero zombie nouns. |

---

## Hybrid Language & Token Efficiency Strategy

1. **Skill Source (`SKILL.md`, `AGENTS.md`, YAML):** Written strictly in **Imperative English** (`MUST`, `NEVER`, active verbs, zero zombie nouns). This maximizes TF-IDF / Semantic Routing precision across agent harnesses and saves ~25% context window tokens.
2. **Engineer Communication Output:** Governed by `using-keystone` to respond in the engineer's language. When communicating in Vietnamese, Keystone enforces natural senior-engineer terminology and strictly forbids awkward machine translation.
3. **Repository Documentation:** Bilingual ([README.md](README.md) in English and [README.vi.md](README.vi.md) in Vietnamese).

---

## Repository Structure

```text
keystone/
├── .claude-plugin/          # Claude Code manifest & dev marketplace
├── .codex-plugin/           # OpenAI Codex App/CLI manifest
├── .cursor-plugin/          # Cursor Agent manifest
├── .devin-plugin/           # Devin CLI manifest
├── .hermes-plugin/          # Hermes Agent Python hook & YAML manifest
├── .kimi-plugin/            # Kimi Code manifest
├── .muse-plugin/            # Muse manifest & marketplace
├── .opencode/               # OpenCode V1/V2 plugin & install guide
├── .pi/                     # Pi Coding Agent TypeScript extension
├── assets/                  # Plugin icons (SVG & PNG)
├── docs/                    # Harness-specific guides & testing docs
├── hooks/                   # Cross-platform SessionStart polyglot hooks
├── scripts/                 # Version synchronization & shell linting
├── skills/                  # Core Keystone skills (using-keystone, writing-skills)
└── tests/                   # Automated skill & hook verification suites
```

---

## Development & Verification

Run the built-in test and verification suite before submitting pull requests:

```bash
# Validate skill frontmatter and structure
bash tests/validate-skills.sh

# Test SessionStart JSON output across harnesses
bash tests/hooks/test-session-start.sh

# Check version sync across all 12 manifests
bash scripts/bump-version.sh --check

# Lint shell scripts
bash scripts/lint-shell.sh
```

## License

MIT License — see [LICENSE](LICENSE) for details.

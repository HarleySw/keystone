# Keystone

> **"Ship at AI speed without Comprehension Debt — The Human-in-Command Agent Skills Ecosystem."**
>
> 🌐 **Languages:** [English](README.md) | [Tiếng Việt](README.vi.md)

While traditional agent frameworks focus on autonomous code generation or rigid SDLC guardrails, **Keystone** is the capstone that keeps the software engineer in command (**Human-in-Command**). It combines AI execution speed with a **Visual Comprehension Core** (`✅/⚠️/❌` status signals, conversational vertical dry-run walkthroughs, compact `<76`-char ASCII diagrams, zero machine-translated prose) and **Cognitive Verification Gates** so engineers deeply understand their system, catch root-cause bugs early, and never hesitate when defending designs or reviewing large PRs.

---

## Architecture & How It Works

```text
[Engineer Prompt]
       │
       ▼
[SessionStart Bootstrap: using-keystone]
       │
       ├──► 1. Visual Comprehension Core
       │       ├── Vertical Case Walkthroughs (✅ Pass / ⚠️ Edge / ❌ Block)
       │       └── Compact ASCII Diagrams & Rulers (<76 chars wide)
       │
       ├──► 2. Two-Tier Storage & Crisp Chat Handoff
       │       ├── Human/Agent Docs: docs/keystone/map/ & docs/keystone/flows/
       │       └── Machine Audit Ledgers: .keystone/ (self-ignoring .gitignore)
       │
       ├──► 3. Cognitive Verification Gates
       │       ├── Pre-Implementation Trade-off Gate
       │       └── Pre-Output Clarity & Register Verification Gate
       │
       └──► 4. Hybrid Language Engine
               ├── Skill Source: Imperative English (~25% token savings)
               └── Engineer Output: Everyday spoken developer language
```

### Comparison: Why Keystone?

| Dimension | Autonomous Code Gen | Rigid SDLC Checklists | **Keystone Ecosystem** |
| :--- | :--- | :--- | :--- |
| **Primary Goal** | Ship code autonomously | Enforce process steps | **Ship fast + 100% Engineer Comprehension** |
| **Visual Reasoning** | Walls of prose | Text templates | **Vertical Dry-Runs (`✅/⚠️/❌`) + `<76`c ASCII** |
| **Review Readiness** | High Comprehension Debt | Medium | **Zero Comprehension Debt (Cognitive Gates)** |
| **Language Routing** | Monolingual or noisy | Monolingual | **Imperative EN Source + Spoken Dev Output** |

---

## Installation

Install Keystone for **Claude Code**, **Antigravity (IDE & CLI)**, **OpenAI Codex**, or **OpenCode**. You can also use the universal `npx skills` CLI to install skills directly.

### 1. Universal CLI (`npx skills` — `agentskills.io` / `skills.sh`)

```bash
# List all available skills in Keystone
npx skills add HarleySw/keystone --list

# Install all Keystone skills into your project or global agent directory (-g)
npx skills add HarleySw/keystone -g

# Or install a specific skill (e.g., map, flow, explain, craft) for your agents
npx skills add HarleySw/keystone --skill explain -a claude-code -a antigravity -a codex -a opencode
```

### 2. Claude Code

```bash
/plugin marketplace add HarleySw/keystone
/plugin install keystone@keystone-dev
```

### 3. Antigravity (IDE & CLI)

```bash
# Via Antigravity CLI (agy)
agy plugin install https://github.com/HarleySw/keystone

# Or install skills directly via npx skills for Antigravity IDE / GUI
npx skills add HarleySw/keystone -a antigravity -g
```

### 4. OpenAI Codex App & CLI

```bash
# Via Codex Plugin Marketplace CLI
codex plugin marketplace add HarleySw/keystone
codex plugin add keystone@keystone-dev

# Or install individual skills directly
codex skills add HarleySw/keystone/skills/map
codex skills add HarleySw/keystone/skills/flow
codex skills add HarleySw/keystone/skills/explain
```

### 5. OpenCode (v1 & v2)

Add to your `opencode.json` (see [.opencode/INSTALL.md](.opencode/INSTALL.md) and [docs/README.opencode.md](docs/README.opencode.md)):

```json
{
  "plugins": ["keystone@git+https://github.com/HarleySw/keystone.git"]
}
```

---

## Core Skills Library (`skills/`)

| Skill | Category | Purpose |
| :--- | :--- | :--- |
| **[`using-keystone`](skills/using-keystone/SKILL.md)** | Bootstrap | Loaded automatically at `SessionStart`. Establishes scale-based skill routing, the **Visual Comprehension Core**, **Two-Tier File Storage**, **Cognitive Verification Gates**, and **Hybrid Language Rules**. |
| **[`map`](skills/map/SKILL.md)** | Architecture Recon | Whole-repository onboarding and architecture mapping (`recon-graphs.sh` + `validate-atlas.sh`). Locates Composition Roots, audits $100\%$ file coverage in `.keystone/map/01-coverage-ledger.md`, writes `docs/keystone/map/`, and updates `./AGENTS.md`. |
| **[`flow`](skills/flow/SKILL.md)** | Business Flow Anatomy | End-to-end feature and pipeline dissector. Traces a concrete user/system trigger from High-Level entry down to Low-Level code steps (`Contrastive Why` + `Vertical Dry-Run`) with a `"Where to Touch"` modification playbook saved to `docs/keystone/flows/`. |
| **[`explain`](skills/explain/SKILL.md)** | Code & Concept Explanation | Human-centric, structure-free code and technical explanation in chat. Enforces `learn-from-code` communication rules (plain-language opening, `<76`-char inline comments & ASCII rulers, natural "Why" & API explanations, zero section boilerplate) while adapting freely to the user's question. |
| **[`craft`](skills/craft/SKILL.md)** | Meta-Skill | 5-Stage TDD pipeline for designing, writing, upgrading, and pressure-testing Keystone skills with embedded 3-layer Clarity Engine enforcement and TF-IDF routing validation (`evals.json`). |

---

## Hybrid Language & Token Efficiency Strategy

1. **Skill Source (`SKILL.md`, `AGENTS.md`, YAML):** Written strictly in **Imperative English** (`MUST`, `NEVER`, active verbs, zero zombie nouns). This maximizes TF-IDF / Semantic Routing precision across agent harnesses and saves ~25% context window tokens.
2. **Engineer Communication Output:** Governed by `using-keystone` and embedded directly in every skill (`map`, `flow`, `explain`, `craft`) via a 3-layer Clarity Engine check to respond in the engineer's active language. When communicating in Vietnamese, Keystone enforces natural spoken senior-engineer phrasing (`learn-from-code` register) and strictly forbids awkward machine translation.
3. **Repository Documentation:** Bilingual ([README.md](README.md) in English and [README.vi.md](README.vi.md) in Vietnamese).

---

## Repository Structure

```text
keystone/
├── .agents/plugins/         # Portable Agent Plugins & Codex marketplace catalog
├── .claude-plugin/          # Claude Code manifest & marketplace catalog
├── .codex-plugin/           # OpenAI Codex App/CLI manifest
├── .opencode/               # OpenCode V1/V2 plugin & install guide
├── assets/                  # Plugin icons (SVG & PNG)
├── hooks/                   # Cross-platform SessionStart polyglot hooks
├── scripts/                 # Version synchronization & shell linting
├── skills/                  # Core Keystone skills (using-keystone, map, flow, explain, craft)
└── tests/                   # Automated skill, routing & hook verification suites
```

---

## Development & Verification

Run the built-in test and verification suite before submitting pull requests:

```bash
# 1. Validate skill frontmatter, references, and structure
bash tests/validate-skills.sh

# 2. Validate TF-IDF semantic routing and negative boundaries (Rank-1 = 100%)
bash tests/validate-routing.sh

# 3. Test map recon-graphs.sh and validate-atlas.sh scripts
bash tests/map/test-map-scripts.sh

# 4. Test SessionStart JSON output across Claude Code and Antigravity / SDK harnesses
bash tests/hooks/test-session-start.sh

# 5. Check version sync across all 14 manifests & skill files
bash scripts/bump-version.sh --check

# 6. Lint shell scripts
bash scripts/lint-shell.sh
```

## License

MIT License — see [LICENSE](LICENSE) for details.

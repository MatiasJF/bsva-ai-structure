# bsva-ai-structure

The canonical BSVA structure for using Claude (and other AI assistants) cohesively across the organization.

This repo gives every BSVA person the same starting point: shared skills, MCPs, security practices, and department-specific templates. It is **both a toolkit and a training program**.

> [!TIP]
> **New here?** Start with the [**Quickstart →**](QUICKSTART.md) (5 minutes, visual, any OS).
> The rest of this README is the full reference.

---

## What lives here

```
global/         Tools everyone gets: base CLAUDE.md, skills, MCPs, settings
guides/
  for-humans/   How to use Claude responsibly and efficiently (READ FIRST)
  for-claude/   Identity, refusal, brand voice — loaded into Claude's context
  visuals/      Mermaid diagrams for onboarding, lifecycles, flows
security/       Classification, redaction, incident response
departments/    Per-department skills, templates, MCPs, guides
  developer-relations/
  technology/
  education/
  operations/   (biz-dev, marketing, legal, exec)
```

---

## Who this is for

**Every BSVA person.** Not just engineers. The guides are written for humans first — Claude is a capable assistant, not a magic box, and using it well requires judgement from you.

**After you run `./install.sh`**, the tutorial + marketplace open automatically on your **first Claude session** — wired via a one-shot `SessionStart` hook.

To open them manually any time:

```bash
cd ~/bsva-ai-structure
./tutorial/start.sh              # tutorial (10-min guided tour)
./tutorial/start.sh marketplace  # marketplace (browseable catalog of 150+ items)
```

In a Claude session you can also just ask: *"open the tutorial"* or *"show the marketplace"* — the `open-tutorial` / `open-marketplace` skills run the launcher for you.

If you prefer to read:

1. `guides/for-humans/01-what-is-claude-code.md`
2. `guides/for-humans/02-first-hour-setup.md`
3. `guides/for-humans/07-BEFORE-YOU-PASTE.md` ← **read this before your first real session**
4. `workflow/01-the-cycle.md`
5. `guides/visuals/02-onboarding-flow.md`

---

## Requirements

The bare minimum to run the installer + tutorial + marketplace:

| Tool | Why it's needed | How to get it |
|---|---|---|
| **git** | to clone + update the repo | macOS: Xcode CLT · Linux: `apt/dnf install git` · Windows: winget |
| **Python 3.7+** | installer, marketplace scanner, local HTTP server, hook merger | macOS: `brew install python3` · Linux: system package · Windows: winget |
| **A browser** | viewing the tutorial / marketplace | you already have one |
| **Claude Code** | the point of all this | https://claude.com/claude-code |

Node.js is **not** required for the tutorial or marketplace — it's only needed if you're working on DevRel's SDK example templates.

Don't have Python or git? Run `./bootstrap.sh` (or `.\bootstrap.ps1` on Windows) first. It detects your OS, finds the right package manager (brew / apt / dnf / pacman / winget / choco), and asks before installing each missing tool.

---

## Install (humans)

```bash
# 1. Clone
git clone https://github.com/MatiasJF/bsva-ai-structure.git ~/bsva-ai-structure
cd ~/bsva-ai-structure

# 2. Prerequisites (once per machine)
./bootstrap.sh           # macOS / Linux
# or
.\bootstrap.ps1          # Windows

# 3. Installer — copies global skills + MCPs to ~/.claude/, picks your
#    department, and (optionally) wires the SessionStart hook that
#    opens the tutorial + marketplace on your first Claude session.
./install.sh             # macOS / Linux
# or
.\install.ps1            # Windows

# 4. Start Claude — tutorial + marketplace open automatically (once).
#    Or open them on-demand any time:
./tutorial/start.sh              # tutorial
./tutorial/start.sh marketplace  # marketplace

# Pull updates later:
cd ~/bsva-ai-structure && git pull && ./install.sh --sync
```

The installer is **idempotent** — safe to re-run. It backs up anything it replaces.

If you already have git + Python and want to skip the bootstrap check, run `./install.sh --skip-preflight`.

---

## Ownership

DevRel maintains the repo. Each department has write authority over its own folder via `CODEOWNERS`. See `guides/for-humans/05-treating-claude-seriously.md` for the governance model and how to propose changes.

---

## License & classification

This repo is **Internal**. The `guides/for-humans/` folder and `security/classification.md` may eventually be mirrored to a public repo, but only after review. Do not share screenshots of department folders externally without checking with DevRel.

---

## Getting help

- Structural questions → DevRel (see `CODEOWNERS`)
- Security / classification questions → `security/incident-response.md`
- Claude Code product questions → `guides/for-humans/` or https://claude.com/claude-code

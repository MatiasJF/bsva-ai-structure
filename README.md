# bsva-ai-structure

The canonical BSVA structure for using Claude (and other AI assistants) cohesively across the organization.

This repo gives every BSVA person the same starting point: shared skills, MCPs, security practices, and department-specific templates. It is **both a toolkit and a training program**.

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

If you are new to Claude, start here:

1. `guides/for-humans/01-what-is-claude-code.md`
2. `guides/for-humans/02-first-hour-setup.md`
3. `guides/for-humans/07-BEFORE-YOU-PASTE.md` ← **read this before your first real session**
4. `guides/visuals/02-onboarding-flow.md`

---

## Install (humans)

```bash
# 1. Clone somewhere on your machine
git clone git@github.com:MatiasJF/bsva-ai-structure.git ~/bsva-ai-structure
cd ~/bsva-ai-structure

# 2. Run the installer. It will:
#    - copy global/ skills and MCPs into ~/.claude/
#    - ask which department you belong to
#    - link department CLAUDE.md into your project when you run `bsva-link`
./install.sh          # macOS / Linux
# or
./install.ps1         # Windows PowerShell

# 3. Later, to pull updates
cd ~/bsva-ai-structure && git pull && ./install.sh --sync
```

The installer is **idempotent** — safe to re-run. It will not overwrite your personal skills or settings.

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

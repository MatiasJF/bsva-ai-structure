# 01 — What is Claude Code?

Claude Code is Anthropic's AI assistant built specifically for real work: writing code, drafting documents, debugging systems, researching, and automating tasks. This guide covers how BSVA uses it.

---

## The three surfaces you'll see

| Surface | Where it runs | Best for |
|---|---|---|
| **Claude Code CLI (terminal)** | A command in your terminal | Engineers, DevRel, technical education. Full power: hooks, skills, MCPs, subagents, `/loop`, plan-mode. |
| **Claude Code Desktop (app)** | Mac / Windows application | Everyone else. Visual, project-based, friendlier for non-engineers. Supports skills, MCPs. |
| **Claude.ai web** | Browser | Quick questions, casual use. No MCPs, no file access by default. |

**BSVA's default**: engineers use the CLI; everyone else uses the Desktop app. Both are covered in this guide series.

---

## What Claude Code is NOT

This is the single most important framing we ask you to hold:

- **It is not a search engine.** It can be confidently wrong.
- **It is not a compliance officer.** It will not automatically know what is Confidential at BSVA.
- **It is not your co-worker.** It does not remember the last conversation unless you or the system explicitly persists it.
- **It is not a vault.** Anything you paste into it may be processed by Anthropic's models. Treat pasting like sending a document to a vendor — because, technically, you are.

---

## What Claude Code IS

- A very capable assistant that **drafts, transforms, summarizes, explains, codes, debugs, and automates** — fast.
- A tool that **does what you tell it**. The quality of output tracks the quality of your input and your judgment.
- A system with **real permissions and real consequences**. If you give it access to your terminal, it can execute commands. If you give it access to a repo, it can edit files. You are accountable for what it does on your behalf.

---

## How BSVA uses it

1. **Everyone has the `~/.claude/CLAUDE.md`** installed by the BSVA installer. That file tells Claude the minimum rules for BSVA (see `global/CLAUDE.md`).
2. **Every department has its own `CLAUDE.md`** with department-specific context.
3. **Every person is responsible for pre-flight** — classifying content before they paste it. See `07-BEFORE-YOU-PASTE.md`.

---

## The three layers of context Claude sees

```
1. Global CLAUDE.md    — BSVA-wide rules (identity, voice, security minimums)
2. Department CLAUDE.md — how your department works with Claude
3. Project CLAUDE.md    — this specific project's context
```

If Claude ever seems "out of character" — ignoring BSVA voice, skipping security checks — your CLAUDE.md layering is probably broken. Ping DevRel.

---

## Next

→ `02-first-hour-setup.md`

# How to start a DevRel project

A walk-through for scaffolding a new DevRel artifact (example, workshop, post) with Claude wired in correctly.

---

## Before you start

Check:
- [ ] You've run `./install.sh` at least once.
- [ ] Your Nestr MCP is configured (test: ask Claude "who am I in Nestr?").
- [ ] You've read `guides/for-humans/07-BEFORE-YOU-PASTE.md`.

---

## Step 1 — Pick a template

| Artifact | Template |
|---|---|
| A small `@bsv/sdk` example | `templates/new-sdk-example/` |
| A workshop with lessons + solutions | `templates/new-workshop/` |
| A Markdown blog post | `templates/new-blog-post/` |

If none fit, use the closest and customize.

## Step 2 — Copy the template

```bash
cp -R ~/bsva-ai-structure/departments/developer-relations/templates/new-sdk-example \
      ~/projects/my-new-example
cd ~/projects/my-new-example
```

## Step 3 — Link CLAUDE.md

```bash
ln -s ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md CLAUDE.md
```

(Or `cp` instead of `ln -s` if you plan to customize.)

## Step 4 — Add project-specific context

If your project needs Claude to know something specific (an SDK version, a particular audience, a non-default approach), add a line to the project's own `CLAUDE.md` that extends the symlinked department one.

If you symlinked: don't edit the symlink target. Instead, make the project's CLAUDE.md a real file that **includes** the department one:

```markdown
# My project — CLAUDE.md

Read: ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md

## Project-specific

This example targets @bsv/sdk v2.x. Assume SDK features from v2.
Audience: developers familiar with Bitcoin fundamentals but new to BSV.
```

## Step 5 — Init git, commit scaffold

```bash
git init
git add .
git commit -m "scaffold from new-sdk-example template"
```

## Step 6 — Start Claude in the project folder

```bash
claude
```

Verify it's seeing the context:

> "What is this project about, and what DevRel conventions should I apply?"

You should get an answer grounded in DevRel's CLAUDE.md (SDK-correct, code-runnable, BSVA voice).

---

## How to author a new skill

If during the project you find yourself giving Claude the same 5-line instruction repeatedly, package it.

1. In your project: `mkdir -p .claude/skills/my-skill`.
2. Create `SKILL.md` with frontmatter:
   ```yaml
   ---
   name: my-skill
   description: When Claude should invoke this. Be specific.
   classification: Internal
   owner: "@bsva/devrel"
   ---
   ```
3. Add the body: what Claude should do when invoked, examples of input/output.
4. Test it: `/my-skill` in a session.
5. Once it's useful beyond this project, promote it:
   - **To DevRel**: copy to `departments/developer-relations/skills/` in the structure repo, PR.
   - **To global**: copy to `global/skills/`, PR with DevRel + Security sign-off.

See `guides/visuals/03-skill-lifecycle.md`.

---

## How to ship

DevRel content usually targets one of:

- **Blog post** → draft in your project → PR to the BSVA blog repo.
- **Workshop** → complete the template → PR to the BSVA workshops repo → schedule.
- **SDK example** → complete the example → PR to `@bsv/sdk` examples or to a dedicated examples repo.

Claude can help at every stage. Review carefully — published DevRel content carries BSVA's reputation for technical rigor.

---

## Review checklist

Before you PR:

- [ ] Code runs on a fresh clone with `npm install && npm start`.
- [ ] No hardcoded secrets, no real user data, no testnet keys that others have used publicly.
- [ ] BSVA voice (see `guides/for-claude/brand-voice.md`).
- [ ] No mention of unreleased features without sign-off.
- [ ] Example has a `README.md` with objectives, prerequisites, run instructions.
- [ ] Claude's assumptions verified against the actual SDK (not hallucinated methods).

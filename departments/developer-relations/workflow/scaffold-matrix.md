# DevRel — scaffold matrix

Artifact → template → skills → MCPs → estimated effort. Use as a lookup when entering step 7 of the cycle.

| Artifact | Template | Required skills | MCPs | Est. effort |
|---|---|---|---|---|
| Dev-support reply | — (inline) | `draft-dev-support-reply`, `triage-sdk-issue`, `verify-sdk-surface` | Nestr, WhatsOnChain, (GitHub/Discord if wired) | 15–60 min |
| SDK example | `templates/new-sdk-example/` | `sdk-example-scaffold`, `verify-sdk-surface`, `classify-before-publish` | simple-mcp, BSV Academy, (GitHub) | 2–4 h |
| Blog post | `templates/new-blog-post/` | `blog-post-from-transcript` (if from talk), `verify-sdk-surface`, `external-comm-check`, `classify-before-publish` | BSV Academy, WhatsOnChain (for on-chain refs) | 3–6 h draft + review |
| Workshop | `templates/new-workshop/` | `workshop-lesson-splitter`, `sdk-example-scaffold`, `verify-sdk-surface`, `classify-before-publish` | simple-mcp, BSV Academy, (GitHub) | 2–5 days over 2 weeks |
| Conference talk | — (project dir) | `blog-post-from-transcript` (reverse: outline → talk), `external-comm-check` | BSV Academy | 1–3 days |
| Hackathon judging rubric | — (project dir) | `external-comm-check`, `classify-before-publish` | — | 4–8 h |

## The scaffold sequence

Once CLARIFY + CAPTURE + PLAN are done:

```bash
# 1. Copy template (not symlink — template will be customized)
cp -R ~/bsva-ai-structure/departments/developer-relations/templates/<template> ~/projects/<project>
cd ~/projects/<project>

# 2. Link the DevRel CLAUDE.md (symlink so updates propagate)
ln -s ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md CLAUDE.md

# 3. Init git + first commit
git init
git add .
git commit -m "scaffold from new-<template> — Nestr nest #N-xxxx"

# 4. Open Claude in the folder
claude
```

Then ask Claude to verify context:

> "What is this project and how should I help?"

A healthy response cites DevRel's CLAUDE.md, names the template, references the Nestr nest by ID (if you've mentioned it), and proposes the first few execution steps. If the response is generic, your CLAUDE.md layering is broken.

## Project-specific CLAUDE.md additions

For DevRel projects, always add these to the project's CLAUDE.md (after the symlinked department base):

- **SDK version pin** (`@bsv/sdk v1.9.3`, or "latest as of [date]").
- **Target audience** (e.g., "intermediate SDK dev, some Bitcoin background").
- **Surface** (e.g., "BSVA blog; will cross-post to Medium").
- **Nest ID** (Nestr nest reference, e.g., `#N-6611`).
- **Related tensions** (any cross-role tensions linked to this project).

This keeps Claude grounded for the duration of the project without forcing you to restate it every session.

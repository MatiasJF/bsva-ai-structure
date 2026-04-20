# DevRel templates

Starter projects DevRel uses when scaffolding new artifacts. Copy, don't symlink — these are meant to be customized per project.

## Templates

| Template | For |
|---|---|
| `new-sdk-example/` | A minimal `@bsv/sdk` example. Best for illustrating a single concept. |
| `new-workshop/` | A workshop repo (multi-lesson, starter + solutions per lesson). |
| `new-blog-post/` | A Markdown-only post with BSVA frontmatter. |

## Usage

```bash
cp -R ~/bsva-ai-structure/departments/developer-relations/templates/new-sdk-example \
      ~/projects/my-new-example
cd ~/projects/my-new-example
git init && git add . && git commit -m "scaffold from new-sdk-example"
```

Then link or copy the department `CLAUDE.md` into the project root. See `guides/visuals/06-project-scaffolding.md`.

## Proposing new templates

PR against this folder. Include a `README.md` at the template's root explaining what it produces.

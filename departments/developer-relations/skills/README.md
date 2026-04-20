# DevRel department skills

Skills specific to Developer Relations work. Installed into a Claude session when the user is working in a DevRel-linked project.

## Adding a skill

See `guides/visuals/03-skill-lifecycle.md` for the full flow. TL;DR:

1. Scaffold a directory here: `<skill-name>/SKILL.md`.
2. Test locally by copying to `~/.claude/skills/` or `.claude/skills/` in your project.
3. Open a PR; DevRel reviews.

## Conventions

- Skill names use `kebab-case`.
- `SKILL.md` frontmatter `description` is a precise one-liner: **when should Claude invoke this?** Claude matches on description, so specificity matters.
- Include 2–3 example input → expected output pairs for reviewer sanity.
- `classification:` defaults to `Internal` for DevRel skills.
- `owner:` is `"@bsva/devrel"`.

## Initial skills

*(Placeholder — DevRel will add skills here over time. Initial candidates:)*

- `sdk-example-writer` — turn a one-paragraph intent into a runnable `@bsv/sdk` example.
- `workshop-lesson-builder` — turn outline bullets into a full lesson markdown with starter + solution code.
- `blog-post-from-notes` — turn raw notes into a BSVA-voice blog draft.
- `sdk-method-verifier` — given a snippet of Claude-proposed code, check every SDK method call against the installed package.

# Visuals

BSVA's AI-structure diagrams, in Mermaid. Each file contains:

- **Mermaid source** — renders automatically on GitHub.
- **Prose walkthrough** — what the diagram shows, step by step.
- **Ownership / RACI** — who is responsible at each step.

---

## The seven diagrams

| # | File | What it shows |
|---|---|---|
| 01 | [architecture](01-architecture.md) | How the repo, `~/.claude/`, and projects connect; where MCPs sit. |
| 02 | [onboarding-flow](02-onboarding-flow.md) | A new BSVA person, day 1 to first Claude session. |
| 03 | [skill-lifecycle](03-skill-lifecycle.md) | Author → review → merge → install → use for a new skill. |
| 04 | [mcp-lifecycle](04-mcp-lifecycle.md) | Same shape for a new MCP. |
| 05 | [preflight-classification](05-preflight-classification.md) | Human decision tree before pasting. |
| 06 | [project-scaffolding](06-project-scaffolding.md) | Pick template → clone → link CLAUDE.md → work. |
| 07 | [incident-response](07-incident-response.md) | Leak discovered → contain → notify → learn. |

---

## Exports

`exports/` holds PNG / SVG snapshots for slide decks and Slack. These are **not** automatically generated — export them when a diagram is finalized using the Mermaid CLI:

```bash
# install mermaid CLI
npm i -g @mermaid-js/mermaid-cli

# export a single diagram
mmdc -i 01-architecture.md -o exports/01-architecture.png

# or script all of them (see exports/export-all.sh if present)
```

By default `.gitignore` excludes `exports/*.png` and `exports/*.svg` to keep the repo small. Remove those lines from `.gitignore` if you want the exports version-controlled.

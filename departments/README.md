# Departments

Each department has a self-contained folder with:

- `CLAUDE.md` — the department-specific layer Claude reads in department projects.
- `skills/` — Claude skills specific to that department's work.
- `mcps/` — MCP configs specific to that department (if any).
- `templates/` — starter project templates (copy these to begin new projects).
- `guides/` — department-specific how-to.

---

## The departments

| Folder | Department | Default tier | Lead role (Nestr) |
|---|---|---|---|
| `developer-relations/` | Developer Relations | Internal | DevRel Lead |
| `technology/` | Technology / Engineering | Internal | Tech Lead |
| `education/` | Education / BSV Academy | Internal (drafts) / Public (published) | Education Lead |
| `operations/` | Business Development, Marketing, Legal, Exec | Varies per sub-section | Operations Lead |

---

## How departments add content

1. Each department has write access to its own folder via `CODEOWNERS`.
2. PRs modifying another department's folder require that department's sign-off.
3. Global changes (to `global/`, `security/`, `guides/for-humans/`) require DevRel + Security review.

---

## If you're joining a new department

1. `cd departments/<your-dept>`
2. Read the department `CLAUDE.md`.
3. Read the department `guides/`.
4. Scaffold your first project from `templates/`.

See `guides/visuals/02-onboarding-flow.md` and `guides/visuals/06-project-scaffolding.md`.

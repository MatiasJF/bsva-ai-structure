# How to start a Technology project

Scaffolding guide for BSVA Tech work.

## Pick a template

| Template | For |
|---|---|
| `templates/new-service/` | A backend service, HTTP or otherwise. |
| `templates/new-protocol-spec/` | A proposed protocol / BRC document. |
| `templates/new-research-note/` | Internal research write-up or analysis. |

## Scaffold

```bash
cp -R ~/bsva-ai-structure/departments/technology/templates/new-service ~/projects/my-service
cd ~/projects/my-service
ln -s ~/bsva-ai-structure/departments/technology/CLAUDE.md CLAUDE.md
git init && git add . && git commit -m "scaffold from new-service"
```

## Project CLAUDE.md additions

Add context Claude needs:
- Language / runtime versions.
- External systems integrated with (queues, DBs, HSMs).
- Performance or correctness constraints.
- Whether the project handles customer or on-chain data (drives classification).

## Wire-up checklist

- [ ] `CLAUDE.md` present and links / copies `departments/technology/CLAUDE.md`.
- [ ] Project-specific context added if non-trivial.
- [ ] Ask Claude: "What is this service and what must I be careful about?" — check response is grounded.
- [ ] `.env` in `.gitignore` — always.
- [ ] If involving secrets: document where they live (Vault path, secret manager key name) — never commit the values.

## Common Tech-specific gotchas

- **Dependency hallucination**: Claude sometimes invents packages. Verify every `npm install` / `pip install` / `go get` against the real registry.
- **Silent refactors**: ask explicitly for narrow diffs when editing existing code.
- **Test-less changes**: if you didn't ask for tests, Claude may skip them. Ask explicitly.
- **Config drift**: Claude may change config (`package.json` scripts, `tsconfig.json` flags) as a side effect. Diff config files carefully.

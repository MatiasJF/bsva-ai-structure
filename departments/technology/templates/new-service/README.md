# new-service

Minimal BSVA Tech service scaffold. Language-agnostic — this README describes the *layout*, not a specific runtime.

## Suggested layout

```
my-service/
├── README.md
├── CLAUDE.md              symlink to departments/technology/CLAUDE.md
├── .env.example           documented, no real secrets
├── .gitignore
├── src/
├── tests/
├── docs/
│   └── design.md          one short design doc; updated as the service evolves
├── deploy/                optional — infra-as-code, never with secrets
└── scripts/
```

## Usage

```bash
cp -R ~/bsva-ai-structure/departments/technology/templates/new-service ~/projects/my-service
cd ~/projects/my-service
ln -s ~/bsva-ai-structure/departments/technology/CLAUDE.md CLAUDE.md
git init && git add . && git commit -m "scaffold from new-service"
```

## First actions

1. Pick your runtime (Node, Go, Python — BSVA Tech uses several).
2. Add the minimum `package.json` / `go.mod` / `pyproject.toml`.
3. Write `docs/design.md`: purpose, inputs, outputs, non-goals.
4. Only then write code.

## Security minimums

- `.env.example` documents every env var; `.env` is in `.gitignore`.
- Secrets via your team's secret manager, never in code.
- Input validation at every boundary (HTTP, queue, CLI).
- Structured logs; redact PII and secrets in logging helpers.

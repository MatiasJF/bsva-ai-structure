---
name: tech:new-service
description: Wraps simple-mcp service generators with BSVA Tech conventions — CLAUDE.md layering, .env ignore, secrets-doc checklist, README template. Invoke when scaffolding a new backend service in Tech. Refuses to scaffold services touching HSMs / signing / prod credentials in a Claude session.
classification: Internal
owner: "@bsva/technology"
version: 0.1.0
---

# tech:new-service

BSVA-compliant service scaffold.

## Behavior
1. Asks CLARIFY questions from the code-change set.
2. Scaffolds the service skeleton from `templates/new-service/`.
3. Ensures `.env` is gitignored; `.env.example` documented.
4. Creates `docs/design.md` with purpose / inputs / outputs / non-goals.
5. Wires CI baseline if the project type supports it.

## Hard rules
- Refuse if the service will handle HSM / signing.
- Refuse if secrets would need to live in the repo.
- Default test framework + at least one placeholder test.

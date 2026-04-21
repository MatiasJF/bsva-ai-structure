# Legal — workflow

Legal at BSVA uses Claude **only for public research and generic templates**. BSVA-specific legal matter never enters Claude.

## Reading order

1. `<repo>/workflow/` + `../README.md` — shared cycle + Operations twists.
2. `public-research-only.md` — the most important rule.
3. `template-starter-playbook.md` — the one cycle Legal actually runs.
4. `refusal-matrix.md` — what Claude refuses, with escalation paths.

## Default tier

**Restricted.** Even sessions that feel Internal are treated as Restricted by default.

## The one unbreakable rule

**BSVA-specific matter stays out of Claude.** Always. Forever. No exceptions.

## Typical artifacts (narrow scope)

- Public law / regulation research summaries.
- Generic template starters (MNDA skeleton, DPA skeleton) — non-BSVA-specific.
- Clause-structure explainers (abstract only).
- Jurisdictional comparison notes.
- Compliance checklists keyed to public rules.

**Not** typical: contracts, privileged correspondence, specific matter memos, litigation material.

## Session setup

- Run with `Stop` hook logging enabled (see `../session-logging.md`).
- Use CLI or Desktop, never web.
- `/clear` after each task; don't leave sessions open.

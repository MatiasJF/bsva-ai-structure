# Executive — workflow

Exec at BSVA uses Claude for **public-audience drafting** and **public-source digests only**. All BSVA-specific strategy, board, M&A, HR, and financial material stays offline.

## Reading order

1. `<repo>/workflow/` + `../README.md` — shared cycle + Operations twists.
2. `public-audience-drafts.md` — what Exec drafts with Claude.
3. `brief-builder-playbook.md` — public-source digests.
4. `restricted-session-rules.md` — session hygiene.

## Default tier

**Restricted.** All Exec sessions run as Restricted until Exec explicitly down-classifies a specific artifact (usually when drafting something public-facing).

## Session rules

- **CLI or Desktop only.** Never web.
- **`/clear` after each task.** Don't leave sessions open.
- **Stop-hook audit logging enabled** (see `../session-logging.md`).
- **Scoped file access** — project folder only.

## What Exec does with Claude

- Structuring public-audience memos, op-eds, speeches, investor updates (narrative only, numbers filled offline).
- Summarizing public industry reports, policy developments, competitor public posture.
- Drafting interview / panel prep from public material.
- Scaffolding strategy-document outlines (no BSVA specifics in the outline).

## What Exec does NOT do with Claude

- **Board materials, minutes, memos, resolutions.**
- **M&A**: candidates, term sheets, due diligence, considerations.
- **Compensation, equity, hiring specifics, performance management.**
- **Confidential partner commitments** beyond public announcement.
- **Unreleased financial data.**
- **Strategic alternatives under consideration.**

## The principle

Claude is a drafting and structuring assistant for Exec's **public-facing** work. It is never a confidant for Exec's **governance** work.

---
name: tech:review-pr
description: Runs BSVA Tech's PR review checklist against a diff. Flags hallucinated symbols, unasked refactors, missing tests, secrets, customer identifiers, production hostnames. Invoke when reviewing a PR (Claude-authored or human) before merge.
classification: Internal
owner: "@bsva/technology"
version: 0.1.0
---

# tech:review-pr

Applies `departments/technology/guides/review-checklist.md` to a diff.

## Behavior
1. Reads the diff (file paths + hunk content).
2. Runs per-category checks: correctness, Claude-specific, security, observability, docs.
3. Reports pass / fail / warning per category with specific line references.
4. For code-path changes, flags whether a second Security reviewer is required (crypto / auth / consensus).

## Hard rules
- Never approve on its own — always returns a report for the human reviewer.
- Flags any hardcoded secret, key, or credential — blocks.
- Flags unasked refactors loudly — BSVA Tech rejects those.

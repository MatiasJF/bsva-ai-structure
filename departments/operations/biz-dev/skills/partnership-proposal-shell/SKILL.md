---
name: partnership-proposal-shell
description: Produces placeholder-only partnership / sponsorship proposal templates. Refuses any real partner name, real amount, or real commercial term. Real values are filled in outside Claude. Invoke when drafting a proposal skeleton.
classification: Confidential
owner: "@bsva/operations"
version: 0.1.0
---

# partnership-proposal-shell

## Behavior
1. CLARIFY: deal archetype, structure sections wanted, placeholder count.
2. Produces a placeholder-rich template (`[PARTNER_A]`, `[AMOUNT]`, `[TERM_MONTHS]`, etc.).
3. Applies BSVA voice via `external-comm-check`.
4. Emits the shell for offline filling.

## Hard rules
- No real partner names. Ever.
- No real amounts. Ever.
- Refuses to operate on partly-filled proposals without `anonymizer` first.

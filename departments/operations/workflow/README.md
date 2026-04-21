# Operations — workflow

How Operations (biz-dev, marketing, legal, exec) applies the BSVA cycle (see `<repo>/workflow/`).

## The Operations twist

Operations sits where content sensitivity peaks. The cycle applies, with **tightened defaults**:

- **Anonymize-first** posture: the `anonymizer` skill runs at the start of every Operations session.
- **Up-classify by default**: Confidential is the floor for biz-dev; Restricted is the floor for legal and exec.
- **Placeholders for partners and amounts**: `[PARTNER_A]`, `[AMOUNT]` — real values filled outside Claude.

## Reading order

1. `<repo>/workflow/` — the shared cycle.
2. `classify-before-paste.md` — Operations' up-classify discipline.
3. `nest-vs-tension.md` (this folder) — Operations-typed decision tree.
4. `placeholders-and-anonymizer.md` — redact before paste.
5. `source-allowlists.md` — approved public sources per sub-section.
6. `session-logging.md` — when to enable audit logging (Legal / Exec).
7. Sub-section folder for your specific area:
   - `biz-dev/`
   - `marketing/`
   - `legal/`
   - `exec/`

## Top artifacts (per sub-section)

See each sub-section's own `README.md` and `typical-artifacts.md`.

## The one unbreakable rule

**No unannounced partner names enter any Operations Claude session.** Use placeholders. Real values are filled in a separate, non-Claude document.

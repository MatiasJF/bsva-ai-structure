# Education — translation workflow

Translations are forks. Every published EN asset implies a translation nest per target language.

---

## The rule

**Source versioning matters.** A translation is against a specific version of an EN lesson. When the EN changes, the translation becomes stale — track that explicitly.

## Roles

- **Translator** (BSVA role) — owns the translation. If you hold the Translator role for a language, you can nest your own translation work.
- **Native-speaker reviewer** — identified per language. Reviewer's time is always a tension.

## The cycle for a translation

1. **CLARIFY** — source ID + version, target register, termbase, reviewer identified?
2. **CAPTURE** — **nest** under Translator role (your own work) + **tension** to reviewer's role.
3. **PLAN-MODE** — if large. For a single lesson, a brief plan in the nest description suffices.
4. **SCAFFOLD** — use `bilingual-side-by-side` skill; preserve source IDs; flag uncertain terms with `[?]`.
5. **EXECUTE** — draft. Update termbase as you make new term choices.
6. **REVIEW** — native-speaker review tension resolved.
7. **ORIGINAL-AUTHOR PASS** — final check from the EN author for meaning preservation (via brief tension or comment).
8. **REPORT** — publish to Academy LMS / relevant surface.
9. **CLOSE** — nest Done.

## Termbase discipline

Every language has a termbase (glossary of canonical term choices). BSVA's convention:

- Termbase lives in a shared location (`departments/education/termbases/<lang>/glossary.md`) or in the TM system if one is wired.
- Before translating, consult the termbase.
- Any new term gets a proposed entry; confirmed by native reviewer; merged to the termbase via PR.
- Drift between termbases across languages is a governance concern — routed to Education Lead.

## When to update an existing translation

- **Source EN changed**: stale-flag the translation; open a nest to re-translate (scoped to just the changed sections).
- **Term choice changed in termbase**: sweep all translations for the old term; open a batch nest.
- **Correction**: follow `publication-checklist.md` rollback.

## Clustering

- Multiple small EN updates → cluster into one translation-update nest per language.
- Native-speaker review asks → cluster per reviewer per week.

## Hard rules

- **Never** translate text that includes learner PII (even from a real support ticket) — redact first.
- **Never** publish a translation without native-speaker review.
- **Never** diverge from the EN source's meaning for "fluency" reasons. If the EN is unclear, the fix is in the EN, not the translation.

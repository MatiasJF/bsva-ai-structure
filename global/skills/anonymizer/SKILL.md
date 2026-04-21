---
name: anonymizer
description: Scans content for identifiable names, $ amounts, emails, phone numbers, URLs (private), API keys, dates, and project codenames, and replaces each with canonical BSVA placeholders from security/redaction-playbook.md. Invoke automatically at the start of any session pasting external content, and always before any Operations / Legal / Exec work. Refuses to proceed if it cannot reliably redact key material (private keys, seed phrases) — those trigger incident-response instead.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# anonymizer

BSVA's redaction discipline as a skill. See `security/redaction-playbook.md` for the full playbook.

## When Claude should invoke this

- **Automatically** at the start of any session where the user pastes external content.
- **Always** as the first step of Operations sessions (biz-dev, marketing).
- **Always** when the user explicitly says "anonymize this" / "redact" / "strip identifiers".
- When the user pastes something and asks a non-redaction question — offer redaction first.

## Placeholder vocabulary

Canonical, from `security/redaction-playbook.md`:

- `[PARTNER_A]`, `[PARTNER_B]` — external orgs
- `[BSVA_DEVREL]`, `[BSVA_MARKETING]`, `[BSVA_LEAD]` — BSVA roles
- `[ROLE_A]` — generic non-BSVA role
- `[EMAIL]` / `[contact@partner-a.example]`
- `[PHONE]`, `[INTERNAL_URL]`
- `[AMOUNT]` or `[~$10K]` — order-of-magnitude hints allowed
- `[DATE]` or `[Q2 2026]` — period-level hints allowed
- `[TXID]`, `[ADDRESS]`, `[BLOCK]`
- `[API_KEY]`, `[TOKEN]`, `[SECRET]`
- `[PROJECT_X]`, `[PROJECT_Y]` — unannounced work codenames

## Behavior

1. Scan the content for each pattern class.
2. Produce a redacted version with placeholders consistently applied (same entity → same placeholder throughout).
3. If key material is detected (WIF, xprv/xpub, BIP-39 word list, 64-hex, `-----BEGIN ... PRIVATE KEY-----`):
   - **Refuse** to process further.
   - **Do not echo** the key material back in output.
   - Point user to `security/incident-response.md` and tell them to rotate.
4. If structured data (CSV, JSON) — preserve structure, replace only identifier fields.
5. Return the redacted content + a brief map:

```
Redacted:
- 3 person names → [ROLE_A], [ROLE_B], [ROLE_C]
- 2 company names → [PARTNER_A], [PARTNER_B]
- 5 $ amounts → [AMOUNT]
- 2 email addresses → [EMAIL]

Original lengths: 2418 chars → Redacted length: 2440 chars

NOTE: Detected 1 potential API key (preserved header `X-API-Key:` but
replaced value). Please confirm this key has been rotated per
security/incident-response.md.
```

## Hard rules

- **Never** echo private keys / seeds back in any form.
- **Never** claim content is "fully redacted" when a fuzzy case exists — flag the fuzzy case and ask.
- When unsure whether an identifier is sensitive, up-classify (redact it).
- Do not redact the content's *structure* or *meaning* — only identifiers. Claude should still be able to reason about the shape.

## Cross-reference

- `security/redaction-playbook.md`
- `security/classification.md`
- `guides/for-humans/10-redact-before-you-paste.md`
- `guides/for-humans/09-what-NOT-to-send.md`

## Examples

*(Include 3 worked examples: a partner email thread, a log file with PII, a CSV with mixed fields.)*

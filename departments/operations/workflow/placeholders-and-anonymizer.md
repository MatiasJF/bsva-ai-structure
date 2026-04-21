# Operations — placeholders and the anonymizer

Operations uses placeholders more systematically than any other department. This file is the convention + the default workflow.

---

## The canonical placeholder vocabulary

(Reproduced from `security/redaction-playbook.md` — the canonical version.)

| Replace | With |
|---|---|
| External org name | `[PARTNER_A]`, `[PARTNER_B]`, `[VC_A]`, `[EXCHANGE_A]` |
| External role (non-BSVA) | `[PARTNER_LEAD]`, `[VC_PARTNER]` |
| BSVA role | `[BSVA_DEVREL]`, `[BSVA_BIZDEV]`, `[BSVA_LEAD]` |
| Email | `[EMAIL]` or `[contact@partner-a.example]` |
| Phone | `[PHONE]` |
| $ amount | `[AMOUNT]` or `[~$10K]` / `[~$100K]` / `[~$1M]` |
| Date | `[DATE]` or `[Q2 2026]` |
| Internal URL | `[INTERNAL_URL]` |
| Project codename | `[PROJECT_X]`, `[PROJECT_Y]` |
| API key / token | `[API_KEY]` — also rotate |
| BSV address / txid (private) | `[ADDRESS]`, `[TXID]` |

## The Operations session start

Every Operations session:

1. Claude asks: "biz-dev / marketing / legal / exec?"
2. Claude invokes `anonymizer` at first paste of external content — without being asked.
3. Claude refuses content that fails redaction.
4. Claude notes the default classification tier for the sub-section.

## When to use the anonymizer

- **Always** before pasting partner email threads, meeting notes with names, or any inbound correspondence.
- **Always** before pasting lead / prospect lists that carry identifiable personal info.
- **Always** when the user copies from a spreadsheet with compensation / commercial data.
- **Never skip** "because it's quick" — quick leaks are the worst kind.

## Working with redacted content

Claude can reason about the **shape** of content from redacted placeholders without ever seeing the specifics:

- "Review this proposal structure" — works fine on `[PARTNER_A]` placeholders.
- "Identify gaps in this outreach sequence" — works fine.
- "Suggest a better subject line for this email" — works fine.

The only things redaction breaks are questions that require the specific identity or amount. Those are precisely the questions Claude shouldn't answer.

## Filling placeholders back in

- Do it **outside Claude** in your regular document editor.
- Use find-replace with placeholder tokens.
- Never send the un-redacted version back into the same Claude session — start a fresh one if you need Claude's help again (with freshly-redacted content).

## What happens when anonymizer can't fully redact

Edge cases where a name or identifier can't be cleanly replaced:

- Well-known public figure whose role is part of the point → "the CEO of [PARTNER_A]" may be fine since the org is redacted.
- Multiple overlapping identifiers (three people in one email) → map each to `[PARTNER_LEAD_1]`, `[PARTNER_LEAD_2]`, etc.
- Content where redaction collapses meaning (e.g., legal text about a specific clause in a specific contract) → **don't use Claude**; work offline.

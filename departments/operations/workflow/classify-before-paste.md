# Operations — classify before you paste

The universal `07-BEFORE-YOU-PASTE.md` applies; Operations tightens it.

## Operations defaults

- **Biz-dev content → Confidential.** Unless explicitly Public.
- **Marketing drafts → Internal.** Published → Public only after the gate.
- **Legal content → Restricted.** Almost all of it.
- **Exec content → Restricted.** Almost all of it.

## Before any paste — Operations pre-flight

Run through:

1. **Is there a named partner in this?** If yes and they're unannounced → STOP. Use a placeholder.
2. **Is there a $ amount?** If paired with a counterparty → redact the counterparty, keep the amount if it helps; or redact both.
3. **Is this NDA-covered or from an NDA'd conversation?** → STOP. Legal process.
4. **Is this draft contract language?** → STOP. Legal process.
5. **Does this contain compensation or performance data about any BSVA person?** → STOP. HR Lead.
6. **Is this board / exec material?** → STOP. Exec handles.
7. **After redacting all the above, is what's left useful to Claude?** If yes → proceed. If no → work offline or escalate.

## The Operations anonymize-first posture

Claude in an Operations session:

1. At session start, asks: "Is this a biz-dev / marketing / legal / exec session?"
2. Runs `anonymizer` on any pasted content — without being asked.
3. Flags any content that fails redaction (detectable partner names, specific unknown identifiers) and refuses until the user resolves.

This is stricter than other departments. The cost of over-caution is a few seconds; the cost of a leaked name is weeks.

## Working with public data

Operations does a lot of public-data work (VC research, market-maker posture, published partner announcements). The posture here is different:

- Public data + public source URL = **Public tier** content. No redaction needed.
- If the analysis combines public data with BSVA's internal posture → **up-classify** to Internal or Confidential.
- Published partner names are fine to reference after the partner has publicly announced.

Line: whatever was publicly published by the source is public. BSVA's own unreleased take on it isn't.

## The rule of three counterparties (Operations-version)

Before each paste, imagine it reaching:
- A **journalist** covering BSV or our partners.
- A **competing** infrastructure organization.
- The **named partner / person / counterparty**.

If any of those three seeing this would be problematic, redact more (or don't paste).

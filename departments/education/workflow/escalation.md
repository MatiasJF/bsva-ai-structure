# Education — escalation and hard-refusal lines

---

## Hard refusals (Mode A)

- **Identifiable learner submissions** — name + email + content. Refuse; redact via anonymizer first.
- **Minors' data** — immediate refusal, escalate to Education Lead + Legal. No session continues.
- **Identifiable student work used as an example** (even "anonymized" if context traces back) — refuse pending author consent.
- **Grading decisions affecting credentials / certificates** — Claude may draft; a human instructor signs.
- **Jurisdiction-sensitive PII** (medical, disability, accommodation) — Restricted; refuse in any non-approved session.
- **Confident-but-unsupported technical claim** in published-targeted material — soft refusal: "I can't verify this against the Academy MCP or a BRC — flag for DevRel review."

## Confirm-then-continue (Mode B)

- Content that names specific learners (even informally — "one of our best students") — confirm consent / redaction.
- Translations with uncertain terminology — confirm with native reviewer before publish.
- Assessment items where distractor plausibility is borderline — confirm with second educator.

## Proceed with note (Mode C)

- Public Academy content, your own drafts, published BRCs, on-chain public data.
- Pedagogy discussion without specific learners.
- Termbase discussions.

---

## Escalation map

| Situation | Route to | Priority |
|---|---|---|
| Learner PII exposure (accidental paste) | Education Lead + Security + Legal | Immediately; Restricted |
| Minors' data | Education Lead + Legal | Immediately; Restricted |
| Cross-jurisdiction privacy (GDPR / CCPA) | Legal | Before any analysis |
| Technical accuracy concern in published material | DevRel + Tech + Education Lead | Within a day |
| Translation disagreement with native reviewer | Education Lead | After normal resolution attempts |
| Assessment item challenged by multiple learners | Second educator + Education Lead | Within a week |
| Content involves protocol / cryptography / consensus | DevRel / Tech (tension) | Before publish |

## Triggers for immediate escalation

1. Any paste you realize (during or after) contained identifiable learner info.
2. Any request to use identifiable student work as an example without documented consent.
3. Any request to act on grading decisions that affect credentials.
4. Any content change that would mislead learners about protocol behavior.

## The meta-rule

**Education touches thousands of learners who cannot easily evaluate our claims.** Accuracy is the top priority. Learner privacy is the second. Fluency is a distant third. When in doubt, escalate.

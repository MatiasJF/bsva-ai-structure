# Education — learner-support workflow

Replying to learner questions — the PII-heaviest part of Education's work.

---

## The first rule

**Never paste a full learner ticket / email / LMS comment into Claude.**

- Use `anonymizer` on anything before it enters a Claude session.
- Extract the **question**, not the **identity**.
- Work with "a learner asked [question]", not "Maria Perez (mperez@example.com) asked [question]".

## The cycle

1. **Intake** (outside Claude) — receive the ticket.
2. **Redact** — anonymizer run on the content. Extract: the diagnosable question.
3. **CLARIFY** — internally: is this a doc gap, a content error, or user error?
4. **CAPTURE** — **nest** under your Learner Support role. Title past-tense, Confidential (because the real reply contains the learner identifier even if the nest doesn't).
5. **EXECUTE** — draft a reply with `learner-support-drafter`. Draft is generic where possible (could help others) but learner-specific where needed.
6. **SEND** — outside Claude, send the reply from the author's own email / LMS account.
7. **REPORT** — comment on the nest: reply sent, doc gap noted, follow-up tension opened if applicable.
8. **CLOSE** — nest Done.

## Pattern detection

If you answer the same question 3+ times in a quarter, it's a **doc gap**. Open a tension to update the relevant lesson.

## Escalation

- **Minors** — immediately escalate to Education Lead + Legal. No Claude session continues.
- **Identifiable health / disability / accommodation data** — Restricted; Legal consultation.
- **Cross-jurisdiction PII (GDPR, CCPA)** — Legal before any analysis.
- **Hostility / safety concerns** — Education Lead + HR, human handles.

## Claude's behavior in support work

Claude:
- Auto-runs `anonymizer` at session start for support work.
- Refuses to echo learner identifiers in output.
- Drafts replies in the author's voice (captured in personal CLAUDE.md).
- Never sends replies — human sends.
- Prompts for doc-gap escalation when pattern is detected.

## Sample nest description (with PII redacted)

```html
<h3>What</h3>
<p>Replied to learner (identifier redacted) question about UTXO input signing on Academy Module 4 Lesson 3 via LMS comment.</p>
<h3>Diagnosis</h3>
<p>User confused <code>unlockingScript</code> with <code>unlockingScriptTemplate</code>.</p>
<h3>Classification</h3>
<p>Confidential — the reply (sent outside Claude) contains the learner identifier; this nest does not.</p>
<h3>Acceptance criteria</h3>
<ul>
  <li>Reply drafted and reviewed for author's voice.</li>
  <li>Reply sent from the author's LMS account.</li>
  <li>Pattern flagged — 3rd identical question this quarter; doc-gap tension opened: T-5501.</li>
</ul>
<h3>Labels</h3>
<p>learner-support, module/m4-l3, classification/confidential</p>
```

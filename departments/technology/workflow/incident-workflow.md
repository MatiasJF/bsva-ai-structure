# Technology — incident workflow

When something is broken or suspected-broken. Extends `<repo>/workflow/01-the-cycle.md` but with different timing: **contain first, document second**.

---

## Severity

- **Critical** — production down, customer-visible impact, key / signing material at risk.
- **High** — degraded service, no data loss, public visibility.
- **Medium** — internal-only impact, recoverable within a day.
- **Low** — minor bug, no user impact.

Severity drives response time; classification drives who sees what.

## Classification floors

- **All incidents**: Confidential minimum.
- **Customer-visible**: Confidential; the external comms piece may be Internal or Public depending on comms plan.
- **Key / signing material exposure**: Restricted. Hard stop; DO NOT paste into any Claude session.
- **Legal exposure (regulatory, contract)**: Restricted.

---

## The sequence

### Immediate (first 15 minutes)
1. **Contain.** Mitigate / roll back / isolate. Don't debug root cause before containing.
2. **Declare** — page on-call, open an incident tension on the Tech circle with Confidential label.
3. **Communicate internally** — Slack incident channel + Tech Lead + Security (if applicable).

### Short-term (first hour)
4. **CLARIFY** — clarify-questions.md for incidents: time window, scope of impact, sensitivity, classification floor.
5. **CAPTURE** — primary nest: "[Incident short name] resolved" under Tech Lead role. Linked tensions for specific remediations.
6. **PLAN-MODE** — not literal plan-mode; the equivalent is a coordination doc in the tension. Who owns what, next checkpoints, time horizons.

### Medium-term (hours to days)
7. **EXECUTE** — remediation work, each remediation as its own nest under the accountable role. Comments on the primary tension for cross-role status.
8. **External comms if needed** — tension to Marketing / Exec for status page / partner comms.

### Long-term (post-resolution)
9. **REPORT** — a complete postmortem. Sections: summary, timeline, impact, root cause, contributing factors, remediations, follow-ups.
10. **CLOSE** — primary nest Done; blameless review scheduled with Tech Lead + Security; guidance PRs filed for any process gaps surfaced.

---

## What Claude does / doesn't do

Claude **does**:
- Help draft timeline entries from log snippets (redacted via `anonymizer`).
- Structure the postmortem.
- Check facts against public docs / BRCs.
- Draft external comms for Marketing review.

Claude **does not**:
- Paste raw production logs (require redaction first).
- Make declarations of severity (that's the on-call + Tech Lead).
- Touch HSMs, production credentials, or signing paths.
- Approve an external comms release.
- Proceed with a postmortem if key material was involved without explicit Security sign-off.

---

## Specific incident types

### Suspected vulnerability in shipped code
1. Triage with Security first (tension, Restricted if severe).
2. Private fix branch; Security review; coordinated disclosure.
3. CVE / advisory process with Security.

### Production outage
1. On-call pages.
2. Contain; incident channel + tension open.
3. Resolve; postmortem within 5 business days.

### Customer-data exposure
1. **Immediately** Restricted classification on all related material.
2. Legal + Exec loop.
3. Response plan → external comms per Legal.
4. Postmortem Restricted; blameless review Restricted.

### Key / signing-material exposure
1. Ceremony-based key rotation initiated immediately.
2. Restricted classification; very narrow comms.
3. Security + Tech Lead + Exec; Legal notified.

---

## The blameless principle

BSVA Tech holds blameless postmortems. Goal: improve the system, not punish the person. This is a structural norm (see `security/incident-response.md`). Honest reporting is worth more than looking good.

## The guidance-PR expectation

Every incident should produce at least one PR to the BSVA AI structure repo:
- A new deny-entry in `global/settings.template.json`.
- A new signal in `guides/for-claude/classification-enforcement.md`.
- A new hard-refusal line in the relevant dept `escalation.md`.
- An updated CLARIFY question.

Close the loop. The next incident should fail differently.

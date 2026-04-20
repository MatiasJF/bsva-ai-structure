# 07 — Incident response

What happens when something slips through: pasted content that shouldn't have been, a secret that leaked, a mis-classified document. Visual form of `security/incident-response.md`.

---

```mermaid
flowchart TD
  discover([⚠ I discovered an incident:<br/>pasted something I shouldn't,<br/>saw a key in output,<br/>mis-classified material]):::alert

  contain[1️⃣ Contain<br/>close the session<br/>stop interacting]:::action

  assess[2️⃣ Assess<br/>what was pasted?<br/>which surface?<br/>were secrets involved?]:::action

  secret{Was a secret<br/>involved<br/>API key, private key,<br/>password?}
  rotate[3️⃣ Rotate immediately<br/>revoke + regenerate<br/>do NOT wait for approval]:::urgent
  skipRotate[3️⃣ no secret<br/>no rotation needed]:::action

  notifyMap{What kind of content?}
  notifyDevRel[4a. Notify DevRel Lead<br/>always]:::action
  notifySec[4b. Notify Security<br/>if secrets or data-exposure]:::action
  notifyLegal[4c. Notify Legal<br/>if contract / NDA / PII]:::action
  notifyHR[4d. Notify HR Lead<br/>if HR / personnel data]:::action

  writeNote[5️⃣ Write incident note<br/>on the Nestr tension<br/>what / when / contained how]:::action

  review[6️⃣ Blameless review within 24h<br/>with DevRel + Security]:::action

  pr[7️⃣ Open PR to close the loop<br/>update guides / heuristics /<br/>denies / examples]:::action

  done([✓ Lesson captured — the system got smarter]):::done

  discover --> contain --> assess --> secret
  secret -- "yes" --> rotate --> notifyMap
  secret -- "no"  --> skipRotate --> notifyMap
  notifyMap --> notifyDevRel
  notifyMap --> notifySec
  notifyMap --> notifyLegal
  notifyMap --> notifyHR
  notifyDevRel --> writeNote
  notifySec    --> writeNote
  notifyLegal  --> writeNote
  notifyHR     --> writeNote
  writeNote --> review --> pr --> done

  classDef alert fill:#fce8ea,stroke:#c03040,stroke-width:3px
  classDef urgent fill:#fce8ea,stroke:#c03040,stroke-width:2px,color:#5a0000
  classDef action fill:#fff,stroke:#555
  classDef done fill:#e8fae5,stroke:#4fa63b,stroke-width:2px
```

---

## The principle

**Silence is the worst outcome. Disclosure is how BSVA's guidance gets sharper.**

Incidents are not career events. They are opportunities to close a gap in the system. Every merged PR that came out of an incident review makes the next person safer.

---

## Timing

| Phase | Window |
|---|---|
| Contain | seconds |
| Rotate (if secrets) | immediately — before anything else |
| Notify | within 1 hour for Confidential/Restricted; within a business day for Internal |
| Write note | same day |
| Blameless review | within 24 hours |
| Close the loop (PR) | within 1 week |

---

## What NOT to do

- ❌ "Just delete it and move on" — the content left your machine.
- ❌ "Ask a colleague in Slack for their opinion" — broadens exposure.
- ❌ "Wait till Monday" — rotation especially cannot wait.
- ❌ "Hope Anthropic doesn't store it" — not a strategy.
- ❌ Confess publicly — use the Nestr tension, not a general channel.

---

## The blameless part

BSVA's policy:

- Good-faith reporters are not punished for reporting.
- Repeat incidents of the same type get a process review, not a blame review.
- Serious incidents (Restricted breach, willful bypass of rules) are handled by Legal + Exec separately — but even those start from a norm of protecting the reporter.

---

## Ownership / RACI

| Phase | Responsible | Accountable |
|---|---|---|
| Contain | The user | The user |
| Rotate | The user (+ IT if needed) | The user |
| Notify | The user | DevRel Lead |
| Write note | The user | DevRel Lead |
| Blameless review | DevRel + Security | DevRel Lead |
| Guidance PR | Incident stakeholders | DevRel Lead |

---

## See also

- `security/incident-response.md` — full prose version of this flow, with specific-incident playbooks.
- `guides/for-humans/12-when-to-escalate.md` — escalation in general (not just incidents).

# 05 — Pre-flight classification (human decision tree)

The 30-second check every BSVA person does before pasting anything into Claude. Visual form of `guides/for-humans/07-BEFORE-YOU-PASTE.md`.

---

```mermaid
flowchart TD
  start([I want to share this<br/>with Claude]):::start

  public{Is it published by<br/>BSVA or clearly public?}
  mineOwn{Did I write it,<br/>about my own work?}
  third{Names / $ / NDA /<br/>contract / unreleased?}
  redact{Can I redact enough<br/>to anonymize?}
  restricted{"Private keys · HR ·<br/>legal · board / M&A?"}

  greenGo([🟢 Public — go]):::green
  greenInt([🟡 Internal — go<br/>Desktop / CLI only]):::yellow
  orangeRed([🟠 Confidential —<br/>redact first,<br/>scoped session]):::orange
  stop([🔴 STOP<br/>escalate to owner<br/>see incident-response.md]):::red

  start --> public
  public -- "yes" --> greenGo
  public -- "no"  --> restricted
  restricted -- "yes" --> stop
  restricted -- "no"  --> mineOwn
  mineOwn -- "yes" --> third
  mineOwn -- "no"  --> third
  third -- "no"  --> greenInt
  third -- "yes" --> redact
  redact -- "yes" --> orangeRed
  redact -- "no"  --> stop

  classDef start fill:#eaf4ff,stroke:#2f6fd8,stroke-width:2px
  classDef green  fill:#e8fae5,stroke:#4fa63b,stroke-width:2px,color:#1f3e15
  classDef yellow fill:#fdf9e8,stroke:#b8941f,stroke-width:2px,color:#3d2f07
  classDef orange fill:#fbe8d3,stroke:#c07222,stroke-width:2px,color:#3d2007
  classDef red    fill:#f8d7da,stroke:#c03040,stroke-width:2px,color:#3d0000
```

---

## The path in plain English

1. **Published and public already?** → Go. No tier concerns.
2. **Private keys, HR, contracts, board/exec material?** → STOP. Don't paste.
3. **Names / amounts / NDA / unreleased** in the content? → You need to redact or stay at Internal.
4. **Can you redact it cleanly?** → Yes, treat as Confidential with a scoped session. No, STOP.

---

## The decision, timed

This should take **30 seconds** after the first week of practice. Example real sessions:

> "I want to ask Claude to polish this draft blog about BRC-100." → published topic, my draft → 🟢.
> "I want Claude to summarize these internal OKR notes." → my department's notes, no partner names, no HR → 🟡.
> "I want Claude to review this proposed contract clause with Partner A." → names, $, legal → **redact** → 🟠 or escalate.
> "I want Claude to help me format this list of test private keys for a workshop." → **STOP**, use documented test vectors instead.

---

## Where the full rules live

- `guides/for-humans/07-BEFORE-YOU-PASTE.md` — prose form.
- `guides/for-humans/11-information-handling.md` — the 4-tier matrix.
- `security/classification.md` — source of truth for tier definitions.
- `security/data-handling-matrix.md` — what you may do with each tier.

---

## See also

- [07 — Incident response](07-incident-response.md) — what to do when pre-flight failed.

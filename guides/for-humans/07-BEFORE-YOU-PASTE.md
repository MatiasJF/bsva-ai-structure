# 07 — BEFORE YOU PASTE ⚑

**The 30-second pre-flight. Do this every time.**

This is the single most important habit at BSVA when using Claude. It takes half a minute. Skipping it is how leaks happen.

---

## The checklist

Before pasting, attaching, or showing Claude anything that isn't your own work:

```
┌─────────────────────────────────────────────────────────────────┐
│  1. WHO wrote this?                                              │
│     □ me (or my role)       → likely Public / Internal           │
│     □ a BSVA colleague      → Internal at minimum                │
│     □ a partner / vendor    → Confidential unless clearly public │
│     □ legal / HR / board    → Restricted. STOP.                  │
│                                                                  │
│  2. WHAT is in it? Scan for:                                     │
│     □ names, emails, phone numbers of real people                │
│     □ $ amounts, salaries, budgets, forecasts                    │
│     □ private keys, API keys, passwords, seeds → STOP.           │
│     □ unreleased partnerships, embargoed dates                   │
│     □ legal terms, contracts, NDAs                               │
│     □ raw user data / PII from a service we run                  │
│                                                                  │
│  3. WHICH tier is it?                                            │
│     □ Public       → go                                          │
│     □ Internal     → go (Desktop / CLI only, not web)            │
│     □ Confidential → redact or refuse; local-only session        │
│     □ Restricted   → STOP. Escalate.                             │
│                                                                  │
│  4. WHAT happens if it leaks?                                    │
│     □ nothing meaningful                    → go                 │
│     □ embarrassment                         → redact first       │
│     □ breach of contract / law / harm       → STOP.              │
└─────────────────────────────────────────────────────────────────┘
```

---

## The one-sentence version

**"If it's not mine, and I can't say 'yes this is safe for all three: an outside vendor, a competitor, a journalist', then it doesn't go in as-is."**

---

## When in doubt

Use the decision tree:

```
        Is it from outside BSVA?  → YES → did the sender say "internal only"?
                                           → YES → stop, classify, probably Confidential
                                           → NO  → still ask yourself: would they mind?
         ↓ NO
        Did I write it?           → YES → almost always OK
         ↓ NO
        A BSVA colleague wrote it → YES → is it about an identifiable third party?
                                           → YES → redact the third-party identifiers
                                           → NO  → Internal is probably fine
```

If the tree doesn't resolve cleanly: **don't paste**. Ask your escalation owner. The cost of asking is 5 minutes. The cost of leaking is weeks.

---

## Where the tiers are defined

Full definitions: `security/classification.md`.
Full handling matrix: `security/data-handling-matrix.md`.
Redaction how-to: `10-redact-before-you-paste.md`.

---

## Red flags that should stop you cold

- The content starts with "CONFIDENTIAL" or "PRIVILEGED" or "DO NOT DISTRIBUTE".
- The content contains something that looks like a private key (long string of hex / base58 / `xprv...` / `5K...` / a 12- or 24-word phrase).
- The content names an unannounced BSVA partnership, product, or acquisition.
- The content contains compensation or performance information about any BSVA person, including yourself.
- The content is a full email thread you received — those almost always contain something third-party.

If any red flag appears: **close the chat window, don't paste, handle the content outside Claude, and if needed escalate.**

---

## The thing we want you to internalize

**Claude will not stop you.** You are the gate. This is by design — it keeps you in the loop and builds good habits. Over time, pre-flight becomes automatic.

---

## Next

→ `08-what-to-send.md` (green-light examples) • `09-what-NOT-to-send.md` (red-light)

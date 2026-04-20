# Classification enforcement (for Claude)

How you, Claude, interpret the 4-tier classification in practice. Read alongside `security/classification.md` (which is the source of truth).

---

## The tiers, as you should treat them

| Tier | What to do when shown this content |
|---|---|
| 🟢 **Public** | Proceed. No constraint on output target. |
| 🟡 **Internal** | Proceed. Do not embed this content verbatim in output that might be published externally (blog posts, tweets, public-facing one-pagers) without the human explicitly approving that downstream use. |
| 🟠 **Confidential** | Proceed only if: (a) session surface is CLI or Desktop (not web), (b) no third-party renderers / pastebins / gists will receive the content, (c) the human confirmed the tier. If any of those is unclear — switch to Mode B (confirm). |
| 🔴 **Restricted** | Refuse. See `refusal-and-escalation.md`, Mode A. |

---

## How to detect tier from content (heuristics)

You won't always know the tier from metadata. When the human didn't state one, look for signals:

**Signals that push toward Confidential / Restricted:**
- "CONFIDENTIAL", "PRIVILEGED", "DO NOT DISTRIBUTE", "INTERNAL ONLY" in the text.
- Recognizable private-key patterns (WIF, xprv, xpub, hex-64, BIP-39 word lists).
- Full names + compensation / performance terms.
- Partner or vendor names + amounts + dates that look like deal terms.
- "Draft contract", "NDA", "letter of intent", "term sheet".
- Board / executive meeting notes, "board minutes", "board memo".
- HR terms: "termination", "performance improvement plan", "disciplinary".

**Signals that push toward Internal:**
- Internal tool URLs (anything on a private domain).
- Content from Nestr tensions.
- Draft blog posts or announcements (not yet published).
- Internal roadmaps or OKRs.

**Signals that it's Public:**
- bsvblockchain.org, github.com/bsv-blockchain, Academy URLs.
- Published Medium posts, conference slides already online.
- BRC / BIP numbers and their specs.

When signals conflict or are absent: **ask the human. Don't guess.**

---

## What to do with classified content in your output

- **Never** raise the tier inside your output (e.g., don't summarize Confidential content into a Public-targeted artifact).
- **Do** lower the tier only by explicit redaction + confirmation.
- **Never** include secrets (keys, tokens, passwords) in output, even ones you were shown. Replace with `[REDACTED]`.

---

## Scoping rules

- **This project has a working directory.** Don't write files outside it without a clear reason.
- **Respect deny-listed paths** (`~/.ssh`, `~/.gnupg`, `/etc/**`).
- **Don't fetch URLs mentioned in Confidential content.** You might accidentally exfiltrate internal URLs to external DNS resolvers.

---

## When the human asks you to violate a tier rule

Stay firm on Mode A triggers. For Mode B, push back once, then defer to the human's classification call.

Never say "sure" and then silently downgrade what you do. If you proceed, proceed fully; if you refuse, refuse clearly.

---

## Logging and auditability

The BSVA installer writes an activity log (if the human has enabled the Stop hook). You don't read from it, but know that:

- **Sessions are observable.** If a human pastes something they shouldn't, the fact that it happened is loggable.
- **Your refusals are also loggable.** Don't refuse quietly — a visible "⚠ I can't proceed" is part of the audit trail.

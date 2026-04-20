# 09 — What NOT to send ⛔

Red-light examples. This is the counterweight to `08-what-to-send.md`.

---

## Never. Under any circumstances. In any Claude surface. ⛔

### 🔐 Cryptographic secrets
- **Private keys** in any format: WIF (`5K...`, `L...`, `K...`), hex, extended (`xprv`, `tprv`), DER, PEM.
- **Seed phrases / mnemonics** (any 12/18/24-word sequence that looks like a BIP-39 list).
- **Passphrases** for HD wallets.
- **API keys** for BSVA systems or any service. Even "just to test" — rotate, don't paste.
- **Access tokens**, JWTs you didn't just generate as throwaway test tokens.
- **SSH private keys** (`-----BEGIN OPENSSH PRIVATE KEY-----`).

### 👤 HR / personal
- Salary figures for anyone, including yourself.
- Performance reviews, 1:1 notes with identifiable people.
- Hiring pipeline data, candidate assessments.
- Medical / disability / accommodation information.
- Disciplinary records.

### ⚖️ Legal
- Signed contracts (even draft amendments — send the question, not the doc).
- NDA'd material.
- Litigation holds, legal opinions, privileged correspondence.
- GDPR subject-access requests with real user data.

### 💰 Pre-announcement financial
- Unreleased financial statements.
- Board materials, board minutes.
- M&A candidates, due-diligence files.
- Treasury balances in detail.

### 🤝 Unannounced partners
- Partner names we haven't publicly announced.
- Draft partnership terms.
- Commercial negotiations in progress.

---

## Never to the web version of Claude (claude.ai). Desktop/CLI only, with care. ⛔🌐

- Internal roadmaps and OKRs.
- Draft press releases, draft announcements.
- Internal Slack / Nestr content.
- Any file marked `Internal` or higher in this repo's classification.

*Why:* Desktop/CLI sessions let you control MCPs, permissions, and file scope. The web interface gives you less fine-grained control.

---

## Edge cases that trip people up

### "It's my own email, so it's fine." ⛔
Emails contain the other person's words and often their identifying info. Redact the other party before using.

### "It's a public figure, so naming them is fine." ⛔
Fine for reasoning about public statements. Not fine for pasting private correspondence with them.

### "It's just test data." ⛔ (maybe)
If the test data came from a production snapshot, it's real user data. If it was fabricated, fine.

### "I'll just paste the whole doc — Claude can figure out what to use." ⛔
The whole doc is now in the context, whether Claude uses it or not. Extract the relevant part first.

### "It's on my screen in a Zoom meeting." ⛔
A screen share is different from a Claude session. Don't paste meeting-shared content into Claude without classifying first.

---

## The rule of three counterparties

Before pasting any non-public content, ask: **would I be comfortable if this ended up seen by…**

1. a **journalist** covering BSV?
2. a **competitor** we respect?
3. the **person** named in it?

If any of those answers is "no" — don't paste without redaction.

---

## If you already pasted something

See `security/incident-response.md`. Short version: don't panic, document what happened, rotate if a secret was involved, notify the escalation owner. This repo has a process; it is not career-ending. Silence is worse than disclosure.

---

## Next

→ `10-redact-before-you-paste.md` — how to sanitize so more content becomes green-light.

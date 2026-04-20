# 08 — What to send ✅

Green-light examples: content you can safely share with Claude in a BSVA context.

---

## General rule

If it's **yours**, **public**, or **sanitized**, it's fair game.

---

## ✅ Always fine

### Code you wrote
- Your own code, in a project folder you've granted access to.
- Your own notes and drafts, even rough ones.

### Public BSV material
- Anything from `bsvblockchain.org`, our public repos, published documentation.
- Published BSV Academy courses and concepts.
- Published one-pagers, press releases, blog posts.
- Public on-chain data (transactions, blocks, UTXOs). That's what the WhatsOnChain MCP is for.

### Your own work output
- Your own draft of a blog post / deck / email (before publication, even).
- Your own research notes.
- Test data and fixtures that you generated.
- Pseudo-code and diagrams that describe public ideas.

### Public third-party material
- Published books, articles, standards (BIP, BRC, W3C, etc.).
- Public npm packages, their READMEs, their source (they're on GitHub).
- Public data from partners that they've already announced.

---

## ✅ Fine after a quick sanity check

### Internal-but-not-sensitive content
- Your department's `CLAUDE.md`, skills, and templates (they're in this repo!).
- Internal roadmap drafts **about your own work**, if they don't name partners or amounts.
- Meeting notes you took **about your own sessions**, with colleagues' names replaced by roles (e.g. "Marketing Lead" instead of "Sarah").
- Sanitized logs — strip IPs, user IDs, emails.

### Your own prompts and previous drafts
- Re-sharing a prompt template you made.
- Asking Claude to iterate on content it helped draft earlier (in a fresh session, pasted back).

---

## ✅ Fine with redaction

These become Public- or Internal-safe after a little work:

### Logs and dumps
- Stack traces: strip paths to user directories (`/Users/matias/...` → `/Users/REDACTED/...`).
- API logs: strip user IDs, emails, IPs.
- Transaction outputs from **internal** services: keep structure, replace identifiers.

### Emails and messages
- Strip names, signatures, footers.
- Replace person names with roles.
- Remove attachments you didn't need for the question.

### Partner content
- Strip partner names and replace with `[PARTNER_A]`.
- Strip amounts, dates, specific commitments.
- Claude can still reason about the structure without the specifics.

---

## Examples: real BSVA tasks where "just paste it" is fine

| Task | Why it's fine |
|---|---|
| "Help me polish this blog post about BRC-100" | The spec is public; the blog is yours. |
| "Explain this public on-chain transaction" | Public data. |
| "Draft a workshop outline on BSV SPV" | Public topic, your draft. |
| "Review my translation of an Academy lesson" | Published material. |
| "Refactor this utility function in my workshop repo" | Your code. |
| "Summarize this public whitepaper" | Public. |
| "Draft a thank-you email for a public conference" | Your template, public event. |
| "Help me turn my bullet notes into a Q1 retrospective draft" | Your notes; if they name specific colleagues with sensitive context, redact to roles first. |

---

## When you're still unsure

Default up one tier. Treat Internal as Confidential until you're sure. No one at BSVA will criticize you for being cautious. Leaks, on the other hand, are a real problem.

---

## Next

→ `09-what-NOT-to-send.md`

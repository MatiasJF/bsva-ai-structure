# 10 — Redact before you paste

Redaction turns red-light content into green-light content. This guide covers the techniques that take 30–90 seconds and handle 90% of BSVA cases.

---

## The principle

**Replace identifying specifics with structural placeholders.** Claude can still help you with the shape of the problem even when the details are anonymized. In many cases, the details don't matter to the question at all.

---

## The placeholder vocabulary we use

Use these consistently across BSVA so Claude (and future-you) can tell them apart:

| Replace | With |
|---|---|
| Partner / vendor name | `[PARTNER_A]`, `[PARTNER_B]` |
| Person name | `[ROLE_A]` (e.g., `[MARKETING_LEAD]`) — prefer roles over "Person A" |
| BSVA employee name | `[BSVA_ROLE]` (e.g., `[BSVA_DEVREL]`) |
| Specific $ amount | `[AMOUNT]` or a rounded order of magnitude: `[~$10K]` |
| Email address | `[EMAIL]` or `[email@partner-a.example]` |
| Phone number | `[PHONE]` |
| URL (private) | `[INTERNAL_URL]` |
| API key / token | `[API_KEY]` |
| Transaction ID (private) | `[TXID]` |
| BSV address (private) | `[ADDRESS]` |
| Specific date | `[DATE]` or `[Q2 2026]` if the period matters |
| Product codename | `[PROJECT_X]` |

Example:

> **Before:** "We are negotiating with Blockstream for $250K to sponsor BSV DevCon London on 2026-06-15. The lead is Sarah Nguyen at sarah@blockstream.com."
>
> **After:** "We are negotiating with `[PARTNER_A]` for `[AMOUNT]` to sponsor a conference in `[Q2 2026]`. The lead is `[PARTNER_LEAD]` at `[EMAIL]`."

Claude can still help you draft a reply, outline a proposal, or identify missing clauses — without ever seeing the sensitive fields.

---

## Quick-and-dirty techniques

### For a chunk of text you're about to paste
1. Select, copy to a scratch file.
2. Find-and-replace names and amounts with placeholders.
3. Paste the redacted version into Claude.
4. When Claude returns output, fill placeholders back in yourself (outside Claude).

### For a long document
Don't redact a 40-page doc manually. Instead:
1. Ask yourself what you actually need Claude for. (A summary? A rewrite of one section? An analysis of the structure?)
2. Extract only that section.
3. Redact it.
4. Paste the extract.

### For logs and traces
- Strip file paths that contain your username: `s|/Users/matias/|~/|g`
- Strip IP addresses if they identify customers.
- Strip user IDs, session IDs, cookies.
- Keep the error message, the stack frames, the timing — those are what Claude needs.

### For PDFs
- Open in Preview (Mac) or Acrobat → **Remove metadata / properties** before sharing.
- If it has tracked changes / comments, **accept or remove** before sharing.
- Copy-paste selected paragraphs rather than attaching the whole file — you see what leaves your machine.

### For images
- Screenshots can contain: filenames in the background, Slack previews, calendar entries, tab titles. **Crop aggressively.**
- **Strip EXIF** if a photo came from a phone: `exiftool -all= image.jpg` (macOS: `brew install exiftool`).

---

## Tooling cheatsheet

### macOS / Linux one-liners

```bash
# strip your username from paths in a log file
sed 's|/Users/[^/]*/|/Users/REDACTED/|g' log.txt > log-redacted.txt

# strip IPv4 addresses
sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[IP]/g' log.txt

# strip email addresses
sed -E 's/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/[EMAIL]/g' doc.txt

# strip anything that looks like a hex private key (64 hex chars)
sed -E 's/\b[0-9a-fA-F]{64}\b/[REDACTED_HEX]/g' doc.txt
```

### Desktop app
Copy the content, paste into a scratch note (Stickies / Notes / VS Code), redact with find-replace, then paste into Claude.

---

## When redaction isn't enough

Some content can't be usefully redacted — the identifying information **is** the information. For example, a contract's specific clauses, an HR complaint's specific allegations, a bug report with real user behavior.

For those: **don't redact and paste. Work offline, ask a colleague, or describe the problem abstractly to Claude without the source material.**

---

## The mental trick that makes this a habit

Before pasting, imagine your copy-paste buffer is a draft Slack message to an **all-company channel including partners and press**. If you wouldn't post it there, redact it.

This is a slight exaggeration — Claude is not a public channel. But the mental posture is the right one for BSVA.

---

## Next

→ `11-information-handling.md` — the formal 4-tier matrix for reference.

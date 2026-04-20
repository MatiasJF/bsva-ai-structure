# Redaction playbook

Step-by-step how to sanitize content for Claude. Companion to `guides/for-humans/10-redact-before-you-paste.md` — that's the introduction, this is the reference.

---

## The placeholder vocabulary (canonical)

Use these exact forms. Consistency matters because Claude (and future humans) can parse them.

| Placeholder | Use for |
|---|---|
| `[PARTNER_A]`, `[PARTNER_B]` | External organizations you're dealing with |
| `[ROLE_A]`, `[ROLE_B]` | Generic non-BSVA role (use actual role title when helpful) |
| `[BSVA_DEVREL]`, `[BSVA_MARKETING]`, `[BSVA_LEAD]`, `[BSVA_ENGINEER]` | BSVA roles (not names) |
| `[EMAIL]` or `[contact@partner-a.example]` | Email addresses |
| `[PHONE]` | Phone numbers |
| `[INTERNAL_URL]` | Private BSVA URLs |
| `[AMOUNT]` or `[~$10K]` / `[~$100K]` / `[~$1M]` | $ amounts — keep order of magnitude if relevant |
| `[DATE]` or `[Q2 2026]` | Dates — keep quarter/year if relevant |
| `[TXID]`, `[ADDRESS]`, `[BLOCK]` | Private / internal on-chain identifiers |
| `[API_KEY]`, `[TOKEN]`, `[SECRET]` | Any credential (and also: **rotate it**, don't just redact) |
| `[PROJECT_X]`, `[PROJECT_Y]` | Codenames for unannounced work |
| `[REDACTED]` | Catch-all — prefer specific placeholders above |

---

## The five techniques in order of frequency

### Technique 1 — Find-replace in a scratch buffer (most common)

```
1. Open a scratch file (VS Code, TextEdit, Notes)
2. Paste the content
3. Find (CMD-F / Ctrl-F) each identifier; replace with placeholder
4. Paste the redacted version into Claude
5. Close the scratch file without saving (or save to a folder tracked in .gitignore)
```

Rhythm tip: do names first, then amounts, then dates, then URLs. One category at a time avoids mistakes.

### Technique 2 — Extract the relevant slice

Don't redact a 40-page doc. Ask yourself what slice Claude needs.

```
Wrong: paste entire contract, ask "summarize"
Right: paste the two paragraphs you're stuck on, ask the specific question
```

Often the slice is already lower-tier than the full document.

### Technique 3 — Regex one-liners (for logs and structured text)

macOS / Linux:

```bash
# your username → REDACTED
sed 's|/Users/[^/]*/|/Users/REDACTED/|g' log.txt > log-redacted.txt

# IPv4 addresses
sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[IP]/g' log.txt

# email addresses
sed -E 's/[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}/[EMAIL]/g' doc.txt

# 64-char hex (possible private keys / hashes)
sed -E 's/\b[0-9a-fA-F]{64}\b/[HEX64]/g' doc.txt

# BIP-39-ish: 12 or 24 short lowercase words separated by spaces (rough heuristic)
# Don't trust this for detection — manually check seed-phrase-looking content.

# WIF-ish private keys: 51–52 base58 chars starting with 5, K, or L
sed -E 's/\b[5KL][1-9A-HJ-NP-Za-km-z]{50,51}\b/[WIF]/g' doc.txt

# xprv / xpub
sed -E 's/\b(xprv|xpub|tprv|tpub)[1-9A-HJ-NP-Za-km-z]{100,}\b/[XKEY]/g' doc.txt
```

### Technique 4 — Abstract the problem

Sometimes you don't need to paste anything. Describe the shape:

```
Wrong: paste a user's complaint email
Right: "A user complained about [feature] — behavior was [X], expected [Y]. Draft a reply in our tone."
```

Abstract descriptions often give better Claude output anyway, because they force you to clarify the problem.

### Technique 5 — Work entirely offline

For Restricted content: don't try to redact for Claude. Use Claude for the general shape (drafting a template, thinking about structure), then fill in the specifics manually, outside Claude.

---

## Per-format playbooks

### PDFs
1. Don't just attach. Open the PDF.
2. Remove metadata: Preview → Tools → Show Inspector → remove author/title/producer fields.
3. Accept all tracked changes if it's a Word-derived PDF.
4. Copy-paste the specific section you need; don't attach the whole thing unless necessary.

### Word / Google Docs
1. Accept all tracked changes and resolve comments (or export "for review" hides them, but verify).
2. Remove the document's properties: File → Properties → clear.
3. Copy-paste specific sections.

### Images / screenshots
1. Crop aggressively — Slack previews, calendar entries, tab bars often leak context.
2. Strip EXIF: `exiftool -all= image.jpg`.
3. For scans with tracked text: OCR first (e.g., Preview on macOS), redact the text output, re-share the text.

### Emails
1. Strip the signature block of anyone not you.
2. Strip quoted reply chains if you don't need them.
3. Replace the other party's name with their role.
4. Watch out for inline images (logos, banners) that identify the sender.

### Code
1. Check for hardcoded credentials. Remove every `const API_KEY = "..."` string.
2. Check for internal URLs / endpoints that aren't public.
3. Check for customer-specific identifiers (user IDs, org IDs).
4. Check for paths that expose directory structure you'd rather not share.

### Spreadsheets
1. Hide / delete columns with PII, compensation, or customer identifiers before copying.
2. If pasting data: filter to only the rows and columns Claude needs.
3. Watch out for cell formulas that reference other sheets with sensitive content.

---

## The three-counterparty test

Before clicking paste, imagine the redacted output leaking to each of:

- A **journalist** covering BSV.
- A **competing** blockchain organization.
- The **named partner / person** in the content.

If each of those seeing this would be *fine*, proceed.

---

## When in doubt

Up-classify. Ask. Don't paste. The 5 minutes it takes to escalate is cheaper than any alternative.

# Operations — CLAUDE.md

Extends the base `~/.claude/CLAUDE.md`. Security rules here are **stricter** than the base, not looser.

This CLAUDE.md is the default for Operations. Each sub-section (biz-dev, marketing, legal, exec) has its own CLAUDE.md that may tighten further. If you're working in one of those sub-areas, link to that sub-CLAUDE.md, not this one.

---

## Who we are

"Operations" at BSVA is an umbrella for:

- **Business Development** — partnerships, sales, enterprise outreach.
- **Marketing** — content, social, events, PR.
- **Legal** — contracts, compliance, regulatory.
- **Executive / Strategy** — leadership, board, high-level direction.

These functions often handle Confidential or Restricted content by default. The rest of BSVA can access this folder's guides, but the individual sub-folders may be access-restricted at the GitHub level for legal / exec content.

---

## Default classification (by sub-section)

| Area | Default |
|---|---|
| Business Development | Confidential |
| Marketing (drafts) | Internal |
| Marketing (published) | Public |
| Legal | Restricted |
| Exec | Restricted |

---

## How to behave in Operations work

1. **Classify aggressively.** The default should be **up**, not down. Pre-flight every session.
2. **Prefer abstractions to specifics.** Draft emails and proposals using `[PARTNER_A]` placeholders; fill in specifics outside Claude.
3. **Don't name unannounced partners.** Ever. Until the joint announcement is public, the partner doesn't exist in any Claude session.
4. **Don't paste contracts.** Claude can help with questions about clause structure using anonymized examples; the actual contract stays out.
5. **Don't paste HR, compensation, or board material.** See `09-what-NOT-to-send.md`.

---

## Tools Operations uses with Claude

- **bsva-docx / pptx / onepager skills** — for documents, decks, and one-pagers.
- **Nestr MCP** — circle / role coordination.
- Marketing may use **BSV Academy MCP** for referencing concepts in content; WhatsOnChain for any factual on-chain references.

---

## Escalation owners

- Operations Lead (general operations questions).
- Biz-Dev Lead, Marketing Lead, Legal Lead, Executive (CEO / equivalent role) — each for their domain.
- Any concern about classification: Security + the relevant area lead.

---

## Templates

See `templates/`. Sub-sections may have their own templates in `biz-dev/templates/`, etc.

## Sub-sections

- `biz-dev/` — partnerships, sales, RFPs.
- `marketing/` — content, campaigns, events.
- `legal/` — contracts, compliance.
- `exec/` — strategy, board, executive communications.

Each sub-folder has its own CLAUDE.md, guides, and (where applicable) tighter classification defaults.

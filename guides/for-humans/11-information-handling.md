# 11 — Information handling: the 4-tier matrix

The formal reference. See `07-BEFORE-YOU-PASTE.md` for the fast version.

---

## The four tiers

### 🟢 Public
Information that is already published or intended for publication without restriction.
Examples: bsvblockchain.org content, published Academy courses, public GitHub repos, press releases, public talks.

### 🟡 Internal
Information meant for BSVA members and approved collaborators but not for public distribution.
Examples: roadmaps, internal OKRs, draft blog posts, internal RFCs, non-sensitive meeting notes, most Nestr tensions.

### 🟠 Confidential
Information whose disclosure would harm BSVA, partners, or individuals.
Examples: partner terms, unannounced features, unreleased financials, candidate pipeline, commercial negotiations in progress.

### 🔴 Restricted
Information that must not leave BSVA's legal / executive sphere.
Examples: signed contracts, NDAs, legal holds, board minutes, M&A, HR and compensation data, private keys of any kind.

---

## Handling matrix

| Action | 🟢 Public | 🟡 Internal | 🟠 Confidential | 🔴 Restricted |
|---|---|---|---|---|
| Paste into Claude CLI | ✅ | ✅ | ✅ (redact first) | ❌ |
| Paste into Claude Desktop | ✅ | ✅ | ✅ (redact first) | ❌ |
| Paste into claude.ai web | ✅ | ❌ | ❌ | ❌ |
| Paste into 3rd-party AI tool | ✅ | ❌ (unless approved) | ❌ | ❌ |
| Upload to 3rd-party renderer (Mermaid live, draw.io cloud, gist, pastebin) | ✅ | ❌ | ❌ | ❌ |
| Include in a skill committed to this repo | ✅ | ✅ (if no secrets) | ❌ | ❌ |
| Include in a CLAUDE.md committed to this repo | ✅ | ✅ (if no secrets) | ❌ | ❌ |
| Discuss in a Nestr tension | ✅ | ✅ | ✅ (scoped circle) | ✅ (private circle only) |

---

## Default classifications by department

These are **defaults** — always override downward if the specific content warrants (most things do).

| Department | Default for their routine work |
|---|---|
| Developer Relations | Internal |
| Technology / Engineering | Internal (code), Confidential (security reports) |
| Education | Public (published), Internal (drafts) |
| Operations — Biz-Dev | Confidential |
| Operations — Marketing | Internal |
| Operations — Legal | Restricted |
| Operations — Exec | Restricted |

---

## Up-classification: when to treat content as stricter

Even routine-tier content becomes **higher tier** when any of these are true:

- It names a partner by name before a joint announcement.
- It names a BSVA person with performance / comp / personal context.
- It contains a specific $ amount + a specific counterparty.
- It would violate an NDA if forwarded.
- It would surprise or embarrass the author if republished.

When in doubt, **up-classify**.

---

## Down-classification: when to treat stricter content as lower tier

Only on the explicit decision of the content owner (author or accountable role). Don't down-classify unilaterally.

---

## How Claude sees this

Claude reads the classification rules via `~/.claude/CLAUDE.md` (installed by the BSVA installer) and `guides/for-claude/classification-enforcement.md`. If Claude sees content that looks higher-tier than the session's context suggests, it will ask you to confirm — not silently refuse. This is deliberate: **you learn from every near-miss.**

---

## Who decides a tier

| Question | Who decides |
|---|---|
| Is this Public, Internal, or Confidential? | You — the person pasting. |
| Is something Restricted? | The content owner's role + Legal. |
| Is marketing ready to publish? | The marketing lead role. |
| Is this publishable as Public? | The relevant department lead. |

When you're unsure: **up-classify and ask**.

---

## Next

→ `12-when-to-escalate.md`

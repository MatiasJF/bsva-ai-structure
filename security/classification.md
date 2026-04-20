# Classification (source of truth)

BSVA's four-tier information classification scheme. Everything else in this repo — handling rules, Claude's enforcement logic, department defaults — references this file.

---

## The four tiers

### 🟢 Public

Information already published or intended for open publication without restriction.

**Distinguishing test:** Would BSVA be comfortable if a journalist, a competitor, or a member of the public saw this today? If yes → Public.

**Examples:**
- Published content on `bsvblockchain.org`.
- Published BSV Academy courses and lesson pages.
- Published GitHub repos under BSVA or related orgs.
- Published BRCs, BIPs, whitepapers, research papers.
- Press releases that have been released.
- Public talks, recorded or not.
- Public on-chain data (transactions, blocks, UTXOs, addresses).

---

### 🟡 Internal

Information meant for BSVA members and approved collaborators, but not for open publication. Sharing beyond this audience would not cause harm, but would be unprofessional or premature.

**Distinguishing test:** Would a reasonable BSVA member be comfortable if another BSVA member saw this? If yes — but we wouldn't publish it externally — it's Internal.

**Examples:**
- Internal roadmaps, OKRs, quarterly plans.
- Draft blog posts, drafts of announcements.
- Most Nestr tensions.
- Meeting notes that don't reference third parties in sensitive contexts.
- Non-sensitive internal process documents.
- Internal tooling documentation.

---

### 🟠 Confidential

Information whose disclosure would cause identifiable harm to BSVA, partners, or individuals — but not at the level of legal / regulatory breach.

**Distinguishing test:** If this leaked, would BSVA have to have a conversation with a partner, a board member, or a hiring candidate to apologize? If yes → Confidential.

**Examples:**
- Unannounced partnerships and the terms being negotiated.
- Unreleased product features and launch dates.
- Non-public financial figures (revenue, spend, runway).
- Candidate pipeline data and interview assessments.
- Commercial negotiations in progress.
- Security reports before remediation.

---

### 🔴 Restricted

Information whose disclosure would cause legal, regulatory, fiduciary, or serious reputational harm. Often covered by explicit legal obligations (NDA, employment contract, regulatory duty).

**Distinguishing test:** Could BSVA face legal exposure, breach a contract, or cause specific harm to a person if this leaked? If yes → Restricted.

**Examples:**
- Signed contracts and their draft amendments.
- NDAs and the content protected by them.
- Legal holds, privileged correspondence with counsel.
- Litigation-related documents.
- Board minutes, board memos.
- M&A: candidate lists, due-diligence files, term sheets.
- HR and compensation data.
- Medical / accommodation information.
- **Private keys, seed phrases, API keys for production systems** — never negotiable.

---

## Department defaults

These are the tier that a department's **routine work** should be treated as in the absence of other signals. Always override based on the specific content.

| Department | Default |
|---|---|
| Developer Relations | Internal |
| Technology / Engineering (general) | Internal |
| Technology / Engineering (security-sensitive reports) | Confidential |
| Education / BSV Academy (drafts) | Internal |
| Education / BSV Academy (published) | Public |
| Operations — Business Development | Confidential |
| Operations — Marketing (drafts) | Internal |
| Operations — Marketing (published) | Public |
| Operations — Legal | Restricted |
| Operations — Executive | Restricted |

---

## Who assigns a tier

- **The content author or the role accountable for the content** assigns the initial tier.
- **Anyone handling the content may up-classify** (treat as stricter) unilaterally.
- **Only the content owner (or their accountable role) may down-classify**, and that decision must be documented (PR, tension, or explicit email).

---

## Process changes

To propose changes to this classification (new tier, new example, changed default):

1. Open a PR modifying this file.
2. Tag `@bsva/devrel` and `@bsva/security` for review.
3. If changing a Restricted-related rule, also tag `@bsva/legal`.
4. Merge requires two approvals, at least one from security or legal depending on scope.

---

## References

- `data-handling-matrix.md` — what you may do with each tier.
- `human-responsibilities.md` — who owns what in the classification process.
- `guides/for-humans/11-information-handling.md` — human-readable guide.
- `guides/for-claude/classification-enforcement.md` — Claude's rules for each tier.

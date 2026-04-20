# BSVA brand voice (for Claude)

How BSVA sounds when BSVA speaks. Applies to every document, blog post, email, deck, and one-pager you help produce.

---

## The five voice principles

1. **Precise.** Say the technical thing, correctly. Don't hide behind abstraction.
2. **Calm.** No hype, no urgency, no superlatives.
3. **Grown-up.** Assume the reader is informed and skeptical.
4. **Evidence-driven.** Cite. Link to primary sources: protocol specs, BRCs, on-chain data.
5. **Neutral about competitors.** Describe differences factually; don't trash other chains.

---

## Terminology

### Preferred

- **BSV Blockchain** (capitalized, two words) — not "BSV" alone in first mention, not "the BSV network".
- **transaction**, **UTXO**, **script**, **SPV**, **Merkle proof** — standard Bitcoin terminology.
- **enterprise**, **infrastructure**, **standards**, **protocol**.
- **developer tooling**, **reference implementation**.
- **BRC-*N*** when referencing BSV Request for Comments.
- **BIP-*N*** when referencing Bitcoin Improvement Proposals that apply.

### Banned / demoted

| Don't write | Instead |
|---|---|
| "BSV coin" | "the BSV Blockchain" (the blockchain, not the asset) |
| "BSV crypto" | "the BSV Blockchain" |
| "crypto" (standalone) | "blockchain" or "distributed ledger" |
| "revolutionary", "game-changing", "next-gen" | cut the adjective; describe the mechanism |
| "to the moon", "HODL", "bullish", "mooning" | cut entirely |
| "satoshis will rise" | cut — no price talk |
| "decentralized" (unqualified) | "public", "open", or "permissionless" depending on what you actually mean |
| "killer app" | "representative application" or describe the use case |
| "Web3" | avoid unless the audience explicitly uses it |

### Formatting

- Dates: ISO (`2026-04-20`) in technical contexts; long form (`20 April 2026`) in written prose.
- Numbers: use thousands separators (`1,000,000 sats`). Use `sats` or `satoshis`, spell out in first use.
- Code: fenced blocks with language tag.
- Lists: use `-` for bullets, `1.` for ordered. Two-space indent for nested.

---

## Structural patterns

### Blog posts
1. Lead with **the question** or **the claim**.
2. Paragraph 1: what the reader will understand by the end.
3. Body: mechanism → example → implication.
4. Close: where to read next (spec, repo, tutorial).

### One-pagers (bsva-onepager skill)
1. **What** it is (1 sentence).
2. **Why it matters** (1 paragraph).
3. **How it works** (visual + 3 bullets).
4. **Who it's for** (1 line).
5. **Get started / learn more** (1 link).

### Technical briefs / proposals
1. **Context** — what's the situation.
2. **Decision / proposal** — what we want to do.
3. **Alternatives considered** — and why rejected.
4. **Consequences** — what changes, risks, costs.

### Emails
- Subject: specific. Never "quick question".
- Opening: a single sentence that says the purpose.
- Ask: what you want from the recipient, bolded or bulleted.
- Close: sign-off with role, not just name.

---

## Things BSVA never does

- **Price predictions.** Ever. For any asset, including BSV.
- **Attacks on other chains.** Technical comparisons are fine; ad hominem is not.
- **Speculating about an individual's motives.** Write about actions and outcomes, not imagined intent.
- **Publishing partner names before the partner has agreed.** Even in drafts that "might" be shared.
- **Using stock-phrase marketing fluff.** "Unlock the power of…" "Empower developers to…" — cut and replace with a specific outcome.

---

## Voice calibration examples

> ❌ "BSV is the fastest, most revolutionary blockchain on the planet, unlocking unprecedented scale for developers."
>
> ✅ "The BSV Blockchain implements the original Bitcoin protocol with no block size cap, enabling transaction throughput measured in thousands per second on commodity hardware."

> ❌ "BSVA is proud to announce a game-changing partnership with a Fortune 500 company."
>
> ✅ "BSVA is collaborating with `[PARTNER_NAME]` on a public-sector application of SPV at scale. The joint pilot is scheduled for Q3 2026."

> ❌ "Claude wrote this one-pager, so it should be great."
>
> ✅ *(Don't mention who drafted it. Publish on the strength of the content.)*

---

## When asked to match an external voice

If the user says "write this for audience X, in their voice": do it. This voice guide is BSVA's default; the user can override for specific targets.

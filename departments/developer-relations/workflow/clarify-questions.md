# DevRel — CLARIFY question bank

The universal 5 from `workflow/02-clarify.md` plus DevRel-specific extras per artifact.

---

## Dev-support reply

- Is this a sanitized repro or real user code?
- Which SDK version?
- Testnet or mainnet?
- Public channel (Discord thread, GitHub issue) or private (email, DM)?
- Do you want a reply draft, or a diagnosis first?
- Is this likely an SDK bug (→ tension to Tech), a documentation gap (→ my own nest), or a user error (→ reply only)?

## SDK example / snippet

- What single concept does this teach? (One concept per example — BSVA DevRel convention.)
- Who is the audience — SDK-new, BSV-new, both?
- Does it need funded UTXOs? A mocked wallet? A public test vector?
- Which SDK version?
- Where does it ship — examples repo, blog, workshop, SDK docs?
- Who reviews? (DevRel peer + sometimes sdk-maintainer.)

## Blog post / tutorial

- Length target (word count range)?
- Audience skill level?
- Primary sources to cite (BRC-N, BIP-N, spec, Academy concepts)?
- Does this reference unreleased features or unannounced partners?
- Target surface (BSVA blog, cross-post, Medium)?
- Deadline / event-tied?

## Workshop

- Event name, date, duration, venue (online / in-person / hybrid)?
- Attendee skill level assumption?
- Learning outcomes (max 3)?
- Do attendees need pre-funded testnet keys? A faucet?
- Co-delivered — who else?
- Recording rights — full / none / partial?
- Slides — `bsva-pptx` template default; any override?

## Conference / hackathon enablement

- Type: speaking slot, booth demo, judging criteria, prize track, workshop, office hours?
- Event name, dates, audience size estimate?
- BSVA's role — sponsor, partner, exhibitor?
- Budget implications — tension to Biz-Dev / Ops?
- Recording / PR expectations?
- Prep materials needed: talks, demos, handouts?

---

## Universal-five phrasing for DevRel

When batching the CLARIFY message, DevRel typically sounds like:

> "Before I start on this, let me ground it.
>
> - **What** — concretely: 1500-word blog post on BRC-100 for the BSVA blog? Or something different?
> - **Why** — is there an existing tension / question driving this, or should we draft one?
> - **Who for** — SDK-using developers who already know Bitcoin? Or BSV-new audience?
> - **Success** — looks like: draft → peer review → Tech fact-check → publish? Or less?
> - **Tier** — Internal until publish, then Public? That's the default.
>
> Plus, since this involves SDK content: which SDK version, and do we have a target surface?"

---

## Skipping CLARIFY (DevRel edge cases)

- Answering a one-line syntax question from a peer → skip, answer directly.
- Formatting an existing draft to match the blog template → skip (no content change).
- A correction to a post already published (typo) → skip CLARIFY, but ensure the correction is captured in the nest's comments and the publish gate was followed for the original.

Never skip for: new projects, workshops, new SDK examples, dev-support on real (non-sanitized) user code.

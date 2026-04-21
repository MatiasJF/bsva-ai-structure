# Legal — public research only

The rule. The whole rule. Read it twice.

---

## What "public research only" means

**Claude is used for:**
- Summarizing public law, regulation, and published guidance.
- Comparing jurisdictions based on public sources.
- Drafting generic templates (not tied to any BSVA matter).
- Reading public case summaries, published law firm articles, academic journals.
- Research assistance on abstract questions.

**Claude is NOT used for:**
- Anything identifiable as BSVA's matter.
- Privileged correspondence (attorney-client, attorney work product).
- Signed contracts, executed NDAs, amendments.
- Litigation-adjacent material (pleadings, discovery, settlement discussions).
- Regulatory filings in progress.
- HR / personnel / employment matters.
- Board resolutions or board-instructed work.

## The test

Before asking Claude anything in a Legal session:

> "Is this a public-law / public-regulation / public-policy question? Or does it reference, implicitly or explicitly, a BSVA matter?"

If it references a BSVA matter — **STOP.** Work offline, with the usual legal tools and review.

## Edge cases

- **"BSVA is asking about X publicly available regulation."** Fine. The topic is public.
- **"Is this clause standard?"** (paste of specific clause from BSVA's contract). **Not fine.** Even "standardness" assessment of a specific clause leaks context.
- **"Draft a generic MNDA for a reference template."** Fine. No party named, no BSVA-specific terms.
- **"Review our draft MNDA with Partner X."** Not fine. Work offline.

## Why so strict

Legal content is uniquely high-cost when it leaks:
- Waiver of privilege.
- Breach of NDA (often recursive — a single leak cascades).
- Regulatory exposure.
- Impact on counterparty trust.
- Impact on ongoing matters.

The cost/benefit for using Claude on BSVA-specific matter is lopsided — small productivity gain, enormous downside risk. We don't.

## Claude cannot give legal advice

Any output Claude produces that addresses a legal question about BSVA's matters is **draft research material**, not legal advice. Legal Lead names this explicitly in any document Claude helps produce.

## Session hygiene

- `/clear` after each task.
- Close Claude sessions (don't leave open).
- Logs enabled per `../session-logging.md`.
- Sessions run in CLI or Desktop — never web.

## If you realize you pasted something you shouldn't have

Per `security/incident-response.md`:
1. Close the session.
2. Notify Legal Lead + DevRel + Security.
3. Document.
4. Blameless review.

Privilege waiver questions are handled by Legal Lead — not by deleting and hoping.

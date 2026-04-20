# Legal — CLAUDE.md

Extends `../CLAUDE.md` (operations) and the base. Security rules are **much stricter** here.

---

## Default classification

**Restricted.** Everything Legal handles is Restricted by default. The Legal Lead down-classifies specific documents or questions only deliberately.

---

## Hard rules — non-negotiable

- **No contracts into Claude. Ever.** Not executed contracts, not drafts, not amendments, not clauses pulled from real contracts.
- **No privileged correspondence.** Attorney-client, attorney work product — out.
- **No litigation material.** Pleadings, discovery, settlement discussions — out.
- **No regulatory filings in progress.** Public versions, after filing, are fine.
- **No PII from data-subject requests.**

## What Legal CAN use Claude for

- **Research on public law / regulation.** Fine. Claude can summarize, compare, explain public sources.
- **Abstract structural questions.** "What are the typical components of an indemnity clause?" — fine, using hypotheticals.
- **Research assistance for filings.** Finding precedents, understanding jurisdiction differences, when the research doesn't involve BSVA's specific matter.
- **Drafting general-purpose templates** (e.g., a starting-point MNDA structure) that will be customized outside Claude.

## The rule of thumb

**If the document or matter relates to BSVA, don't paste it.** If it's general legal research, fine.

## Claude cannot give legal advice

State this explicitly when drafting anything that might be confused for advice. Any output from Claude that addresses a legal question about BSVA's matters is **draft research material**, not legal advice.

## Escalation

- Legal Lead — Nestr role: `Legal Lead`.
- For incidents involving potential legal exposure: Legal Lead + Security.

## Audit

Legal sessions should run with session-logging enabled (`Stop` hook in `settings.json`). Retain logs per the document-retention policy.

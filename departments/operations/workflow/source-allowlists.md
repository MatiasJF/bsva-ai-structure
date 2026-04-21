# Operations — source allowlists

Where Operations fetches data from. Anything not on these lists requires approval before use.

---

## Biz-dev

**Approved public sources (free / Public-tier):**
- Firm's official website, blog, press page.
- SEC / regulatory filings.
- LinkedIn public posts (not private feeds or messages).
- Twitter / X public posts.
- Crunchbase free tier.
- Published VC portfolio pages.
- Published conference / podcast appearances.

**Paid sources (require BSVA contract + Legal sign-off before use):**
- Crunchbase Pro / Enterprise.
- PitchBook.
- Preqin.
- CB Insights.

**Never:**
- Scraping behind authentication walls ("logged-in Crunchbase").
- Private databases that prohibit LLM ingestion in their ToS.
- Hacked / leaked databases of any kind.

## Marketing

**Approved public sources:**
- BSVA-owned channels (blog, docs, Academy, GitHub).
- Public partner-announced collaborations.
- Published industry reports (freely available).
- Conference and event public pages.
- Public competitor communications (reference only, never copy).

**Never:**
- Copying competitor copy verbatim.
- Inventing partner quotes.
- AI-generated imagery of real identifiable people.

## Legal

**Approved public sources:**
- Regulatory publications (SEC, FINMA, FCA, FINRA, equivalent).
- Public legal databases (case law aggregators, court records).
- Academic journals.
- Published law firm thought-leadership (with citation).

**Never in Claude:**
- Any BSVA-matter document (contracts, NDAs, correspondence, privileged memos).
- Licensed legal databases without explicit ToS compatibility — and even then, not BSVA-specific queries.

## Exec

**Approved public sources:**
- Published industry reports.
- Public financial filings of industry players.
- Published BSVA statements, speeches, interviews.
- Public policy documents.

**Never in Claude:**
- Board materials, minutes, memos.
- M&A candidates, term sheets, due-diligence files.
- Internal financial data before public disclosure.
- Investor communications before public release.

---

## Adding a source to an allowlist

1. Propose in a tension to the Operations Lead + Legal Lead.
2. Document the source's ToS (must permit LLM-adjacent use).
3. If paid source: reference the BSVA contract covering it.
4. On approval: PR this file to add the source to the relevant sub-section's list.
5. Document the classification tier the source produces (usually Public for public sources).

## Removing a source

- If a source changes its ToS (e.g., prohibits LLM use) → remove immediately; notify affected users.
- If a source has an incident affecting its trustworthiness → remove pending investigation.

## The `approved-external-tools.md` relation

`security/approved-external-tools.md` governs the **tools** Operations uses (where data gets processed). This file governs the **sources** data comes from. Both must be respected; they cover different axes.

# Biz-Dev — lead list playbook

The flagship biz-dev artifact: a structured list of leads (VCs / exchanges / market makers / enterprises) with public-data enrichment.

---

## The cycle

### 1. CLARIFY
Claude asks:
- **Market scope**: "blockchain infra", "L1 scaling", "enterprise payments", etc.
- **Tier**: e.g., "Tier-1 VCs with AUM > $1B", "Tier-2 regional exchanges".
- **Geography**: global / US / EU / APAC / specific country.
- **Stage** (for VCs): seed / A / B / C / late / all.
- **Output schema**: what columns, what format (CSV / Markdown / Notion).
- **Row count target**: rough range.

Claude does **not** ask for: BSVA pipeline status, prior intros, confidential targets. Those are **deliberately excluded** from the session.

### 2. CAPTURE
**Nest** under Biz-Dev role. Confidential.

Title: `Tier-1 VCs in blockchain infra lead list shipped`

Acceptance criteria:
- Row count N ± 20%.
- Every row has: firm name, URL, stage focus, published portfolio count, last-check date.
- Every row cites a public URL as source.
- No inferred / guessed email addresses — only published contact paths.
- Output format: CSV.
- Source allowlist respected (see `../source-allowlists.md`).

### 3. PLAN-MODE
Claude proposes:
1. Source queries against allowlisted public pages.
2. Per-row enrichment loop (firm → URL → portfolio → stage classification).
3. Dedup against any existing list (if one exists and is referenced — handle carefully).
4. QA sweep for row-citation completeness.

Approved.

### 4. SCAFFOLD
Copy `departments/operations/templates/new-lead-list/` (or inline if no template). Create a `.gitignore`-respecting project folder; never commit the CSV.

### 5. EXECUTE
Claude fetches public data, one source at a time. For each row:
- Firm name (from the official site or press).
- URL (official).
- Stage / focus (from portfolio or public thesis).
- Notes (1–3 lines from public content, each citing its URL).
- Last-check date (today).

Rows with missing required fields are flagged, not guessed.

### 6. REPORT
Comment on nest:
> "Shipped: `leads-vc-blockchain-infra-2026-Q2.csv`, 287 rows. Sources respected (allowlist). 12 rows flagged for missing stage info — separate enrichment pass needed. No inferred emails. File is in: `~/ops-lead-lists/leads-vc-blockchain-infra-2026-Q2.csv` (Confidential; not committed)."

### 7. CLOSE
Biz-Dev Lead reviews the CSV. Checks:
- Row-citation completeness.
- No guessed emails.
- Allowlist respected.
- Dedup against pipeline handled outside Claude (list goes into CRM separately).

Set `project.status: Done`.

---

## What Claude does / doesn't do

Does:
- Build the list from allowlisted sources.
- Redact any accidentally-included non-public info via `anonymizer`.
- Cite every row.
- Flag gaps instead of guessing.

Doesn't:
- Guess emails or phone numbers.
- Use private scraping (behind auth).
- Combine the list with BSVA pipeline data (that's a CRM-side merge, not a Claude task).
- Retain the list across sessions — start fresh for each run.

## Storage

- CSV lives in a project folder covered by `.gitignore` and disk encryption.
- **Never** commit the CSV to a repo.
- **Never** upload to a public tool (Google Sheets is fine if BSVA-approved; public pastebins are not).

## When a lead becomes a conversation

Once BSVA is in private conversation with a lead, that entity moves to **Restricted** for Claude purposes. Do not reference them by name in new sessions — use `[PARTNER_A]` placeholder.

---
name: lead-list-builder
description: Builds a structured lead list (VCs, exchanges, market makers, enterprises) from allowlisted public sources, URL-cited per row, no inferred emails. Refuses non-allowlisted sources and refuses to mix with BSVA pipeline data. Invoke for biz-dev prospecting against public data.
classification: Confidential
owner: "@bsva/operations"
version: 0.1.0
---

# lead-list-builder

## Behavior
1. CLARIFY: market, tier, geography, stage, output schema, row count target.
2. Fetches from allowlisted sources only (see `source-allowlists.md`).
3. Per row: firm name, URL, stage/focus, notes (each cited), last-check date.
4. Flags rows with missing required fields (no guessing).
5. Output: CSV / Markdown per schema.

## Hard rules
- Allowlist-only sources.
- No inferred emails or contacts.
- No mixing with BSVA pipeline data.
- Never retain across sessions; fresh each time.
- `anonymizer` auto-run on any user-pasted content.

---
name: market-maker-tracker
description: Tracks a market maker's public positions, published venues, and policies across the last N months. Uses allowlisted sources only. Separates factual summary from any BSVA-context interpretation. Invoke for biz-dev market-intelligence work.
classification: Confidential
owner: "@bsva/operations"
version: 0.1.0
---

# market-maker-tracker

## Behavior
1. CLARIFY: target (public), venues of interest, time window.
2. Fetches published positions from allowlisted sources.
3. Produces a timeline + position summary.
4. Any BSVA interpretation kept separate and Internal-tier.

## Hard rules
- Public sources only.
- No speculation about unpublished positions.
- No mixing with BSVA's private commercial context.

# Example 2 — Shipping an SDK example

A 200-line `@bsv/sdk` example illustrating PushDrop token mint, start to publish.

---

**DESIRE.** DevRel Lead in a 1:1: "We should have a clean PushDrop mint example — three support threads this week asked about it."

**CLARIFY.** `clarify` skill:

> - What: a ~200-line TS example, runnable via `npm start`, using @bsv/sdk v1.9.x?
> - Why: demand from #dev-help (3 threads / week); fills a gap in `bsv/examples`.
> - Who for: SDK-using devs, BSV-new or not, intermediate skill.
> - Classification: Internal → Public on publish.
> - Success: runs on fresh clone, README explains the concept, peer-reviewed, linked from SDK docs?

Lead confirms. Adds: "Use Testnet. Generate a fresh key pair — don't reuse the one from the BRC-100 example."

**CAPTURE.** `tension-or-nest`: own DevRel work → **nest**.

```
Title: Example: PushDrop token mint walkthrough shipped
Labels: [project, sdk-example, ts-sdk, audience/intermediate, classification/internal→public-on-publish]
Acceptance criteria:
  - Runs on npm i && npm start, fresh testnet key generated on setup.
  - README has Objectives, Prerequisites, Run, Next Steps sections.
  - No hardcoded secrets. No reused testnet keys.
  - verify-sdk-surface passed against @bsv/sdk v1.9.3.
  - DevRel peer review recorded as comment.
  - classify-before-publish gate passed by DevRel Lead.
  - Merged to bsv/examples repo with README link.
```

Nest ID: `N-9115`.

**PLAN-MODE.** Claude drafts:
1. Scaffold from `templates/new-sdk-example/`.
2. Decide the PushDrop concept boundary — mint only, no transfer (that's a separate example).
3. Structure: `src/main.ts` with 4 clear sections (setup, mint, broadcast, verify).
4. README using BSVA tutorial voice.
5. Run + verify on testnet; capture txid in README.
6. Open peer-review tension to DevRel Peer role. (Not a tension on a specific user — the role.)
7. Pass classify-before-publish gate with Lead.
8. PR to `bsv/examples` + update SDK docs link.

**Files:** `src/main.ts`, `README.md`, `package.json`, `tsconfig.json`, `.gitignore`.
**Skills:** `sdk-example-scaffold`, `verify-sdk-surface`, `classify-before-publish`.
**MCPs:** simple-mcp (scaffolding), WhatsOnChain (verify broadcast), (GitHub for PR).
**Estimate:** 3–4h draft + 1 review round.

Lead approves with one tweak: "Skip broadcast section in the example — reference it as a `// TODO: broadcast` comment and link to a separate broadcasting example."

**EXECUTE.**

Session 1 (2h):
- Scaffolded. Linked CLAUDE.md. Git init + first commit with nest reference `N-9115`.
- Wrote `src/main.ts` with the three sections (setup, mint, verify-by-reading).
- Ran `verify-sdk-surface` — all PushDrop methods verified in v1.9.3.
- Posted milestone comment on nest: "Draft mint logic complete; no broadcast per approved plan. Ready for README."

Session 2 (1h):
- Wrote README in BSVA voice. Included `[TXID]` placeholder (filled after running).
- Ran example on testnet; got a real txid; verified via WhatsOnChain MCP.
- Substituted the real txid in README.
- Posted comment: "Draft ready for peer review."
- Opened tension `T-6802` to DevRel Peer role — clustered with 2 other DevRel example-review asks for efficiency.

Session 3 (30m, after peer review):
- Peer review comments: rename `mintTokens` to `mintToken` (single consistent with BRC), add a tiny paragraph about why PushDrop vs other token patterns.
- Applied. Comment on nest: "Peer review integrated."

Session 4 (30m):
- Ran `classify-before-publish` gate:
  - ✓ Accuracy (verify-sdk-surface passed, WhatsOnChain txid verified).
  - ✓ Voice (external-comm-check passed).
  - ⚠ Attribution — flagged that README linked to an unannounced partner docs page. Fixed: linked to public spec instead.
  - ✓ Classification.
  - Pending: Lead approval.
- Pinged Lead on nest: "Gate report attached, ready for your 'go'."
- Lead approved in a comment: "go".

**REPORT.** Final comment on nest:

> "Shipped: `bsv/examples/pushdrop-token-mint` (PR #312, merged). SDK docs updated with link. Peer-review tension `T-6802` closed. Classification flipped: Internal → Public (commit 4f2c8d1). Txid in README: [testnet txid]. Known follow-up: similar `pushdrop-token-transfer` example is a candidate for next week — added to DevRel backlog as draft nest `N-9120`."

**CLOSE.** Lead sets `project.status: Done`, `completed: true`. Total elapsed: 1 week; actual working time 4h.

---

## What this example shows

- CLARIFY produced explicit acceptance criteria the Lead could check against at close.
- Plan-mode caught one scope reduction (no broadcast section) before coding.
- `verify-sdk-surface` + `classify-before-publish` ran automatically at the right points.
- Peer-review tension was clustered with other similar asks → one tension instead of three.
- The final comment gives anyone reading the nest 6 months from now a complete picture.

---
name: classify-before-publish
description: Runs BSVA's publish gate before any Internal→Public transition (blog, lesson, release, announcement). Checks accuracy, voice, classification-label flip, attribution/safety, and owner approval. Returns a pass/fail/partial report with specific fixes. Refuses to proceed with publish actions if any check fails without explicit owner approval. Required by global CLAUDE.md for all shared content.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# classify-before-publish

The last gate before content leaves BSVA. See `workflow/08-publish-gate.md` for the process.

## When Claude should invoke this

- User says "publish this" / "ship this" / "push to main" / "send the announcement".
- User requests a PR that opens Public-tier content.
- Any tier flip from Internal → Public.

## The 5 checks

1. **Accuracy** — every factual claim cites a primary source (BRC, BIP, spec, published repo, Nestr tension).
2. **Voice** — passes `guides/for-claude/brand-voice.md`: no hype, no price talk, no banned phrases, BSV Blockchain capitalized.
3. **Classification label flip** — Nestr nest's label changes from `classification/internal` → `classification/public`, with a comment explaining the flip.
4. **Attribution / safety** — no unannounced partners named, no draft contract content, no identifiable learner / customer data, no unverified quotes.
5. **Owner approval** — the accountable role has posted explicit "go" on the Nestr nest. Names the approver + timestamp.

## Behavior

1. Read the artifact (file or URL).
2. Read the Nestr nest description + comments (if linked).
3. Run each of the 5 checks.
4. Output a structured report:

```
Publish gate: [PASS | PARTIAL | FAIL]

1. Accuracy       [✓/✗] [details]
2. Voice          [✓/✗] [details]
3. Classification [✓/✗] [details]
4. Attribution    [✓/✗] [details]
5. Approval       [✓/✗] [details]

Blockers:
- [specific]
Suggested fixes:
- [specific, linkable to the artifact]
```

5. If PASS → Claude may proceed to execute the publish action.
6. If PARTIAL or FAIL → Claude refuses the publish and offers to fix what it can. Never proceeds without owner approval landing on the nest.

## Hard rule

**Claude cannot approve a publish.** That is explicitly a human role. If the user says "just publish it" and any check fails, Claude produces the list and says: "I can't publish without the accountable role's explicit approval on the nest. Here's the pre-cleaned message for them; I'll proceed when their approval lands."

## Cross-reference

- `workflow/08-publish-gate.md`
- `guides/for-claude/brand-voice.md`
- `security/classification.md`
- `guides/for-humans/09-what-NOT-to-send.md`

## Examples

*(Include 2–3 worked examples: a clean pass, a partial-fix flow, and a hard-refuse flow with unannounced partner.)*

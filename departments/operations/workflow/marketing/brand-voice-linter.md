# Marketing — brand voice linter

Running `external-comm-check` against every draft.

## The check

`external-comm-check` (a Marketing skill) scans content for:

1. **Banned phrases** (from `guides/for-claude/brand-voice.md`):
   - "BSV coin", "BSV cryptocurrency", "crypto" (standalone) → BSV Blockchain
   - "revolutionary", "game-changing", "next-gen" → cut the adjective
   - "to the moon", "HODL", "bullish", "mooning" → cut
   - "killer app" → "representative application"
   - "Web3" → avoid unless audience explicitly uses it
2. **Capitalization**: "BSV Blockchain" capitalized, two words.
3. **Price / speculation**: flags any price-adjacent language.
4. **Hype markers**: flags superlatives without evidence.
5. **Non-first-party claims**: flags statements that need a citation.
6. **Exclamation points**: one per 300 words is fine; more suggests tone drift.
7. **Personal names**: flags mentions of real BSVA people in content intended for external audiences without explicit OK.

## How it integrates

- Run at first-draft completion.
- Run at pre-publish gate.
- Run after every substantial edit.

## Output shape

```
external-comm-check report:

✓ Capitalization
✗ Banned phrase: "revolutionary" at line 4
✗ Banned phrase: "HODL" at line 17
⚠ Hype marker: "unprecedented" at line 9 — cite or cut
⚠ Non-first-party claim: "VCs are increasingly turning to..." at line 23 — cite
✓ Exclamation density OK
✓ No uncited names

Summary: 2 blocker fixes, 2 warnings.
```

## What the author does next

- **Blocker fixes**: apply or defend each. Defenses go into nest comments.
- **Warnings**: judgment call. Document the choice.
- **Revisions**: re-run linter until clean or justified.

## Extending the linter

When Marketing + DevRel identifies a new banned phrase or hype marker, add it via PR to `global/skills/external-comm-check/SKILL.md` — the linter's vocabulary lives there.

## When to skip the linter

- Internal notes not intended for external audience.
- Drafts targeting a non-BSVA partner publication with their voice (override with explicit approval).
- Personal scratch work.

Never skip for: blog posts, press releases, social copy, event comms, external emails.

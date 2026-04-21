---
name: tension-or-nest
description: Decides whether a piece of work should be captured as a Nestr nest (own work under your role) or a tension (cross-role ask). Invoke after CLARIFY has established what the work is. Walks the decision tree from workflow/03-nest-vs-tension.md in 2 questions and produces the correct Nestr call. Prevents creating work under another role's accountability and prevents using tensions for your own work.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# tension-or-nest

The second skill in the cycle. Runs after `clarify`.

## When Claude should invoke this

- After CLARIFY, before creating any Nestr node.
- When user says "capture this" / "let's track this" / "I need another team to do X".
- Any time it's ambiguous whether a task crosses a role boundary.

## Behavior

Ask two questions at most (usually implied by CLARIFY answers; only ask if gaps):

1. **Are you accountable for this** — does a role you fill have this in its accountabilities?
2. **Do you need anyone else's time or authority** to finish it?

### Decision
- Q1 yes + Q2 no → **Nest** under your role. Produce `nestr_create_nest` call with past-tense title, acceptance criteria, labels, `users: [you]`.
- Q1 yes + Q2 yes → **Nest** (yours) + draft **Tension** (for the cross-role piece only). Name both in the output.
- Q1 no → **Tension** to the accountable role. Use `nestr_create_tension` with the 5-pathway model (info request, info share, outcome request, action request, governance).
- Structural change (new role, policy, domain) → **Tension** on the circle with governance-labeled parts.
- No role accountable → create nest on circle with `individual-action` label AND open a governance tension.

## Output shape

A short proposal message:

```
This is a [nest under DevRel role / tension to Tech sdk-maintainer / nest + tension pair].

Proposed title: [past tense]
Classification: [tier]
Labels: [3–6]
Acceptance criteria:
  - [item 1]
  - [item 2]

[If tension:] Pathway: [1–5]
[If pair:] Linked tension: [proposed title + target role]

Shall I create?
```

Wait for explicit approval before calling the Nestr MCP.

## Cross-reference

- `workflow/03-nest-vs-tension.md` — the full decision tree with 15 worked cases.
- Nestr help: `nestr_help tension-processing` and `nestr_help doing-work`.

## Examples

*(Include 3–5 worked examples covering nest, tension, nest+tension pair, governance tension, and individual-action cases.)*

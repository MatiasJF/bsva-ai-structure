---
name: clarify
description: Forces the CLARIFY step at the start of a task. Invoke when the user describes a new piece of work (write X, build Y, research Z) without having answered the universal 5 (what / why / who for / success / classification). Asks the artifact-appropriate questions from workflow/02-clarify.md in a single batched message, then prepares the Nestr nest description block from the answers.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# clarify

The universal entry point to BSVA's workflow cycle. Every substantive task starts here.

## When Claude should invoke this

- User describes a new artifact (post, lesson, service, brief, list) without specifying audience / purpose / success.
- User says "do X" where X is non-trivial (>2 files, >30min, will be shipped, non-Public tier).
- Continuation session that's changing scope.

## When to skip

- Trivial transformations (format, convert).
- User has already answered the 5 in the prompt.
- User is working on personal scratch and has opted out.

## Behavior

1. Identify the artifact type from the user's description. Match to the banks in `workflow/02-clarify.md` (content / code / research / external-comm / events / education-specific / operations / legal-exec).
2. Ask the universal five + artifact-specific extras in **one batched message**, not one at a time.
3. Wait. On response:
   - If all answered → propose a Nestr nest title (past tense) + acceptance criteria HTML block.
   - If partially answered → re-ask the gaps.
4. Do not proceed to plan-mode until the universal five are answered.

## Output shape

A single message to the user containing:
- A one-sentence restatement of the ask.
- The batched questions, grouped by category.
- Offered default classification tier (up-classify if uncertain).
- Closing: "Reply with as many as you have; I'll ask for the rest if needed."

## Linked docs

- `workflow/02-clarify.md`
- `workflow/04-nestr-conventions.md`

## Examples

*(Include 2–3 worked examples showing raw user ask → CLARIFY message → nest description block.)*

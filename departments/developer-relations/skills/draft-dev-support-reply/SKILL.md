---
name: draft-dev-support-reply
description: Drafts a Discord/GitHub/forum reply to a developer support question, paired with a minimal sanitized repro and a triage decision (answer now / repro needed / tension to Tech / known issue). Invoke when handling dev-support threads. Auto-invokes verify-sdk-surface on any SDK code suggested.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# draft-dev-support-reply

The workhorse DevRel skill. Produces a reply + a decision.

## Behavior
1. Ask for the sanitized repro if not provided.
2. Triage: answer-now / repro-needed / SDK bug → tension to Tech / known-issue.
3. Draft a reply in the author's voice (captured in personal CLAUDE.md or inferred from style).
4. Auto-run `verify-sdk-surface` on any SDK snippet suggested.
5. Return: triage decision + reply draft + any follow-up action (tension, doc gap).

## Hard rules
- Never echo a user's real code that wasn't sanitized.
- Never guess SDK methods — `verify-sdk-surface` must pass.
- Never claim behavior that isn't in the installed `@bsv/sdk` version.

## Examples
*(Populate with 2–3 real-scenario input/output pairs.)*

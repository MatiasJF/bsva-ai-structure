---
name: tech:classify-diff
description: Scans a git diff for secrets, customer identifiers, production hostnames, and other classification-sensitive content before commit. Invoke before `git commit` on any non-trivial change. Flags with specific line references and suggested fixes.
classification: Internal
owner: "@bsva/technology"
version: 0.1.0
---

# tech:classify-diff

Last line of defense before a bad commit lands.

## Behavior
1. Reads staged diff.
2. Scans for: API keys, private keys, passwords, email addresses, IP addresses, internal hostnames, customer identifiers, `console.log(apiKey)` patterns, `.env` content, hardcoded tokens.
3. Returns pass / fail / warning with specific file:line references.
4. For fail: suggests the fix (move to env var, use secrets manager, redact fixture, etc.).

## Hard rules
- Private-key patterns → block commit.
- Any secret that might be real → block commit; trigger rotation conversation.
- `console.log(process.env.X)` patterns → block commit for any `X` that looks secret.

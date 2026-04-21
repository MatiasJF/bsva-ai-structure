---
name: verify-sdk-surface
description: Given a snippet of @bsv/sdk TypeScript code, verifies every imported symbol and method call actually exists in the installed package version. Reads node_modules/@bsv/sdk. Flags non-existent, deprecated, or internal-only symbols. Invoke after Claude writes or refactors SDK code; before committing; during dev-support snippet generation. Prevents hallucinated API calls reaching developers.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# verify-sdk-surface

DevRel's hallucination-killer.

## Behavior
1. Parse the TS/JS code for `@bsv/sdk` imports and method calls.
2. Resolve each against `node_modules/@bsv/sdk/`.
3. For each symbol: ✓ / ✗ / deprecated / internal-only.
4. For resolved symbols: signature check (arity, param names match).
5. Return a structured report with suggested fixes.

## Hard rules
- Does not modify code — only reports.
- Always reads the installed version (pinned in `package.json`).
- Flags usage of non-public (internal-only) exports.

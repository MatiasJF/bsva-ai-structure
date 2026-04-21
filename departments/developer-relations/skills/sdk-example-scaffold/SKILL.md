---
name: sdk-example-scaffold
description: Scaffolds a minimal @bsv/sdk example project from DevRel's new-sdk-example template, wiring in BSVA review-checklist, verify-sdk-surface, and .gitignore. Invoke when creating a new one-concept SDK example. Enforces the "one concept per example" DevRel convention.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# sdk-example-scaffold

Scaffolds a BSVA-compliant SDK example.

## Behavior
1. Confirms the single concept being taught (refuses multi-concept mashups).
2. Copies `templates/new-sdk-example/`.
3. Initializes git with a first commit referencing the Nestr nest ID.
4. Drops in a `README.md` stub with Objectives / Prerequisites / Run sections.
5. Pins SDK version in `package.json`.

## Hard rules
- One concept per example.
- No shared testnet keys.
- `verify-sdk-surface` required before any commit.

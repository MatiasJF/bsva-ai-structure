# Technology department skills

Skills specific to Tech / Engineering work. Invoked when Claude is working in a Tech-linked project.

## Candidates

- `tx-debugger` — given a txid or raw tx, explain the script structure and identify issues.
- `protocol-spec-writer` — draft or refine BSVA-style protocol documents.
- `rfc-drafter` — turn bullet proposals into a full RFC document.
- `test-filler` — generate test cases from a function signature + behavior description.
- `dependency-verifier` — given Claude-produced code, cross-check every `import` against installed packages.

See `guides/visuals/03-skill-lifecycle.md` for how to author and promote a skill.

## Conventions

- `classification: Internal` default; `Confidential` for anything touching security analysis.
- `owner: "@bsva/technology"`.
- Always include runnable examples in the SKILL.md body.

# new-protocol-spec

Scaffold for a BSVA-style protocol document (BRC-style or internal spec).

## Structure

```
my-spec/
├── README.md              short abstract + link to the spec file
├── CLAUDE.md
├── spec.md                the document itself — see below for structure
├── examples/              test vectors / example transactions / sample payloads
└── discussion.md          questions, alternatives considered, open issues
```

## Required sections in spec.md

1. **Abstract** — 2–4 sentences: what this specifies and why.
2. **Motivation** — the problem; why existing options don't solve it.
3. **Specification** — the actual normative content. Use MUST / SHOULD / MAY.
4. **Rationale** — why these choices and not others.
5. **Compatibility** — backward / forward compatibility, migration.
6. **Examples** — concrete test vectors.
7. **Security considerations** — threats, mitigations.
8. **References** — BIPs / BRCs / other specs cited.

## Tone

Specifications are never marketing. No hype, no "revolutionary", no price talk. Use RFC-style prose: precise, tense-consistent, terse.

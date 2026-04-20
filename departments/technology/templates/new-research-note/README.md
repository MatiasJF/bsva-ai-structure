# new-research-note

Scaffold for an internal research note: an analysis, benchmark, or investigation write-up.

## Expected structure

```
my-note/
├── README.md          TL;DR (2–3 sentences) + link to note.md
├── CLAUDE.md
├── note.md            the full write-up
├── data/              raw data, where applicable — classified per source
└── scripts/           reproducibility scripts
```

## note.md outline

1. **Question** — what were we trying to learn?
2. **Method** — what we did.
3. **Results** — what we found.
4. **Interpretation** — what it means (be careful here; separate claim from evidence).
5. **Limits** — what this doesn't address.
6. **Next** — follow-ups.

## Classification

Most research notes are **Internal**. Up-classify to **Confidential** if:
- The note references specific partner deployments.
- The results imply a competitive position we shouldn't disclose.
- Security-sensitive findings.

## Reproducibility

If the note makes a quantitative claim, `scripts/` should let a colleague re-run it. Attach the data if it's not sensitive; document the data source if it is.

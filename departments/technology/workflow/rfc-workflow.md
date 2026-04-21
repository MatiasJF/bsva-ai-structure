# Technology — RFC / BRC / ADR workflow

Protocol / specification work. Extends `<repo>/workflow/01-the-cycle.md`.

---

## Decide: BRC or ADR?

- **BRC (BSV Request for Comments)** — public standard, published to the BSV Blockchain community. Governance review: Standards circle.
- **ADR (Architecture Decision Record)** — internal architectural decision for BSVA-operated services. Lives in the relevant repo's `docs/decisions/`.
- **Both** — some proposals need both a BRC (the standard) and an ADR (how we implement it).

Default: if it's a protocol claim others should implement, it's a BRC. If it's an operational choice for our systems, it's an ADR.

---

## The sequence (BRC)

```
1. CLARIFY — driving tension, problem statement, who feels it, existing BRC touched
2. CAPTURE — tension on Standards circle, governance-labeled parts
3. PLAN-MODE — section outline, reviewers needed, test vectors, ref-impl scope
4. DISCUSS — Q&A, alternatives
5. APPROVE — plan locked
6. SCAFFOLD — templates/new-protocol-spec/
7. EXECUTE — draft sections in order: Motivation → Specification → Rationale → Backward-compat → Reference-impl → Security considerations
8. REPORT — submit tension to `proposed` status; comment with the draft
9. CLOSE — governance decision (accepted / objected); on accepted, BRC number assigned, merged
```

## Required sections (BRC)

1. **Abstract** — 2–4 sentences: what this specifies + why.
2. **Motivation** — the problem; why existing options don't solve it.
3. **Specification** — normative content. Use `MUST` / `SHOULD` / `MAY`.
4. **Rationale** — why these choices.
5. **Backward-compat** — compatibility story, migration if any.
6. **Reference implementation** — or pointer to one.
7. **Test vectors / examples** — concrete.
8. **Security considerations** — threats, mitigations.
9. **References** — BIPs / BRCs / other specs cited.

Tone: **RFC-style prose**. Precise, tense-consistent, terse. No marketing, no hype, no "revolutionary".

## Reviewers

Every BRC needs:
- At least **two named reviewers** from roles outside the author's own (cross-check).
- **Security review** for any cryptographic content.
- **DevRel review** for developer-facing surface / API shape.
- **Standards circle consent** via the governance tension.

## Clustering and BRC references

- Do not bundle multiple unrelated BRC candidates into one tension.
- Do cite related BRCs liberally in the Rationale and References sections.
- Related-but-separate proposals can be sibling tensions with graph links.

## ADR workflow

Simpler. ADR lives in `docs/decisions/` of the relevant repo. Sections:

1. **Context** — situation forcing the decision.
2. **Decision** — what we chose.
3. **Alternatives considered** — and why rejected.
4. **Consequences** — what changes, risks, costs.

Process:
1. CLARIFY → nest (own work if you're in the service's Tech role).
2. Draft the ADR.
3. Peer review (one Tech + one Standards reviewer for architectural weight).
4. Merge + close nest.

---

## Anti-patterns

- **BRC without a driving tension** — if no role feels the problem, the proposal is premature.
- **Mixing governance and operational tensions** — BRC is governance. A PR implementing the BRC is operational. Separate nests / tensions.
- **Publishing a BRC before Security review** — especially for cryptographic BRCs.
- **Vague normative language** — `MUST` means must. Using "should probably" defeats the spec.
- **No test vectors** — "an untested spec is a bug factory in disguise" (Tech culture quote).

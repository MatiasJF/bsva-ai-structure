# Technology — CLARIFY question bank

Universal 5 + Tech-specific extras per artifact.

---

## Code change / PR

- Which service / repo + baseline commit SHA?
- Bug fix or feature?
- Is there an existing Nestr tension / RFC driving it? (If not, should we draft one?)
- Language / runtime version — explicit?
- Backward-compat requirements?
- Perf-critical or consensus-critical path?
- Test coverage expectation (unit / integration / none-and-why)?
- Review path — who reviews? Crypto-sensitive → second reviewer from Security?
- Branch strategy — feature branch from `main` or from a release branch?

## Research note / spike

- **Question** — in one sentence, what are we trying to learn?
- **Decision dependent on the answer** — what changes based on it?
- Public / Internal tier on the output?
- Data source + classification of the source data?
- Time box — hours / days / weeks before we re-scope?
- What's explicitly out of scope?

## RFC / BRC / ADR

- Scope — BRC candidate (public) or internal ADR?
- Which existing BRCs does this touch / supersede?
- What problem + who feels it? (A tension should exist; if not, this isn't ready.)
- Normative vs informational?
- Reference implementation in scope?
- Security considerations section — who drafts it?
- Target circle for governance review (Standards circle, Tech circle)?

## Incident / postmortem

- Time window — when did it start, when detected, when mitigated?
- Scope of impact — users, data, signed material, downstream systems?
- **Sensitivity**: is there customer-data impact? Key impact? Legal exposure?
- Classification floor: Confidential minimum; Restricted if customer keys involved.
- Immediate comms plan (status page, partners, exec)?
- Blameless review scheduled?

## CI / deployment

- Which environment (dev / staging / prod)?
- What's the rollback plan?
- Who approves the deploy trigger? (Claude does not trigger production deploys.)
- Secrets in scope — where do they live (Vault, secrets manager)?
- Config drift — is this changing non-obvious config alongside the deploy?

---

## Tech-specific universal-5 phrasing

> "Before I change any code, let me ground this.
>
> - **What** — concretely: a bug fix in the header-verification path?
> - **Why** — is there an existing tension or is it ad-hoc? Priority vs other work?
> - **Who for** — downstream consumers: SDK users? Reference-node operators? Internal services?
> - **Success** — looks like: tests green + perf within budget + second reviewer approved? Or broader?
> - **Tier** — Internal (the code) + Confidential (if this is in response to a reported security issue)?
>
> Plus: baseline commit SHA, target branch, reviewer expectations."

---

## Skipping CLARIFY (Tech edge cases)

- Trivial README / comment fix inside your own repo → skip.
- Dependency version bump within semver-minor → skip CLARIFY but run `tech:classify-diff`.
- Answering a code-review question in-thread → skip (it's a comment, not new work).

Never skip for: new services, RFCs, any consensus-critical code change, any incident response, any production deploy.

# Technology review checklist

Paste into PR descriptions; check off as you review.

## Correctness
- [ ] Tests added or updated; they pass.
- [ ] Every external API used is verified against actual docs (not Claude-imagined).
- [ ] Dependency versions pinned; no `^latest`.
- [ ] Error paths handled explicitly — no swallowed exceptions.

## Claude-specific
- [ ] `git diff` reviewed line by line, not trusted from Claude's summary.
- [ ] No "helpful" unasked refactors in the diff.
- [ ] No placeholder comments (`// TODO: Claude fill in`).
- [ ] Hallucinated symbols (functions, methods, env vars) checked against source.

## Security
- [ ] No secrets in code, config, or tests.
- [ ] Input validation at trust boundaries.
- [ ] No `eval` / `exec` on untrusted input.
- [ ] Dependencies audited (`npm audit` / `pip-audit` clean).
- [ ] If touching crypto / auth / signing code: second reviewer from Security.

## Observability
- [ ] Logs don't leak PII or secrets.
- [ ] Errors logged with enough context to debug.
- [ ] Metrics / traces where the change is performance-sensitive.

## Docs
- [ ] `README.md` / relevant docs updated.
- [ ] Breaking changes called out in PR description.
- [ ] Public API changes noted.

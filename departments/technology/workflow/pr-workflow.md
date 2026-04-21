# Technology — PR workflow

BSVA Tech's code-change cycle. Extends `<repo>/workflow/01-the-cycle.md`.

---

## The sequence

```
1. CLARIFY (via clarify-questions.md → "Code change / PR")
2. CAPTURE → nest (own work in a service you own)
                → tension to Security (if crypto / auth / consensus path)
3. PLAN-MODE — files to change, tests to add, rollback plan
4. DISCUSS → APPROVE
5. SCAFFOLD — branch from baseline commit
6. EXECUTE with comments — commits map to nest tasks
7. REPORT — PR URL, test output, review link, deploy plan
8. CLOSE — merged + deployed + acceptance criteria met
```

## Branching

- Feature / fix branches from `main` (or the relevant release branch).
- Branch name includes the nest ID: `fix/N-1234-header-reorg` or `feat/N-1250-spv-verify`.
- Commits reference the nest in messages: `[N-1234] widen reorg window to 100 blocks`.

## Testing

The acceptance criteria in the nest should specify testing explicitly. Defaults for Tech:

- **Unit tests** — required for every logic change.
- **Integration tests** — required for anything crossing a service boundary.
- **Performance tests** — required if touching a perf-critical path (and the budget is in the AC).
- **Security tests** — for crypto / auth / consensus: property-based where possible, plus adversarial cases.

Skipping tests requires a named reason in the AC (e.g., "trivial docstring fix — no behavior change").

## Review

1. Draft PR → link the nest in the description.
2. Request review via tension if a specific role (Security, Standards) is needed.
3. Peer review — at least one Tech reviewer for any non-trivial PR.
4. For crypto / auth / consensus: **second reviewer from Security required**. This is a hard rule.
5. Address review as commits, not force-push (preserves review history).

## Merge

- Squash-and-merge is the default. Commit message includes the nest ID and AC summary.
- `main` is always green — if CI fails, fix before merging.
- Merges tagged with a version if they land in a release.

## Post-merge

- Comment on the nest: "PR #N merged at commit X, deployed to [env]."
- If deployment is separate (scheduled window), comment again on deploy.
- Close the nest once AC is fully met (including deploy if in scope).

## When to spawn more tensions during execution

Per the cycle: if you discover a blocker not in the plan, post a comment on the nest and create a linked tension. Examples:

- Discovered: the test framework has a race condition affecting this feature. → Tension to Tech (shared infrastructure).
- Discovered: a sibling service's API is undocumented. → Tension to the owning role.
- Discovered: your change has unexpected perf regression. → Pause, open a research nest, re-plan.

---

## Anti-patterns

- **Silent refactor**: Claude "cleans up" code that wasn't in scope. Reviewer rejects the PR and asks for a narrow diff.
- **Skipping tests**: "I'll add them in a follow-up PR." Don't. Tests live with the code that needs them.
- **Skipping Security review**: on anything crypto / auth / consensus. Hard rule.
- **Force-pushing during review**: loses review history. Use additional commits.
- **Merging with failing CI**: never, even "just to unblock me". Fix or revert.

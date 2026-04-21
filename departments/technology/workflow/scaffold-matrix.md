# Technology — scaffold matrix

| Artifact | Template | Skills | MCPs | Est. effort |
|---|---|---|---|---|
| Code change / PR | existing repo | `tech:review-pr`, `tech:classify-diff`, `verify-sdk-surface` (if SDK-adjacent) | GitHub, CI, registry | 30m–2 days |
| Research note | `templates/new-research-note/` | `tech:research-note` | BSV Academy, WhatsOnChain, observability (if any) | 4–16h |
| RFC / BRC | `templates/new-protocol-spec/` | `tech:new-rfc` | BSV Academy | 2–10 days |
| Incident | — (coordination in tension) | `tech:incident-draft`, `anonymizer` | observability, GitHub | hours to weeks |
| CI / deploy change | existing repo | `tech:classify-diff` | GitHub, CI | 1–8h |

## Project-specific CLAUDE.md additions for Tech projects

Always include:
- Language + runtime versions (pinned).
- Consensus invariants (if consensus-critical).
- External systems touched (queues, DBs, nodes, HSMs — though HSMs never go into Claude's context).
- Perf budgets (if applicable).
- Security-sensitivity flag (crypto / auth / consensus / none).

Example:

```markdown
# <service name> — CLAUDE.md

Read: ~/bsva-ai-structure/departments/technology/CLAUDE.md

## Project-specific

- Language: Go 1.22.
- Consensus-critical: YES — header-chain verification path.
- External: talks to internal reference-node (RPC; read-only from this service).
- Security-sensitive: YES — second reviewer from Security required on all PRs.
- Perf budget: header verification ≤ 2ms per block at p99.
```

# Technology — typical artifacts

| Rank | Artifact | Cadence | Default tier | Template | Top skills |
|---|---|---|---|---|---|
| 1 | Code change / PR | Daily | Internal | existing repo | `tech:review-pr`, `tech:classify-diff` |
| 2 | Research note / spike | Weekly | Internal | `templates/new-research-note/` | `tech:research-note` |
| 3 | RFC / BRC / ADR | Monthly | Internal → Public on publication | `templates/new-protocol-spec/` | `tech:new-rfc` |
| 4 | Incident comment / postmortem | As needed | Confidential → Restricted if customer/key impact | — | `tech:incident-draft` |
| 5 | CI / deployment work | Weekly | Internal | — | `tech:classify-diff` |

## Classification defaults

- **Internal** for code, designs, in-flight RFCs.
- **Confidential** for security reports before remediation, performance data involving customers, unreleased protocol features, analyses naming specific partner deployments.
- **Restricted** for: production signing keys, HSM configuration, production credentials, incidents with customer-key impact, litigation-related security material.

## What Tech never ships without review

- **Crypto / auth / consensus code** → second reviewer from Security required. Claude can help draft; cannot substitute for the review.
- **Dependency additions** → verify against registry (`tech:classify-diff`).
- **Production deploy plans** → CI + Tech Lead sign-off; Claude never triggers deploys.
- **Anything touching HSMs or production signing** → out of Claude's scope entirely.

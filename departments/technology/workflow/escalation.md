# Technology — escalation and hard-refusal lines

---

## Hard refusals (Mode A)

- **Production signing**, period. Testnet only if explicitly scoped; never mainnet from a Claude session.
- **HSM configuration**, policies, or any credential touching HSMs.
- **Raw customer data** in prompts (require redaction or synthetic fixtures).
- **Production logs pasted without redaction** (IPs, user IDs, session tokens, auth headers).
- **Vault / IAM / service-account JSON** paste-in.
- **`curl | sh` or unverified install scripts** suggested.
- **Dependency additions without registry verification** (fights hallucination, prevents supply-chain drift).

## Confirm-then-continue (Mode B)

- Deploy plans — confirm environment and rollback before proceeding.
- Dependency upgrades spanning major versions — confirm compat strategy.
- Crypto / consensus changes — confirm Security review is scheduled.
- Redaction of logs that might contain customer identifiers — confirm before summarizing.

## Proceed with note (Mode C)

- Routine development in a non-sensitive service.
- Public on-chain data analysis.
- Reading BRCs / specs / Academy concepts.

---

## Escalation map

| Situation | Route to | Priority |
|---|---|---|
| Suspected vulnerability / CVE impact | Security + Tech Lead | Immediately; Restricted if severe |
| Production incident | On-call + Tech Lead + Security (if sensitive) | Immediately |
| Architectural decisions spanning services | Tech Lead + Standards circle | Before coding |
| Dependency with unclear license | Legal Lead | Before merge |
| Customer-data exposure | Tech Lead + Security + Legal + Exec | Immediately; Restricted |
| Key / signing exposure | Security + Tech Lead + Exec | Immediately; Restricted; ceremony-based rotation |
| Deploy coordination / capacity | Ops Lead + Tech Lead | Before deploy |

## Triggers for escalation without question

1. A PR touches crypto / auth / consensus and has no Security reviewer assigned.
2. A log paste contains unredacted customer identifiers.
3. A dependency appears that isn't in the registry or has an unexpected publisher.
4. A suspected key-material exposure (anywhere — Slack, GitHub, chat, Claude session).
5. An incident's initial classification is "Confidential" but on inspection involves customer-key material → must up-classify to Restricted and narrow comms.

## The meta-rule

**Tech at BSVA ships software that may operate at consensus-critical depth. The cost of a wrong action is large. When the path is unclear, stop and escalate. The two minutes to get a second opinion always beats the week to recover from a mistake.**

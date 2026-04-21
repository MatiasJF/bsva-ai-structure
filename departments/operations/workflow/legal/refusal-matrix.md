# Legal — refusal matrix

What Claude refuses in Legal sessions, with escalation paths.

| Content | Response | Escalation |
|---|---|---|
| Signed contract language | Refuse. | "Work offline." |
| Draft contract language for a specific matter | Refuse. | "Work offline with counterparty-specific drafting." |
| Privileged correspondence | Refuse. | "Privilege concerns — Legal Lead only." |
| Litigation material (pleadings, discovery, settlement) | Refuse. | "Outside Claude scope; Legal Lead + external counsel." |
| Regulatory filings in progress | Refuse. | "Confidentiality and privilege concerns; Legal Lead." |
| NDA-covered content from a specific counterparty | Refuse. | "NDA obligations; Legal Lead." |
| HR / personnel / compensation | Refuse. | HR Lead + Legal Lead. |
| Board resolutions / board-instructed work | Refuse. | Exec + Legal Lead. |
| M&A / due-diligence / term sheets | Refuse. | Exec + Legal Lead. |
| Named BSVA counterparty + commercial terms | Refuse. | Legal Lead. |
| Generic template drafting | **Proceed** per `template-starter-playbook.md`. | — |
| Public-law / public-regulation research | **Proceed** per `public-research-only.md`. | — |
| Jurisdictional comparison (public sources) | **Proceed**. | — |
| Abstract clause-structure questions (no BSVA specifics) | **Proceed**, with "no legal advice" note. | — |

## How Claude refuses

Per `guides/for-claude/refusal-and-escalation.md` Mode A:

> ⚠ I can't proceed with this.
>
> This looks like BSVA-specific matter. Claude is used in Legal only for public research and generic templates; BSVA-specific content belongs offline.
>
> What to do next:
> - Work offline with your usual legal tools and review.
> - If this was an accidental paste: see `security/incident-response.md`. Privilege concerns may need Legal Lead immediately.

## How Claude proceeds safely

When the content is in scope (public research / generic template):
- Confirms tier with user before starting (usually: session Restricted; output Internal).
- Cites public sources.
- Adds BSVA disclaimer.
- Closes session explicitly after task (`/clear`).

## Incident triggers

Escalate immediately if:
- Specific BSVA-matter content was pasted before you caught it.
- Privileged material was pasted.
- A counterparty-specific amount or term appeared.

Don't delete-and-hope. Report to Legal Lead + Security + DevRel. Privilege waiver is handled by legal expertise, not by silence.

# DevRel — escalation and hard-refusal lines

Claude's refusal lines specific to DevRel + the escalation map.

---

## Hard refusals (Mode A — no questions asked)

Claude refuses and escalates immediately on any of these:

- Real **private keys, seed phrases, funded mainnet keys, or shared testnet keys** (even "just for the demo").
- **Unannounced SDK features / partnerships / release dates** being written into public-targeted content.
- Making **commitments on BSVA's behalf** in public channels (sponsorships, speaking slots, prize amounts).
- **Price / market / speculative language** about BSV — redirect to BSV Blockchain capabilities.
- **Deepfakes or fabricated quotes** attributed to real people.

## Confirm-then-continue (Mode B)

Claude asks the user to confirm tier / classification before proceeding on:

- Content referencing partner names before a joint announcement is public.
- Sample code that intentionally includes a testnet key — require explicit confirmation the key is fresh and not reused.
- Dev-support replies that might include user-shared code — verify it's sanitized before echoing.

## Proceed with note (Mode C)

For routine DevRel work (published specs, own drafts, public on-chain data), Claude proceeds and adds a brief classification note at the end of the output.

---

## Escalation owners (Nestr roles)

| Situation | Route to | Priority |
|---|---|---|
| DevRel content-strategy decisions | DevRel Lead | Always |
| SDK correctness / bug / interface questions | sdk-maintainer (Tech) | Always |
| Partner-adjacent content (naming, clearance) | Biz-Dev Lead | Before publish |
| Legal / license questions on open-source | Legal Lead | Before merge |
| Budget / sponsorship commitments | Ops Lead + Biz-Dev Lead + (Exec for >$X) | Before commit |
| Brand voice / PR sensitive | Marketing Lead | Before publish |
| Security incident in a DevRel artifact (leak, key exposure) | DevRel Lead + Security + Legal (if legal exposure) | Immediately |

---

## DevRel-specific escalation triggers

Escalate without waiting for a sense check if you notice:

1. A published example has a hardcoded mainnet key. (Rotate + redact + incident response.)
2. An external developer shares a real user's data in a support thread. (Redact; don't echo; request a sanitized repro.)
3. A published post names an unannounced partner. (Emergency takedown + Biz-Dev + Exec loop.)
4. A workshop's repo was made public before classify-before-publish ran. (Audit the content; make private until the gate runs.)
5. A dev-support reply claims SDK behavior that isn't in the actual installed package. (Retract / correct; update the reply; add a `verify-sdk-surface` step to your workflow if you didn't.)

---

## How to escalate

**Preferred:** create a Nestr tension in the relevant circle, tagged appropriately. For incidents, mark Confidential.

**Urgent (same-hour):** direct message to the named role filler + log a tension immediately after. Don't skip the logging step.

---

## Silent-handoff anti-patterns

- Claude writes content referencing an unannounced partner, then the user publishes without a publish-gate run. → Escalation, not a silent takedown.
- Support thread answer posted without verifying SDK behavior. → Escalate + update the thread.
- A "quick" dev-support response turns into a 40-message thread in Discord. → Should be a tension to Tech by message 3.

---

## The meta-rule

**DevRel's content reaches the most external developers of any department. When in doubt, escalate — the cost of one delayed publish is small; the cost of a reputational misstep is significant.**

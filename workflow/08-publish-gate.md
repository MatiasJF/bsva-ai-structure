# 08 — The publish gate

Internal → Public is the highest-consequence transition at BSVA. It's also the most common tier flip (blog posts, lessons, announcements). This file defines the gate.

---

## What "publish" means here

Any action that takes content from **Internal** (inside BSVA) to **Public** (visible to anyone):

- Pushing a branch's merge to a public repo's `main`.
- Hitting publish on a blog post / Academy lesson / one-pager.
- Posting to an external social channel.
- Sending a press release.
- Uploading a talk recording.
- Anything that creates a URL someone outside BSVA can visit.

---

## The gate: five checks before publish

Every publish, without exception, requires all five:

1. **Accuracy** — Every factual claim is verified against a primary source. Technical claims cite BRC / BIP / spec. Product claims cite the published repo / docs. BSVA-operational claims cite the Nestr tension or memo.
2. **Voice** — Content passes `brand-voice.md`: no hype, no price talk, no banned phrases, BSV Blockchain capitalized. Use the `external-comm-check` skill.
3. **Classification flip** — The Nestr nest's `classification/internal` label is replaced with `classification/public`. The change is recorded in a comment: "Flipping to Public per publish on [URL] [date]."
4. **Attribution / safety** — No unannounced partners named. No draft contract content. No identifiable learner / customer data. No unverified quotes.
5. **Owner approval** — The person accountable for the content (department lead or their delegate) has said "go". Not implied, not inferred — explicit.

---

## Who approves what

| Artifact | Approver |
|---|---|
| DevRel blog post | DevRel Lead or delegate |
| Published BSV Academy lesson | Education Lead |
| Technical release notes / tags | Tech Lead |
| Marketing campaign piece | Marketing Lead |
| Press release | Marketing Lead + affected dept lead |
| Joint partner announcement | Biz-Dev Lead + Marketing Lead + partner sign-off |
| Executive public statement | Exec |
| Open-source release of BSVA-authored code | DevRel Lead + Tech Lead |

When in doubt, escalate higher, not lower.

---

## The sequence (operational)

```
1. Author self-checks against the 5-check gate.
2. Author requests approval via comment on the Nestr nest.
   ("@DevRel Lead — ready for publish gate review; see description
    for CLARIFY answers and acceptance criteria. Three outstanding:
    [link], [link], [link].")
3. Approver reviews. Possible outcomes:
   - Approved → approver comments "go".
   - Changes requested → author addresses, re-requests.
   - Blocked (classification concern, fact error, legal) → escalate.
4. On approval:
   - Publish the artifact (push PR, hit publish, etc.).
   - Post a comment on the Nestr nest with the live URL / publish date.
   - Flip the classification label.
   - Set project.status: Done, completed: true.
```

---

## The Claude skill

`global:classify-before-publish` runs the 5-check gate and produces a review report:

- What it passed.
- What it failed with specific references.
- Suggested fixes for each failure.
- A readiness score (ready / partial / not ready).

Claude cannot approve a publish on its own — that's explicitly a human role. But it can refuse to proceed when the gate fails.

---

## What Claude does if asked to "just publish it"

If the user says "publish this" and any check fails, Claude:

1. Runs the gate.
2. Returns the failure list with specifics.
3. Offers to fix what it can (e.g., brand-voice adjustments).
4. **Does not proceed** until the approver's "go" lands on the nest.

If the user insists, Claude says:

> "I can't publish this on my own — publishing requires the accountable role's explicit approval on the nest. Here's what I'd send them, pre-cleaned. Paste this into Nestr or into Slack; I'll proceed when their approval comes through."

---

## Timing and holds

- **Business hours.** Publish gate happens during business hours when the approver can react. Don't rush Saturday-night publishes unless there's a genuine urgency (incident response, time-sensitive PR).
- **Embargo periods.** If the content is embargoed (partner announcement, conference keynote), the approved gate plus the embargo time controls publish. Claude must respect both.
- **Legal holds.** If Legal has placed a hold on the content (they will communicate via tension), publish is blocked until the hold lifts. This is above and beyond the normal gate.

---

## Post-publish

After publish:

1. **Post the live URL as a comment** on the Nestr nest.
2. **Flip the classification label** to `classification/public`.
3. **Close the nest** (`project.status: Done`, `completed: true`).
4. **Promote learnings** — if something generalizable came out of the work, follow `09-retro-and-skills.md` to propose a new or updated skill.

---

## Rollback

If something goes wrong after publish (factual error caught, unauthorized partner naming, legal issue):

1. **Open a new Nestr tension**, tagged `incident/post-publish`, Confidential by default.
2. **Decide the response** with the accountable owner: correction, retraction, takedown.
3. **Act on the response**, documenting every step as comments on the tension.
4. **Blameless review** as in `security/incident-response.md`.
5. **Guidance PR** to close the loop: add a new gate check, a new brand-voice rule, or a new CLARIFY question so next time catches it.

---

## The principle

**The gate is a two-party system: the author and the approver.** Claude runs the checks, the author fixes, the approver approves. No single party can publish on BSVA's behalf. This keeps trust with external audiences and keeps accountability clear internally.

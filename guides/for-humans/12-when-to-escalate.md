# 12 — When to escalate

Some things are not yours to decide. This guide says which ones.

---

## The short version

**Escalate when the question involves:**
1. Money + a counterparty outside BSVA
2. Legal obligations or compliance
3. HR / people
4. Security incidents or suspected leaks
5. Public statements on behalf of BSVA
6. Anything you're tempted to paste but the pre-flight says no

---

## Who to escalate to

Find your escalation owner in your department's `CLAUDE.md`. Defaults:

| Topic | Escalation role (Nestr) |
|---|---|
| Claude Code / tooling questions | DevRel Lead |
| Security / leak / incident | Security + DevRel Lead |
| Legal, contracts, NDAs | Legal Lead |
| HR / people | HR Lead |
| Partner communications / deals | Biz-Dev Lead |
| Public statements | Marketing Lead + department lead |
| Financial / board-related | Finance Lead + Exec |

---

## How to escalate

**Via Nestr tension** (preferred — creates durable context):

1. Open Nestr → your circle → create tension.
2. Title it plainly: "Claude: [one-line question]".
3. Tag the relevant lead role.
4. Include: what you want to do, what's blocking you, what you've tried.

**Via Slack / direct message**: only for urgent time-sensitive things (ongoing leak, active incident).

---

## What counts as escalation-worthy — concrete examples

### You should escalate

- "I want to draft a partnership proposal with `[PARTNER]` in Claude. The terms aren't announced yet. OK?"
- "I pasted a snippet from a contract. I'm not sure if it was privileged. What do I do?"
- "A colleague asked me to summarize a board memo using Claude. The memo is marked confidential. Can I?"
- "I want to create a skill that pulls HR data from our HRIS. Is that OK?"
- "I want to publish a blog post Claude helped draft. Who approves before it goes live?"

### You don't need to escalate

- "How do I use the `bsva-docx` skill?"
- "Can Claude help me refactor my own workshop code?"
- "How do I set up the Nestr MCP?"
- "What's the right prompt pattern for long-form editing?"

---

## When the answer is "wait"

Some escalations come back as "don't do that right now". That's a valid outcome. You're not being blocked — you're being given the correct scope.

If an escalation sits without response for more than 48 hours on a non-urgent question, ping again. If urgent, call / in-person.

---

## Documenting the outcome

When an escalation resolves, **write the decision into the relevant `CLAUDE.md` or guide** (via PR). That way the next person doesn't have to ask the same question.

This is how BSVA's Claude guidance gets smarter over time: **every escalation is a PR waiting to be written.**

---

## Next

→ `13-prompting-patterns.md`

# 05 — Treating Claude seriously

Read this before your first real work session. It is short and the most important guide in this series.

---

## The frame

Claude is a **capable assistant with real authority**. At BSVA, it can:

- Read files on your machine (within permissions you grant)
- Execute shell commands
- Edit your code
- Send data to external services you configure
- Publish content on your behalf (if you let it)

Everything Claude does, **you did**. Your name is on the PR. Your reputation is on the doc. Your NDA covers the thing you pasted.

This is not a toy. It is closer to a junior colleague with a very fast typing speed, no common sense about classification, and no social accountability. **Your judgment fills the gap.**

---

## What Claude cannot do (and why that matters)

A short list of things Claude **cannot** do, so you can spot when someone claims otherwise:

1. **Read folders outside your granted permissions.** Even if Claude is running on your machine, it cannot browse random parts of your disk. It sees what you show it.
2. **Remember past conversations unless someone persisted them.** Memory is file-based. If you didn't save it, it's gone. If you did save it, it's in your `~/.claude/` — a plain file, reviewable, deletable.
3. **Access the internet by default.** It needs the `WebFetch` / `WebSearch` tool, and you can revoke those permissions.
4. **Act on shared systems without you.** It cannot send a Slack message, publish a PR, or run a deploy unless you've wired it up and approved the action.
5. **Decide classification.** It does not know what your contract with Partner X says. You do.

These limits are features. They let Claude be powerful without becoming uncontainable.

---

## What you are accountable for

- **Classification.** Before you paste, you decide the tier. See `07-BEFORE-YOU-PASTE.md`.
- **Review.** Before you commit / publish / send, you read it. "Claude wrote it" is not an excuse in a PR review.
- **Permissions.** You choose what Claude can read and run. Lock it down; open up only what you need.
- **Incident response.** If you pasted something you shouldn't have, you are the first responder. See `security/incident-response.md`.

---

## BSVA's governance rules for Claude

1. **No Restricted content into any Claude session, ever.** (Private keys, contracts, HR, board.) This is non-negotiable.
2. **No Confidential content into web-based Claude.** Desktop or CLI only, with MCPs and file access scoped.
3. **No MCP credentials in a shared / committed file.** `~/.claude/settings.json` is personal; department `CLAUDE.md` files are committed, but never contain keys.
4. **Every department has an escalation owner** — a Nestr role you can ping when you're unsure. See your department's `CLAUDE.md`.
5. **Every PR that modifies this repo requires code-owner review.** You cannot self-merge guidance changes that affect others.

---

## When Claude is wrong

- **Confidently wrong** is a known failure mode. Verify facts, citations, function names, URLs, command flags.
- **Silently stale** is another. A skill or MCP installed 3 months ago may reference a tool that's been renamed.
- **Overconfident refactors**: if Claude "cleans up" code you didn't ask it to, reject the PR and ask for a narrower diff.

---

## The 30-second daily sanity check

Before you hit "run" on something Claude produced, ask yourself:

1. Did I read the whole output?
2. If this is wrong / leaks / misfires — **what's the blast radius**? Can I undo?
3. Is this something I should commit, or run in a sandbox first?

If blast radius is big and undo is hard: **slow down, don't speed up.**

---

## Next

→ `06-what-claude-cannot-do.md` for the full limits reference.

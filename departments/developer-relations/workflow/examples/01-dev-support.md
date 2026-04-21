# Example 1 — Dev-support reply

A dev-support thread, start to close. Shows how even a small task follows the cycle.

---

**DESIRE.** User in Discord #dev-help:
> "Hey, when I do `new Transaction().addInput(...)` with a UTXO from the faucet, `toHex()` returns with `00000000` for the input's prev script length. What am I doing wrong?"

**CLARIFY.** I invoke `draft-dev-support-reply`:

> Before I reply, let me ground this.
> - Sanitized repro or real code? (Need to see 5–10 lines to diagnose.)
> - SDK version?
> - Testnet or mainnet?
> - Should I reply inline in Discord, or escalate as a GitHub issue?
> - Likely: SDK bug (→ tension to Tech), docs gap (→ my nest), or user error (→ reply only)?

User posts a sanitized snippet: it's `@bsv/sdk v1.9.2`, testnet, they forgot to set `unlockingScriptTemplate`. Classic user error.

**CAPTURE.** `tension-or-nest`: own work under DevRel, no cross-role needed → **nest**.

```
nestr_create_nest({
  parentId: "<devrel-role-id>",
  title: "SDK UTXO-input helpfulness answered (Discord 2026-04-21)",
  labels: ["project", "dev-support", "sdk/1.9", "triage"],
  fields: { "project.status": "Current" },
  users: ["<my-user-id>"],
  description: `
    <h3>What</h3>
    <p>Answered dev-support question about why Transaction.toHex() produces empty script length for UTXO inputs in @bsv/sdk v1.9.2.</p>
    <h3>Why</h3>
    <p>User blocked; public reply surfaces a common mistake.</p>
    <h3>Who for</h3>
    <p>SDK-new developer on testnet.</p>
    <h3>Classification</h3>
    <p>Internal; public (as thread reply).</p>
    <h3>Acceptance criteria</h3>
    <ul>
      <li>Reply posted to thread with diagnosis + fix snippet.</li>
      <li>Snippet verified against installed @bsv/sdk v1.9.2 via verify-sdk-surface.</li>
      <li>If pattern recurs (>3 similar threads this quarter), open a docs-gap tension.</li>
    </ul>
  `
})
```

Nest ID: `N-9102`.

**PLAN-MODE.** Skipped — trivial reply, not a scaffold task. CLARIFY answers cover it.

**EXECUTE.** I draft the reply:

> "Nice repro. This is a common one — when you construct a `Transaction` input, you need to set `unlockingScriptTemplate` (not just `sourceTXID` + `sourceOutputIndex`). Otherwise `toHex()` will serialize with an empty unlocking script. Try this:
>
> ```ts
> tx.addInput({
>   sourceTransaction: sourceTx,
>   sourceOutputIndex: 0,
>   unlockingScriptTemplate: new P2PKH().unlock(privKey),
> });
> ```
>
> Docs: [link to Academy concept on input signing]. Let me know if that unblocks you."

I run `verify-sdk-surface` on the snippet — all methods exist in v1.9.2. ✓

**REPORT.** Post to Discord, then comment on the nest:
> "Replied: [Discord URL]. User marked resolved. Tagged as a 'input signing' type question — 4th this quarter, close to threshold for a docs-gap tension. Will open one at 5."

**CLOSE.** Set `project.status: Done`, `completed: true`. Add final comment:
> "Closed. No SDK bug — user error. Monitoring the pattern."

Total cycle time: 12 minutes.

---

## What this example shows

- Even trivial work goes through the cycle — but plan-mode is skipped for clearly-scoped small tasks.
- `verify-sdk-surface` runs on every SDK snippet, no exceptions.
- Tracking patterns in comments lets us spot when to spawn a follow-up tension (docs-gap).
- The nest becomes a searchable record: next quarter, someone reviewing support load can query `label:dev-support in:<devrel-role-id>` and see the pattern.

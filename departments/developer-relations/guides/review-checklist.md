# DevRel review checklist

Use this before PRing any DevRel artifact. Paste it into the PR description and check off as you go.

---

## ✓ Correctness

- [ ] Code runs from a fresh clone: `git clone ... && cd ... && npm install && npm start`.
- [ ] No import errors, no undefined symbols, no TypeScript errors in strict mode.
- [ ] All SDK methods used exist in the version specified in `package.json`.
- [ ] All on-chain data referenced (txids, addresses, block hashes) is **real public data** verifiable on WhatsOnChain.
- [ ] Any test vectors used are standard, documented test vectors — not Claude-generated.

## ✓ Claude-specific sanity

- [ ] I ran `git diff` before committing. I did not take Claude's "here's what I did" summary on faith.
- [ ] I verified every function call Claude wrote actually exists in the library.
- [ ] I verified every URL / link Claude produced by visiting it.
- [ ] No placeholder strings like `// TODO: replace this`, `// Claude: implement this`, or `[YOUR_KEY_HERE]`.

## ✓ Security

- [ ] No API keys, private keys, or credentials in code or docs.
- [ ] No testnet private keys that other tutorials might use. (Generate fresh; burn after use.)
- [ ] No internal BSVA URLs or infrastructure references.
- [ ] No real user data in examples, tests, or fixtures.
- [ ] No Confidential / Restricted content in any committed file.

## ✓ Brand

- [ ] "BSV Blockchain" (capitalized, two words) on first mention.
- [ ] No price talk, no HODL, no "revolutionary", no hype.
- [ ] Tone: precise, calm, grown-up. No exclamation points in tutorial prose unless genuinely warranted.
- [ ] Consistent with `guides/for-claude/brand-voice.md`.

## ✓ Pedagogy

- [ ] Objectives stated at the top (what the reader will know by the end).
- [ ] Prerequisites stated (tools, prior knowledge).
- [ ] Minimal abstraction — no helper functions just for "cleanliness" at the expense of clarity.
- [ ] Examples build incrementally; each step is runnable.
- [ ] Common pitfalls are called out explicitly.

## ✓ Discoverability

- [ ] `README.md` present with overview, run instructions, links to related content.
- [ ] Metadata tags / frontmatter where relevant (for blog / course mgmt).
- [ ] Links to the relevant BRC / BIP / spec.

## ✓ Maintenance

- [ ] No dependencies pinned to `latest` — pin to specific versions for stability.
- [ ] No devDependencies that won't be available in common CI.
- [ ] `package.json` has an author and description.
- [ ] No committed `node_modules/`, `dist/`, or `.env` files.

---

## When to override

Some of the above is overkill for a 3-line utility. Use judgment. But for anything going to external developers: every box checked.

---

## After merge

- [ ] Update related content (SDK docs, workshop catalog, blog index).
- [ ] Announce in Nestr #devrel circle.
- [ ] If the piece generated a reusable skill: promote it per `guides/visuals/03-skill-lifecycle.md`.

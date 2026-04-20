# Developer Relations — CLAUDE.md

This file extends the base `~/.claude/CLAUDE.md`. It does not replace it. Security rules in the base are floors; this file may tighten, never loosen.

---

## Who we are

Developer Relations (DevRel) at BSVA supports developers building on the BSV Blockchain. We write example code, run workshops, publish tutorials, maintain SDK documentation, answer developer questions, and generally make the experience of building on BSV excellent.

We are the primary authors and maintainers of this `bsva-ai-structure` repo.

---

## Default classification

**Internal.** Most DevRel work lives here: drafts, outlines, workshop prep, review notes. Published content (blog posts, docs, examples) is Public **after** the publish button is pressed — not before.

---

## Who you are helping (when a DevRel person is at the keyboard)

A technical communicator. They write code; they also write prose. Claude should support both. They often think in terms of:

- **Audience**: building SDK users, BSV-curious developers, enterprise architects, students.
- **Artifact types**: code examples, READMEs, tutorials, workshops, conference talks, SDK documentation.
- **Tools**: TypeScript, the BSV TS SDK (`@bsv/sdk`), Node.js, sometimes Python / Go / Java mirrors.

---

## How to behave in DevRel work

1. **Code must run.** Don't invent function names, import paths, or SDK methods. If unsure, check `node_modules` or the `@bsv/sdk` source. When in doubt, ask.
2. **Code must follow BSVA conventions.** Small, focused examples. Clear variable names. Minimal abstractions. No "clever" one-liners in teaching material.
3. **Prose must follow BSVA voice.** See `guides/for-claude/brand-voice.md`.
4. **Workshops must be reproducible.** If an example won't run on a fresh clone with `npm install && npm start`, the example is broken.
5. **Examples must use public data.** Public addresses, public txids, test vectors. Never real user data.

---

## Tools DevRel uses with Claude

- **BSV Academy MCP** — pull concepts for tutorials.
- **WhatsOnChain MCP** — fetch real on-chain examples to reference.
- **simple-mcp** — scaffold generators for example projects.
- **Nestr MCP** — manage tensions for content production workflows.
- **bsva-docx / pptx / onepager skills** — for any BSVA-branded artifact.

If an example needs a specific SDK behavior, Claude should prefer reading the actual SDK source over guessing.

---

## Escalation owner for DevRel questions

- DevRel Lead — Nestr role: `DevRel Lead`.
- For Claude-structure questions: same.
- For security incidents in DevRel projects: DevRel Lead + Security.

---

## DevRel-specific don'ts

- **Don't publish examples with hardcoded test keys.** Even testnet keys get posted, indexed, and then used for phishing demos. Use dedicated test-vectors documented in the SDK.
- **Don't publish material referencing unannounced SDK features.** Coordinate with the SDK maintainers via Nestr.
- **Don't paste users' real code into Claude sessions** (when helping answer dev support questions). Describe the problem abstractly or ask for a sanitized minimal reproduction.

---

## Templates we maintain

See `templates/`:

- `new-sdk-example/` — a minimal `@bsv/sdk` example project.
- `new-workshop/` — a workshop repo with lessons, starter code, and solutions.
- `new-blog-post/` — a Markdown post with BSVA frontmatter + structure.

Use them. Propose improvements via PR.

---

## Skills we own

See `skills/` (populated as DevRel adds department skills — initial repo starts with the global set only).

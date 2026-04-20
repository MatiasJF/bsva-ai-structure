# 03 — Claude Code Desktop — efficiency

For non-engineers (education, biz-dev, marketing, legal, exec) and for engineers who want the visual experience.

---

## Setup essentials

- **Projects** — one per real project (not per conversation). Right sidebar → `+ New project`. A project = a folder Claude can read + a system prompt + scoped MCPs.
- **System prompt** — paste your department's `CLAUDE.md` here. This is what makes Claude "speak BSVA" in that project.
- **Workspace** — keep one window per project. Conversations within a project share the system prompt and file context.

---

## The 80/20 of daily use

1. **Drag files into the chat** to give Claude context. It can read PDFs, DOCX, PPTX, images, CSVs.
2. **Use `/` to trigger skills.** Typing `/bsva-docx` at the prompt invokes the Word-template skill. Your global BSVA skills are available here.
3. **Use MCPs.** If Nestr is configured, ask Claude to "list my open tensions" — it will.
4. **Use "projects" for durable context.** Don't re-paste the same background doc every session.
5. **Use "attach" instead of copy-paste for long content.** Attachment content is often handled more predictably than huge pastes.

---

## Keyboard shortcuts (Desktop)

| Shortcut (Mac / Win) | What it does |
|---|---|
| `⌘K / Ctrl+K` | Command palette |
| `⌘N / Ctrl+N` | New chat in current project |
| `⌘⇧N / Ctrl+Shift+N` | New project |
| `⌘/ / Ctrl+/` | Toggle model picker |
| `⌘↑ / Ctrl+↑` | Jump to top of conversation |
| `⌘K then model name` | Fast model switch |

---

## Efficient prompting patterns

### Pattern: "Draft, then refine"
Instead of: "Write me a perfect one-pager about X." →
Do: "Draft a rough one-pager about X in plain Markdown. Don't worry about format. Use headings: What, Why, For whom, How." Then refine in a second message: "Good. Now rewrite section 'Why' more concretely with two examples."

### Pattern: "Critic mode"
After any draft: "Now read that back as a skeptical reviewer at [our audience]. What's weak?"

### Pattern: "Transform, don't generate"
Claude is best at transforming content you already have (notes → summary, bullets → prose, MD → docx). Bring raw material; let Claude reshape.

### Pattern: "Attach, reference, don't paste"
For long documents, attach the file and reference it ("use section 2 of the attached brief"). Avoids truncation.

---

## When to use the CLI instead

Switch to the CLI when you need:

- Custom hooks / automations that fire on every session
- Recurring scheduled tasks (`/loop`, `/schedule`)
- Multi-agent workflows (subagents)
- Full-repo analysis (the Desktop app sees fewer files at once)

Ask DevRel if you're unsure whether a task needs the CLI.

---

## The big trap to avoid

**Do not paste entire internal documents into the chat just to have a conversation.** Attach the file, classify it first, redact if needed. See `07-BEFORE-YOU-PASTE.md`.

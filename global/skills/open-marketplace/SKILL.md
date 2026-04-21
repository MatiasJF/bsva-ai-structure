---
name: open-marketplace
description: Opens BSVA's skill / MCP / template marketplace in the user's browser. Invoke when the user asks to "see / open / browse the marketplace / catalog / skills list / what skills are available / what templates exist / what MCPs are configured". Runs the bundled launcher with the marketplace argument, which scans the repo for all installable bits and serves a searchable, filterable viewer at http://localhost:8765/marketplace/.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# open-marketplace

## When Claude should invoke this

- "Show me the marketplace / catalog / skills browser."
- "What skills are available?" / "What templates exist?" / "What MCPs do we have?"
- "Browse the BSVA skills."
- "Can I see everything in the repo?"
- "What's installed?"

## Behavior

Claude runs the BSVA launcher in marketplace mode:

```bash
bash ~/bsva-ai-structure/tutorial/start.sh marketplace
```

If the user's checkout is elsewhere, locate it via `ls ~/bsva-ai-structure` first or ask the user for the path.

The launcher:
1. Runs `marketplace/generate_index.py` to scan the repo (skills / MCPs / templates / workflow docs / guides) and produce `marketplace/data.json`.
2. Starts a local HTTP server on port 8765.
3. Opens `http://localhost:8765/marketplace/index.html` in the default browser.

Ctrl+C stops the server.

## Output

After launching, Claude should tell the user:

- The URL (in case auto-open didn't work).
- That `/` focuses the search; `Esc` closes the detail drawer.
- That the index is regenerated each launch — if they've just added or edited a skill, reopening will reflect it.
- They can jump to the tutorial from the marketplace's topbar "Tour" button.

## Hard rules

- Do NOT try to list or render catalog entries inline — it's a browser app.
- If the user asks for a summary without opening the browser, instead read `marketplace/data.json` (via Read tool) and summarize; do not spawn the launcher for a summary-only request.
- If the scanner fails (e.g., a malformed SKILL.md frontmatter), surface the error; don't hide it.

## Cross-reference

- `marketplace/` — the viewer + scanner.
- `marketplace/generate_index.py` — the scanner that produces `data.json`.
- `tutorial/start.sh marketplace` — the launcher entry point.

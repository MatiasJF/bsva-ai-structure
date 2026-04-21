---
name: open-tutorial
description: Opens BSVA's interactive guided tour in the user's browser. Invoke when the user asks to "see / open / show / launch the tutorial / tour / onboarding / guided walkthrough / welcome guide". Runs the bundled launcher, which starts a local HTTP server and opens http://localhost:8765/tutorial/ — a 10-minute visual walkthrough of the BSVA AI structure.
classification: Internal
owner: "@bsva/devrel"
version: 1.0.0
---

# open-tutorial

## When Claude should invoke this

- "Open / show / launch / start the tutorial."
- "Walk me through BSVA's AI structure."
- "How do I use this?" (when the user is clearly new to the repo).
- "Show me the onboarding / tour / welcome."

## Behavior

Claude runs the BSVA tour launcher via the Bash tool:

```bash
bash ~/bsva-ai-structure/tutorial/start.sh
```

If the user's checkout is elsewhere, locate it via `ls ~/bsva-ai-structure` first or ask the user for the path.

The launcher:
1. Scans the repo for skills/MCPs/templates to refresh the marketplace index.
2. Starts a local HTTP server (Python's `http.server`) on port 8765.
3. Opens `http://localhost:8765/tutorial/index.html` in the default browser.

Ctrl+C in the terminal stops the server.

## Output

After launching, Claude should tell the user:

- The URL (in case auto-open didn't work).
- The keyboard tip: ←/→ to navigate sections.
- That progress is saved in the browser's localStorage.
- That they can open the marketplace next with `bash ~/bsva-ai-structure/tutorial/start.sh marketplace`.

## Hard rules

- Do NOT try to "render" the tutorial inline — it's an HTML app, browser only.
- Do NOT attempt to modify tutorial files in response to this request.
- If Python is missing, surface the installer's error message — don't silently fail.

## Cross-reference

- `tutorial/` — the tour source.
- `tutorial/start.sh` / `start.ps1` — the launchers.

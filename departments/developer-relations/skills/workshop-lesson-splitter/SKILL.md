---
name: workshop-lesson-splitter
description: Turns a workshop outline into ordered lesson branches with starter/solution diffs, each building on the previous. Invoke when designing a workshop. Produces the repo structure (lessons/01-.../starter, /solution) and the branch strategy.
classification: Internal
owner: "@bsva/devrel"
version: 0.1.0
---

# workshop-lesson-splitter

Turns a workshop outline into executable lesson branches.

## Behavior
1. Takes outline bullets + target duration.
2. Proposes lesson count and per-lesson timing (≤ 20 min each for live workshops).
3. For each lesson: starter code + solution code + README with objective + CfU.
4. Checks dependency chain (lesson N depends on lesson N-1 outcomes).
5. Produces branch-naming scheme.

## Hard rules
- Solutions checked in (students reference when stuck).
- Each lesson runnable standalone from its starter (`npm i && npm start`).
- No shared credentials / funded keys across lessons.

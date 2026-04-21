#!/usr/bin/env python3
"""
Merges BSVA's SessionStart hook into the user's ~/.claude/settings.json.

- Reads the source template (~/.claude/settings.bsva-template.json; the
  installer wrote it with {{REPO_DIR}} already substituted).
- Creates a timestamped backup of the existing settings.json.
- Adds the BSVA SessionStart hook (identified by the marker BSVA_WELCOME_HOOK)
  without removing any existing hooks or other keys.
- Idempotent: re-running replaces the BSVA hook in place, never duplicates it.

Usage:
  python3 tutorial/install-hooks.py             # merge
  python3 tutorial/install-hooks.py --remove    # remove the BSVA hook
  python3 tutorial/install-hooks.py --dry-run   # show what would change

Exit codes: 0 ok, 1 error, 2 nothing to do.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from datetime import datetime
from pathlib import Path

HOME = Path.home()
CLAUDE_DIR = HOME / ".claude"
SETTINGS_PATH = CLAUDE_DIR / "settings.json"
TEMPLATE_PATH = CLAUDE_DIR / "settings.bsva-template.json"

MARKER = "BSVA_WELCOME_HOOK"


def load_json(path: Path) -> dict:
    if not path.exists():
        return {}
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        print(f"error: {path} isn't valid JSON: {e}", file=sys.stderr)
        sys.exit(1)


def bsva_hook_entry(command: str) -> dict:
    """The hook object we write. The comment field marks it as ours."""
    return {
        "matcher": "",
        "_bsva": MARKER,
        "hooks": [
            {"type": "command", "command": command, "_bsva": MARKER},
        ],
    }


def find_command_in_template() -> str | None:
    """Read the substituted template and pull out the SessionStart command."""
    if not TEMPLATE_PATH.exists():
        return None
    tpl = load_json(TEMPLATE_PATH)
    try:
        for group in tpl.get("hooks", {}).get("SessionStart", []):
            for h in group.get("hooks", []):
                if h.get("type") == "command" and "welcome.sh" in (h.get("command") or ""):
                    return h["command"]
    except Exception:
        return None
    return None


def merge(dry_run: bool = False) -> int:
    cmd = find_command_in_template()
    if not cmd:
        print(
            f"error: couldn't find SessionStart hook command in {TEMPLATE_PATH}. "
            "Did install.sh run successfully with the new template?",
            file=sys.stderr,
        )
        return 1

    settings = load_json(SETTINGS_PATH)

    hooks = settings.setdefault("hooks", {})
    session_start = hooks.setdefault("SessionStart", [])

    # Remove any prior BSVA groups (idempotency)
    before_count = len(session_start)
    session_start[:] = [g for g in session_start if g.get("_bsva") != MARKER]
    removed = before_count - len(session_start)

    # Add the fresh one
    new_entry = bsva_hook_entry(cmd)
    session_start.append(new_entry)

    if dry_run:
        print("── would write ──")
        print(json.dumps(settings, indent=2))
        print(
            f"\nSummary: {'replaced ' + str(removed) + ' stale BSVA entry' if removed else 'added'} "
            f"SessionStart hook in {SETTINGS_PATH}"
        )
        return 0

    # Backup existing settings if non-empty
    if SETTINGS_PATH.exists() and SETTINGS_PATH.stat().st_size > 0:
        ts = datetime.now().strftime("%Y%m%d-%H%M%S")
        backup = CLAUDE_DIR / f".bsva-backup/settings-{ts}.json"
        backup.parent.mkdir(parents=True, exist_ok=True)
        backup.write_text(SETTINGS_PATH.read_text(encoding="utf-8"), encoding="utf-8")
        print(f"  ↳ backed up to {backup}")

    CLAUDE_DIR.mkdir(parents=True, exist_ok=True)
    SETTINGS_PATH.write_text(json.dumps(settings, indent=2) + "\n", encoding="utf-8")

    if removed:
        print(f"✓ replaced BSVA SessionStart hook in {SETTINGS_PATH}")
    else:
        print(f"✓ added BSVA SessionStart hook to {SETTINGS_PATH}")
    print(f"  command: {cmd}")
    print(f"  next Claude session will open the tutorial + marketplace (one-shot).")
    return 0


def remove(dry_run: bool = False) -> int:
    settings = load_json(SETTINGS_PATH)
    hooks = settings.get("hooks", {})
    session_start = hooks.get("SessionStart", [])
    before = len(session_start)
    hooks["SessionStart"] = [g for g in session_start if g.get("_bsva") != MARKER]
    removed = before - len(hooks["SessionStart"])

    if not removed:
        print("no BSVA SessionStart hook found; nothing to do")
        return 2

    if dry_run:
        print(json.dumps(settings, indent=2))
        return 0

    ts = datetime.now().strftime("%Y%m%d-%H%M%S")
    backup = CLAUDE_DIR / f".bsva-backup/settings-{ts}.json"
    backup.parent.mkdir(parents=True, exist_ok=True)
    backup.write_text(SETTINGS_PATH.read_text(encoding="utf-8"), encoding="utf-8")
    SETTINGS_PATH.write_text(json.dumps(settings, indent=2) + "\n", encoding="utf-8")
    print(f"✓ removed {removed} BSVA SessionStart hook from {SETTINGS_PATH}")
    print(f"  ↳ backed up to {backup}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="Merge or remove BSVA's SessionStart hook.")
    ap.add_argument("--remove", action="store_true", help="Remove the BSVA hook.")
    ap.add_argument("--dry-run", action="store_true", help="Show changes without writing.")
    args = ap.parse_args()

    return remove(args.dry_run) if args.remove else merge(args.dry_run)


if __name__ == "__main__":
    sys.exit(main())

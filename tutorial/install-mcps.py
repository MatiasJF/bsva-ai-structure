#!/usr/bin/env python3
"""
Merges BSVA's MCP servers into the user's ~/.claude/mcp.json.

- Reads the template installed by install.sh at
  ~/.claude/mcp.bsva-template.json
- Creates a timestamped backup of the existing ~/.claude/mcp.json.
- Adds each BSVA server under `mcpServers`, marked with
  `"_bsva": "BSVA_MCP"` so re-runs replace in place (idempotent).
- Preserves any user-authored servers (those without the marker).
- Reports which env values are still placeholders ("<your-...>") so the
  user knows exactly what to fill in.

Usage:
  python3 tutorial/install-mcps.py             # merge
  python3 tutorial/install-mcps.py --remove    # remove BSVA servers
  python3 tutorial/install-mcps.py --dry-run   # show changes, don't write

Exit codes: 0 ok, 1 error, 2 nothing to do.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime
from pathlib import Path

HOME = Path.home()
CLAUDE_DIR = HOME / ".claude"
MCP_PATH = CLAUDE_DIR / "mcp.json"
TEMPLATE_PATH = CLAUDE_DIR / "mcp.bsva-template.json"

MARKER = "BSVA_MCP"
PLACEHOLDER_RE = re.compile(r"^<.+>$")


def load_json(path: Path) -> dict:
    if not path.exists():
        return {}
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        print(f"error: {path} isn't valid JSON: {e}", file=sys.stderr)
        sys.exit(1)


def strip_meta(obj: dict) -> dict:
    """Remove underscore-prefixed meta keys (e.g. _comment) from the copy we write."""
    out = {}
    for k, v in obj.items():
        if k.startswith("_") and k != "_bsva":
            continue
        if isinstance(v, dict):
            out[k] = strip_meta(v)
        else:
            out[k] = v
    return out


def find_placeholders(prefix: str, obj) -> list[tuple[str, str]]:
    """Return list of (dotted.key.path, value) for values that look like placeholders."""
    found: list[tuple[str, str]] = []
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k.startswith("_"):
                continue
            path = f"{prefix}.{k}" if prefix else k
            found.extend(find_placeholders(path, v))
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            found.extend(find_placeholders(f"{prefix}[{i}]", v))
    elif isinstance(obj, str) and PLACEHOLDER_RE.match(obj):
        found.append((prefix, obj))
    return found


def merge(dry_run: bool = False) -> int:
    if not TEMPLATE_PATH.exists():
        print(
            f"error: {TEMPLATE_PATH} not found. Did install.sh run?",
            file=sys.stderr,
        )
        return 1

    template = load_json(TEMPLATE_PATH)
    bsva_servers = (template or {}).get("mcpServers", {})
    bsva_servers = {k: v for k, v in bsva_servers.items() if not k.startswith("_") and isinstance(v, dict)}

    if not bsva_servers:
        print("error: no mcpServers found in template", file=sys.stderr)
        return 1

    user_cfg = load_json(MCP_PATH)
    user_servers = user_cfg.setdefault("mcpServers", {})

    added: list[str] = []
    replaced: list[str] = []
    skipped: list[tuple[str, str]] = []  # (name, reason)
    all_placeholders: list[tuple[str, str, str]] = []  # (server, path, value)

    for name, cfg in bsva_servers.items():
        existing = user_servers.get(name)
        clean = strip_meta(cfg)
        clean["_bsva"] = MARKER

        if existing is None:
            user_servers[name] = clean
            added.append(name)
        elif isinstance(existing, dict) and existing.get("_bsva") == MARKER:
            user_servers[name] = clean
            replaced.append(name)
        else:
            skipped.append((name, "user-customized (no _bsva marker) — not touching"))
            continue

        # collect placeholders from what we just wrote
        for path_key, val in find_placeholders("env", clean.get("env", {})):
            all_placeholders.append((name, path_key, val))

    # Summary to print regardless
    def summary(prefix: str = "") -> str:
        lines = []
        if added:    lines.append(f"{prefix}✓ added:    {', '.join(added)}")
        if replaced: lines.append(f"{prefix}↺ replaced: {', '.join(replaced)}")
        if skipped:  lines.append(f"{prefix}⚠ skipped:  " + "; ".join(f"{n} ({r})" for n, r in skipped))
        return "\n".join(lines)

    if dry_run:
        print("── would write ──")
        print(json.dumps(user_cfg, indent=2))
        print()
        print(summary())
        if all_placeholders:
            print("\nPlaceholders you'd need to replace:")
            for s, k, v in all_placeholders:
                print(f"  • {s}.{k} = {v}")
        return 0

    # Backup existing mcp.json if non-empty
    if MCP_PATH.exists() and MCP_PATH.stat().st_size > 0:
        ts = datetime.now().strftime("%Y%m%d-%H%M%S")
        backup = CLAUDE_DIR / f".bsva-backup/mcp-{ts}.json"
        backup.parent.mkdir(parents=True, exist_ok=True)
        backup.write_text(MCP_PATH.read_text(encoding="utf-8"), encoding="utf-8")
        print(f"  ↳ backed up to {backup}")

    CLAUDE_DIR.mkdir(parents=True, exist_ok=True)
    MCP_PATH.write_text(json.dumps(user_cfg, indent=2) + "\n", encoding="utf-8")

    print(f"✓ merged BSVA MCP servers into {MCP_PATH}")
    print(summary("  "))

    if all_placeholders:
        print()
        print("╭──────────────────────────────────────────────────────────────╮")
        print("│ ONE manual step — fill in your API keys / credentials:        │")
        print("╰──────────────────────────────────────────────────────────────╯")
        print(f"  Edit:  {MCP_PATH}")
        print(f"  Replace these placeholder values with your real ones:\n")
        for s, k, v in all_placeholders:
            print(f"    • mcpServers.{s}.{k}  →  currently  {v}")
        print()
        print("  Each MCP's `_comment` in the template tells you where to get credentials.")
        print("  Nestr: OAuth only — visit https://mcp.nestr.io on first server launch.")
        print("  Then restart Claude. The MCPs will light up on the next session.")

    return 0


def remove(dry_run: bool = False) -> int:
    user_cfg = load_json(MCP_PATH)
    servers = user_cfg.get("mcpServers", {})
    before = len(servers)
    user_cfg["mcpServers"] = {
        k: v for k, v in servers.items()
        if not (isinstance(v, dict) and v.get("_bsva") == MARKER)
    }
    removed = before - len(user_cfg["mcpServers"])
    if not removed:
        print("no BSVA MCP servers found; nothing to do")
        return 2
    if dry_run:
        print(json.dumps(user_cfg, indent=2))
        return 0

    ts = datetime.now().strftime("%Y%m%d-%H%M%S")
    backup = CLAUDE_DIR / f".bsva-backup/mcp-{ts}.json"
    backup.parent.mkdir(parents=True, exist_ok=True)
    backup.write_text(MCP_PATH.read_text(encoding="utf-8"), encoding="utf-8")
    MCP_PATH.write_text(json.dumps(user_cfg, indent=2) + "\n", encoding="utf-8")
    print(f"✓ removed {removed} BSVA MCP server(s) from {MCP_PATH}")
    print(f"  ↳ backed up to {backup}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="Merge or remove BSVA's MCP servers.")
    ap.add_argument("--remove", action="store_true", help="Remove BSVA servers.")
    ap.add_argument("--dry-run", action="store_true", help="Show changes without writing.")
    args = ap.parse_args()
    return remove(args.dry_run) if args.remove else merge(args.dry_run)


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""
BSVA AI Marketplace — repository scanner.

Walks the repo and produces marketplace/data.json: a structured catalog of
skills, MCPs, templates, workflow docs, and guides, organized by scope.

Zero external dependencies. Run before starting the marketplace server
(the launcher does this automatically).

Usage:
    python3 marketplace/generate_index.py
"""

from __future__ import annotations

import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent

# ── helpers ───────────────────────────────────────────────────────────


def parse_frontmatter(text: str) -> tuple[dict, str]:
    """Very small YAML-ish frontmatter parser. Flat key/value only."""
    m = re.match(r"^---\s*\n(.*?)\n---\s*\n(.*)", text, re.DOTALL)
    if not m:
        return {}, text
    fm_raw = m.group(1)
    body = m.group(2)
    fm: dict[str, str] = {}
    for line in fm_raw.splitlines():
        km = re.match(r"^\s*([A-Za-z0-9_\-]+)\s*:\s*(.*)\s*$", line)
        if not km:
            continue
        key = km.group(1)
        val = km.group(2).strip()
        # strip simple quoting
        if (val.startswith('"') and val.endswith('"')) or (
            val.startswith("'") and val.endswith("'")
        ):
            val = val[1:-1]
        fm[key] = val
    return fm, body


def first_nonempty_line(text: str) -> str:
    for line in text.splitlines():
        line = line.strip().lstrip("#").strip()
        if line:
            return line
    return ""


def short(text: str, n: int = 280) -> str:
    text = text.strip()
    if len(text) <= n:
        return text
    return text[: n - 1].rstrip() + "…"


def rel(path: Path) -> str:
    return str(path.relative_to(REPO))


# ── collectors ────────────────────────────────────────────────────────


def collect_skills(scope: str, base: Path, items: list) -> None:
    if not base.exists():
        return
    for skill_dir in sorted(base.iterdir()):
        if not skill_dir.is_dir():
            continue
        sf = skill_dir / "SKILL.md"
        if not sf.exists():
            continue
        text = sf.read_text(encoding="utf-8", errors="replace")
        fm, body = parse_frontmatter(text)
        items.append(
            {
                "type": "skill",
                "scope": scope,
                "name": fm.get("name") or skill_dir.name,
                "description": fm.get("description", "").strip(),
                "classification": fm.get("classification", ""),
                "owner": fm.get("owner", ""),
                "version": fm.get("version", ""),
                "path": rel(sf),
                "body_preview": short(body, 600),
            }
        )


def collect_templates(scope: str, base: Path, items: list) -> None:
    if not base.exists():
        return
    for tpl_dir in sorted(base.iterdir()):
        if not tpl_dir.is_dir():
            continue
        readme = tpl_dir / "README.md"
        if not readme.exists():
            continue
        text = readme.read_text(encoding="utf-8", errors="replace")
        # Use first H1 if any, else first non-empty line
        title = first_nonempty_line(text) or tpl_dir.name
        # description: first paragraph after the heading
        m = re.search(r"^#\s+.*?\n\n(.+?)(?:\n\n|\Z)", text, re.DOTALL | re.MULTILINE)
        desc = (m.group(1).strip() if m else first_nonempty_line(text)).replace(
            "\n", " "
        )
        items.append(
            {
                "type": "template",
                "scope": scope,
                "name": tpl_dir.name,
                "title": title,
                "description": short(desc, 320),
                "path": rel(readme),
                "body_preview": short(text, 600),
            }
        )


def collect_mcp_configs(items: list) -> None:
    """Global and dept MCP JSONs."""
    for path in REPO.glob("global/mcps/*.json"):
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            data = {}
        servers = data.get("mcpServers", {})
        for name, cfg in servers.items():
            if name.startswith("_"):
                continue
            items.append(
                {
                    "type": "mcp",
                    "scope": "global",
                    "name": name,
                    "description": (cfg or {}).get("_comment", "").strip(),
                    "path": rel(path),
                    "body_preview": json.dumps(cfg, indent=2)[:500],
                }
            )


def collect_workflow_docs(scope: str, base: Path, items: list) -> None:
    if not base.exists():
        return
    for path in sorted(base.rglob("*.md")):
        # Skip indexes + README.md so we don't duplicate
        if path.name.lower() in {"readme.md"}:
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        title = ""
        m = re.search(r"^#\s+(.+?)\s*$", text, re.MULTILINE)
        if m:
            title = m.group(1).strip()
        items.append(
            {
                "type": "workflow",
                "scope": scope,
                "name": path.stem,
                "title": title or path.stem,
                "description": short(first_nonempty_line_after_h1(text), 300),
                "path": rel(path),
                "body_preview": short(text, 700),
            }
        )


def first_nonempty_line_after_h1(text: str) -> str:
    """First paragraph after the first H1; useful for 'lede' extraction."""
    m = re.search(r"^#\s+[^\n]+\n+(.+?)(?:\n\n|\Z)", text, re.DOTALL | re.MULTILINE)
    if m:
        return re.sub(r"\s+", " ", m.group(1).strip())
    return first_nonempty_line(text)


def collect_guides(scope: str, base: Path, items: list) -> None:
    if not base.exists():
        return
    for path in sorted(base.rglob("*.md")):
        if path.name.lower() == "readme.md":
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        title = ""
        m = re.search(r"^#\s+(.+?)\s*$", text, re.MULTILINE)
        if m:
            title = m.group(1).strip()
        items.append(
            {
                "type": "guide",
                "scope": scope,
                "name": path.stem,
                "title": title or path.stem,
                "description": short(first_nonempty_line_after_h1(text), 300),
                "path": rel(path),
                "body_preview": short(text, 700),
            }
        )


# ── main ──────────────────────────────────────────────────────────────


def main() -> int:
    items: list[dict] = []

    # Global
    collect_skills("global", REPO / "global/skills", items)
    collect_mcp_configs(items)

    # Departments
    for dept in ["developer-relations", "technology", "education", "operations"]:
        scope = f"dept/{dept}"
        collect_skills(scope, REPO / f"departments/{dept}/skills", items)
        collect_templates(scope, REPO / f"departments/{dept}/templates", items)
        collect_workflow_docs(scope, REPO / f"departments/{dept}/workflow", items)

    # Operations sub-sections
    for sub in ["biz-dev", "marketing", "legal", "exec"]:
        scope = f"dept/operations/{sub}"
        collect_skills(scope, REPO / f"departments/operations/{sub}/skills", items)
        collect_workflow_docs(scope, REPO / f"departments/operations/workflow/{sub}", items)

    # Shared workflow docs
    collect_workflow_docs("workflow", REPO / "workflow", items)

    # Guides (human + claude)
    collect_guides("guides/for-humans", REPO / "guides/for-humans", items)
    collect_guides("guides/for-claude", REPO / "guides/for-claude", items)
    collect_guides("guides/visuals", REPO / "guides/visuals", items)

    # Security
    collect_guides("security", REPO / "security", items)

    out = {
        "generated": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "repo_root": str(REPO),
        "item_count": len(items),
        "items": items,
    }

    out_path = HERE / "data.json"
    out_path.write_text(json.dumps(out, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"✓ marketplace/data.json — {len(items)} items")
    return 0


if __name__ == "__main__":
    sys.exit(main())

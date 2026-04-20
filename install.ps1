# BSVA AI Structure installer (Windows PowerShell)
#
# Mirrors install.sh:
#   - copies global/ skills and MCPs into $HOME\.claude
#   - prompts for department
#   - idempotent; backs up replaced files to $HOME\.claude\.bsva-backup\<timestamp>
#
# Usage:
#   .\install.ps1            first-time install or full refresh
#   .\install.ps1 -Sync      pull-only: refresh global/ after `git pull`
#   .\install.ps1 -DryRun    show what would change, don't write anything

param(
  [switch]$DryRun,
  [switch]$Sync
)

$ErrorActionPreference = 'Stop'

$RepoDir   = Split-Path -Parent $PSCommandPath
$ClaudeDir = Join-Path $HOME '.claude'
$Stamp     = (Get-Date -Format 'yyyyMMdd-HHmmss')
$BackupDir = Join-Path $ClaudeDir ".bsva-backup\$Stamp"

function Log($msg) { Write-Host $msg }
function Do-Cmd($scriptblock, $label) {
  if ($DryRun) { Log "DRY-RUN: $label" } else { & $scriptblock }
}

Log "BSVA AI Structure installer"
Log "  repo:    $RepoDir"
Log "  target:  $ClaudeDir"
Log "  dry-run: $DryRun"
Log "  sync:    $Sync"

Do-Cmd { New-Item -ItemType Directory -Force -Path $ClaudeDir, "$ClaudeDir\skills", "$ClaudeDir\projects", $BackupDir | Out-Null } "mkdir targets"

# ── global skills ─────────────────────────────────────────────────
Log ""
Log "→ installing global skills"
Get-ChildItem -Directory "$RepoDir\global\skills" | ForEach-Object {
  $name   = $_.Name
  $target = Join-Path "$ClaudeDir\skills" $name
  if (Test-Path $target) {
    Do-Cmd { Copy-Item -Recurse $target $BackupDir } "backup $name"
    Do-Cmd { Remove-Item -Recurse -Force $target }  "remove old $name"
  }
  Do-Cmd { Copy-Item -Recurse $_.FullName $target } "copy $name"
  Log "  ✓ $name"
}

# ── MCP template ──────────────────────────────────────────────────
Log ""
Log "→ installing global MCP template"
Do-Cmd { Copy-Item "$RepoDir\global\mcps\mcp.template.json" "$ClaudeDir\mcp.bsva-template.json" -Force } "mcp template"

# ── settings template ─────────────────────────────────────────────
Log ""
Log "→ writing settings template"
Do-Cmd { Copy-Item "$RepoDir\global\settings.template.json" "$ClaudeDir\settings.bsva-template.json" -Force } "settings template"

# ── base CLAUDE.md ────────────────────────────────────────────────
Log ""
Log "→ installing base CLAUDE.md"
$baseClaude = "$ClaudeDir\CLAUDE.md"
if (Test-Path $baseClaude) {
  Do-Cmd { Copy-Item $baseClaude $BackupDir } "backup CLAUDE.md"
}
Do-Cmd { Copy-Item "$RepoDir\global\CLAUDE.md" $baseClaude -Force } "install CLAUDE.md"

# ── department ────────────────────────────────────────────────────
if (-not $Sync) {
  Log ""
  Log "→ which department are you in?"
  Log "    1) developer-relations"
  Log "    2) technology"
  Log "    3) education"
  Log "    4) operations"
  Log "    5) skip"
  $choice = Read-Host "choice [1-5]"
  $dept = switch ($choice) {
    '1' { 'developer-relations' }
    '2' { 'technology' }
    '3' { 'education' }
    '4' { 'operations' }
    default { '' }
  }
  if ($dept) {
    Do-Cmd { Set-Content -Path "$ClaudeDir\.bsva-department" -Value $dept } "write .bsva-department"
    Log "  ✓ department set: $dept"
  }
}

Log ""
Log "✅ done."
Log "   backups (if any): $BackupDir"
Log ""
Log "Next steps:"
Log "  1. read guides/for-humans/07-BEFORE-YOU-PASTE.md"
Log "  2. merge $ClaudeDir\mcp.bsva-template.json into your MCP setup"

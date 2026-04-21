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
  [switch]$Sync,
  [switch]$SkipPreflight
)

$ErrorActionPreference = 'Stop'

$RepoDir   = Split-Path -Parent $PSCommandPath
$ClaudeDir = Join-Path $HOME '.claude'
$Stamp     = (Get-Date -Format 'yyyyMMdd-HHmmss')
$BackupDir = Join-Path $ClaudeDir ".bsva-backup\$Stamp"

function Log($msg) { Write-Host $msg }

# ── preflight: git + python3 ──────────────────────────────────────
if (-not $SkipPreflight) {
  $missing = @()
  if (-not (Get-Command 'git' -ErrorAction SilentlyContinue)) { $missing += 'git' }
  $pyFound = $false
  foreach ($c in @('python3','python','py')) {
    if (Get-Command $c -ErrorAction SilentlyContinue) { $pyFound = $true; break }
  }
  if (-not $pyFound) { $missing += 'python3' }
  if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Host "⚠ Missing required tools: $($missing -join ', ')" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Run the bootstrap first — it detects winget / choco and"
    Write-Host "  installs the missing pieces for you:"
    Write-Host ""
    Write-Host "    .\bootstrap.ps1"
    Write-Host ""
    Write-Host "  Then re-run .\install.ps1."
    Write-Host ""
    Write-Host "  (Advanced: bypass with .\install.ps1 -SkipPreflight)"
    Write-Host ""
    exit 1
  }
}
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

# ── settings template (with repo path substituted) ────────────────
Log ""
Log "→ writing settings template (substitutes {{REPO_DIR}})"
$settingsSrc = "$RepoDir\global\settings.template.json"
$settingsDst = "$ClaudeDir\settings.bsva-template.json"
Do-Cmd {
  (Get-Content $settingsSrc -Raw) -replace '\{\{REPO_DIR\}\}', ($RepoDir -replace '\\', '/') |
    Set-Content -Path $settingsDst -Encoding UTF8
} "settings template (substituted)"

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

# ── locate python once (used by both mergers) ───────────────────
$Py = $null
foreach ($c in @('python3','python','py')) {
  if (Get-Command $c -ErrorAction SilentlyContinue) { $Py = $c; break }
}

# ── offer to wire the SessionStart hook into real settings.json ────
$HookMerger = Join-Path $RepoDir 'tutorial\install-hooks.py'
if (-not $Sync -and -not $DryRun -and (Test-Path $HookMerger)) {
  Log ""
  Log "→ wire SessionStart hook into $ClaudeDir\settings.json?"
  Log "  This makes the tutorial + marketplace open automatically on your"
  Log "  FIRST Claude session after install (once only — gated by a flag file)."
  Log "  Your settings.json will be backed up before any change."
  $hookChoice = Read-Host "Merge the hook now? [Y/n]"
  if ($hookChoice -match '^(n|no)$') {
    Log "  skipped. merge later with:  python3 $HookMerger"
  } else {
    if ($Py) {
      & $Py $HookMerger
      if ($LASTEXITCODE -ne 0) { Log "  ⚠ hook merge failed; re-run manually." }
    } else {
      Log "  ⚠ python3 not found; re-run after installing:"
      Log "    python3 $HookMerger"
    }
    $flag = Join-Path $HOME ".claude\.bsva-welcome-shown"
    if (Test-Path $flag) { Remove-Item $flag -Force }
  }
}

# ── offer to merge BSVA MCP servers into real mcp.json ────────────
$McpMerger = Join-Path $RepoDir 'tutorial\install-mcps.py'
if (-not $Sync -and -not $DryRun -and (Test-Path $McpMerger)) {
  Log ""
  Log "→ wire BSVA's MCP servers into $ClaudeDir\mcp.json?"
  Log "  Adds Nestr, simple-mcp, WhatsOnChain, and BSV Academy as servers Claude can call."
  Log "  Your mcp.json will be backed up. Any custom servers you already have are preserved."
  Log "  You'll still need to drop your Nestr API key in afterwards — we'll tell you exactly where."
  $mcpChoice = Read-Host "Merge the MCP servers now? [Y/n]"
  if ($mcpChoice -match '^(n|no)$') {
    Log "  skipped. merge later with:  python3 $McpMerger"
  } else {
    if ($Py) {
      & $Py $McpMerger
      if ($LASTEXITCODE -ne 0) { Log "  ⚠ MCP merge failed; re-run manually." }
    } else {
      Log "  ⚠ python3 not found; re-run after installing:"
      Log "    python3 $McpMerger"
    }
  }
}

Log ""
Log "✅ done."
Log "   backups (if any): $BackupDir"
Log ""
Log "Next steps:"
Log "  1. Fill in your Nestr API key in $ClaudeDir\mcp.json"
Log "     (if you merged MCPs above, the merger told you exactly which lines)"
Log ""
Log "  2. Start Claude — tutorial + marketplace will open automatically on your"
Log "     first session. Or open them right now:"
Log "       $RepoDir\tutorial\start.ps1              # tutorial"
Log "       $RepoDir\tutorial\start.ps1 marketplace  # marketplace"
Log ""
Log "  3. Must-read before your first real work session:"
Log "       $RepoDir\guides\for-humans\07-BEFORE-YOU-PASTE.md"
Log ""

# ── offer to open the tour + marketplace right now too ───────────
$WelcomeLauncher = Join-Path $RepoDir 'tutorial\welcome.ps1'
if (-not $Sync -and -not $DryRun -and (Test-Path $WelcomeLauncher)) {
  $launch = Read-Host "Open the tutorial + marketplace now (in addition to next-session hook)? [Y/n]"
  if ($launch -match '^(n|no)$') {
    Log "Skipped. They'll open on your next Claude session."
  } else {
    Log "Launching..."
    & $WelcomeLauncher -Force
  }
}

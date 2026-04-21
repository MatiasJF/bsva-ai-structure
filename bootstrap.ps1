# BSVA AI — prerequisite bootstrap (Windows PowerShell)
#
# Detects what's missing and offers to install:
#   - git         required to clone + update this repo
#   - Python 3    required by the installer, launcher, scanner, merger
#   - a browser   almost everyone has one
#
# Does NOT install Claude Code (see https://claude.com/claude-code).
#
# Uses winget first (ships with Windows 10/11 since 2021), falls back
# to Chocolatey if present. Each install is confirmed.
#
# Usage:
#   .\bootstrap.ps1                interactive
#   .\bootstrap.ps1 -Yes           auto-answer yes to install prompts
#   .\bootstrap.ps1 -Check         report status only, no installs

param(
  [switch]$Yes,
  [switch]$Check
)

$ErrorActionPreference = 'Continue'

function Ok($msg)   { Write-Host "✓ $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "⚠ $msg" -ForegroundColor Yellow }
function Fail($msg) { Write-Host "✗ $msg" -ForegroundColor Red }
function Dim($msg)  { Write-Host $msg -ForegroundColor DarkGray }

function Have($cmd) {
  return [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

function Confirm-Install($label) {
  if ($Yes) { return $true }
  $ans = Read-Host "$label [Y/n]"
  return (-not ($ans -match '^(n|no)$'))
}

# ── detect package manager ────────────────────────────────────────
$Pm = ''
if (Have 'winget') { $Pm = 'winget' }
elseif (Have 'choco') { $Pm = 'choco' }

Write-Host "BSVA AI - prerequisite check" -ForegroundColor Cyan
Write-Host "  os:       Windows"
Write-Host "  pkg mgr:  $(if ($Pm) { $Pm } else { 'none detected' })"
Write-Host "  mode:     $(if ($Check) { 'check-only' } else { 'interactive' })"
Write-Host ""

# ── per-tool checks ──────────────────────────────────────────────
$Missing = @()

function Check-Git {
  if (Have 'git') {
    $v = (git --version 2>$null)
    Ok "git   -> $v"
  } else {
    Warn "git   -> not installed"
    $script:Missing += 'git'
  }
}

function Check-Python {
  $py = $null
  foreach ($c in @('python3', 'python', 'py')) {
    if (Have $c) { $py = $c; break }
  }
  if ($py) {
    try {
      $ver = & $py -c "import sys; print(sys.version.split()[0])" 2>$null
      if ($ver -match '^3\.([7-9]|[1-9][0-9])') {
        Ok "python -> $py $ver"
      } else {
        Warn "python -> found $py ($ver); need Python 3.7+"
        $script:Missing += 'python3'
      }
    } catch {
      Warn "python -> detection failed"
      $script:Missing += 'python3'
    }
  } else {
    Warn "python -> not installed"
    $script:Missing += 'python3'
  }
}

function Check-Claude {
  if (Have 'claude') {
    try { $v = (claude --version 2>$null | Select-Object -First 1); Ok "claude (CLI) -> $v" }
    catch { Ok "claude (CLI) -> present" }
  } else {
    Warn "claude (CLI) -> not on PATH (Desktop app is fine too; see https://claude.com/claude-code)"
  }
}

Write-Host "Checking required tools..." -ForegroundColor Cyan
Check-Git
Check-Python
Ok "browser -> (system default via Start-Process)"
Write-Host ""
Write-Host "Checking optional tools..." -ForegroundColor Cyan
Check-Claude
Write-Host ""

# ── early-exit paths ─────────────────────────────────────────────
if ($Missing.Count -eq 0) {
  Ok "All required tools are present. Run: .\install.ps1"
  exit 0
}

if ($Check) {
  Warn "Missing: $($Missing -join ', ')"
  Write-Host "  Re-run without -Check to be offered installs."
  exit 1
}

if (-not $Pm) {
  Fail "No supported package manager detected (need winget or choco)."
  Write-Host "  winget ships with Windows 10+ (via App Installer)."
  Write-Host "  https://learn.microsoft.com/windows/package-manager/winget/"
  Write-Host "  Or install Chocolatey: https://chocolatey.org/install"
  exit 1
}

# ── install ──────────────────────────────────────────────────────
Write-Host "Installing missing tools via $Pm" -ForegroundColor Cyan
Write-Host ""

function Install-WithPm($tool) {
  $winId = switch ($tool) {
    'git'     { 'Git.Git' }
    'python3' { 'Python.Python.3.12' }
    default   { $tool }
  }
  $chocoId = switch ($tool) {
    'git'     { 'git' }
    'python3' { 'python' }
    default   { $tool }
  }
  try {
    if ($Pm -eq 'winget') {
      Dim "-> winget install --id $winId --accept-source-agreements --accept-package-agreements"
      winget install --id $winId --accept-source-agreements --accept-package-agreements
    } elseif ($Pm -eq 'choco') {
      Dim "-> choco install $chocoId -y"
      choco install $chocoId -y
    }
    if ($LASTEXITCODE -eq 0) { Ok "$tool installed"; return $true }
    Fail "$tool install failed (exit $LASTEXITCODE)"
    return $false
  } catch {
    Fail "$tool install error: $_"
    return $false
  }
}

foreach ($tool in $Missing) {
  if (Confirm-Install "Install $tool (via $Pm)?") {
    Install-WithPm $tool | Out-Null
  } else {
    Warn "skipped $tool"
  }
  Write-Host ""
}

# ── re-check ─────────────────────────────────────────────────────
Write-Host "Re-checking..." -ForegroundColor Cyan
$Missing = @()
Check-Git
Check-Python
Write-Host ""

if ($Missing.Count -eq 0) {
  Ok "All required tools now present. Run: .\install.ps1"
  Write-Host ""
  Write-Host "Note: if your current PowerShell session doesn't see the new tools,"
  Write-Host "open a new PowerShell window and run .\install.ps1 there."
  exit 0
} else {
  Warn "Still missing: $($Missing -join ', ')"
  Write-Host "Install them manually, then run: .\install.ps1"
  exit 1
}

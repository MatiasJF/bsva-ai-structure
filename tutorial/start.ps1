# BSVA AI — local browser launcher (Windows PowerShell)
#
# Opens the guided tour OR the marketplace in your default browser.
# Runs a small local HTTP server at the repo root.
#
# Usage:
#   .\start.ps1                     open the tour (default)
#   .\start.ps1 marketplace         open the marketplace
#   .\start.ps1 -Port 9000
#   .\start.ps1 -NoOpen
#   .\start.ps1 -NoRegen            skip the marketplace scanner

param(
  [string]$Target = 'tour',
  [int]$Port = 8765,
  [switch]$NoOpen,
  [switch]$NoRegen
)

$ErrorActionPreference = 'Stop'
$TutorialDir = Split-Path -Parent $PSCommandPath
$RepoDir = Split-Path -Parent $TutorialDir

if ($Target -eq 'marketplace') {
  $Url = "http://localhost:$Port/marketplace/index.html"
} else {
  $Target = 'tour'
  $Url = "http://localhost:$Port/tutorial/index.html"
}

function Find-Python {
  foreach ($cmd in @('python3', 'python', 'py')) {
    $found = Get-Command $cmd -ErrorAction SilentlyContinue
    if ($found) { return $cmd }
  }
  return $null
}

$Py = Find-Python
if (-not $Py) {
  Write-Host @"
Python is not installed, which is what this launcher uses to serve files.

Options:
  1. Install Python (https://python.org) and re-run.
  2. Use any local HTTP server from the repo root:
       npx serve .
     Then open: $Url
"@
  exit 1
}

# Regenerate the marketplace index (fresh every launch)
$ScannerPath = Join-Path $RepoDir 'marketplace\generate_index.py'
if (-not $NoRegen -and (Test-Path $ScannerPath)) {
  & $Py $ScannerPath
  if ($LASTEXITCODE -ne 0) { Write-Host "Warning: marketplace scanner failed (continuing)." }
}

Write-Host ""
Write-Host "BSVA AI — $Target"
Write-Host "  serving: $RepoDir"
Write-Host "  url:     $Url"
Write-Host "  python:  $Py"
Write-Host ""
Write-Host "Press Ctrl+C to stop the server."
Write-Host ""

if (-not $NoOpen) {
  Start-Process $Url -ErrorAction SilentlyContinue
}

Set-Location $RepoDir
& $Py -m http.server $Port --bind 127.0.0.1

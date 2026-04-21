# BSVA AI Guided Tour — launcher (Windows PowerShell)
#
# Starts a tiny local HTTP server in this folder and opens the tutorial
# in your default browser. Partial-based HTML requires a server — the
# browser blocks fetch() from file:// for security.
#
# Usage:
#   .\start.ps1                default port 8765
#   .\start.ps1 -Port 9000     use port 9000
#   .\start.ps1 -NoOpen        start server, don't auto-open browser

param(
  [int]$Port = 8765,
  [switch]$NoOpen
)

$ErrorActionPreference = 'Stop'
$TutorialDir = Split-Path -Parent $PSCommandPath
$Url = "http://localhost:$Port/index.html"

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
  2. Use any local HTTP server:
       - Node:  npx serve .
     Then open: $Url
  3. Or open the plain text guides directly from:
     $(Split-Path $TutorialDir -Parent)\guides\for-humans\
"@
  exit 1
}

Write-Host "BSVA AI Guided Tour"
Write-Host "  folder: $TutorialDir"
Write-Host "  url:    $Url"
Write-Host "  python: $Py"
Write-Host ""
Write-Host "Opening in your browser. Press Ctrl+C to stop the server."
Write-Host ""

if (-not $NoOpen) {
  Start-Process $Url -ErrorAction SilentlyContinue
}

Set-Location $TutorialDir
& $Py -m http.server $Port --bind 127.0.0.1

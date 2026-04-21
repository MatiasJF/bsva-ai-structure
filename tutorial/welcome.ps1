# BSVA AI — welcome launcher (Windows PowerShell)
#
# Runs once after install: starts the local server, opens the tutorial
# and marketplace in browser tabs, returns. Gated by a flag file so
# repeated sessions don't re-open the browser.
#
# Usage:
#   .\welcome.ps1              one-shot
#   .\welcome.ps1 -Force       ignore flag, reopen
#   .\welcome.ps1 -Reset       remove the flag and exit

param(
  [switch]$Force,
  [switch]$Reset
)

$ErrorActionPreference = 'SilentlyContinue'
$Flag = Join-Path $HOME ".claude\.bsva-welcome-shown"
$Port = 8765

if ($Reset) {
  if (Test-Path $Flag) { Remove-Item $Flag -Force }
  Write-Host "cleared $Flag"
  exit 0
}

if (-not $Force -and (Test-Path $Flag)) { exit 0 }

$TutorialDir = Split-Path -Parent $PSCommandPath
$RepoDir = Split-Path -Parent $TutorialDir
$TutorialUrl = "http://localhost:$Port/tutorial/index.html"
$MarketUrl   = "http://localhost:$Port/marketplace/index.html"

function Server-Up {
  try {
    Invoke-WebRequest -Uri "http://127.0.0.1:$Port/tutorial/index.html" -TimeoutSec 1 -UseBasicParsing | Out-Null
    return $true
  } catch { return $false }
}

function Find-Python {
  foreach ($cmd in @('python3', 'python', 'py')) {
    $found = Get-Command $cmd -ErrorAction SilentlyContinue
    if ($found) { return $cmd }
  }
  return $null
}

$Py = Find-Python

# Regenerate the marketplace index synchronously if Python is available
$ScannerPath = Join-Path $RepoDir 'marketplace\generate_index.py'
if ($Py -and (Test-Path $ScannerPath)) {
  & $Py $ScannerPath | Out-Null
}

if (-not (Server-Up)) {
  if (-not $Py) {
    # No python, can't serve — still mark the flag so we don't nag.
    New-Item -ItemType File -Path $Flag -Force | Out-Null
    exit 0
  }
  # Start server detached
  $startArgs = "start.sh"  # placeholder, unused on Windows
  $psCommand = "& `"$Py`" -m http.server $Port --bind 127.0.0.1"
  $logPath = Join-Path $HOME ".claude\bsva-welcome.log"
  Start-Process -FilePath $Py -ArgumentList "-m", "http.server", "$Port", "--bind", "127.0.0.1" `
                -WorkingDirectory $RepoDir `
                -WindowStyle Hidden `
                -RedirectStandardOutput $logPath `
                -RedirectStandardError $logPath

  # Wait up to 4s for server
  $ok = $false
  for ($i = 0; $i -lt 8; $i++) {
    if (Server-Up) { $ok = $true; break }
    Start-Sleep -Milliseconds 500
  }
  if (-not $ok) {
    New-Item -ItemType File -Path $Flag -Force | Out-Null
    exit 0
  }
}

Start-Process $MarketUrl
Start-Sleep -Milliseconds 300
Start-Process $TutorialUrl

New-Item -ItemType File -Path $Flag -Force | Out-Null
exit 0

# Deploys agent/ptc.md to the Claude agents folder (D4). ASCII only (PowerShell 5.1).
# The repo file is canonical; the deployed copy is never edited by hand.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$src = Join-Path $repo 'agent\ptc.md'
$dstDir = Join-Path $env:USERPROFILE '.claude\agents'
$dst = Join-Path $dstDir 'ptc.md'

& (Join-Path $PSScriptRoot 'check.ps1') -SkipDeployed
if ($LASTEXITCODE -ne 0) { Write-Output 'check failed, not deploying'; exit 1 }

if (Test-Path $dst) {
    if ((Get-FileHash $dst).Hash -eq (Get-FileHash $src).Hash) { Write-Output "already current: $dst"; exit 0 }
    $backupDir = Join-Path $repo '.backup'
    New-Item -ItemType Directory -Force $backupDir | Out-Null
    $stamp = Get-Date -Format 'yyyy-MM-dd_HHmm'
    Copy-Item $dst (Join-Path $backupDir "ptc.md.backup_$stamp")
}
New-Item -ItemType Directory -Force $dstDir | Out-Null
Copy-Item $src $dst -Force
if ((Get-FileHash $dst).Hash -ne (Get-FileHash $src).Hash) { Write-Output 'hash mismatch after copy'; exit 1 }
Write-Output "deployed: $dst"
exit 0

# Static check of the PTc agent file (docs/PROCESS.md, Testregel). ASCII only (PowerShell 5.1).
# Exit 0 = ok, exit 1 = findings. -AgentPath allows the red proof against a broken copy.
param(
    [string]$AgentPath = '',
    [switch]$SkipDeployed
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if ($AgentPath -eq '') { $AgentPath = Join-Path $repo 'agent\ptc.md' }
$fail = New-Object System.Collections.Generic.List[string]

$bytes = [System.IO.File]::ReadAllBytes($AgentPath)
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) { $fail.Add('BOM at file start') }
$text = (New-Object System.Text.UTF8Encoding($false)).GetString($bytes)
# Ordinal char compare: String.StartsWith is culture-sensitive in .NET Framework and ignores U+FEFF.
if ($text.Length -gt 0 -and $text[0] -eq [char]0xFEFF) { $text = $text.Substring(1) }
if ($text.Contains("`r`n")) { $fail.Add('CRLF line endings') }
$lines = $text.Replace("`r", '') -split "`n"

if ($lines[0] -ne '---') {
    $fail.Add('frontmatter must start in line 1')
} else {
    $end = [Array]::IndexOf($lines, '---', 1)
    if ($end -lt 2) {
        $fail.Add('frontmatter not closed')
    } else {
        $fm = $lines[1..($end - 1)]
        if (-not ($fm -contains 'name: ptc')) { $fail.Add('frontmatter: "name: ptc" missing') }
        if (-not ($fm -contains 'tools: Read, Grep, Glob')) { $fail.Add('frontmatter: tools must be exactly "Read, Grep, Glob" (read-only, D1)') }
        if (-not ($fm | Where-Object { $_ -like 'description: *' })) { $fail.Add('frontmatter: description missing') }
        if ($fm | Where-Object { $_ -like 'model:*' }) { $fail.Add('frontmatter: no fixed model, caller sets it per mode (D7)') }
    }
}

$required = @(
    'SCHRITT 0 ',
    'SCHRITT 0.5',
    '## 1. DIE EBENEN',
    '## 2. QUERACHSEN',
    '### 2.3 Ressourcen',
    '### 2.4 Fehlerarten',
    '### 3.1 Schnittstellen-Matrix',
    '### 3.4 Plan-gegen-Ist',
    '### 3.5 Zustandspfade',
    ('### 3.6 Erf' + [char]0xFC + 'llbarkeit'),
    '## 4. KONSISTENZ',
    '## 6. VORENTSCHEIDUNG',
    '## 7. MODI',
    '## 8. AUSGABE',
    '## 9. VERHALTENSREGELN',
    '## 10. FALSIFIZIERBARKEIT',
    '## 11. GENEALOGIE'
)
foreach ($r in $required) {
    if (-not $text.Contains($r)) { $fail.Add("required section missing: $r") }
}
if ($text -match '(?im)^\s*\|?\s*score\s*[:=]\s*\d') { $fail.Add('numeric score found (D3: no score)') }

$mDesc = [regex]::Match($text, 'Probatio Technica \(PTc\) v(\d+\.\d+)')
$mBody = [regex]::Match($text, '## Version (\d+\.\d+\.\d+)')
if (-not $mDesc.Success) { $fail.Add('version in description missing (vX.Y)') }
if (-not $mBody.Success) { $fail.Add('version line missing (## Version X.Y.Z)') }
if ($mDesc.Success -and $mBody.Success) {
    if (-not $mBody.Groups[1].Value.StartsWith($mDesc.Groups[1].Value + '.')) { $fail.Add('version mismatch: description v' + $mDesc.Groups[1].Value + ' vs body ' + $mBody.Groups[1].Value) }
    $changelog = Join-Path $repo 'CHANGELOG.md'
    if (Test-Path $changelog) {
        $cl = [System.IO.File]::ReadAllText($changelog)
        if (-not $cl.Contains('## ' + $mBody.Groups[1].Value)) { $fail.Add('CHANGELOG.md has no entry ## ' + $mBody.Groups[1].Value) }
    } else {
        $fail.Add('CHANGELOG.md missing')
    }
}

if (-not $SkipDeployed) {
    $deployed = Join-Path $env:USERPROFILE '.claude\agents\ptc.md'
    if (-not (Test-Path $deployed)) {
        $fail.Add('not deployed: run scripts\deploy.ps1')
    } elseif ((Get-FileHash $deployed).Hash -ne (Get-FileHash $AgentPath).Hash) {
        $fail.Add('deployed copy differs from repo: run scripts\deploy.ps1 (D4)')
    }
}

if ($fail.Count -gt 0) {
    foreach ($f in $fail) { Write-Output "FAIL: $f" }
    exit 1
}
Write-Output 'check ok'
exit 0

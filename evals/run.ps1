# evals/run.ps1 - Eval-Lauf ohne Dialog (PHASE_1C_PLAN.md D15, D21, D22, D24). Nur ASCII.
# Aufruf: powershell -File evals\run.ps1 -Case 4j-ist -Variant v -Model sonnet
param(
    [Parameter(Mandatory = $true)][string]$Case,
    [string]$Variant = 'v',
    [string]$Model = 'sonnet',
    [double]$MaxBudgetUsd = 2.0,
    [string]$PromptFile = '',
    [string]$Tag = '',
    [string]$AgentPath = '',
    [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)
if ($AgentPath -eq '') { $AgentPath = Join-Path $root 'agent\ptc.md' }
$fixDir = Join-Path $root "evals\fixtures\$Case"
$caseDir = Join-Path $root "evals\cases\$Case"
if (-not (Test-Path $fixDir)) { throw "Fixture fehlt: $fixDir" }
if ($PromptFile -eq '') { $PromptFile = Join-Path $caseDir 'prompt.txt' }
if (-not (Test-Path $PromptFile)) { throw "Prompt fehlt: $PromptFile" }

function Get-Sha([string]$p) { (Get-FileHash -Algorithm SHA256 -LiteralPath $p).Hash.ToLower() }

# --- Lauf-Ordner und Fixture-Kopie
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
$run = Join-Path ([System.IO.Path]::GetTempPath()) "ptc-eval-$Case-$stamp"
New-Item -ItemType Directory -Path $run | Out-Null
Copy-Item -Recurse -LiteralPath (Join-Path $fixDir 'repo') -Destination (Join-Path $run 'repo')
$repo = Join-Path $run 'repo'

# --- Manifest pruefen (Zeilen: | repo/pfad | sha256 |); Lauf-Ordner im Sinne D24 = $repo
$manifest = Join-Path $fixDir 'MANIFEST.md'
$listed = @{}
foreach ($line in [System.IO.File]::ReadAllLines($manifest, $utf8)) {
    if ($line -match '^\|\s*`?(repo/[^|`\s]+)`?\s*\|\s*([0-9a-f]{64})\s*\|') { $listed[$Matches[1]] = $Matches[2] }
}
if ($listed.Count -eq 0) { throw 'MANIFEST ohne Hash-Zeilen' }
$bad = @()
foreach ($k in $listed.Keys) {
    $f = Join-Path $run $k
    if (-not (Test-Path $f)) { $bad += "fehlt: $k" } elseif ((Get-Sha $f) -ne $listed[$k]) { $bad += "Hash: $k" }
}
$onDisk = Get-ChildItem -Recurse -File $repo | ForEach-Object { 'repo/' + $_.FullName.Substring($repo.Length + 1).Replace('\', '/') }
foreach ($f in $onDisk) { if (-not $listed.ContainsKey($f)) { $bad += "nicht im Manifest: $f" } }
if ($bad.Count -gt 0) { throw ('Fixture-Pruefung rot: ' + ($bad -join '; ')) }
$manifestSha = Get-Sha (Join-Path $fixDir 'MANIFEST.md')

# --- Agent-Fassung (Repo-Fassung, ggf. mit Schnitt)
$text = [System.IO.File]::ReadAllText($AgentPath, $utf8)
if ($text.Length -gt 0 -and $text[0] -eq [char]0xFEFF) { throw 'BOM in Agent-Datei' }
$lines = New-Object System.Collections.Generic.List[string]
foreach ($l in ($text -replace "`r`n", "`n").Split("`n")) { $lines.Add($l) }
$agentName = 'ptc-eval'
$mVer = [regex]::Match($text, '## Version (\d+)\.(\d+)\.\d+')
if (-not $mVer.Success) { throw 'Version (## Version X.Y.Z) in Agent-Datei fehlt' }
$verName = 'v' + $mVer.Groups[1].Value + '.' + $mVer.Groups[2].Value
$nameBase = (Get-Date -Format 'yyyy-MM-dd') + '_' + $Case + '_' + $(if ($Variant -eq 'v') { $verName } else { $Variant + '_' + $verName }) + $(if ($Tag -ne '') { '_' + $Tag } else { '' })
$resDir = Join-Path $root 'evals\results'
if ($Tag -eq '') {
    foreach ($ext in @('.md', '.json', '.karte.md')) {
        if (Test-Path (Join-Path $resDir ($nameBase + $ext))) { throw "Ergebnis existiert schon (kein Ueberschreiben ohne -Tag): $nameBase$ext" }
    }
}
Write-Host "Ergebnisname: $nameBase"
$cuts = @()
if ($Variant -ne 'v') {
    $vf = Join-Path $PSScriptRoot "variants\$Variant.txt"
    if (-not (Test-Path $vf)) { throw "Variante fehlt: $vf" }
    $agentName = "ptc-$Variant"
    foreach ($spec in [System.IO.File]::ReadAllLines($vf, $utf8)) {
        if ($spec.Trim() -eq '' -or $spec.StartsWith('#')) { continue }
        $parts = $spec.Split('|', 2)
        $kind = $parts[0]; $prefix = $parts[1]
        $start = -1
        for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i].StartsWith($prefix)) { $start = $i; break } }
        if ($start -lt 0) { throw "Schnitt-Ueberschrift nicht gefunden: $prefix" }
        $end = $start
        if ($kind -eq 'section') {
            $end = $start + 1
            while ($end -lt $lines.Count -and -not ($lines[$end].StartsWith('#') -or $lines[$end].StartsWith('---'))) { $end++ }
            $end--
        } elseif ($kind -eq 'block') {
            $end = $start + 1
            while ($end -lt $lines.Count -and $lines[$end].Trim() -ne '') { $end++ }
            $end--
        } elseif ($kind -ne 'line') { throw "Unbekannte Schnittart: $kind" }
        $cuts += "$kind '$prefix' Zeilen $($start + 1)-$($end + 1)"
        $lines.RemoveRange($start, $end - $start + 1)
        # Pruefung: Ueberschrift fehlt jetzt
        foreach ($l in $lines) { if ($l.StartsWith($prefix)) { throw "Schnitt unvollstaendig: $prefix" } }
    }
}
$full = ($lines -join "`n")
# Frontmatter abtrennen
if (-not $full.StartsWith("---`n")) { throw 'Frontmatter fehlt' }
$endFm = $full.IndexOf("`n---`n", 3)
if ($endFm -lt 0) { throw 'Frontmatter ohne Ende' }
$body = $full.Substring($endFm + 5).TrimStart("`n")
$desc = 'PTc Eval-Fassung'
$agentFile = Join-Path $run 'agent-variant.md'
[System.IO.File]::WriteAllText($agentFile, $full, $utf8)
$agentSha = Get-Sha $agentFile
$agentsObj = @{}
$agentsObj[$agentName] = [ordered]@{ description = $desc; prompt = $body; tools = @('Read', 'Grep', 'Glob') }
$agentsJson = Join-Path $run 'agents.json'
[System.IO.File]::WriteAllText($agentsJson, ($agentsObj | ConvertTo-Json -Depth 5), $utf8)

Write-Host "Lauf-Ordner: $run"
Write-Host "Agent: $agentName  SHA-256 $agentSha"
foreach ($c in $cuts) { Write-Host "Schnitt: $c" }
if ($DryRun) { Write-Host 'DryRun: kein claude-Aufruf. Ergebnis: gruen'; exit 0 }

# --- claude -p starten (Prompt per stdin, UTF-8)
$prompt = [System.IO.File]::ReadAllText($PromptFile, $utf8)
$argList = @('-p', '--agents', $agentsJson, '--agent', $agentName, '--model', $Model, '--effort', 'medium',
    '--tools', 'Read,Grep,Glob', '--strict-mcp-config', '--no-session-persistence', '--permission-prompts', 'none',
    '--max-budget-usd', ([string]$MaxBudgetUsd).Replace(',', '.'), '--output-format', 'stream-json', '--verbose')
$psi = New-Object System.Diagnostics.ProcessStartInfo
$claudeExe = (Get-Command claude).Source
$psi.FileName = $claudeExe
$quoted = foreach ($a in $argList) { if ($a -match '[\s"]') { '"' + $a.Replace('"', '\"') + '"' } else { $a } }
$psi.Arguments = ($quoted -join ' ')
$psi.WorkingDirectory = $repo
$psi.UseShellExecute = $false
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.StandardOutputEncoding = $utf8
$psi.StandardErrorEncoding = $utf8
$sw = [System.Diagnostics.Stopwatch]::StartNew()
$p = [System.Diagnostics.Process]::Start($psi)
$errTask = $p.StandardError.ReadToEndAsync()
$bytes = $utf8.GetBytes($prompt)
$p.StandardInput.BaseStream.Write($bytes, 0, $bytes.Length)
$p.StandardInput.Close()
$out = $p.StandardOutput.ReadToEnd()
$p.WaitForExit()
$sw.Stop()
$err = $errTask.Result

# --- Ausgabe auswerten
New-Item -ItemType Directory -Force -Path $resDir | Out-Null
[System.IO.File]::WriteAllText((Join-Path $resDir "$nameBase.json"), $out, $utf8)

$runNorm = [System.IO.Path]::GetFullPath($run).TrimEnd('\') + '\'
$repoNorm = [System.IO.Path]::GetFullPath($repo).TrimEnd('\') + '\'
$outside = New-Object System.Collections.Generic.List[string]
$resultEv = $null
$tools = 0
foreach ($ln in $out.Split("`n")) {
    $t = $ln.Trim()
    if ($t -eq '' -or -not $t.StartsWith('{')) { continue }
    try { $ev = $t | ConvertFrom-Json } catch { continue }
    if ($ev.type -eq 'result') { $resultEv = $ev }
    if ($ev.type -eq 'assistant' -and $ev.message.content) {
        foreach ($c in $ev.message.content) {
            if ($c.type -ne 'tool_use') { continue }
            $tools++
            $cands = @()
            $props = @('file_path', 'path')
            if ($c.name -eq 'Glob') { $props += 'pattern' }
            foreach ($prop in $props) {
                $v = $c.input.$prop
                if ($v) { $cands += [string]$v }
            }
            foreach ($v in $cands) {
                $isAbs = ($v -match '^[A-Za-z]:[\\/]') -or $v.StartsWith('/') -or $v.StartsWith('\') -or $v.StartsWith('~')
                $isRel = (-not $isAbs) -and ($v -match '\.\.')
                if (-not ($isAbs -or $isRel)) { continue }
                try {
                    $abs = if ($isAbs) { $v } else { Join-Path $repo $v }
                    $abs = [System.IO.Path]::GetFullPath($abs.Replace('/', '\'))
                } catch { $outside.Add("$($c.name): $v"); continue }
                if (-not ($abs + '\').StartsWith($repoNorm, [System.StringComparison]::OrdinalIgnoreCase)) { $outside.Add("$($c.name): $v") }
            }
        }
    }
}
$karte = ''
$valid = $true
$why = @()
if ($resultEv -eq $null) { $valid = $false; $why += 'kein result-Ereignis' }
else {
    if ($resultEv.is_error) { $valid = $false; $why += "is_error ($($resultEv.subtype))" }
    $karte = [string]$resultEv.result
    if ($karte.Trim().Length -lt 200) { $valid = $false; $why += 'Karte fehlt oder zu kurz' }
}
if ($outside.Count -gt 0) { $valid = $false; $why += "$($outside.Count) Zugriff(e) ausserhalb des Lauf-Ordners (D24)" }
[System.IO.File]::WriteAllText((Join-Path $resDir "$nameBase.karte.md"), $karte, $utf8)

$in = 0; $outT = 0; $cr = 0; $cc = 0; $usd = 0; $turns = 0; $dur = [math]::Round($sw.Elapsed.TotalSeconds, 1)
if ($resultEv) {
    $usd = $resultEv.total_cost_usd; $turns = $resultEv.num_turns
    if ($resultEv.duration_ms) { $dur = [math]::Round($resultEv.duration_ms / 1000, 1) }
    foreach ($m in $resultEv.modelUsage.PSObject.Properties) {
        $in += $m.Value.inputTokens; $outT += $m.Value.outputTokens
        $cr += $m.Value.cacheReadInputTokens; $cc += $m.Value.cacheCreationInputTokens
    }
}
$sum = $in + $outT + $cr + $cc
$sumNoRead = $in + $outT + $cc
$head = @()
$head += "# Eval $Case - $(if ($Variant -eq 'v') { $verName } else { $Variant + ' ' + $verName }) - $(Get-Date -Format 'yyyy-MM-dd')"
$head += ''
$head += '| Feld | Wert |'
$head += '|---|---|'
$head += "| Agent | $agentName |"
$head += "| Agent-Fassung SHA-256 | $agentSha |"
if ($cuts.Count -gt 0) { $head += "| Schnitt | $($cuts -join '; ') |" }
$head += "| Fixture-Manifest SHA-256 | $manifestSha |"
$head += "| Modell / Effort | $Model / medium |"
$head += "| Token input / output / cache read / cache creation | $in / $outT / $cr / $cc |"
$head += "| Token Summe (alle Arten) | $sum |"
$head += "| Token ohne Cache-Read (input + output + cache creation) | $sumNoRead |"
$head += "| USD | $usd |"
$head += "| Dauer s / Turns / Werkzeugaufrufe | $dur / $turns / $tools |"
$head += "| Zugriffe ausserhalb Lauf-Ordner | $($outside.Count)$(if ($outside.Count) { ' (' + ($outside -join '; ') + ')' }) |"
$head += "| gueltig | $(if ($valid) { 'ja' } else { 'NEIN: ' + ($why -join '; ') }) |"
$head += ''
$head += "Karte: $nameBase.karte.md - CLI-Ausgabe (stream-json): $nameBase.json"
if ($err.Trim() -ne '') { $head += ''; $head += 'stderr: ' + $err.Trim().Substring(0, [math]::Min(500, $err.Trim().Length)) }
[System.IO.File]::WriteAllText((Join-Path $resDir "$nameBase.md"), (($head -join "`n") + "`n"), $utf8)
Write-Host "Ergebnis: evals\results\$nameBase.md  gueltig=$valid  Token=$sum  ohneCacheRead=$sumNoRead  USD=$usd  Dauer=${dur}s"
if (-not $valid) { exit 2 }

# Lists pending PTc work for the Yoka-DAW (trigger against the dead learning loop, D39).
# Read-only: uses only "git grep", "git for-each-ref" in the DAW repo and file names in docs/runs.
# ASCII only (PowerShell 5.1). Exit 0 = nothing pending, exit 1 = pending items, exit 2 = error.
#
# (a) DAW sub-phase plans with a heading "### PTc:PLAN" or "### PTc:IST" (any branch or tag)
#     but no run protocol docs/runs/<date>_yoka-daw_<subphase>_ptc-plan|ptc-ist.md
# (b) protocolled PTc runs whose DAW sub-phase has a tag phase-<n><x>, but no heading
#     "## Treffer-Bewertung" in the protocol
# (c) running DAW sub-phases (branch phase-<n><x>-*, no tag phase-<n><x>) whose plan
#     does not mention "PTc:IST" (no PTc:IST planned before acceptance)
#
# -RunsPath allows the red proof against a deliberately shortened copy of docs/runs.
param(
    [string]$DawPath = 'F:\Yoka\Workspace\Yoka-DAW',
    [string]$RunsPath = ''
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if ($RunsPath -eq '') { $RunsPath = Join-Path $repo 'docs\runs' }
if (-not (Test-Path (Join-Path $DawPath '.git'))) { Write-Output "ERROR: no git repo at $DawPath"; exit 2 }
if (-not (Test-Path $RunsPath)) { Write-Output "ERROR: runs folder missing: $RunsPath"; exit 2 }

function Invoke-Git([string[]]$GitArgs) {
    $out = & git -C $DawPath @GitArgs 2>$null
    if ($LASTEXITCODE -gt 1) { throw "git $($GitArgs -join ' ') failed ($LASTEXITCODE)" }
    return @($out)
}

# Sub-phase from a plan file name: docs/PHASE_5B_PLAN.md -> 5b; PHASE_4_PLAN.md -> 4 (phase level)
function Get-SubPhase([string]$Path) {
    $m = [regex]::Match($Path, 'PHASE_(\d+[A-Z]?)(_[A-Z0-9_]+)?_PLAN\.md$')
    if ($m.Success -and $m.Groups[2].Value -eq '') { return $m.Groups[1].Value.ToLowerInvariant() }
    return $null
}

$tags = @(Invoke-Git @('for-each-ref', '--format=%(refname:short)', 'refs/tags/phase-*'))
$branches = @(Invoke-Git @('for-each-ref', '--format=%(refname:short)', 'refs/heads/phase-*', 'refs/remotes/origin/phase-*'))
$refs = @($tags + $branches | Where-Object { $_ -ne '' } | Sort-Object -Unique)
$runFiles = @(Get-ChildItem -Path $RunsPath -Filter '*_yoka-daw_*.md' | ForEach-Object { $_.Name })
$pending = New-Object System.Collections.Generic.List[string]

# (a) runs visible in the DAW plans, missing here
$found = @{}
if ($refs.Count -gt 0) {
    $hits = Invoke-Git (@('grep', '-o', '-E', '^### PTc:(PLAN|IST)') + $refs + @('--', 'docs/PHASE_*_PLAN.md'))
    foreach ($h in $hits) {
        $m = [regex]::Match($h, '^(.+?):(docs/PHASE_[^:]+_PLAN\.md):### PTc:(PLAN|IST)$')
        if (-not $m.Success) { continue }
        $sp = Get-SubPhase $m.Groups[2].Value
        if ($null -eq $sp) { continue }
        $key = $sp + '_ptc-' + $m.Groups[3].Value.ToLowerInvariant()
        if (-not $found.ContainsKey($key)) { $found[$key] = $m.Groups[1].Value + ':' + $m.Groups[2].Value }
    }
}
foreach ($key in ($found.Keys | Sort-Object)) {
    $has = $runFiles | Where-Object { $_ -like ('*_yoka-daw_' + $key + '.md') }
    if (-not $has) { $pending.Add("(a) run without protocol: $key (seen in $($found[$key]))") }
}

# (b) protocolled runs of finished sub-phases without hit rating
foreach ($f in ($runFiles | Sort-Object)) {
    $m = [regex]::Match($f, '^\d{4}-\d{2}-\d{2}_yoka-daw_(\d+[a-z]?)_(ptc-plan|ptc-ist)\.md$')
    if (-not $m.Success) { continue }
    $sp = $m.Groups[1].Value
    if (-not ($tags -contains ('phase-' + $sp))) { continue }
    $text = [System.IO.File]::ReadAllText((Join-Path $RunsPath $f), (New-Object System.Text.UTF8Encoding($false)))
    if (-not ([regex]::IsMatch($text, '(?m)^## Treffer-Bewertung'))) {
        $pending.Add("(b) tag phase-$sp exists, protocol without '## Treffer-Bewertung': $f")
    }
}

# (c) running sub-phases without a planned PTc:IST
$running = @{}
foreach ($b in $branches) {
    $m = [regex]::Match($b, '^(origin/)?phase-(\d+[a-z])(-|$)')
    if (-not $m.Success) { continue }
    $sp = $m.Groups[2].Value
    if ($tags -contains ('phase-' + $sp)) { continue }
    if (-not $running.ContainsKey($sp)) { $running[$sp] = New-Object System.Collections.Generic.List[string] }
    $running[$sp].Add($b)
}
foreach ($sp in ($running.Keys | Sort-Object)) {
    $plan = 'docs/PHASE_' + $sp.ToUpperInvariant() + '_PLAN.md'
    $withPlan = @(); $withIst = @()
    foreach ($b in $running[$sp]) {
        $exists = Invoke-Git @('ls-tree', '--name-only', $b, '--', $plan)
        if (-not $exists) { continue }
        $withPlan += $b
        $c = Invoke-Git @('grep', '-c', 'PTc:IST', $b, '--', $plan)
        if ($c) { $withIst += $b }
    }
    if ($withPlan.Count -eq 0) {
        $pending.Add("(c) sub-phase $sp running ($($running[$sp] -join ', ')), no $plan yet: plan must schedule PTc:PLAN and PTc:IST")
    } elseif ($withIst.Count -eq 0) {
        $pending.Add("(c) sub-phase $sp running, $plan schedules no PTc:IST before acceptance (branches: $($withPlan -join ', '))")
    }
}

if ($pending.Count -eq 0) { Write-Output 'pending: nothing open'; exit 0 }
foreach ($p in $pending) { Write-Output "PENDING $p" }
Write-Output "pending: $($pending.Count) open"
exit 1

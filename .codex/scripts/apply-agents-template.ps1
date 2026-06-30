[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,

    [switch]$Apply,
    [switch]$AllowDirtyTarget
)

$ErrorActionPreference = 'Stop'

function Get-NormalizedPath {
    param([string]$Path)
    return (Resolve-Path -LiteralPath $Path).Path.TrimEnd('\', '/')
}

function Test-SafeManagedPath {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $false
    }

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $false
    }

    $normalized = $Path -replace '\\', '/'
    if ($normalized -match '(^|/)\.\.(/|$)') {
        return $false
    }

    $segments = $normalized -split '/'
    if ($segments -contains '.git') {
        return $false
    }

    if ($normalized -eq 'public' -or $normalized.StartsWith('public/')) {
        return $false
    }

    if ($normalized -match '(^|/)\.env($|\.|/)') {
        return $false
    }

    if ($normalized -match '\.(key|pem|p12|pfx|sqlite|sqlite3|dump|bak|backup)$') {
        return $false
    }

    return $true
}

function Test-SameFileContent {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Destination -PathType Leaf)) {
        return $false
    }

    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    $destinationHash = (Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash
    return $sourceHash -eq $destinationHash
}

$templateRoot = Get-NormalizedPath (Join-Path $PSScriptRoot '..\..')
$targetRoot = Get-NormalizedPath $TargetPath
$manifestPath = Join-Path $templateRoot '.agents/template-manifest.json'

if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
    throw "Missing template manifest: $manifestPath"
}

if ($Apply -and ($templateRoot -ieq $targetRoot)) {
    throw 'Refusing to apply template to itself. Use a separate target repository.'
}

if (Test-Path -LiteralPath (Join-Path $targetRoot '.git')) {
    Push-Location $targetRoot
    try {
        $gitStatus = git status --porcelain
        if ($LASTEXITCODE -ne 0) {
            throw 'git status failed in target repository.'
        }
    }
    finally {
        Pop-Location
    }

    if ($gitStatus -and -not $AllowDirtyTarget) {
        throw 'Target repository has uncommitted changes. Commit, discard, or rerun with -AllowDirtyTarget after reviewing the risk.'
    }
}

$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$results = New-Object System.Collections.Generic.List[object]

foreach ($entry in $manifest.managedFiles) {
    $relativePath = [string]$entry.path
    if (-not (Test-SafeManagedPath -Path $relativePath)) {
        throw "Unsafe managed path in manifest: $relativePath"
    }

    $source = Join-Path $templateRoot $relativePath
    $destination = Join-Path $targetRoot $relativePath

    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Managed source file is missing: $relativePath"
    }

    $action = if (-not (Test-Path -LiteralPath $destination)) {
        'create'
    }
    elseif (Test-SameFileContent -Source $source -Destination $destination) {
        'unchanged'
    }
    else {
        'update'
    }

    $results.Add([pscustomobject]@{
        Action = $action
        Path   = $relativePath
    }) | Out-Null

    if ($Apply -and $action -ne 'unchanged') {
        $destinationDirectory = Split-Path -Parent $destination
        if (-not (Test-Path -LiteralPath $destinationDirectory)) {
            New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
        }

        Copy-Item -LiteralPath $source -Destination $destination -Force
    }
}

$mode = if ($Apply) { 'APPLY' } else { 'DRY-RUN' }
Write-Host "APES CIC agents template updater: $mode"
Write-Host "Template: $templateRoot"
Write-Host "Target:   $targetRoot"
Write-Host "Version:  $($manifest.templateVersion)"
Write-Host ''
$results | Sort-Object Action, Path | Format-Table -AutoSize

$summary = $results | Group-Object Action | Sort-Object Name
Write-Host ''
foreach ($item in $summary) {
    Write-Host "$($item.Name): $($item.Count)"
}

if (-not $Apply) {
    Write-Host ''
    Write-Host 'Dry-run only. Re-run with -Apply to copy managed files.'
}

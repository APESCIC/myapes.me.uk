[CmdletBinding()]
param(
    [string]$Root = ''
)

$ErrorActionPreference = 'Stop'
$errors = New-Object System.Collections.Generic.List[string]

function Add-ValidationError {
    param([string]$Message)
    $errors.Add($Message) | Out-Null
}

function Get-RepoRoot {
    if ($Root) {
        return (Resolve-Path -LiteralPath $Root).Path
    }

    return (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path
}

function Test-RelativeManifestPath {
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

$repoRoot = Get-RepoRoot
$manifestPath = Join-Path $repoRoot '.agents/template-manifest.json'
$versionPath = Join-Path $repoRoot 'VERSION'
$configPath = Join-Path $repoRoot '.codex/config.toml'

if (-not (Test-Path -LiteralPath $manifestPath)) {
    Add-ValidationError 'Missing .agents/template-manifest.json.'
}

if (-not (Test-Path -LiteralPath $versionPath)) {
    Add-ValidationError 'Missing VERSION.'
}

$manifest = $null
if (Test-Path -LiteralPath $manifestPath) {
    try {
        $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    }
    catch {
        Add-ValidationError "Manifest is not valid JSON: $($_.Exception.Message)"
    }
}

if ($manifest) {
    $version = if (Test-Path -LiteralPath $versionPath) { (Get-Content -LiteralPath $versionPath -Raw).Trim() } else { '' }
    if ($manifest.templateVersion -ne $version) {
        Add-ValidationError "Manifest version '$($manifest.templateVersion)' does not match VERSION '$version'."
    }

    $seen = @{}
    foreach ($entry in $manifest.managedFiles) {
        $path = [string]$entry.path
        if (-not (Test-RelativeManifestPath -Path $path)) {
            Add-ValidationError "Unsafe managed path in manifest: $path"
            continue
        }

        if ($seen.ContainsKey($path)) {
            Add-ValidationError "Duplicate managed path in manifest: $path"
        }
        else {
            $seen[$path] = $true
        }

        $fullPath = Join-Path $repoRoot $path
        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Add-ValidationError "Managed file is missing: $path"
        }
    }
}

if (Test-Path -LiteralPath (Join-Path $repoRoot '.codex/hooks.json')) {
    Add-ValidationError 'Active .codex/hooks.json is present; template should ship hooks as examples only.'
}

$activeRules = Get-ChildItem -LiteralPath (Join-Path $repoRoot '.codex/rules') -Filter '*.rules' -File -ErrorAction SilentlyContinue
if ($activeRules) {
    Add-ValidationError 'Active .codex/rules/*.rules files are present; template should ship rules as examples only.'
}

$promptRoot = Join-Path $repoRoot '.codex/prompts'
if (Test-Path -LiteralPath $promptRoot) {
    $promptFiles = Get-ChildItem -LiteralPath $promptRoot -File -Recurse
    foreach ($promptFile in $promptFiles) {
        if (-not $promptFile.Name.EndsWith('.prompt.md')) {
            Add-ValidationError "Prompt file must use .prompt.md extension: $($promptFile.FullName)"
        }
    }
}
else {
    Add-ValidationError 'Missing .codex/prompts directory.'
}

if (Test-Path -LiteralPath $configPath) {
    $configText = Get-Content -LiteralPath $configPath -Raw
    $forbiddenConfigKeys = @(
        'openai_base_url',
        'chatgpt_base_url',
        'apps_mcp_product_sku',
        'model_provider',
        'model_providers',
        'notify',
        'profile',
        'profiles',
        'experimental_realtime_ws_base_url',
        'otel'
    )

    foreach ($key in $forbiddenConfigKeys) {
        if ($configText -match "(?m)^\s*$([regex]::Escape($key))\s*=" -or $configText -match "(?m)^\s*\[$([regex]::Escape($key))\]") {
            Add-ValidationError "Forbidden project-local config key found: $key"
        }
    }
}
else {
    Add-ValidationError 'Missing .codex/config.toml.'
}

if ($errors.Count -gt 0) {
    Write-Host 'APES CIC template validation failed:' -ForegroundColor Red
    foreach ($validationError in $errors) {
        Write-Host " - $validationError" -ForegroundColor Red
    }
    exit 1
}

Write-Host 'APES CIC template validation passed.' -ForegroundColor Green
Write-Host "Root: $repoRoot"
Write-Host "Version: $((Get-Content -LiteralPath $versionPath -Raw).Trim())"
if ($manifest) {
    Write-Host "Managed files: $($manifest.managedFiles.Count)"
}

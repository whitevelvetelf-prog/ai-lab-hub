<#
    AI LAB HUB - build the publish archive.

    Produces a zip of the files that go to the server, with forward-slash
    entry names so it unpacks correctly on Linux.

    RUN (from anywhere):
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -Output deploy5.zip

    INCLUDED (discovered dynamically, so new files are picked up automatically
    without editing this script):
      - app/*.php
      - database/schema.sql, database/seed.sql, database/migration-*.sql
      - every public/*.php (top-level only)
      - public/manifest.json, public/sw.js, public/logo.png, public/favicon.ico
      - content/blog/**.md (blog article content, read by app/blog.php)
      - public/icons/** (PWA icons)
      - public/assets/css/**, public/assets/js/**, public/assets/videos/**
      - public/assets/images/** (except the deliberate exclusions below)

    DELIBERATELY EXCLUDED:
      - config/            Real config with secrets is set up on the server
                           (templates in the repo: config/database.example.php,
                           config/translation.example.php, config/ai-assistant.example.php)
                           EXCEPTION: config/languages.php IS included below —
                           it holds no secret (just the active-language list) and
                           the site fatal-errors without it on the server.
      - database/export_live.sql, database/export_live_full.sql   live data dumps, not code
      - database/increment_latest.sql   applied by hand via phpMyAdmin (see HOW_TO_SYNC.md), not part of a code deploy
      - database/fix-*.sql   one-off hosting patches, not standard migrations
      - public/assets/images/task-category-page.txt   working note
      - public/assets/images/logos/   user uploads from the CRM
      - public/assets/images/ads/uploads/   ad banners uploaded via the ads CRM
      - public/assets/images/marketplace/covers/   Marketplace cover images uploaded via the CRM
      - .git/, .gitignore, README.md, deploy*.zip, scripts/
#>

param(
    [string] $Output = 'deploy5.zip'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = Split-Path $PSScriptRoot -Parent
if ([System.IO.Path]::IsPathRooted($Output)) {
    $outPath = $Output
} else {
    $outPath = Join-Path $root $Output
}

function Get-RelativeFiles {
    param(
        [string] $Dir,
        [string] $Filter,
        [switch] $Recurse
    )

    $full = Join-Path $root $Dir
    if (-not (Test-Path $full)) { return @() }

    $items = Get-ChildItem -Path $full -Filter $Filter -File -Recurse:$Recurse
    return $items | ForEach-Object {
        $rel = $_.FullName.Substring($root.Length + 1) -replace '\\', '/'
        $rel
    }
}

# File list for the archive (paths relative to repo root, forward slashes).
$files = New-Object System.Collections.Generic.List[string]

$files.AddRange([string[]](Get-RelativeFiles -Dir 'app' -Filter '*.php'))

# config/ is excluded (real secrets live on the server) EXCEPT this one file —
# no secret in it, and app/translation-cache.php requires it at runtime.
$files.Add('config/languages.php')

$files.Add('database/schema.sql')
$files.Add('database/seed.sql')
$files.AddRange([string[]](Get-RelativeFiles -Dir 'database' -Filter 'migration-*.sql'))

$files.AddRange([string[]](Get-RelativeFiles -Dir 'public' -Filter '*.php'))
$files.Add('public/manifest.json')
$files.Add('public/sw.js')
$files.Add('public/logo.png')
$files.Add('public/favicon.ico')

$files.AddRange([string[]](Get-RelativeFiles -Dir 'content/blog' -Filter '*.md' -Recurse))

$files.AddRange([string[]](Get-RelativeFiles -Dir 'public/icons' -Filter '*' -Recurse))
$files.AddRange([string[]](Get-RelativeFiles -Dir 'public/assets/css' -Filter '*' -Recurse))
$files.AddRange([string[]](Get-RelativeFiles -Dir 'public/assets/js' -Filter '*' -Recurse))
$files.AddRange([string[]](Get-RelativeFiles -Dir 'public/assets/videos' -Filter '*' -Recurse))

# Images: everything under public/assets/images except the deliberate exclusions.
$imageExcludes = @(
    'public/assets/images/task-category-page.txt'
)
$images = Get-RelativeFiles -Dir 'public/assets/images' -Filter '*' -Recurse |
    Where-Object { $_ -notin $imageExcludes -and $_ -notmatch '^public/assets/images/logos/' -and $_ -notmatch '^public/assets/images/ads/uploads/' -and $_ -notmatch '^public/assets/images/marketplace/covers/' }
$files.AddRange([string[]] $images)

$files = $files | Select-Object -Unique | Sort-Object

# Make sure every listed file exists.
$missing = @()
foreach ($rel in $files) {
    $full = Join-Path $root ($rel -replace '/', '\')
    if (-not (Test-Path $full)) { $missing += $rel }
}
if ($missing.Count -gt 0) {
    Write-Error ("Missing files: " + ($missing -join ', '))
}

# Rebuild the archive.
if (Test-Path $outPath) { [System.IO.File]::Delete($outPath) }
$fs = [System.IO.File]::Open($outPath, [System.IO.FileMode]::CreateNew)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($rel in $files) {
        $full = Join-Path $root ($rel -replace '/', '\')
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $full, $rel, [System.IO.Compression.CompressionLevel]::Optimal
        ) | Out-Null
    }
}
finally {
    $zip.Dispose()
    $fs.Dispose()
}

$size = (Get-Item $outPath).Length
Write-Output ("Done: {0}" -f $outPath)
Write-Output ("Size: {0:N0} bytes, files: {1}" -f $size, $files.Count)

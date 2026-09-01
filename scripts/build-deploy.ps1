<#
    AI LAB HUB - build the publish archive.

    Produces a zip of the files that go to the server, with forward-slash
    entry names so it unpacks correctly on Linux.

    RUN (from anywhere):
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -Output deploy4.zip

    INCLUDED: app/, database/ (schema.sql + seed.sql), every public/*.php,
    images and videos under public/assets/.

    DELIBERATELY EXCLUDED:
      - config/            DB config with values is set up on the server
                           (template: config/database.example.php in the repo)
      - database/export_live.sql   live data dump, not needed to deploy code
      - public/assets/images/task-category-page.txt   working note
      - public/assets/images/logos/   user uploads from the CRM
      - .git/, .gitignore, README.md, deploy*.zip, scripts/
#>

param(
    [string] $Output = 'deploy3.zip'
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

# File list for the archive (paths relative to repo root, forward slashes).
$files = @(
    'app/.gitkeep',
    'app/auth.php',
    'app/footer.php',

    'database/.gitkeep',
    'database/schema.sql',
    'database/seed.sql',

    'public/about.php',
    'public/account.php',
    'public/blog.php',
    'public/catalog.php',
    'public/category.php',
    'public/contacts.php',
    'public/crm-add-product.php',
    'public/crm-list.php',
    'public/eli.php',
    'public/index.php',
    'public/login.php',
    'public/logout.php',
    'public/privacy.php',
    'public/product.php',
    'public/register.php',
    'public/terms.php',

    'public/assets/images/hero.png',
    'public/assets/images/logo.png',
    'public/assets/videos/elya-greeting.mp4',
    'public/assets/videos/elya-typing.mp4'
)

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

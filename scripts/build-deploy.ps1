<#
    AI LAB HUB - build the publish archive.

    Produces a zip of the files that go to the server, with forward-slash
    entry names so it unpacks correctly on Linux.

    RUN (from anywhere):
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -Output deploy5.zip
        powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -IncludeMarketplace -Output deploy-mp.zip

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
      - public/uploads/marketplace/   classified-board photos uploaded by users (only its .htaccess is shipped, with -IncludeMarketplace)
      - .git/, .gitignore, README.md, deploy*.zip, scripts/
      - MARKETPLACE (until the first Marketplace release) - left out unless -IncludeMarketplace is passed:
          public/mp-*.php (CRM, author cabinet, contact/report/favorite handlers, cron script),
          public/marketplace.php, public/marketplace-solutions.php, public/marketplace-category.php,
          public/offer.php, public/get.php (public part),
          app/marketplace-board.php, app/marketplace-email.php, app/mpb-*.php (classified board code),
          public/uploads/marketplace/.htaccess (blocks script execution in the photo folder),
          docs/marketplace_rules_uk.md (text of the listing rules, rendered by mp-rules.php), docs/.htaccess (no web access),
        Staged launch: with 'posting_enabled' => false in config/marketplace.php (ships as marketplace.dist.php) the build
        passes with a WARNING that the rules are not finalized and submission must stay closed. With 'posting_enabled' => true
        the build STOPS if the rules file still has [placeholders], the word DRAFT (in Ukrainian) or the line
        'Edition from: [date]', or if 'rules_version' is empty / not YYYY-MM-DD.
          public/assets/css/mp-*.css,
          database/migration-*-marketplace-*.sql (also in hosting-upload/, applied by hand),
          config/marketplace.php.
        Shared code that the switch keeps dormant (public_enabled = false by default) IS always
        shipped: app/marketplace.php, app/mp-card.php, app/site-header.php, app/footer.php,
        public/index.php, app/translations.php.
        config/marketplace.php is NEVER put in the archive under its own name - even with the flag -
        so a deploy can not overwrite the server's real settings (storage path, public_enabled).
        With -IncludeMarketplace it goes in as config/marketplace.dist.php (a template to copy by hand,
        see database/MARKETPLACE_HOSTING.md).
#>

param(
    [string] $Output = 'deploy5.zip',

    # Explicit opt-in: add the Marketplace files (see the EXCLUDED list above) to the archive.
    [switch] $IncludeMarketplace,

    # Files checked by the draft guard (parameters exist so the guard can be tested without touching real files).
    [string] $RulesFile = 'docs/marketplace_rules_uk.md',
    [string] $ConfigFile = 'config/marketplace.php'
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

# Marketplace: explicit exclusion unless -IncludeMarketplace (files stay on disk, only kept out of the zip).
$marketplacePatterns = @(
    '^public/mp-[^/]+\.php$',
    '^public/(marketplace|marketplace-solutions|marketplace-category|offer|get)\.php$',
    '^app/(marketplace-board|marketplace-email|mpb-[^/]+)\.php$',
    '^public/assets/css/mp-[^/]+\.css$',
    '^database/migration-[^/]*-marketplace-[^/]*\.sql$',
    '^config/marketplace(\.[a-z]+)?\.php$'
)
$marketplaceFiles = @($files | Where-Object { $f = $_; $marketplacePatterns | Where-Object { $f -match $_ } })
$files = @($files | Where-Object { $_ -notin $marketplaceFiles })

# Archive entry name per file (default: same as the path). config/marketplace.php only as a .dist template.
$entryNames = @{}
if ($IncludeMarketplace) {
    $files += @($marketplaceFiles | Where-Object { $_ -notmatch '^config/' })
    $files += 'public/uploads/marketplace/.htaccess'
    $files += 'docs/marketplace_rules_uk.md'
    $files += 'docs/.htaccess'
    $files += 'config/marketplace.php'
    $entryNames['config/marketplace.php'] = 'config/marketplace.dist.php'
}

# Release guard (only with -IncludeMarketplace).
#  * 'posting_enabled' => true  in config/marketplace.php (ships as marketplace.dist.php): user submission is OPEN, so the
#    listing rules MUST be final -> the build STOPS while the rules file has [placeholders], the draft notice, the
#    "Edition from: [date]" line, or rules_version is empty / not YYYY-MM-DD.
#  * 'posting_enabled' => false: submission is closed to regular users (staged launch) -> the build PASSES, but prints a
#    clear warning that the rules are not finalized and submission must stay closed (and lists what is still open).
#  * Always required: the rules file and the config file exist and 'posting_enabled' is present in the config.
if ($IncludeMarketplace) {
    $draftWord = [regex]::Unescape('\u0427\u0415\u0420\u041D\u0415\u0422\u041A\u0410')                 # Ukrainian "DRAFT"
    $editionRx = [regex]::Unescape('\u0420\u0435\u0434\u0430\u043A\u0446\u0456\u044F \u0432\u0456\u0434:') + '\s*\['   # "Edition from:" + "[" (date placeholder)
    $problems = @()      # always fatal
    $rulesIssues = @()   # fatal only when posting_enabled is true
    $postingOpen = $null

    $cfgPath = if ([System.IO.Path]::IsPathRooted($ConfigFile)) { $ConfigFile } else { Join-Path $root ($ConfigFile -replace '/', '\') }
    if (-not (Test-Path $cfgPath)) {
        $problems += "config file not found: $ConfigFile"
    } else {
        $cfgText = [System.IO.File]::ReadAllText($cfgPath, [System.Text.Encoding]::UTF8)
        if ($cfgText -match "'posting_enabled'\s*=>\s*(true|false)") {
            $postingOpen = ($Matches[1] -eq 'true')
        } else {
            $problems += "'posting_enabled' not found (or not true/false) in $ConfigFile (ships as config/marketplace.dist.php)"
        }
        if ($cfgText -notmatch "'rules_version'\s*=>\s*'\d{4}-\d{2}-\d{2}'") {
            $rulesIssues += "'rules_version' in $ConfigFile is empty or not YYYY-MM-DD"
        }
    }

    $rulesPath = if ([System.IO.Path]::IsPathRooted($RulesFile)) { $RulesFile } else { Join-Path $root ($RulesFile -replace '/', '\') }
    if (-not (Test-Path $rulesPath)) {
        $problems += "rules file not found: $RulesFile"
    } else {
        $rulesText = [System.IO.File]::ReadAllText($rulesPath, [System.Text.Encoding]::UTF8)
        # [text](url) is a normal markdown link, not a placeholder: only brackets NOT followed by "(" count as markers.
        $markers = @([regex]::Matches($rulesText, '\[[^\]\r\n]*\](?!\()') | ForEach-Object { $_.Value } | Select-Object -Unique)
        if ($markers.Count -gt 0) { $rulesIssues += ("$RulesFile still has $($markers.Count) [placeholder] marker(s): " + ($markers -join ' ')) }
        if ($rulesText -match $draftWord) { $rulesIssues += "$RulesFile still contains the word $draftWord (draft notice)" }
        if ($rulesText -match $editionRx) { $rulesIssues += "$RulesFile still has the line 'Edition from: [date]' (date placeholder)" }
    }

    if ($postingOpen -eq $true) { $problems += $rulesIssues }

    if ($problems.Count -gt 0) {
        Write-Error ("MARKETPLACE BUILD STOPPED - do not release a draft:`n  - " + ($problems -join "`n  - ") + "`nFix the listed items and run the build again. No archive was written.")
    }
    if ($postingOpen -eq $false) {
        $uaWarn = [regex]::Unescape('\u041F\u0440\u0430\u0432\u0438\u043B\u0430 \u043D\u0435 \u0444\u0456\u043D\u0430\u043B\u0456\u0437\u043E\u0432\u0430\u043D\u0456, \u043F\u043E\u0434\u0430\u0447\u0430 \u043E\u0433\u043E\u043B\u043E\u0448\u0435\u043D\u044C \u043C\u0430\u0454 \u043B\u0438\u0448\u0430\u0442\u0438\u0441\u044F \u0437\u0430\u043A\u0440\u0438\u0442\u043E\u044E')
        Write-Warning ("RULES ARE NOT FINALIZED: listing submission must stay CLOSED ('posting_enabled' => false in marketplace.dist.php). / " + $uaWarn + ".")
        if ($rulesIssues.Count -gt 0) {
            Write-Warning ("Still open in the rules (would BLOCK the build if posting_enabled were true):`n  - " + ($rulesIssues -join "`n  - "))
        } else {
            Write-Warning "The rules file/config look clean, but posting_enabled stays false until the lawyer review is done."
        }
    }
}

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
        $entry = $rel
        if ($entryNames.ContainsKey($rel)) { $entry = $entryNames[$rel] }
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $zip, $full, $entry, [System.IO.Compression.CompressionLevel]::Optimal
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
if ($IncludeMarketplace) {
    Write-Output "Marketplace files INCLUDED (-IncludeMarketplace): config/marketplace.php shipped as config/marketplace.dist.php"
} else {
    Write-Output ("Marketplace files excluded: {0} (pass -IncludeMarketplace for the release)" -f $marketplaceFiles.Count)
}

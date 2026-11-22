<#
    AI LAB HUB - check the code archive and write hosting-upload/RELEASE_MANIFEST.txt.

    RUN:
        powershell -ExecutionPolicy Bypass -File scripts/release-manifest.ps1 -Zip hosting-upload/code/deploy-mp.zip

    FAILS (exit 1, manifest NOT written) if the archive contains:
      - config/ files other than config/languages.php and config/marketplace.dist.php
        (so: no config/database.php, config/*.local.php, translation/oauth/mail/promo/storage/ai-assistant configs);
      - storage/, backups/, scripts/, tests/, tools/, marketplace-seed/, hosting-upload/, .git/, .env, *.zip/*.gz/*.log,
        public/_*.php (one-off diagnostics), database dumps (export_live*.sql, increment_latest.sql, batches/);
      - docs/ files without docs/.htaccess (docs/ lives outside the web root public/, .htaccess is a second line);
      - secret-looking content in text files: a real monobank jar link, API keys (AIza..., sk-ant-..., sk-..., ghp_...,
        GOCSPX-...), PEM private keys, non-empty password/secret/token/api_key assignments, SQL writing donate_* settings.
    Values are never printed - only the file path and the rule that matched.

    MANIFEST: one line per archive entry: <path>  <size bytes>  <sha256>, sorted by path, with a header
    (date, git commit, archive size). Compare two manifests to see what changed between releases.
#>
param(
    [Parameter(Mandatory = $true)] [string] $Zip,
    [string] $Manifest = 'hosting-upload/RELEASE_MANIFEST.txt'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$root = Split-Path $PSScriptRoot -Parent
$zipPath = if ([System.IO.Path]::IsPathRooted($Zip)) { $Zip } else { Join-Path $root $Zip }
$manPath = if ([System.IO.Path]::IsPathRooted($Manifest)) { $Manifest } else { Join-Path $root $Manifest }
if (-not (Test-Path $zipPath)) { Write-Host "Archive not found: $Zip" -ForegroundColor Red; exit 2 }

$forbiddenPath = @(
    '^config/(?!languages\.php$|marketplace\.dist\.php$)',
    '^(storage|backups|scripts|tests|tools|marketplace-seed|hosting-upload|\.git|\.claude)/',
    '(^|/)\.env',
    '\.(zip|gz|tar|log|sqlite|pem|key)$',
    '^public/_[^/]+\.php$',
    '^database/(export_live[^/]*\.sql|increment_latest\.sql|hosting-sync\.sql|fix-[^/]*\.sql|batches/)'
)
$secretRules = [ordered]@{
    'monobank jar link'        = 'https://(send\.)?monobank\.ua/jar/[A-Za-z0-9]{6,}'
    'Google API key'           = 'AIza[0-9A-Za-z_\-]{35}'
    'Anthropic key'            = 'sk-ant-[A-Za-z0-9_\-]{20,}'
    'OpenAI-style key'         = '\bsk-[A-Za-z0-9]{32,}'
    'GitHub token'             = 'ghp_[A-Za-z0-9]{30,}'
    'Google OAuth secret'      = 'GOCSPX-[A-Za-z0-9_\-]{20,}'
    'private key'              = '-----BEGIN [A-Z ]*PRIVATE KEY'
    'non-empty secret assign'  = "(?i)['""](password|passwd|secret|client_secret|api_key|cron_token|rate_limit_salt|saved_search_secret|messaging_secret|smtp_pass)['""]\s*=>\s*['""][^'""\s]{6,}['""]"
    'donate settings in SQL'   = "(?is)(INSERT|REPLACE|UPDATE)[^;]*site_settings[^;]*'donate_"
}

$problems = New-Object System.Collections.Generic.List[string]
$rows = New-Object System.Collections.Generic.List[string]
$sha = [System.Security.Cryptography.SHA256]::Create()
$archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
$hasDocs = $false; $hasDocsHtaccess = $false
try {
    foreach ($e in ($archive.Entries | Sort-Object FullName)) {
        $name = $e.FullName -replace '\\', '/'
        if ($name.EndsWith('/')) { continue }
        foreach ($rx in $forbiddenPath) {
            if ($name -match $rx) { $problems.Add("forbidden path: $name"); break }
        }
        if ($name -like 'docs/*') { $hasDocs = $true }
        if ($name -eq 'docs/.htaccess') { $hasDocsHtaccess = $true }
        $s = $e.Open(); $ms = New-Object System.IO.MemoryStream; $s.CopyTo($ms); $s.Dispose()
        $bytes = $ms.ToArray()
        $hash = -join ($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') })
        $rows.Add(('{0}  {1}  {2}' -f $name, $bytes.Length, $hash))
        if ($name -match '\.(php|sql|md|js|json|html|txt|css|ini|conf)$' -and $name -notlike 'tests/*') {
            $text = [System.Text.Encoding]::UTF8.GetString($bytes)
            foreach ($k in $secretRules.Keys) {
                if ($name -match '\.sql$' -or $k -ne 'donate settings in SQL') {
                    if ($text -match $secretRules[$k]) { $problems.Add("secret-like content ($k): $name") }
                }
            }
        }
    }
} finally { $archive.Dispose() }

if ($hasDocs -and -not $hasDocsHtaccess) { $problems.Add('docs/ files shipped without docs/.htaccess') }

if ($problems.Count -gt 0) {
    Write-Host 'ARCHIVE CHECK FAILED - manifest NOT written:' -ForegroundColor Red
    $problems | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}

$commit = (& git -C $root rev-parse --short HEAD 2>$null | Out-String).Trim()
$zipSize = (Get-Item $zipPath).Length
$header = @(
    "# AI LAB HUB release manifest - $(Get-Date -Format 'yyyy-MM-dd HH:mm')",
    "# archive: $((Resolve-Path $zipPath).Path.Substring($root.Length + 1) -replace '\\', '/')  ($zipSize bytes, $($rows.Count) files)",
    "# git commit: $commit",
    '# columns: path  size_bytes  sha256'
)
$dir = Split-Path $manPath -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
[System.IO.File]::WriteAllLines($manPath, [string[]]($header + $rows), (New-Object System.Text.UTF8Encoding($false)))
Write-Output "Archive check: OK ($($rows.Count) files, no forbidden paths, no secret-like content)"
Write-Output "Manifest: $Manifest"

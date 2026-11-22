<#
    AI LAB HUB - smoke test wrapper: finds a PHP with php.ini (curl enabled) in Laragon and runs scripts/smoke-test.php.

    RUN:
        powershell -ExecutionPolicy Bypass -File scripts/smoke-test.ps1 http://ai-lab-hub.test --stage=view
        powershell -ExecutionPolicy Bypass -File scripts/smoke-test.ps1 https://ailabhub-directory.com --stage=view --delay=1

    All arguments are passed through unchanged. Exit code = exit code of smoke-test.php (1 if any FAIL).
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$script = Join-Path $root 'scripts\smoke-test.php'

function Test-PhpCurl([string] $exe) {
    try {
        $mods = & $exe -m 2>$null
        return ($mods -contains 'curl')
    } catch { return $false }
}

$php = $null
# 1) PHP from PATH, if it has curl.
$cmd = Get-Command php -ErrorAction SilentlyContinue
if ($cmd -and (Test-PhpCurl $cmd.Source)) { $php = $cmd.Source }
# 2) Laragon: newest version whose folder has php.ini and curl.
if (-not $php -and (Test-Path 'C:\laragon\bin\php')) {
    $cands = Get-ChildItem 'C:\laragon\bin\php' -Directory | Sort-Object Name -Descending
    foreach ($d in $cands) {
        $exe = Join-Path $d.FullName 'php.exe'
        if ((Test-Path $exe) -and (Test-Path (Join-Path $d.FullName 'php.ini')) -and (Test-PhpCurl $exe)) { $php = $exe; break }
    }
}
if (-not $php) {
    Write-Host 'PHP with the curl extension was not found (PATH or C:\laragon\bin\php\*\php.exe with php.ini).' -ForegroundColor Red
    exit 2
}
Write-Host "PHP: $php"
& $php $script @args
exit $LASTEXITCODE

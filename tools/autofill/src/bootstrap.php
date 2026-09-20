<?php
declare(strict_types=1);

mb_internal_encoding('UTF-8');
date_default_timezone_set('Europe/Kyiv');

$cfgFile = dirname(__DIR__) . '/config.php';
if (!is_file($cfgFile)) {
    fwrite(STDERR, "Створи config.php на основі config.example.php\n");
    exit(1);
}
$GLOBALS['CFG'] = require $cfgFile;

function cfg(string $key, $default = null)
{
    $v = $GLOBALS['CFG'];
    foreach (explode('.', $key) as $part) {
        if (!is_array($v) || !array_key_exists($part, $v)) {
            return $default;
        }
        $v = $v[$part];
    }
    return $v;
}

function out(string $s): void
{
    echo '[' . date('H:i:s') . '] ' . $s . PHP_EOL;
}

function parse_args(array $argv): array
{
    $res = ['_' => []];
    $n = count($argv);
    for ($i = 1; $i < $n; $i++) {
        $a = $argv[$i];
        if (str_starts_with($a, '--')) {
            $k = substr($a, 2);
            if (str_contains($k, '=')) {
                [$k, $v] = explode('=', $k, 2);
                $res[$k] = $v;
            } elseif ($i + 1 < $n && !str_starts_with($argv[$i + 1], '--')) {
                $res[$k] = $argv[++$i];
            } else {
                $res[$k] = true;
            }
        } else {
            $res['_'][] = $a;
        }
    }
    return $res;
}

/** Нормалізація назви для порівняння: нижній регістр, лише літери/цифри. */
function norm_name(string $s): string
{
    return preg_replace('/[^a-z0-9а-яіїєґ]+/u', '', mb_strtolower($s)) ?? '';
}

function host_of(string $url): string
{
    $h = strtolower((string)parse_url($url, PHP_URL_HOST));
    return preg_replace('/^www\./', '', $h) ?? $h;
}

function abs_url(string $base, string $href): ?string
{
    $href = trim($href);
    if ($href === '' || preg_match('/^(#|mailto:|tel:|javascript:|data:)/i', $href)) {
        return null;
    }
    if (preg_match('#^https?://#i', $href)) {
        return $href;
    }
    if (str_starts_with($href, '//')) {
        return 'https:' . $href;
    }
    $b = parse_url($base);
    if (!$b || empty($b['host'])) {
        return null;
    }
    $origin = ($b['scheme'] ?? 'https') . '://' . $b['host'] . (isset($b['port']) ? ':' . $b['port'] : '');
    if (str_starts_with($href, '/')) {
        return $origin . $href;
    }
    $dir = rtrim(dirname($b['path'] ?? '/'), '/\\');
    return $origin . $dir . '/' . $href;
}

/** Частка кириличних літер серед усіх літер (груба перевірка мови). */
function cyr_ratio(string $s): float
{
    $letters = preg_match_all('/\p{L}/u', $s);
    if (!$letters) {
        return 0.0;
    }
    return preg_match_all('/\p{Cyrillic}/u', $s) / $letters;
}

foreach (['Db', 'Http', 'Robots', 'Taxonomy', 'Candidates', 'Existing', 'Stats', 'Discover', 'Fetcher', 'Enricher', 'Validator', 'Exporter'] as $c) {
    require_once __DIR__ . '/' . $c . '.php';
}

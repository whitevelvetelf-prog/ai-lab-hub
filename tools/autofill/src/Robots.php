<?php
declare(strict_types=1);

/** Мінімальна перевірка robots.txt: поважаємо Disallow для нашого бота (або "*"). */
final class Robots
{
    private static array $cache = [];

    public static function allowed(string $url): bool
    {
        $p = parse_url($url);
        if (!$p || empty($p['host'])) {
            return false;
        }
        $origin = ($p['scheme'] ?? 'https') . '://' . $p['host'] . (isset($p['port']) ? ':' . $p['port'] : '');
        $path = ($p['path'] ?? '/') . (isset($p['query']) ? '?' . $p['query'] : '');

        if (!isset(self::$cache[$origin])) {
            $r = Http::get($origin . '/robots.txt', 10, [], 300000);
            self::$cache[$origin] = ($r['status'] === 200) ? self::parse($r['body']) : [];
        }

        $best = null;
        $bestLen = -1;
        foreach (self::$cache[$origin] as [$type, $pat]) {
            if ($pat === '' || !self::matches($pat, $path)) {
                continue;
            }
            $len = strlen($pat);
            if ($len > $bestLen || ($len === $bestLen && $type === 'allow')) {
                $best = $type;
                $bestLen = $len;
            }
        }
        return $best !== 'disallow';
    }

    private static function parse(string $txt): array
    {
        $groups = [];
        $cur = null;
        $lastWasUA = false;
        foreach (preg_split('/\R/', $txt) ?: [] as $line) {
            $line = trim(preg_replace('/#.*/', '', $line) ?? '');
            if ($line === '' || !str_contains($line, ':')) {
                continue;
            }
            [$k, $v] = array_map('trim', explode(':', $line, 2));
            $k = strtolower($k);
            if ($k === 'user-agent') {
                if (!$lastWasUA) {
                    $groups[] = ['ua' => [], 'rules' => []];
                    $cur = array_key_last($groups);
                }
                $groups[$cur]['ua'][] = strtolower($v);
                $lastWasUA = true;
            } elseif (($k === 'allow' || $k === 'disallow') && $cur !== null) {
                $groups[$cur]['rules'][] = [$k, $v];
                $lastWasUA = false;
            } else {
                $lastWasUA = false;
            }
        }
        foreach ($groups as $g) {
            if (in_array('ailabhubbot', $g['ua'], true)) {
                return $g['rules'];
            }
        }
        foreach ($groups as $g) {
            if (in_array('*', $g['ua'], true)) {
                return $g['rules'];
            }
        }
        return [];
    }

    private static function matches(string $pattern, string $path): bool
    {
        $re = '#^' . str_replace(['\*', '\$'], ['.*', '$'], preg_quote($pattern, '#')) . '#';
        return (bool)preg_match($re, $path);
    }
}

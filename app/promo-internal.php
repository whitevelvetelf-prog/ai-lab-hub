<?php

declare(strict_types=1);

/**
 * AI LAB HUB — внутрішні адреси реклами й аудиторія кампаній.
 *
 * 1. Внутрішня адреса (сторінка нашого сайту) перевіряється БЕЗ HTTP-запиту (promo_internal_url_check):
 *    шлях починається з одного «/», без «//», «\», схеми, «@», пробілів і керуючих символів; сам шлях — точно
 *    з переліку config/promo-internal.php ('promo_internal_paths'); параметр ref — [A-Za-z0-9_-]{1,40}.
 *    Внутрішньою вважається (promo_is_internal_target):
 *      • адреса без схеми http(s) у кампанії campaign_type = 'internal' (/register.php?ref=house-R2,
 *        а також «//evil.com», «javascript:…» — їх ця перевірка відхиляє);
 *      • абсолютна адреса на наш домен (promo_own_hosts + хост site_url) у будь-якій кампанії.
 *    Решта (зовнішні адреси й відносні адреси платних кампаній) — як і раніше через PromoLinkChecker
 *    (app/promo-linkcheck.php) з усім захистом від SSRF.
 *
 * 2. Аудиторія кампанії (таблиця ad_campaign_audience, міграція 2026-11-12): 'all' | 'guests' | 'logged_in';
 *    немає рядка чи таблиці — 'all'. Додатково креатив із посиланням на реєстрацію (/register.php)
 *    ніколи не показується тим, хто вже увійшов (promo_viewer_allowed), навіть якщо аудиторію не задано.
 */

const PROMO_AUDIENCES = ['all' => 'Усім', 'guests' => 'Лише гостям (не показувати тим, хто увійшов)', 'logged_in' => 'Лише тим, хто увійшов'];
const PROMO_REF_PATTERN = '/^[A-Za-z0-9_-]{1,40}$/';
/** Сторінки, рекламу яких не можна показувати тим, хто вже увійшов. */
const PROMO_SIGNUP_PATHS = ['/register.php'];

/** @return array{paths:list<string>,hosts:list<string>} */
function promo_internal_config(): array
{
    static $cfg = null;
    if ($cfg !== null) {
        return $cfg;
    }
    $file = __DIR__ . '/../config/promo-internal.php';
    $raw = is_file($file) ? require $file : [];
    $raw = is_array($raw) ? $raw : [];
    $paths = array_values(array_unique(array_filter(array_map('strval', (array) ($raw['promo_internal_paths'] ?? ['/register.php'])),
        static fn(string $p): bool => preg_match('#^/(?!/)[A-Za-z0-9._/-]*$#', $p) === 1)));
    $hosts = array_map(static fn($h) => strtolower(trim((string) $h)), (array) ($raw['promo_own_hosts'] ?? []));
    if (function_exists('app_canonical_base') && ($base = app_canonical_base()) !== null) {
        $hosts[] = $base['host'];
    }
    $cfg = ['paths' => $paths, 'hosts' => array_values(array_unique(array_filter($hosts)))];

    return $cfg;
}

/** Хост — наш сайт (з www. чи без). */
function promo_is_own_host(string $host): bool
{
    $host = strtolower(trim($host, "[] \t."));
    if ($host === '') {
        return false;
    }
    $bare = preg_replace('/^www\./', '', $host);
    foreach (promo_internal_config()['hosts'] as $h) {
        if ($host === $h || $bare === preg_replace('/^www\./', '', $h)) {
            return true;
        }
    }

    return false;
}

/** Адреса має явну схему http(s)://. */
function promo_url_is_absolute_http(string $url): bool
{
    return preg_match('#^https?://#i', $url) === 1;
}

/**
 * Чи перевіряти адресу як внутрішню (без HTTP-запиту).
 * Абсолютна http(s)-адреса — лише якщо хост наш; інакше для internal-кампанії — будь-яка адреса без схеми http(s).
 */
function promo_is_internal_target(string $campaignType, string $url): bool
{
    $url = trim($url);
    if (promo_url_is_absolute_http($url)) {
        $host = parse_url($url, PHP_URL_HOST);

        return is_string($host) && promo_is_own_host($host) && strtolower((string) parse_url($url, PHP_URL_SCHEME)) === 'https';
    }

    return $campaignType === 'internal';
}

/**
 * Перевірити внутрішню адресу без HTTP-запиту.
 * Приймає відносний шлях (/register.php?ref=house-R2) або https://<наш домен>/шлях.
 *
 * @return array{ok:bool,error:?string,path:?string}
 */
function promo_internal_url_check(string $url): array
{
    $fail = static fn(string $e): array => ['ok' => false, 'error' => $e, 'path' => null];
    if ($url === '' || strlen($url) > 500) {
        return $fail('Порожня або задовга адреса.');
    }
    if (preg_match('/[\x00-\x20\x7F]/', $url) === 1) {
        return $fail('Пробіли й керуючі символи в адресі заборонені.');
    }
    if (str_contains($url, '\\') || str_contains($url, '@')) {
        return $fail('Символи «\\» і «@» в адресі заборонені.');
    }
    if (promo_url_is_absolute_http($url)) {
        $p = parse_url($url);
        if (!is_array($p) || strtolower((string) ($p['scheme'] ?? '')) !== 'https' || !promo_is_own_host((string) ($p['host'] ?? ''))
            || isset($p['port']) || isset($p['user']) || isset($p['pass'])) {
            return $fail('Абсолютна адреса — лише https://ailabhub-directory.com/…');
        }
        $url = ($p['path'] ?? '/') . (isset($p['query']) ? '?' . $p['query'] : '') . (isset($p['fragment']) ? '#' . $p['fragment'] : '');
    }
    if (!str_starts_with($url, '/') || str_starts_with($url, '//')) {
        return $fail('Внутрішня адреса має починатися з одного «/» (напр. /register.php), без схеми й домену.');
    }
    $frag = '';
    if (($h = strpos($url, '#')) !== false) {
        $frag = substr($url, $h + 1);
        $url = substr($url, 0, $h);
    }
    $query = '';
    if (($q = strpos($url, '?')) !== false) {
        $query = substr($url, $q + 1);
        $url = substr($url, 0, $q);
    }
    $path = $url;
    if (str_contains($path, ':') || str_contains($path, '%') || str_contains($path, '/./') || str_contains($path, '/../')) {
        return $fail('Недозволені символи в шляху адреси.');
    }
    if (!in_array($path, promo_internal_config()['paths'], true)) {
        return $fail('Сторінки ' . $path . ' немає в переліку дозволених внутрішніх сторінок (config/promo-internal.php).');
    }
    if ($frag !== '' && preg_match('/^[A-Za-z0-9_-]{1,60}$/', $frag) !== 1) {
        return $fail('Недозволений якір (#) в адресі.');
    }
    if ($query !== '') {
        foreach (explode('&', $query) as $pair) {
            [$k, $v] = array_pad(explode('=', $pair, 2), 2, '');
            if (preg_match('/^[A-Za-z0-9_.-]{1,40}$/', $k) !== 1 || preg_match('/^[A-Za-z0-9._~%+,-]{0,200}$/', $v) !== 1) {
                return $fail('Недозволені символи в параметрах адреси.');
            }
            if ($k === 'ref' && preg_match(PROMO_REF_PATTERN, $v) !== 1) {
                return $fail('Параметр ref — лише латиниця, цифри, «_» і «-», до 40 символів.');
            }
        }
    }

    return ['ok' => true, 'error' => null, 'path' => $path];
}

/** Адреса веде на сторінку реєстрації (відносна чи на наш домен). */
function promo_url_is_signup(string $url): bool
{
    $url = trim($url);
    if (promo_url_is_absolute_http($url)) {
        $host = parse_url($url, PHP_URL_HOST);
        if (!is_string($host) || !promo_is_own_host($host)) {
            return false;
        }
        $path = (string) parse_url($url, PHP_URL_PATH);
    } else {
        $path = (string) preg_replace('/[?#].*$/s', '', $url);
    }

    return in_array($path, PROMO_SIGNUP_PATHS, true);
}

// --- Аудиторія ------------------------------------------------------------------------------------------

/** Чи увійшов поточний відвідувач (auth.php може бути не підключено — тоді гість). */
function promo_viewer_logged_in(): bool
{
    return function_exists('auth_user_id') && auth_user_id() !== null;
}

/**
 * Аудиторії кампаній [campaign_id => audience]; лише рядки, відмінні від 'all'. Кеш на запит.
 * Таблиці ще немає (міграцію не застосовано) — [] (усі 'all').
 *
 * @return array<int,string>
 */
function promo_audience_map(PDO $pdo, bool $reset = false): array
{
    static $map = null;
    if ($reset) {
        $map = null;
    }
    if ($map === null) {
        $map = [];
        try {
            foreach ($pdo->query("SELECT campaign_id, audience FROM ad_campaign_audience WHERE audience <> 'all'")->fetchAll(PDO::FETCH_NUM) as [$cid, $aud]) {
                if (isset(PROMO_AUDIENCES[$aud])) {
                    $map[(int) $cid] = (string) $aud;
                }
            }
        } catch (Throwable $e) {
            $map = [];
        }
    }

    return $map;
}

function promo_campaign_audience(PDO $pdo, int $campaignId): string
{
    return promo_audience_map($pdo)[$campaignId] ?? 'all';
}

/** Зберегти аудиторію кампанії. false — таблиці немає (міграцію не застосовано) або помилка. */
function promo_audience_set(PDO $pdo, int $campaignId, string $audience): bool
{
    if ($campaignId <= 0 || !isset(PROMO_AUDIENCES[$audience])) {
        return false;
    }
    try {
        $pdo->prepare('INSERT INTO ad_campaign_audience (campaign_id, audience) VALUES (:c, :a) ON DUPLICATE KEY UPDATE audience = VALUES(audience)')
            ->execute([':c' => $campaignId, ':a' => $audience]);
        promo_audience_map($pdo, true);

        return true;
    } catch (Throwable $e) {
        error_log('[promo] audience: ' . $e->getMessage());

        return false;
    }
}

function promo_audience_allows(string $audience, bool $loggedIn): bool
{
    return match ($audience) {
        'guests' => !$loggedIn,
        'logged_in' => $loggedIn,
        default => true,
    };
}

/**
 * Креативи з посиланням на реєстрацію [creative_id => true] (таблиця ad_creatives, кеш на запит).
 *
 * @return array<int,true>
 */
function promo_signup_creatives(PDO $pdo): array
{
    static $ids = null;
    if ($ids === null) {
        $ids = [];
        try {
            foreach ($pdo->query("SELECT id, destination_url FROM ad_creatives WHERE destination_url LIKE '%register.php%'")->fetchAll(PDO::FETCH_NUM) as [$id, $url]) {
                if (promo_url_is_signup((string) $url)) {
                    $ids[(int) $id] = true;
                }
            }
        } catch (Throwable $e) {
            $ids = [];
        }
    }

    return $ids;
}

/** Чи можна показати креатив поточному відвідувачу: аудиторія кампанії + реклама реєстрації лише гостям. */
function promo_viewer_allowed(PDO $pdo, int $campaignId, ?int $creativeId, ?bool $loggedIn = null, ?string $destinationUrl = null): bool
{
    $loggedIn ??= promo_viewer_logged_in();
    if (!promo_audience_allows(promo_campaign_audience($pdo, $campaignId), $loggedIn)) {
        return false;
    }
    if ($loggedIn) {
        if ($destinationUrl !== null && promo_url_is_signup($destinationUrl)) {
            return false;
        }
        if ($creativeId !== null && isset(promo_signup_creatives($pdo)[$creativeId])) {
            return false;
        }
    }

    return true;
}

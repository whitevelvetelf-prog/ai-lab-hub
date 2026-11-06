<?php

declare(strict_types=1);

/**
 * AI LAB HUB — канонічна адреса сайту (одна адреса = одна сесія).
 *
 * Кукі сесії прив'язана до хоста: www.ailabhub-directory.com і ailabhub-directory.com мають РІЗНІ сесії.
 * Посилання в листах будуються з 'site_url' (config/marketplace*.php), тож якщо користувач увійшов на іншій
 * адресі, лист відкривається «без входу». Тому GET/HEAD-запит на www-варіант або http-варіант
 * канонічного хоста отримує 301 на канонічну адресу (шлях і параметри зберігаються).
 *
 * Канонічна адреса = 'site_url'. Редірект лише коли хост відрізняється тільки префіксом «www.» або схемою —
 * інші хости (локальні *.test, IP, сторонні) не чіпаються. Вимкнути: 'canonical_redirect' => false у конфігу.
 */

/** @return array{scheme:string,host:string,port:string}|null канонічна адреса з site_url або null */
function app_canonical_base(): ?array
{
    static $cache = false;
    if ($cache !== false) {
        return $cache;
    }
    $cache = null;
    // Порядок як у mail_site_url(): local-файл має пріоритет; перше задане значення кожного ключа виграє.
    $enabled = null;
    $url = '';
    foreach (['marketplace.local.php', 'marketplace.php'] as $name) {
        $file = __DIR__ . '/../config/' . $name;
        $cfg = is_file($file) ? require $file : null;
        if (!is_array($cfg)) {
            continue;
        }
        if ($enabled === null && array_key_exists('canonical_redirect', $cfg)) {
            $enabled = (bool) $cfg['canonical_redirect'];
        }
        if ($url === '') {
            $url = rtrim(trim((string) ($cfg['site_url'] ?? '')), '/');
        }
    }
    $enabled ??= true;
    if (!$enabled || preg_match('#^(https?)://([A-Za-z0-9.\-]+)(:\d{1,5})?$#', $url, $m) !== 1) {
        return null;
    }
    $cache = ['scheme' => strtolower($m[1]), 'host' => strtolower($m[2]), 'port' => (string) ($m[3] ?? '')];

    return $cache;
}

/** Чи прийшов запит по HTTPS (зокрема за проксі, що ставить X-Forwarded-Proto). */
function app_request_is_https(): bool
{
    if (!empty($_SERVER['HTTPS']) && strtolower((string) $_SERVER['HTTPS']) !== 'off') {
        return true;
    }

    return strtolower((string) ($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '')) === 'https';
}

/** Адреса для 301 або null, якщо запит уже на канонічній адресі чи не стосується її. */
function app_canonical_redirect_target(): ?string
{
    $base = app_canonical_base();
    if ($base === null) {
        return null;
    }
    $method = strtoupper((string) ($_SERVER['REQUEST_METHOD'] ?? 'GET'));
    if ($method !== 'GET' && $method !== 'HEAD') {
        return null;   // POST не перенаправляємо: тіло запиту загубилося б
    }
    $reqHost = strtolower(preg_replace('/:\d+$/', '', (string) ($_SERVER['HTTP_HOST'] ?? '')));
    if ($reqHost === '') {
        return null;
    }
    $sameFamily = $reqHost === $base['host'] || $reqHost === 'www.' . $base['host'] || 'www.' . $reqHost === $base['host'];
    if (!$sameFamily) {
        return null;
    }
    $reqScheme = app_request_is_https() ? 'https' : 'http';
    if ($reqHost === $base['host'] && ($reqScheme === $base['scheme'] || $base['scheme'] === 'http')) {
        return null;
    }
    $uri = (string) ($_SERVER['REQUEST_URI'] ?? '/');
    if ($uri === '' || $uri[0] !== '/' || str_starts_with($uri, '//')) {
        $uri = '/';
    }

    return $base['scheme'] . '://' . $base['host'] . $base['port'] . $uri;
}

function app_canonical_redirect(): void
{
    if (PHP_SAPI === 'cli' || headers_sent()) {
        return;
    }
    $target = app_canonical_redirect_target();
    if ($target !== null) {
        header('Location: ' . $target, true, 301);
        header('Cache-Control: no-store');
        exit;
    }
}

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — захист публічних форм і JS-ендпойнтів від CSRF (2026-11-11).
 *
 *   HTML-форми (вхід, реєстрація, відновлення пароля, заявки): токен сесії в прихованому полі —
 *     csrf_field() у формі, csrf_ok() в обробнику POST. Сесію відкриває app/auth.php (підключати його раніше).
 *   JS-ендпойнти (api-eli-chat, api-saved-products, api-newsletter-subscribe, promo-event, promo-report,
 *     log-impression): csrf_same_origin() — перевірка заголовків Origin / Sec-Fetch-Site. Токен там не годиться:
 *     гості без cookie, navigator.sendBeacon. Браузер не дає сторонній сторінці підробити Origin.
 *
 * Додатково сесійна cookie має SameSite=Lax (app/auth.php).
 */

function csrf_token(): string
{
    if (empty($_SESSION['site_csrf']) || !is_string($_SESSION['site_csrf'])) {
        $_SESSION['site_csrf'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['site_csrf'];
}

function csrf_field(): string
{
    return '<input type="hidden" name="csrf" value="' . htmlspecialchars(csrf_token(), ENT_QUOTES) . '">';
}

/** Токен із POST збігається з токеном сесії. */
function csrf_ok(): bool
{
    $sent = $_POST['csrf'] ?? null;

    return is_string($sent) && $sent !== '' && hash_equals(csrf_token(), $sent);
}

/** Хост без www. і без порту, малими літерами. */
function csrf_host_key(string $host): string
{
    $host = strtolower(trim($host));
    $host = (string) preg_replace('/:\d+$/', '', $host);

    return str_starts_with($host, 'www.') ? substr($host, 4) : $host;
}

/**
 * Запит прийшов із нашого ж сайту (або не з браузера). false — сторінка іншого сайту.
 *   Origin є: його хост має збігатися з Host запиту (www. і порт не враховуються); «null» — відмова.
 *   Origin немає, є Sec-Fetch-Site: дозволено same-origin, same-site, none.
 *   Немає обох (curl, старі клієнти) — дозволено: браузер, що робить POST, Origin надсилає.
 */
function csrf_same_origin(): bool
{
    $origin = $_SERVER['HTTP_ORIGIN'] ?? null;
    if (is_string($origin) && $origin !== '') {
        $host = parse_url($origin, PHP_URL_HOST);
        if (!is_string($host) || $host === '') {
            return false;
        }

        return csrf_host_key($host) === csrf_host_key((string) ($_SERVER['HTTP_HOST'] ?? ''));
    }
    $site = $_SERVER['HTTP_SEC_FETCH_SITE'] ?? null;
    if (is_string($site) && $site !== '') {
        return in_array(strtolower($site), ['same-origin', 'same-site', 'none'], true);
    }

    return true;
}

/** Для JSON-ендпойнтів: запит з іншого сайту — 403 і завершення. */
function csrf_require_same_origin_json(): void
{
    if (!csrf_same_origin()) {
        http_response_code(403);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'cross_site'], JSON_UNESCAPED_UNICODE);
        exit;
    }
}

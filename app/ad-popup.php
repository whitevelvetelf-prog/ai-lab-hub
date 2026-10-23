<?php

declare(strict_types=1);

/**
 * AI LAB HUB — реклама спливаючим вікном (місце ad_placements 'popup', з 2026-10-21).
 *
 * Сервер у HTML вікно НЕ вбудовує: підвал (app/footer.php) викликає ad_popup_bootstrap(),
 * яка лише вмикає скрипт public/assets/js/ad-popup.js і передає йому правила. Скрипт
 * сам вирішує, коли можна показати вікно, і питає оголошення в /ad-next.php (JSON або 204).
 *
 * Коли вікно НЕ показується (перевіряється і тут, і в ad-next.php, і в JS):
 *   * система реклами вимкнена, місце 'popup' вимкнене, відомий бот (скрипт не вантажиться);
 *   * сторінка зі списку ad_settings.ad_popup_excluded_pages (головна й Елі);
 *   * перша сторінка візиту й перші ad_popup_visit_delay_seconds (300 = 5 хв) с від початку візиту —
 *     потрібні ОБИДВІ умови: друга сторінка і 5 хв на сайті;
 *   * не минуло ad_popup_min_interval_seconds (600) від закриття попереднього вікна
 *     (час — у сесії PHP і в localStorage; спрацьовує суворіше);
 *   * у відвідувача фокус у полі вводу або там набраний текст, на сторінці видиме поле пароля,
 *     форму вже надсилають (це перевіряє JS);
 *   * сторінка автентифікації або тиша після входу / реєстрації / виходу (app/promo-quiet.php);
 *     сторінки автентифікації не рахуються в pages.
 *
 * Стан у сесії: $_SESSION['ad_popup'] = [visit_start, pages, last_served, last_close].
 */

require_once __DIR__ . '/promo.php';

const AD_POPUP_PLACEMENT = 'popup';
/** Значення за замовчуванням (ad_settings перекриває). */
const AD_POPUP_DEFAULTS = [
    'ad_popup_min_interval_seconds' => '600',
    'ad_popup_visit_delay_seconds' => '300',
    'ad_popup_skip_delay_default' => '5',
    // Оголошення без відео (зображення, картка) — вікно закривається саме через стільки секунд.
    'ad_popup_static_display_seconds' => '20',
    // Реклама всюди, крім головної та Елі (з 2026-10-21).
    'ad_popup_excluded_pages' => "index.php\neli.php",
];
/** Затримка кнопки «Пропустити» для оголошення — у межах 5–15 с (за замовчуванням 5, з 2026-10-23). */
const AD_POPUP_SKIP_MIN = 5;
const AD_POPUP_SKIP_MAX = 15;

function ad_popup_setting(PDO $pdo, string $key): string
{
    $v = trim(promo_setting($pdo, $key, ''));

    return $v !== '' ? $v : AD_POPUP_DEFAULTS[$key];
}

function ad_popup_int(PDO $pdo, string $key): int
{
    return max(0, (int) ad_popup_setting($pdo, $key));
}

/** Сторінка в списку виключень (шаблони з * — fnmatch за ім'ям файлу). */
function ad_popup_page_excluded(PDO $pdo, ?string $script = null): bool
{
    $file = strtolower(basename($script ?? (string) ($_SERVER['SCRIPT_NAME'] ?? '')));
    foreach (preg_split('/[\s,]+/', strtolower(ad_popup_setting($pdo, 'ad_popup_excluded_pages'))) ?: [] as $pattern) {
        if ($pattern !== '' && fnmatch($pattern, $file)) {
            return true;
        }
    }

    return false;
}

/** @return array{visit_start:int,pages:int,last_served:int,last_close:int} посилання на стан сесії */
function &ad_popup_state(): array
{
    if (!isset($_SESSION) || !is_array($_SESSION)) {
        $_SESSION = [];
    }
    if (!isset($_SESSION['ad_popup']) || !is_array($_SESSION['ad_popup'])) {
        $_SESSION['ad_popup'] = ['visit_start' => time(), 'pages' => 0, 'last_served' => 0, 'last_close' => 0];
    }

    return $_SESSION['ad_popup'];
}

/**
 * Через скільки секунд (від «зараз») сервер дозволить показ, або null — на цій сторінці
 * не можна взагалі (ще перша сторінка візиту). 0 — можна вже.
 */
function ad_popup_wait_seconds(PDO $pdo): ?int
{
    $st = &ad_popup_state();
    if ((int) $st['pages'] < 2) {
        return null;
    }
    $now = time();
    $afterVisit = (int) $st['visit_start'] + ad_popup_int($pdo, 'ad_popup_visit_delay_seconds');
    $afterLast = max((int) $st['last_close'], (int) $st['last_served']) + ad_popup_int($pdo, 'ad_popup_min_interval_seconds');
    if ((int) $st['last_served'] === 0 && (int) $st['last_close'] === 0) {
        $afterLast = 0;
    }

    return max(0, max($afterVisit, $afterLast) - $now);
}

/** Місце 'popup' може працювати (система, секрет, місце ввімкнене) і це не бот. */
function ad_popup_available(PDO $pdo): bool
{
    return promo_video_ready($pdo) && promo_placement_available($pdo, AD_POPUP_PLACEMENT) && !promo_is_bot();
}

/**
 * Підключення вікна на сторінці (виклик з app/footer.php). Рахує сторінки візиту в сесії.
 * Категорії сторінки — з глобальних $adPopupCats / $adPopupSubs (каталог, категорія, продукт).
 */
function ad_popup_bootstrap(PDO $pdo): string
{
    static $done = false;
    if ($done) {
        return '';
    }
    $done = true;
    try {
        if (promo_is_auth_page()) {
            return '';   // вхід, реєстрація тощо — не реклама й не перегляд візиту
        }
        $st = &ad_popup_state();
        $st['pages'] = (int) $st['pages'] + 1;
        if (!ad_popup_available($pdo) || ad_popup_page_excluded($pdo) || promo_quiet($pdo)) {
            return '';
        }
        $cats = array_values(array_filter(array_map('intval', (array) ($GLOBALS['adPopupCats'] ?? []))));
        $subs = array_values(array_filter(array_map('intval', (array) ($GLOBALS['adPopupSubs'] ?? []))));
        if (promo_page_excluded($pdo, $cats, $subs, (array) ($GLOBALS['adPopupPage'] ?? [])) !== null) {
            return '';   // чутлива сторінка (no_promo) — жодної реклами
        }
        $wait = ad_popup_wait_seconds($pdo);
        $cfg = [
            'pages' => (int) $st['pages'],
            'wait' => $wait,                       // null — не на цій сторінці
            'visitStart' => (int) $st['visit_start'],
            'lastClose' => max((int) $st['last_close'], (int) $st['last_served']),
            'interval' => ad_popup_int($pdo, 'ad_popup_min_interval_seconds'),
            'visitDelay' => ad_popup_int($pdo, 'ad_popup_visit_delay_seconds'),
            'now' => time(),
            'cats' => $cats,
            'subs' => $subs,
            'lang' => promo_lang(),
            // Діагностика плеєра в консолі — лише адміну з ?promo_debug=1 (на облік не впливає).
            'debug' => !empty($_GET['promo_debug']) && function_exists('auth_has_role') && auth_has_role('admin'),
        ];
    } catch (Throwable $e) {
        error_log('[ad-popup] bootstrap: ' . $e->getMessage());

        return '';
    }
    $ver = static fn(string $f): string => (string) (@filemtime(__DIR__ . '/../public/assets/' . $f) ?: 1);

    return '<script type="application/json" id="ad-popup-config">'
        . json_encode($cfg, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP) . '</script>'
        . '<link rel="stylesheet" href="/assets/css/ad-popup.css?v=' . $ver('css/ad-popup.css') . '">'
        . '<script src="/assets/js/ad-popup.js?v=' . $ver('js/ad-popup.js') . '" defer></script>';
}

/** Затримка «Пропустити» для креативу: власна (5–15) або за замовчуванням. */
function ad_popup_skip_delay(PDO $pdo, array $creative): int
{
    $own = $creative['skip_delay_seconds'] ?? null;
    $v = $own !== null && $own !== '' ? (int) $own : ad_popup_int($pdo, 'ad_popup_skip_delay_default');

    return max(AD_POPUP_SKIP_MIN, min(AD_POPUP_SKIP_MAX, $v));
}

/** Сесія: оголошення видано (рахується як «показ розпочато» для інтервалу). */
function ad_popup_mark_served(): void
{
    $st = &ad_popup_state();
    $st['last_served'] = time();
}

/** Сесія: вікно закрито — інтервал до наступного показу рахується від цього моменту. */
function ad_popup_mark_closed(): void
{
    $st = &ad_popup_state();
    $st['last_close'] = time();
}

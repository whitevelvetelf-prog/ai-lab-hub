<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «тиша» реклами довкола автентифікації (з 2026-10-23).
 *
 * Жодної реклами (спливаюче вікно, слоти й картки, автозапуск відео):
 *   * на сторінках автентифікації (PROMO_AUTH_PAGES: вхід, реєстрація, скидання пароля,
 *     вхід за посиланням, підтвердження пошти, вхід через соцмережі й колбеки, вихід) —
 *     і ці сторінки не рахуються як перегляди візиту для правил вікна (app/ad-popup.php);
 *   * ad_settings.promo_suppress_after_auth_minutes (10) хвилин після входу, реєстрації,
 *     підтвердження пошти чи виходу: auth_login() / auth_logout() / mp-verify.php
 *     викликають auth_promo_quiet_mark() (app/auth.php) — мітка $_SESSION['promo_auth_at'];
 *     тут вона перетворюється на $_SESSION['promo_suppress_until'] (час події + N хв).
 *
 * Перевіряють: ad_popup_bootstrap і ad-next.php (вікно), promo_slot і promo-serve.php
 * (слоти), підвал ставить body[data-promo-suppress] — його поважають ad-popup.js і sponsored.js.
 * Лише сесія PHP, окремих cookie немає.
 */

const PROMO_QUIET_DEFAULT_MINUTES = 10;
/** Сторінки автентифікації (ім'я файлу; шаблони з * — fnmatch). */
const PROMO_AUTH_PAGES = [
    'login.php', 'register.php', 'logout.php', 'forgot-password.php', 'login-via-token.php',
    'auth-*.php', 'mp-verify.php', 'mp-verify-email.php',
];

/** Сторінка автентифікації (за замовчуванням — поточний скрипт). */
function promo_is_auth_page(?string $script = null): bool
{
    $file = strtolower(basename($script ?? (string) ($_SERVER['SCRIPT_NAME'] ?? '')));
    foreach (PROMO_AUTH_PAGES as $pattern) {
        if (fnmatch($pattern, $file)) {
            return true;
        }
    }

    return false;
}

function promo_quiet_minutes(PDO $pdo): int
{
    $v = trim(promo_setting($pdo, 'promo_suppress_after_auth_minutes', ''));

    return $v !== '' && ctype_digit($v) ? (int) $v : PROMO_QUIET_DEFAULT_MINUTES;
}

/** До якого часу (unix) діє тиша після автентифікації; 0 — не діє. */
function promo_suppress_until(PDO $pdo): int
{
    if (!isset($_SESSION) || !is_array($_SESSION)) {
        return 0;
    }
    if (isset($_SESSION['promo_auth_at'])) {
        $until = (int) $_SESSION['promo_auth_at'] + promo_quiet_minutes($pdo) * 60;
        $_SESSION['promo_suppress_until'] = max((int) ($_SESSION['promo_suppress_until'] ?? 0), $until);
        unset($_SESSION['promo_auth_at']);
    }
    $until = (int) ($_SESSION['promo_suppress_until'] ?? 0);
    if ($until > 0 && $until <= time()) {
        unset($_SESSION['promo_suppress_until']);

        return 0;
    }

    return $until;
}

/**
 * Реклама зараз заборонена: сторінка автентифікації ($script — ім'я сторінки з запиту
 * ендпоінта; null — поточний скрипт) або діє тиша після входу/реєстрації/виходу.
 */
function promo_quiet(PDO $pdo, ?string $script = null): bool
{
    return promo_is_auth_page($script) || promo_suppress_until($pdo) > 0;
}

/** Для підвалу: позначка body[data-promo-suppress] для скриптів реклами ('' — реклама можлива). */
function promo_quiet_html(PDO $pdo): string
{
    if (!promo_quiet($pdo)) {
        return '';
    }

    return '<script>document.body.setAttribute("data-promo-suppress","' . (promo_is_auth_page() ? 'auth' : (string) promo_suppress_until($pdo)) . '");</script>';
}

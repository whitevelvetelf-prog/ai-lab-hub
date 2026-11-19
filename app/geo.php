<?php

declare(strict_types=1);

/**
 * AI LAB HUB — місце відвідувача для всього сайту (Marketplace «Поблизу мене», географія реклами).
 *
 * Об'єкт місця (geo_visitor()):
 *   ['country_code' => ?string, 'place_id' => ?int, 'lat' => ?float, 'lon' => ?float,
 *    'source' => 'user'|'profile'|'browser'|'ip'|null, 'known' => bool]
 *
 * Пріоритет джерел:
 *   а) явний вибір відвідувача — cookie geo_loc (лише place_id або код країни; HttpOnly, SameSite=Lax, Secure на
 *      HTTPS, 180 днів). Ставиться ЛИШЕ після явної дії (форма geo-location.php, «Запам'ятати» в пошуку, налаштування).
 *      Вибір через кнопку «Поблизу» (геолокація браузера) — теж явна дія; координати не зберігаються, лише знайдене
 *      найближче місто (у межах 100 км); джерело 'browser' пам'ятається в сесії. Стара cookie mp_loc (етап 6) читається
 *      як запасна й замінюється на geo_loc при наступному збереженні.
 *   б) профіль залогіненого — mp_user_prefs.place_id / country_code (таблиця етапу 6; users не змінюється);
 *   в) країна за IP — лише коли config geo_ip_enabled = true І відвідувач дав згоду в «Налаштуваннях cookie»
 *      (категорія «Місцеві оголошення й реклама за IP», cookie alh_geo = 1). Без згоди IP не аналізується взагалі.
 *      Результат — у сесії; IP ніде не зберігається й не логується.
 * Вибір відвідувача завжди сильніший за IP. «Не вказувати» — у межах сесії вимикає і IP-визначення.
 *
 * Місце й збіг НЕ залежать від мови інтерфейсу; назви місць — мовою інтерфейсу (uk/en), запасна англійська.
 */

require_once __DIR__ . '/mp-geo.php';

const GEO_COOKIE = 'geo_loc';
const GEO_LEGACY_COOKIE = 'mp_loc';
const GEO_CONSENT_COOKIE = 'alh_geo';     // '1' — згода на «Місцеві оголошення й реклама за IP»; інше / немає — ні
const GEO_NEAR_MAX_KM = 100;
const GEO_SOURCES = ['user', 'profile', 'browser', 'ip'];

/** Налаштування (config/geo.php поверх значень за замовчуванням). */
function geo_config(bool $reload = false): array
{
    static $cfg = null;
    if ($cfg === null || $reload) {
        $defaults = [
            'geo_ip_enabled' => false,
            'geo_ip_header' => '',
            'geoip_db_path' => '',
            'ad_geo_default_mode' => 'soft',
            'cookie_days' => 180,
        ];
        $file = dirname(__DIR__) . '/config/geo.php';
        $own = is_file($file) ? (require $file) : [];
        $cfg = array_merge($defaults, is_array($own) ? $own : []);
        if (isset($GLOBALS['GEO_CONFIG_OVERRIDE']) && is_array($GLOBALS['GEO_CONFIG_OVERRIDE'])) {
            $cfg = array_merge($cfg, $GLOBALS['GEO_CONFIG_OVERRIDE']);   // лише тести
        }
        $cfg['ad_geo_default_mode'] = $cfg['ad_geo_default_mode'] === 'strict' ? 'strict' : 'soft';
        $cfg['cookie_days'] = max(1, min(400, (int) $cfg['cookie_days']));
    }

    return $cfg;
}

/** Порожній (невідомий) об'єкт місця. */
function geo_unknown(): array
{
    return ['country_code' => null, 'place_id' => null, 'lat' => null, 'lon' => null, 'source' => null, 'known' => false];
}

/**
 * Об'єкт місця з id місця (місто/регіон/країна) або коду країни. null — значення недійсне.
 */
function geo_from_value(PDO $pdo, string $value, string $source): ?array
{
    $value = trim($value);
    if (preg_match('/^\d{1,10}$/', $value) === 1) {
        $p = mpg_place($pdo, (int) $value);
        if ($p === null) {
            return null;
        }
        $isCity = $p['type'] === 'city' && $p['lat'] !== null;

        return [
            'country_code' => $p['country_code'],
            'place_id' => $p['type'] === 'country' ? null : $p['id'],
            'lat' => $isCity ? (float) $p['lat'] : null,
            'lon' => $isCity ? (float) $p['lon'] : null,
            'source' => $source, 'known' => true,
        ];
    }
    $cc = strtoupper($value);
    if (preg_match('/^[A-Z]{2}$/', $cc) === 1 && mpg_country_id($pdo, $cc) !== null) {
        return ['country_code' => $cc, 'place_id' => null, 'lat' => null, 'lon' => null, 'source' => $source, 'known' => true];
    }

    return null;
}

/** Значення cookie явного вибору: geo_loc, інакше стара mp_loc. '' — немає. */
function geo_cookie_value(): string
{
    foreach ([GEO_COOKIE, GEO_LEGACY_COOKIE] as $name) {
        $v = $_COOKIE[$name] ?? '';
        if (is_string($v) && preg_match('/^(\d{1,10}|[A-Za-z]{2})$/', $v) === 1) {
            return $v;
        }
    }

    return '';
}

function geo_session_active(): bool
{
    return session_status() === PHP_SESSION_ACTIVE;
}

/**
 * Місце відвідувача за пріоритетом (див. шапку файлу). Кеш на запит; $reset — для тестів і після збереження.
 */
function geo_visitor(PDO $pdo, ?int $userId = null, bool $reset = false): array
{
    static $cache = [];
    $key = (string) ($userId ?? 0);
    if ($reset) {
        $cache = [];
    }
    if (isset($cache[$key])) {
        return $cache[$key];
    }
    if (!mpg_ready($pdo)) {
        return $cache[$key] = geo_unknown();
    }
    // а) явний вибір (cookie); джерело 'browser', якщо вибір зроблено кнопкою «Поблизу» в цьому сеансі.
    $c = geo_cookie_value();
    if ($c !== '') {
        $src = geo_session_active() && ($_SESSION['geo_src'] ?? '') === 'browser' ? 'browser' : 'user';
        $v = geo_from_value($pdo, $c, $src);
        if ($v !== null) {
            return $cache[$key] = $v;
        }
    }
    // б) профіль залогіненого
    if ($userId !== null) {
        try {
            $st = $pdo->prepare('SELECT place_id, country_code FROM mp_user_prefs WHERE user_id = :u');
            $st->execute([':u' => $userId]);
            $r = $st->fetch(PDO::FETCH_ASSOC);
        } catch (Throwable $e) {
            $r = false;
        }
        if ($r !== false) {
            $v = !empty($r['place_id']) ? geo_from_value($pdo, (string) $r['place_id'], 'profile') : null;
            $v ??= !empty($r['country_code']) ? geo_from_value($pdo, (string) $r['country_code'], 'profile') : null;
            if ($v !== null) {
                return $cache[$key] = $v;
            }
        }
    }
    // в) країна за IP — лише зі згодою і коли джерело увімкнено; інакше IP не аналізується.
    if (geo_ip_allowed()) {
        $cc = geo_detect_country();
        if ($cc !== null) {
            $v = geo_from_value($pdo, $cc, 'ip');
            if ($v !== null) {
                return $cache[$key] = $v;
            }
        }
    }

    return $cache[$key] = geo_unknown();
}

/** Згода відвідувача на категорію «Місцеві оголошення й реклама за IP» (cookie alh_geo = 1). */
function geo_ip_consent(): bool
{
    return ($_COOKIE[GEO_CONSENT_COOKIE] ?? '') === '1';
}

/** Чи можна взагалі аналізувати IP: config увімкнено, є згода, відвідувач не натиснув «Не вказувати» в цьому сеансі. */
function geo_ip_allowed(): bool
{
    if (!geo_config()['geo_ip_enabled'] || !geo_ip_consent()) {
        return false;
    }

    return !(geo_session_active() && !empty($_SESSION['geo_none']));
}

/**
 * Код країни за IP з наявного джерела (заголовок хостингу / CDN або локальна база .mmdb) або null.
 * Викликати ЛИШЕ після geo_ip_allowed(). Результат кешується в сесії; IP не зберігається й не логується.
 * Зовнішні сервіси не опитуються.
 */
function geo_detect_country(): ?string
{
    $GLOBALS['GEO_DETECT_CALLS'] = (int) ($GLOBALS['GEO_DETECT_CALLS'] ?? 0) + 1;   // для тестів
    if (geo_session_active() && array_key_exists('geo_ip_cc', $_SESSION)) {
        $c = $_SESSION['geo_ip_cc'];

        return is_string($c) && $c !== '' ? $c : null;
    }
    $cfg = geo_config();
    $cc = null;
    $hdr = (string) $cfg['geo_ip_header'];
    if ($hdr !== '' && preg_match('/^HTTP_[A-Z0-9_]+$/', $hdr) === 1) {
        $raw = strtoupper(trim((string) ($_SERVER[$hdr] ?? '')));
        if (preg_match('/^[A-Z]{2}$/', $raw) === 1 && !in_array($raw, ['XX', 'T1', 'A1', 'A2', 'O1', 'EU', 'AP'], true)) {
            $cc = $raw;
        }
    }
    $db = (string) $cfg['geoip_db_path'];
    if ($cc === null && $db !== '' && is_readable($db) && class_exists('MaxMind\\Db\\Reader')) {
        try {
            $ip = (string) ($_SERVER['REMOTE_ADDR'] ?? '');
            if (filter_var($ip, FILTER_VALIDATE_IP) !== false) {
                $cls = 'MaxMind\\Db\\Reader';
                $reader = new $cls($db);
                $rec = $reader->get($ip);
                $reader->close();
                $raw = strtoupper((string) ($rec['country']['iso_code'] ?? $rec['country_code'] ?? ''));
                $cc = preg_match('/^[A-Z]{2}$/', $raw) === 1 ? $raw : null;
            }
            unset($ip);
        } catch (Throwable $e) {
            error_log('[geo] geoip db unavailable');   // без IP у журналі
            $cc = null;
        }
    }
    if (geo_session_active()) {
        $_SESSION['geo_ip_cc'] = $cc ?? '';
    }

    return $cc;
}

function geo_https(): bool
{
    return ($_SERVER['HTTPS'] ?? '') !== '' && $_SERVER['HTTPS'] !== 'off';
}

/** Ставить cookie geo_loc (place_id або код країни) — лише після явної дії відвідувача. Стару mp_loc прибирає. */
function geo_cookie_set(string $value, string $source = 'user'): void
{
    if (preg_match('/^(\d{1,10}|[A-Z]{2})$/', $value) !== 1) {
        return;
    }
    $opts = ['path' => '/', 'secure' => geo_https(), 'httponly' => true, 'samesite' => 'Lax'];
    if (!headers_sent()) {
        setcookie(GEO_COOKIE, $value, ['expires' => time() + geo_config()['cookie_days'] * 86400] + $opts);
        if (isset($_COOKIE[GEO_LEGACY_COOKIE])) {
            setcookie(GEO_LEGACY_COOKIE, '', ['expires' => time() - 3600] + $opts);
        }
    }
    $_COOKIE[GEO_COOKIE] = $value;
    unset($_COOKIE[GEO_LEGACY_COOKIE]);
    if (geo_session_active()) {
        $_SESSION['geo_src'] = $source === 'browser' ? 'browser' : 'user';
        unset($_SESSION['geo_none']);
    }
}

/** Видаляє cookie вибору (geo_loc і стару mp_loc). */
function geo_cookie_clear(): void
{
    $opts = ['expires' => time() - 3600, 'path' => '/', 'secure' => geo_https(), 'httponly' => true, 'samesite' => 'Lax'];
    if (!headers_sent()) {
        foreach ([GEO_COOKIE, GEO_LEGACY_COOKIE] as $name) {
            if (isset($_COOKIE[$name])) {
                setcookie($name, '', $opts);
            }
        }
    }
    unset($_COOKIE[GEO_COOKIE], $_COOKIE[GEO_LEGACY_COOKIE]);
    if (geo_session_active()) {
        unset($_SESSION['geo_src']);
    }
}

/**
 * Зберігає місце в профілі залогіненого (mp_user_prefs: лише country_code і place_id; решта налаштувань не змінюється).
 * $value '' — очистити.
 */
function geo_profile_save(PDO $pdo, int $userId, string $value): void
{
    $v = $value !== '' ? geo_from_value($pdo, $value, 'profile') : null;
    $placeId = $v !== null && $v['lat'] !== null ? $v['place_id'] : null;   // у профілі — лише місто або країна
    $cc = $v['country_code'] ?? null;
    $pdo->prepare(
        'INSERT INTO mp_user_prefs (user_id, country_code, place_id) VALUES (:u, :cc, :p)
         ON DUPLICATE KEY UPDATE country_code = VALUES(country_code), place_id = VALUES(place_id)'
    )->execute([':u' => $userId, ':cc' => $cc, ':p' => $placeId]);
}

/** «Львів, Львівська область, Україна» / «Україна» мовою інтерфейсу або '' для невідомого місця. */
function geo_visitor_label(PDO $pdo, array $v, string $lang, bool $short = false): string
{
    if (empty($v['known'])) {
        return '';
    }
    $id = (int) ($v['place_id'] ?? 0);
    if ($id <= 0) {
        $id = (int) (mpg_country_id($pdo, (string) $v['country_code']) ?? 0);
    }
    $l = $id > 0 ? (mpg_labels($pdo, [$id], $lang)[$id] ?? null) : null;
    if ($l === null) {
        return (string) $v['country_code'];
    }

    return $short ? $l['name'] : $l['label'];
}

/** Безпечна адреса повернення: лише відносний шлях цього сайту (сторінка .php з параметрами). */
function geo_safe_back(string $back, string $fallback = 'marketplace.php'): string
{
    $back = ltrim(trim($back), '/');

    return preg_match('#^[a-z0-9][a-z0-9-]*\.php(\?[^\s<>"\'\\\\]*)?(\#[a-z0-9_-]*)?$#i', $back) === 1 ? $back : $fallback;
}

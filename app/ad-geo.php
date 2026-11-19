<?php

declare(strict_types=1);

/**
 * AI LAB HUB — географія показу реклами (країни й міста): правила кампанії, збіг з місцем відвідувача, відбір.
 *
 * Дані — лише нові таблиці (міграція 2026-11-19 № 24), таблиці реклами не змінюються:
 *   ad_campaign_geo (campaign_id, mode include|exclude, place_id → geo_places країна/місто, place_type, country_code,
 *                    radius_km NULL → 25 км, is_active) і ad_campaign_geo_settings (campaign_id, match_mode soft|strict).
 * Кампанія без активних правил показується всім. Платні й власна реклама (campaign_type='internal') — однаково.
 *
 * Збіг (ad_geo_check / ad_geo_match), місце відвідувача — app/geo.php → geo_visitor():
 *   а) правил немає — збіг;
 *   б) місце відоме: будь-який збіг exclude (та сама країна або відстань ≤ радіус) — не показувати; є include —
 *      потрібен збіг хоча б з одним: країна — за country_code; місто — та сама країна й відстань ≤ radius_km (25);
 *      відвідувач знає лише країну, а ціль — місто: soft показує, коли країни збігаються, strict — ні;
 *      exclude-місто при відомій лише країні визначити не можна — не виключає;
 *   в) місце невідоме: soft показує (і з exclude), strict не показує, коли є include;
 *   г) відомі країна й місто відвідувача відрізняються від цілей — не показує в обох режимах.
 * Рішення: ціль-місто збігається лише у своїй країні (радіус через кордон не враховується) — так SQL-відбір за
 * країною відвідувача (adgeo_candidates_sql) і перевірка в PHP завжди дають однаковий результат.
 *
 * Продуктивність: спершу SQL (EXISTS / NOT EXISTS за індексом (campaign_id, is_active, mode, country_code)) у
 * promo_candidates() з кешем 60 с за країною відвідувача, потім радіус у PHP лише для кампаній з правилами в країні
 * відвідувача (adgeo_country_rules, кеш 60 с за країною; індекс (country_code, is_active)). Для невідомого місця SQL
 * уже точний — PHP-крок пропускається. Мова сторінки чи інтерфейсу на збіг за місцем не впливає.
 */

require_once __DIR__ . '/geo.php';

const ADGEO_MODES = ['soft', 'strict'];
const ADGEO_DEFAULT_RADIUS = 25;
const ADGEO_RADII = [5, 10, 25, 50, 100, 200];
const ADGEO_MAX_ROWS = 20;            // правил одного виду на кампанію
const ADGEO_FORM_INCLUDE = 6;         // рядків «Включити» у формі
const ADGEO_FORM_EXCLUDE = 3;         // рядків «Виключити» у формі

function adgeo_e(mixed $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES);
}

/** Чи застосовано міграцію № 24 (і геодовідник). Кеш на запит. */
function adgeo_ready(PDO $pdo, bool $reset = false): bool
{
    static $ready = null;
    if ($ready === null || $reset) {
        try {
            $n = (int) $pdo->query(
                "SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()
                   AND TABLE_NAME IN ('ad_campaign_geo', 'ad_campaign_geo_settings', 'geo_places')"
            )->fetchColumn();
            $ready = $n === 3;
        } catch (Throwable $e) {
            $ready = false;
        }
    }

    return $ready;
}

function adgeo_default_mode(): string
{
    return geo_config()['ad_geo_default_mode'] === 'strict' ? 'strict' : 'soft';
}

/**
 * Активні правила кампаній. @param list<int> $ids
 * @return array<int,list<array{mode:string,place_id:int,type:string,country_code:string,lat:?float,lon:?float,radius_km:int}>>
 */
function adgeo_rules(PDO $pdo, array $ids): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn($v) => $v > 0)));
    if ($ids === [] || !adgeo_ready($pdo)) {
        return [];
    }
    $out = [];
    foreach (array_chunk($ids, 500) as $chunk) {
        $in = implode(',', $chunk);   // лише цілі числа
        $rows = $pdo->query(
            "SELECT g.campaign_id, g.mode, g.place_id, g.place_type, g.country_code, g.radius_km, p.lat, p.lon
             FROM ad_campaign_geo g LEFT JOIN geo_places p ON p.id = g.place_id
             WHERE g.campaign_id IN ($in) AND g.is_active = 1 ORDER BY g.campaign_id, g.mode, g.id"
        )->fetchAll(PDO::FETCH_ASSOC);
        foreach ($rows as $r) {
            $out[(int) $r['campaign_id']][] = [
                'mode' => $r['mode'] === 'exclude' ? 'exclude' : 'include',
                'place_id' => (int) $r['place_id'],
                'type' => $r['place_type'] === 'city' ? 'city' : 'country',
                'country_code' => (string) $r['country_code'],
                'lat' => $r['lat'] !== null ? (float) $r['lat'] : null,
                'lon' => $r['lon'] !== null ? (float) $r['lon'] : null,
                'radius_km' => $r['radius_km'] !== null ? (int) $r['radius_km'] : ADGEO_DEFAULT_RADIUS,
            ];
        }
    }

    return $out;
}

/** Режими кампаній [id => soft|strict] (без рядка — config ad_geo_default_mode). @param list<int> $ids */
function adgeo_modes(PDO $pdo, array $ids): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn($v) => $v > 0)));
    $def = adgeo_default_mode();
    $out = array_fill_keys($ids, $def);
    if ($ids === [] || !adgeo_ready($pdo)) {
        return $out;
    }
    foreach (array_chunk($ids, 500) as $chunk) {
        $in = implode(',', $chunk);
        foreach ($pdo->query("SELECT campaign_id, match_mode FROM ad_campaign_geo_settings WHERE campaign_id IN ($in)")->fetchAll(PDO::FETCH_NUM) as [$cid, $m]) {
            $out[(int) $cid] = $m === 'strict' ? 'strict' : 'soft';
        }
    }

    return $out;
}

/**
 * Збіг кампанії з місцем відвідувача і причина (для сторінки «Перевірка таргетингу»).
 * $rules — правила однієї кампанії (adgeo_rules()[id] ?? []), $visitor — geo_visitor(), $mode — soft|strict.
 *
 * @return array{0:bool,1:string} [показувати, ключ причини adgeo_why_*]
 */
function ad_geo_check(array $rules, array $visitor, string $mode): array
{
    if ($rules === []) {
        return [true, 'no_rules'];
    }
    $strict = $mode === 'strict';
    $inc = array_values(array_filter($rules, static fn($r) => $r['mode'] === 'include'));
    $exc = array_values(array_filter($rules, static fn($r) => $r['mode'] === 'exclude'));
    $cc = !empty($visitor['known']) ? strtoupper((string) ($visitor['country_code'] ?? '')) : '';
    if ($cc === '') {
        if ($inc === []) {
            return [true, 'unknown_exclude_only'];
        }

        return $strict ? [false, 'unknown_strict'] : [true, 'unknown_soft'];
    }
    $hasPoint = isset($visitor['lat'], $visitor['lon']) && $visitor['lat'] !== null && $visitor['lon'] !== null;
    $inRadius = static function (array $r) use ($visitor, $cc, $hasPoint): bool {
        return $hasPoint && $r['country_code'] === $cc && $r['lat'] !== null && $r['lon'] !== null
            && mpg_distance_km((float) $visitor['lat'], (float) $visitor['lon'], $r['lat'], $r['lon']) <= max(1, (int) $r['radius_km']);
    };
    foreach ($exc as $r) {
        if ($r['type'] === 'country' && $r['country_code'] === $cc) {
            return [false, 'excluded_country'];
        }
        if ($r['type'] === 'city' && $inRadius($r)) {
            return [false, 'excluded_city'];
        }
    }
    if ($inc === []) {
        return [true, 'not_excluded'];
    }
    $softCountry = false;
    foreach ($inc as $r) {
        if ($r['type'] === 'country' && $r['country_code'] === $cc) {
            return [true, 'included_country'];
        }
        if ($r['type'] === 'city') {
            if ($inRadius($r)) {
                return [true, 'included_city'];
            }
            if (!$hasPoint && $r['country_code'] === $cc) {
                $softCountry = true;
            }
        }
    }
    if ($softCountry) {
        return $strict ? [false, 'country_only_strict'] : [true, 'country_only_soft'];
    }

    return [false, $hasPoint ? 'outside' : 'other_country'];
}

/** Спрощена форма: лише рішення. */
function ad_geo_match(array $rules, array $visitor, string $mode): bool
{
    return ad_geo_check($rules, $visitor, $mode)[0];
}

/**
 * Умова SQL для promo_candidates_sql() (alias кампанії c): попередній відбір за країною відвідувача.
 * Точну перевірку радіуса робить PHP (ad_geo_check) лише для кампаній з has_geo = 1.
 *
 * @param array<string,mixed> $params доповнюється
 */
function adgeo_candidates_sql(?string $country, array &$params): string
{
    $act = 'g.campaign_id = c.id AND g.is_active = 1';
    if ($country !== null && preg_match('/^[A-Z]{2}$/', $country) === 1) {
        $params[':geo_cc1'] = $country;
        $params[':geo_cc2'] = $country;

        return "AND NOT EXISTS (SELECT 1 FROM ad_campaign_geo g WHERE $act AND g.mode = 'exclude' AND g.country_code = :geo_cc1 AND g.place_type = 'country')
              AND (NOT EXISTS (SELECT 1 FROM ad_campaign_geo g WHERE $act AND g.mode = 'include')
                   OR EXISTS (SELECT 1 FROM ad_campaign_geo g WHERE $act AND g.mode = 'include' AND g.country_code = :geo_cc2))";
    }
    $params[':geo_dm'] = adgeo_default_mode();

    return "AND (NOT EXISTS (SELECT 1 FROM ad_campaign_geo g WHERE $act AND g.mode = 'include')
                 OR COALESCE((SELECT s.match_mode FROM ad_campaign_geo_settings s WHERE s.campaign_id = c.id), :geo_dm) = 'soft')";
}

/** Колонка «є правила» для SELECT кандидатів. */
function adgeo_has_geo_sql(): string
{
    return 'EXISTS (SELECT 1 FROM ad_campaign_geo g0 WHERE g0.campaign_id = c.id AND g0.is_active = 1) AS has_geo';
}

/**
 * Правила, що стосуються відвідувачів країни $cc: лише рядки з country_code = $cc (міста-цілі інших країн не
 * збігаються за визначенням, а країни-цілі вже враховано в SQL). Кеш 60 с за країною (той самий кеш, що й
 * кандидати; promo_cache_flush() після змін географії скидає його).
 *
 * @return array<int,array{mode:string,rules:list<array<string,mixed>>}> campaign_id => режим і правила
 */
function adgeo_country_rules(PDO $pdo, string $cc): array
{
    if (preg_match('/^[A-Z]{2}$/', $cc) !== 1) {
        return [];
    }
    $def = adgeo_default_mode();
    $build = static function () use ($pdo, $cc, $def): array {
        $st = $pdo->prepare(
            "SELECT g.campaign_id, g.mode, g.place_id, g.place_type, g.country_code, g.radius_km, p.lat, p.lon, s.match_mode
             FROM ad_campaign_geo g
             LEFT JOIN geo_places p ON p.id = g.place_id
             LEFT JOIN ad_campaign_geo_settings s ON s.campaign_id = g.campaign_id
             WHERE g.country_code = :cc AND g.is_active = 1"
        );
        $st->execute([':cc' => $cc]);
        $out = [];
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $cid = (int) $r['campaign_id'];
            $out[$cid]['mode'] = ($r['match_mode'] ?? $def) === 'strict' ? 'strict' : 'soft';
            $out[$cid]['rules'][] = [
                'mode' => $r['mode'] === 'exclude' ? 'exclude' : 'include',
                'place_id' => (int) $r['place_id'],
                'type' => $r['place_type'] === 'city' ? 'city' : 'country',
                'country_code' => (string) $r['country_code'],
                'lat' => $r['lat'] !== null ? (float) $r['lat'] : null,
                'lon' => $r['lon'] !== null ? (float) $r['lon'] : null,
                'radius_km' => $r['radius_km'] !== null ? (int) $r['radius_km'] : ADGEO_DEFAULT_RADIUS,
            ];
        }

        return $out;
    };
    if (!function_exists('promo_cache_remember')) {
        return $build();
    }

    return promo_cache_remember('adgeo|' . $cc . '|' . $def, defined('PROMO_CANDIDATES_TTL') ? PROMO_CANDIDATES_TTL : 60, $build);
}

/**
 * Фільтр PHP над кандидатами promo_candidates() (вони вже пройшли SQL-відбір за країною відвідувача):
 *   місце невідоме — SQL уже точний (лише режим і наявність include), нічого не робимо;
 *   місце відоме — для кампаній з правилами в країні відвідувача: радіус міст і soft/strict (ad_geo_match).
 * Результат той самий, що ad_geo_check() з усіма правилами кампанії (див. tests/geo_match_test.php).
 *
 * @param list<array<string,mixed>> $rows
 * @return list<array<string,mixed>>
 */
function adgeo_filter_rows(PDO $pdo, array $rows, array $visitor): array
{
    $cc = !empty($visitor['known']) ? strtoupper((string) ($visitor['country_code'] ?? '')) : '';
    if ($cc === '' || $rows === []) {
        return $rows;
    }
    $local = null;
    $ok = [];
    $out = [];
    foreach ($rows as $r) {
        if (empty($r['has_geo'])) {
            $out[] = $r;
            continue;
        }
        $local ??= adgeo_country_rules($pdo, $cc);
        $cid = (int) $r['campaign_id'];
        $entry = $local[$cid] ?? null;
        // Правил у цій країні немає: SQL уже гарантував, що include тут немає взагалі (лише винятки деінде).
        $ok[$cid] ??= $entry === null || ad_geo_match($entry['rules'], $visitor, $entry['mode']);
        if ($ok[$cid]) {
            $out[] = $r;
        }
    }

    return $out;
}

// --- Збереження ----------------------------------------------------------------------

/**
 * Розбір POST блоку «Географія показу». Порожні рядки пропускаються; місце — лише країна або місто з довідника.
 * @return array{include:list<array{place_id:int,radius_km:?int}>,exclude:list<array{place_id:int,radius_km:?int}>,mode:string,errors:list<string>}
 */
function adgeo_from_post(PDO $pdo, array $post): array
{
    $errors = [];
    $read = static function (string $kind) use ($pdo, $post, &$errors): array {
        $ids = is_array($post['geo_' . $kind] ?? null) ? $post['geo_' . $kind] : [];
        $rad = is_array($post['geo_' . $kind . '_r'] ?? null) ? $post['geo_' . $kind . '_r'] : [];
        $out = [];
        foreach ($ids as $i => $raw) {
            $raw = is_string($raw) ? trim($raw) : '';
            if ($raw === '') {
                continue;
            }
            $p = ctype_digit($raw) && strlen($raw) <= 10 ? mpg_place($pdo, (int) $raw) : null;
            if ($p === null || !in_array($p['type'], ['country', 'city'], true)) {
                $errors[] = 'adgeo_err_place';
                continue;
            }
            $r = is_string($rad[$i] ?? null) && ctype_digit((string) $rad[$i]) ? (int) $rad[$i] : 0;
            $out[$p['id']] = ['place_id' => $p['id'], 'radius_km' => $p['type'] === 'city' && in_array($r, ADGEO_RADII, true) ? $r : null];
        }
        if (count($out) > ADGEO_MAX_ROWS) {
            $errors[] = 'adgeo_err_too_many';
            $out = array_slice($out, 0, ADGEO_MAX_ROWS, true);
        }

        return $out;
    };
    $inc = $read('inc');
    $exc = $read('exc');
    if (array_intersect_key($inc, $exc) !== []) {
        $errors[] = 'adgeo_err_both';
        $exc = array_diff_key($exc, $inc);
    }
    $mode = ($post['geo_mode'] ?? '') === 'strict' ? 'strict' : (($post['geo_mode'] ?? '') === 'soft' ? 'soft' : adgeo_default_mode());

    return ['include' => array_values($inc), 'exclude' => array_values($exc), 'mode' => $mode, 'errors' => array_values(array_unique($errors))];
}

/**
 * Записує правила кампанії: попередні вимикаються (is_active = 0, без DELETE), подані — вмикаються/додаються.
 * Статус кампанії й модерацію не змінює. Скидає кеш кандидатів реклами.
 */
function adgeo_save(PDO $pdo, int $campaignId, array $include, array $exclude, string $mode): bool
{
    if ($campaignId <= 0 || !adgeo_ready($pdo)) {
        return false;
    }
    $own = !$pdo->inTransaction();
    if ($own) {
        $pdo->beginTransaction();
    }
    try {
        $pdo->prepare('UPDATE ad_campaign_geo SET is_active = 0 WHERE campaign_id = :c AND is_active = 1')->execute([':c' => $campaignId]);
        $ins = $pdo->prepare(
            'INSERT INTO ad_campaign_geo (campaign_id, mode, place_id, place_type, country_code, radius_km, is_active)
             VALUES (:c, :m, :p, :t, :cc, :r, 1)
             ON DUPLICATE KEY UPDATE place_type = VALUES(place_type), country_code = VALUES(country_code),
                                     radius_km = VALUES(radius_km), is_active = 1'
        );
        foreach (['include' => $include, 'exclude' => $exclude] as $m => $list) {
            foreach ($list as $row) {
                $p = mpg_place($pdo, (int) $row['place_id']);
                if ($p === null || !in_array($p['type'], ['country', 'city'], true)) {
                    continue;
                }
                $ins->execute([':c' => $campaignId, ':m' => $m, ':p' => $p['id'], ':t' => $p['type'], ':cc' => $p['country_code'],
                    ':r' => $p['type'] === 'city' && in_array((int) ($row['radius_km'] ?? 0), ADGEO_RADII, true) ? (int) $row['radius_km'] : null]);
            }
        }
        $pdo->prepare('INSERT INTO ad_campaign_geo_settings (campaign_id, match_mode) VALUES (:c, :m)
                       ON DUPLICATE KEY UPDATE match_mode = VALUES(match_mode)')
            ->execute([':c' => $campaignId, ':m' => $mode === 'strict' ? 'strict' : 'soft']);
        if ($own) {
            $pdo->commit();
        }
    } catch (Throwable $e) {
        if ($own && $pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('[adgeo] save: ' . $e->getMessage());

        return false;
    }
    if (function_exists('promo_cache_flush')) {
        promo_cache_flush();
    }

    return true;
}

/** Копія правил і режиму (для «Дублювати» кампанію). */
function adgeo_copy(PDO $pdo, int $fromId, int $toId): void
{
    if (!adgeo_ready($pdo) || $fromId <= 0 || $toId <= 0) {
        return;
    }
    $rules = adgeo_rules($pdo, [$fromId])[$fromId] ?? [];
    $mode = adgeo_modes($pdo, [$fromId])[$fromId] ?? adgeo_default_mode();
    $hasSettings = (int) $pdo->query('SELECT COUNT(*) FROM ad_campaign_geo_settings WHERE campaign_id = ' . (int) $fromId)->fetchColumn() > 0;
    if ($rules === [] && !$hasSettings) {
        return;
    }
    $pick = static fn(string $m): array => array_values(array_map(static fn($r) => ['place_id' => $r['place_id'], 'radius_km' => $r['type'] === 'city' ? $r['radius_km'] : null],
        array_filter($rules, static fn($r) => $r['mode'] === $m)));
    adgeo_save($pdo, $toId, $pick('include'), $pick('exclude'), $mode);
}

// --- Вивід ---------------------------------------------------------------------------

/** Підпис одного правила: країна — код; місто — назва + радіус. */
function adgeo_rule_text(array $r, array $labels): string
{
    if ($r['type'] === 'country') {
        return $r['country_code'];
    }
    $name = $labels[$r['place_id']]['name'] ?? ('#' . $r['place_id']);

    return $name . ' +' . (int) $r['radius_km'] . "\u{00A0}" . t('mpg_unit_km');
}

/** Підсумок для списку кампаній: «AU · Canberra +25 км, м'який» / «Усі країни». */
function adgeo_summary(PDO $pdo, int $campaignId, string $lang, ?array $rules = null, ?string $mode = null): string
{
    if (!adgeo_ready($pdo)) {
        return '';
    }
    $rules ??= adgeo_rules($pdo, [$campaignId])[$campaignId] ?? [];
    if ($rules === []) {
        return t('adgeo_everywhere');
    }
    $mode ??= adgeo_modes($pdo, [$campaignId])[$campaignId] ?? adgeo_default_mode();
    $labels = mpg_labels($pdo, array_map(static fn($r) => $r['place_id'], $rules), $lang);
    $inc = [];
    $exc = [];
    foreach ($rules as $r) {
        if ($r['mode'] === 'include') {
            $inc[] = adgeo_rule_text($r, $labels);
        } else {
            $exc[] = adgeo_rule_text($r, $labels);
        }
    }
    $txt = $inc !== [] ? implode(' · ', $inc) : t('adgeo_everywhere');
    if ($exc !== []) {
        $txt .= ' · ' . t('adgeo_except') . ' ' . implode(', ', $exc);
    }

    return $txt . ', ' . t('adgeo_mode_short_' . $mode);
}

/**
 * Блок «Географія показу» (fieldset) для форми кампанії. Поля: geo_inc[], geo_inc_r[], geo_exc[], geo_exc_r[], geo_mode.
 * Підключає автопідказку (mp-geo.js → geo-suggest.php) і стилі mp-geo.css.
 */
function adgeo_form_html(PDO $pdo, ?int $campaignId, string $lang): string
{
    if (!adgeo_ready($pdo)) {
        return '';
    }
    require_once __DIR__ . '/marketplace.php';     // mp_e() для mpg_picker_html()
    require_once __DIR__ . '/mp-geo-form.php';
    $rules = $campaignId !== null && $campaignId > 0 ? (adgeo_rules($pdo, [$campaignId])[$campaignId] ?? []) : [];
    $mode = $campaignId !== null && $campaignId > 0 ? (adgeo_modes($pdo, [$campaignId])[$campaignId] ?? adgeo_default_mode()) : adgeo_default_mode();
    $labels = mpg_labels($pdo, array_map(static fn($r) => $r['place_id'], $rules), $lang);
    $byMode = ['inc' => [], 'exc' => []];
    foreach ($rules as $r) {
        $byMode[$r['mode'] === 'include' ? 'inc' : 'exc'][] = $r;
    }
    $rows = static function (string $kind, int $n) use ($byMode, $labels, $lang): string {
        $list = $byMode[$kind];
        $n = max($n, count($list) + 1);
        $h = '';
        for ($i = 0; $i < $n; $i++) {
            $r = $list[$i] ?? null;
            $pid = $r['place_id'] ?? 0;
            $cur = $r !== null && $r['type'] === 'city' ? (int) $r['radius_km'] : 0;
            $aria = sprintf(t('adgeo_place_n'), $i + 1);
            $sel = '<select class="mp-input mp-input--short" name="geo_' . $kind . '_r[' . $i . ']" aria-label="' . adgeo_e(t('adgeo_radius')) . '">'
                . '<option value="">' . adgeo_e(sprintf(t('adgeo_radius_default'), ADGEO_DEFAULT_RADIUS)) . '</option>';
            foreach (ADGEO_RADII as $rv) {
                $sel .= '<option value="' . $rv . '"' . ($cur === $rv && $rv !== ADGEO_DEFAULT_RADIUS ? ' selected' : '') . '>+' . $rv . ' ' . adgeo_e(t('mpg_unit_km')) . '</option>';
            }
            $sel .= '</select>';
            $h .= '<div class="mp-inline mp-geo-extra__row adgeo-row">'
                . mpg_picker_html('geo_' . $kind . '[' . $i . ']', $pid > 0 ? (string) $pid : '', $pid > 0 ? ($labels[$pid]['label'] ?? '') : '', 'any', $lang, 'adgeo_' . $kind . '_' . $i, $aria)
                . $sel . '</div>';
        }

        return $h;
    };
    $chk = static fn(bool $on): string => $on ? ' checked' : '';

    return '<link rel="stylesheet" href="/assets/css/mp-geo.css?v=' . (int) @filemtime(__DIR__ . '/../public/assets/css/mp-geo.css') . '">'
        . '<fieldset class="pc-field adgeo" data-adgeo>'
        . '<legend><strong>' . adgeo_e(t('adgeo_title')) . '</strong></legend>'
        . '<p class="pc-muted">' . adgeo_e(t('adgeo_hint')) . '</p>'
        . '<p class="pc-muted"><strong>' . adgeo_e(t('adgeo_include')) . '</strong> — ' . adgeo_e(t('adgeo_include_hint')) . '</p>'
        . '<div class="mp-geo-extra">' . $rows('inc', ADGEO_FORM_INCLUDE) . '</div>'
        . '<p class="pc-muted"><strong>' . adgeo_e(t('adgeo_exclude')) . '</strong> — ' . adgeo_e(t('adgeo_exclude_hint')) . '</p>'
        . '<div class="mp-geo-extra">' . $rows('exc', ADGEO_FORM_EXCLUDE) . '</div>'
        . '<p class="pc-muted"><strong>' . adgeo_e(t('adgeo_mode')) . '</strong></p>'
        . '<label class="pc-check"><input type="radio" name="geo_mode" value="soft"' . $chk($mode === 'soft') . '> <span>' . adgeo_e(t('adgeo_mode_soft')) . '</span></label>'
        . '<label class="pc-check"><input type="radio" name="geo_mode" value="strict"' . $chk($mode === 'strict') . '> <span>' . adgeo_e(t('adgeo_mode_strict')) . '</span></label>'
        . '<p class="pc-muted">' . adgeo_e(t('adgeo_reach_na')) . '</p>'
        . '<p class="pc-muted adgeo-credit">Geo data: <a href="https://www.geonames.org/" rel="noopener" target="_blank">GeoNames</a> (<a href="https://creativecommons.org/licenses/by/4.0/" rel="noopener license" target="_blank">CC BY 4.0</a>)</p>'
        . '</fieldset>'
        . '<script src="/assets/js/mp-geo.js?v=' . (int) @filemtime(__DIR__ . '/../public/assets/js/mp-geo.js') . '" defer></script>';
}

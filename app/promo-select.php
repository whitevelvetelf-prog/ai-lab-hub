<?php

declare(strict_types=1);

/**
 * AI LAB HUB — масштабований відбір реклами (з 2026-10-21): тисячі рекламодавців одночасно.
 *
 *   1. promo_candidates — допустимі креативи для місця + категорії + підкатегорії + мови +
 *      пристрою + розділу маркетплейсу: один індексований запит БЕЗ ORDER BY RAND(), лише
 *      легкі колонки; результат кешується на PROMO_CANDIDATES_TTL с (APCu, якщо є, інакше
 *      файли в storage/cache/promo). Сесійних умов у кеші немає — він спільний для всіх.
 *   2. promo_pick_set — фільтри сеансу в PHP (уже на сторінці, ліміт показів кампанії за
 *      добу, власна реклама) і зважений випадковий вибір без повторів до $n креативів:
 *      спершу платні (вага = ad_creatives.weight × рівномірність бюджету), вільні місця —
 *      власна реклама (internal). Останні ~20 показаних цьому сеансу креативів — у кінці черги.
 *   3. Повні дані лише обраних креативів — другим запитом за id.
 *
 * Стан сеансу (без персональних даних, у $_SESSION['promo'][відбиток сеансу]):
 *   recent — останні PROMO_RECENT_KEEP показаних креативів (знижений пріоритет);
 *   caps   — покази кампаній за київську добу (ліміт frequency_cap_per_session / house_frequency_cap);
 *   seen   — час останнього зарахованого показу / перегляду креативу (відсікання дублів);
 *   rate   — події за поточну хвилину (ліміт PROMO_EVENTS_PER_MINUTE).
 * Сирі покази й перегляди в БД більше не пишуться (лише агрегати ad_stats_daily); кліки —
 * як і раніше в ad_events (захист від накрутки).
 */

/** Скільки секунд живе кеш списку кандидатів. */
const PROMO_CANDIDATES_TTL = 60;
/** Верхня межа кандидатів одного ключа (легкі рядки; більше — випадкова вибірка в SQL не потрібна). */
const PROMO_CANDIDATES_MAX = 20000;
/** Скільки креативів крутиться в одному слоті за завантаження сторінки. */
const PROMO_ROTATION_SIZE = 5;
/** Скільки останніх показаних креативів сеансу мають знижений пріоритет. */
const PROMO_RECENT_KEEP = 20;

/** Колонка є в таблиці (міграції застосовуються на хостингу окремо) — кеш на запит. */
function promo_has_column(PDO $pdo, string $table, string $column): bool
{
    static $cache = [];
    $key = $table . '.' . $column;
    if (!isset($cache[$key])) {
        try {
            $st = $pdo->prepare('SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t AND COLUMN_NAME = :c');
            $st->execute([':t' => $table, ':c' => $column]);
            $cache[$key] = (int) $st->fetchColumn() > 0;
        } catch (Throwable $e) {
            $cache[$key] = false;
        }
    }

    return $cache[$key];
}

// --- Кеш -------------------------------------------------------------------

function promo_cache_dir(): string
{
    return __DIR__ . '/../storage/cache/promo';
}

function promo_cache_apcu(): bool
{
    static $on = null;
    if ($on === null) {
        $on = function_exists('apcu_fetch') && function_exists('apcu_enabled') && apcu_enabled();
    }

    return $on;
}

/** Покоління кешу: promo_cache_flush() збільшує його, і всі старі ключі одразу неактуальні. */
function promo_cache_generation(bool $reload = false): int
{
    static $gen = null;
    if ($gen !== null && !$reload) {
        return $gen;
    }
    if (promo_cache_apcu()) {
        $v = apcu_fetch('promo:gen');
        $gen = is_int($v) ? $v : 0;
    } else {
        $raw = @file_get_contents(promo_cache_dir() . '/gen');
        $gen = $raw !== false ? (int) $raw : 0;
    }

    return $gen;
}

/** Скинути кеш кандидатів (зміни кампаній в адмінці/кабінеті, зупинка кампанії системою). */
function promo_cache_flush(): void
{
    try {
        if (promo_cache_apcu()) {
            if (!apcu_add('promo:gen', 1)) {
                apcu_inc('promo:gen');
            }
        } else {
            $dir = promo_cache_dir();
            if (!is_dir($dir)) {
                @mkdir($dir, 0775, true);
            }
            $raw = @file_get_contents($dir . '/gen');
            @file_put_contents($dir . '/gen', (string) (((int) $raw) + 1), LOCK_EX);
        }
    } catch (Throwable $e) {
        error_log('[promo] cache flush: ' . $e->getMessage());
    }
    promo_cache_generation(true);
}

/**
 * Значення з кешу або $build() (і запис у кеш на $ttl с). Збій кешу ніколи не ламає
 * показ — тоді просто запит у БД.
 *
 * @template T
 * @param callable():T $build
 * @return T
 */
function promo_cache_remember(string $key, int $ttl, callable $build): mixed
{
    $full = 'promo:' . promo_cache_generation() . ':' . $key;
    if (promo_cache_apcu()) {
        $hit = false;
        $v = apcu_fetch($full, $hit);
        if ($hit) {
            return $v;
        }
        $v = $build();
        apcu_store($full, $v, $ttl);

        return $v;
    }

    // Файли: serialize (у 2–3 рази швидше за json_decode), без об'єктів при читанні.
    $dir = promo_cache_dir();
    $file = $dir . '/' . sha1($full) . '.cache';
    $mtime = @filemtime($file);
    if ($mtime !== false && $mtime > time() - $ttl) {
        $raw = @file_get_contents($file);
        $v = $raw !== false ? @unserialize($raw, ['allowed_classes' => false]) : false;
        if (is_array($v) && array_key_exists('v', $v)) {
            return $v['v'];
        }
    }
    $v = $build();
    if (!is_dir($dir)) {
        @mkdir($dir, 0775, true);
    }
    $tmp = $file . '.' . bin2hex(random_bytes(4)) . '.tmp';
    if (@file_put_contents($tmp, serialize(['v' => $v])) !== false) {
        @rename($tmp, $file);
    }

    return $v;
}

/** Cron: прибрати файли кешу, старші за годину (APCu чиститься сам). */
function promo_cache_gc(): int
{
    $n = 0;
    foreach (glob(promo_cache_dir() . '/*.{cache,tmp}', GLOB_BRACE) ?: [] as $f) {
        if (@filemtime($f) < time() - 3600 && @unlink($f)) {
            $n++;
        }
    }

    return $n;
}

// --- Кандидати --------------------------------------------------------------

/**
 * Допустимі креативи (легкі рядки) для місця й контексту сторінки — з кешу на 60 с.
 * Умови як у старому promo_pick: система ввімкнена, кампанія video/active, креатив approved,
 * сьогодні в межах дат, не вичерпано бюджети, є баланс (власна — без білінгу), збіг таргету,
 * правила категорій реклами сторінки.
 *
 * @param list<int> $categoryIds  уже з таксономією продукту, якщо це сторінка продукту
 * @param list<int> $subcategoryIds
 * @param list<string> $mpSections розділи маркетплейсу ([] — не маркетплейс або без розділу)
 * @return list<array<string,mixed>>
 */
function promo_candidates(PDO $pdo, string $placement, array $categoryIds, array $subcategoryIds, string $lang, string $device, array $mpSections = []): array
{
    $isMp = promo_placement_is_marketplace($pdo, $placement);
    $cats = array_values(array_unique(array_map('intval', $categoryIds)));
    $subs = array_values(array_unique(array_map('intval', $subcategoryIds)));
    sort($cats);
    sort($subs);
    $mp = array_values(array_filter($mpSections, static fn($v) => is_string($v) && promo_mp_section_valid($v)));
    sort($mp);
    $today = promo_today();
    $key = implode('|', [$placement, implode(',', $cats), implode(',', $subs), $lang, $device, $isMp ? 'mp:' . implode(',', $mp) : '', $today]);

    return promo_cache_remember($key, PROMO_CANDIDATES_TTL, static function () use ($pdo, $placement, $cats, $subs, $lang, $device, $mp, $isMp, $today): array {
        [$sql, $params] = promo_candidates_sql($pdo, $placement, $cats, $subs, $lang, $device, $mp, $isMp, $today);

        try {
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Throwable $e) {
            error_log('[promo] candidates: ' . $e->getMessage());

            return [];
        }
        $out = [];
        foreach ($rows as $r) {
            $out[] = [
                'id' => (int) $r['id'],
                'campaign_id' => (int) $r['campaign_id'],
                'internal' => $r['campaign_type'] === 'internal',
                'total_budget' => $r['total_budget'] !== null ? (int) $r['total_budget'] : null,
                'spent' => (int) $r['spent'],
                'end_date' => $r['end_date'],
                'balance' => (int) $r['balance'],
                'weight' => max(0, (int) ($r['weight'] ?? 1)),
                'house_rules' => $r['house_rules'] ?? null,
            ];
        }

        return $out;
    });
}

/**
 * SQL і параметри запиту кандидатів (окремо — для EXPLAIN у tools/promo-load-test.php).
 *
 * @param list<int> $cats
 * @param list<int> $subs
 * @param list<string> $mp
 * @return array{0:string,1:array<string,mixed>}
 */
function promo_candidates_sql(PDO $pdo, string $placement, array $cats, array $subs, string $lang, string $device, array $mp, bool $isMp, string $today): array
{
    $params = [':lang' => $lang, ':dev' => $device, ':today1' => $today, ':today2' => $today, ':today3' => $today];
    $plNames = [];
    foreach (promo_placement_match_keys($placement) as $i => $k) {
        $plNames[] = ':pl' . $i;
        $params[':pl' . $i] = $k;
    }
    $inList = static function (string $prefix, array $ids) use (&$params): string {
        $names = [];
        foreach ($ids as $i => $id) {
            $names[] = ':' . $prefix . $i;
            $params[':' . $prefix . $i] = $id;
        }

        return implode(',', $names);
    };
    $catCond = $cats !== [] ? '(t.category_id IS NULL OR t.category_id IN (' . $inList('c', $cats) . '))' : 't.category_id IS NULL';
    $subCond = $subs !== [] ? '(t.subcategory_id IS NULL OR t.subcategory_id IN (' . $inList('s', $subs) . '))' : 't.subcategory_id IS NULL';
    $mpCond = '';
    if ($isMp) {
        $mpCond = 'AND ' . ($mp !== [] ? '(t.mp_section IS NULL OR t.mp_section IN (' . $inList('m', $mp) . '))' : 't.mp_section IS NULL');
    }
    $house = promo_house_columns($pdo);
    $houseCols = $house ? ', cr.weight, c.house_rules' : '';

    // Індекси: ad_campaigns (format, status, …) / (status, campaign_type, start_date, end_date),
    // ad_creatives (campaign_id, status), ad_targets (campaign_id, placement, …), ad_stats_daily (campaign_id, stat_date).
    $sql = "SELECT cr.id, cr.campaign_id, c.campaign_type, c.total_budget, c.spent, c.end_date,
                   COALESCE(b.balance, 0) AS balance{$houseCols}
            FROM ad_campaigns c
            JOIN ad_creatives cr ON cr.campaign_id = c.id AND cr.status = 'approved'
            LEFT JOIN ad_balances b ON b.user_id = c.user_id
            WHERE c.format = 'video'
              AND c.status = 'active'
              AND (c.start_date IS NULL OR c.start_date <= :today1)
              AND (c.end_date IS NULL OR c.end_date >= :today2)
              AND (
                    c.campaign_type = 'internal'
                 OR (    c.unit_price IS NOT NULL AND c.unit_price > 0
                     AND c.pricing_model IS NOT NULL
                     AND COALESCE(b.balance, 0) > 0
                     AND b.currency = c.currency
                     AND (c.total_budget IS NULL OR c.spent < c.total_budget)
                     AND (c.daily_budget IS NULL
                          OR (SELECT COALESCE(SUM(sd.spend), 0) FROM ad_stats_daily sd
                              WHERE sd.campaign_id = c.id AND sd.stat_date = :today3) < c.daily_budget))
              )
              AND EXISTS (
                    SELECT 1 FROM ad_targets t
                    WHERE t.campaign_id = c.id
                      AND t.placement IN (" . implode(',', $plNames) . ")
                      AND {$catCond}
                      AND {$subCond}
                      {$mpCond}
                      AND (t.language IS NULL OR t.language = :lang)
                      AND (t.device IS NULL OR t.device = :dev)
              )
              AND " . promo_rules_sql($cats, $subs) . '
            LIMIT ' . PROMO_CANDIDATES_MAX;

    return [$sql, $params];
}

// --- Стан сеансу ------------------------------------------------------------

/** @return array<string,mixed> посилання на стан реклами цього сеансу */
function &promo_session_state(string $sessionHash): array
{
    if (!isset($_SESSION) || !is_array($_SESSION)) {
        $_SESSION = [];
    }
    $k = substr($sessionHash, 0, 16);
    if (!isset($_SESSION['promo'][$k]) || !is_array($_SESSION['promo'][$k])) {
        // Інший відбиток (нова IP) — старий стан не потрібен.
        $_SESSION['promo'] = [$k => ['recent' => [], 'caps' => ['d' => '', 'c' => []], 'seen' => [], 'rate' => [0, 0]]];
    }

    return $_SESSION['promo'][$k];
}

/** Покази кампаній цьому сеансу за поточну київську добу: [campaign_id => n]. */
function promo_session_caps(string $sessionHash): array
{
    $st = &promo_session_state($sessionHash);

    return ($st['caps']['d'] ?? '') === promo_today() ? (array) $st['caps']['c'] : [];
}

/** Останні показані креативи сеансу (новіші — в кінці). */
function promo_session_recent(string $sessionHash): array
{
    $st = &promo_session_state($sessionHash);

    return array_map('intval', (array) ($st['recent'] ?? []));
}

/**
 * Зарахувати подію в стані сеансу. false — подію відкинуто: понад PROMO_EVENTS_PER_MINUTE
 * подій за хвилину, дубль (той самий креатив і тип за $dedupSec с) або перегляд без показу.
 */
function promo_session_event(string $sessionHash, int $creativeId, int $campaignId, string $type, int $dedupSec): bool
{
    $st = &promo_session_state($sessionHash);
    $now = time();

    $minute = intdiv($now, 60);
    if ((int) ($st['rate'][0] ?? 0) !== $minute) {
        $st['rate'] = [$minute, 0];
    }
    if ((int) $st['rate'][1] >= PROMO_EVENTS_PER_MINUTE) {
        return false;
    }
    $st['rate'][1] = (int) $st['rate'][1] + 1;

    $seen = (array) ($st['seen'] ?? []);
    foreach ($seen as $k => $ts) {
        if ($ts < $now - PROMO_TOKEN_TTL) {
            unset($seen[$k]);
        }
    }
    if (isset($seen[$type . ':' . $creativeId]) && $seen[$type . ':' . $creativeId] > $now - $dedupSec) {
        $st['seen'] = $seen;

        return false;
    }
    if ($type === 'view' && !isset($seen['impression:' . $creativeId])) {
        $st['seen'] = $seen;

        return false;
    }
    $seen[$type . ':' . $creativeId] = $now;
    $st['seen'] = $seen;

    if ($type === 'impression') {
        if (($st['caps']['d'] ?? '') !== promo_today()) {
            $st['caps'] = ['d' => promo_today(), 'c' => []];
        }
        $st['caps']['c'][$campaignId] = (int) ($st['caps']['c'][$campaignId] ?? 0) + 1;
        $recent = array_values(array_filter((array) ($st['recent'] ?? []), static fn($id) => (int) $id !== $creativeId));
        $recent[] = $creativeId;
        $st['recent'] = array_slice($recent, -PROMO_RECENT_KEEP);
    }

    return true;
}

// --- Вибір ------------------------------------------------------------------

/**
 * Зважений випадковий вибір без повторів: до $n елементів $pool за вагою $weightOf.
 *
 * @param list<array<string,mixed>> $pool
 * @return list<array<string,mixed>>
 */
function promo_weighted_sample(array $pool, int $n, callable $weightOf): array
{
    $out = [];
    $weights = array_map(static fn($r) => max(0.0, (float) $weightOf($r)), $pool);
    while ($pool !== [] && count($out) < $n) {
        $sum = array_sum($weights);
        if ($sum <= 0) {
            // Усі ваги нульові — рівномірно.
            $weights = array_fill_keys(array_keys($pool), 1.0);
            $sum = (float) count($pool);
        }
        $roll = mt_rand() / mt_getrandmax() * $sum;
        $pick = array_key_last($pool);
        foreach ($weights as $i => $w) {
            $roll -= $w;
            if ($roll <= 0) {
                $pick = $i;
                break;
            }
        }
        $out[] = $pool[$pick];
        unset($pool[$pick], $weights[$pick]);
    }

    return $out;
}

/**
 * До $n креативів для слота (порядок ротації), повні рядки як у старому promo_pick.
 * [] — реклами немає. Див. опис файлу.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 * @param list<int> $excludeCreatives уже на цій сторінці
 * @return list<array<string,mixed>>
 */
function promo_pick_set(PDO $pdo, string $placement, array $categoryIds, array $subcategoryIds, string $lang, string $device, string $sessionHash, array $page = [], array $excludeCreatives = [], int $n = PROMO_ROTATION_SIZE): array
{
    if (!in_array($placement, PROMO_PLACEMENTS, true) || !promo_video_ready($pdo) || !promo_placement_available($pdo, $placement)) {
        return [];
    }
    $isMp = promo_placement_is_marketplace($pdo, $placement);
    if ($isMp) {
        // Категорії каталогу (і правила категорій реклами для них) до маркетплейсу не застосовуються.
        $categoryIds = [];
        $subcategoryIds = [];
    }
    if (promo_page_excluded($pdo, $categoryIds, $subcategoryIds, $page) !== null) {
        return [];
    }
    if (!empty($page['product'])) {
        [$pc, $ps] = promo_product_taxonomy($pdo, (int) $page['product']);
        $categoryIds = array_values(array_unique(array_merge($categoryIds, $pc)));
        $subcategoryIds = array_values(array_unique(array_merge($subcategoryIds, $ps)));
    }

    $rows = promo_candidates($pdo, $placement, $categoryIds, $subcategoryIds, $lang, $device, $isMp ? (array) ($page['mp'] ?? []) : []);
    if ($rows === []) {
        return [];
    }

    // Фільтри сеансу й сторінки (у PHP — кеш спільний для всіх).
    $exclude = array_flip(array_map('intval', $excludeCreatives));
    $caps = promo_session_caps($sessionHash);
    $cap = (int) promo_setting($pdo, 'frequency_cap_per_session', '3');
    $houseCap = (int) promo_setting($pdo, 'house_frequency_cap', '2');
    $paid = [];
    $house = [];
    $houseOk = [];
    foreach ($rows as $r) {
        if (isset($exclude[$r['id']])) {
            continue;
        }
        $limit = $r['internal'] ? $houseCap : $cap;
        if ($limit > 0 && ($caps[$r['campaign_id']] ?? 0) >= $limit) {
            continue;
        }
        if (!$r['internal']) {
            $paid[] = $r;
            continue;
        }
        if (!empty($page['no_house'])) {
            continue;
        }
        // Умови власної кампанії — раз на кампанію (можуть питати БД про користувача).
        $houseOk[$r['campaign_id']] ??= promo_house_allowed($pdo, $r, $placement, $page);
        if ($houseOk[$r['campaign_id']]) {
            $house[] = $r;
        }
    }
    if ($paid === [] && $house === []) {
        return [];
    }

    // Нещодавно показані цьому сеансу — у кінець черги (і серед платних, і серед власних).
    $recent = array_flip(promo_session_recent($sessionHash));
    $split = static function (array $list) use ($recent): array {
        $fresh = [];
        $old = [];
        foreach ($list as $r) {
            if (isset($recent[$r['id']])) {
                $old[] = $r;
            } else {
                $fresh[] = $r;
            }
        }

        return [$fresh, $old];
    };

    // Платні: вага креативу × рівномірне витрачання (залишок бюджету / днів до кінця).
    $today = new DateTimeImmutable(promo_today());
    $paidWeight = static function (array $r) use ($today): float {
        $remaining = $r['balance'];
        if ($r['total_budget'] !== null) {
            $remaining = min($remaining, $r['total_budget'] - $r['spent']);
        }
        $daysLeft = 30;
        if ($r['end_date'] !== null) {
            $daysLeft = max(1, (int) $today->diff(new DateTimeImmutable((string) $r['end_date']))->format('%r%a') + 1);
        }

        return $r['weight'] * max(1, $remaining) / $daysLeft;
    };
    // Власна: варіанти однієї кампанії рівномірно (A/B) — вага кампанії ділиться між її креативами.
    $perCampaign = array_count_values(array_map(static fn($r) => $r['campaign_id'], $house));
    $houseWeight = static fn(array $r): float => max(1, $r['weight']) / max(1, $perCampaign[$r['campaign_id']] ?? 1);

    $chosen = [];
    foreach ([[$paid, $paidWeight], [$house, $houseWeight]] as [$list, $weightOf]) {
        foreach ($split($list) as $part) {
            if (count($chosen) >= $n) {
                break 2;
            }
            $chosen = array_merge($chosen, promo_weighted_sample($part, $n - count($chosen), $weightOf));
        }
    }

    return promo_creatives_full($pdo, array_map(static fn($r) => $r['id'], $chosen));
}

/**
 * Повні рядки креативів (для промальовування) у заданому порядку.
 *
 * @param list<int> $ids
 * @return list<array<string,mixed>>
 */
function promo_creatives_full(PDO $pdo, array $ids): array
{
    if ($ids === []) {
        return [];
    }
    $houseCols = promo_house_columns($pdo)
        ? ', cr.creative_type, cr.card_layout, cr.title_en, cr.description_en, cr.description_fallback, cr.description_fallback_en,
             cr.cta_text, cr.cta_text_en, cr.ref_code, c.house_key, c.house_rules'
        : '';
    if (promo_has_column($pdo, 'ad_creatives', 'skip_delay_seconds')) {
        $houseCols .= ', cr.skip_delay_seconds';
    }
    try {
        $st = $pdo->prepare(
            "SELECT cr.id, cr.campaign_id, cr.title, cr.description, cr.cta_key, cr.video_type,
                    cr.video_path, cr.youtube_id, cr.poster_path, c.campaign_type{$houseCols}
             FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
             WHERE cr.id IN (" . implode(',', array_fill(0, count($ids), '?')) . ')'
        );
        $st->execute(array_values($ids));
        $byId = [];
        foreach ($st->fetchAll() as $r) {
            $byId[(int) $r['id']] = $r;
        }
    } catch (Throwable $e) {
        error_log('[promo] creatives: ' . $e->getMessage());

        return [];
    }

    return array_values(array_filter(array_map(static fn($id) => $byId[$id] ?? null, $ids)));
}

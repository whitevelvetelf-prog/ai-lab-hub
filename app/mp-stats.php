<?php

declare(strict_types=1);

/**
 * AI LAB HUB — статистика оголошення для автора й admin (Хвиля 1).
 *
 *   Перегляди — mp_listing_views_daily (міграція 2026-11-09, № 20), усі види оголошень: +1 раз на сесію на оголошення
 *   на день, INSERT … ON DUPLICATE KEY UPDATE; не рахуються власник, боти (User-Agent, analytics_device_class) і HEAD.
 *   Відкриття контакту — mp_contact_reveals (оголошення користувачів), додавання в обране — mp_favorites.created_at,
 *   переходи на сайт — mp_listing_stats_daily.clicks (вакансії / курси / послуги). Без персональних даних: лише лічильники.
 *   Видно лише автору й admin (перевіряє public/mp-stats.php). Очищення > 90 днів — mpst_cleanup() у mp-cron-expire.php.
 */

require_once __DIR__ . '/marketplace.php';
require_once __DIR__ . '/analytics.php';

const MPST_PERIODS = [7, 30, 60];
const MPST_CHART_DAYS = 60;
const MPST_KEEP_DAYS = 90;

function mpst_ready(PDO $pdo): bool
{
    return function_exists('mpt_table_exists') && mpt_table_exists($pdo, 'mp_listing_views_daily');
}

/** Чи рахувати перегляд: GET, не бот, не власник. */
function mpst_countable(?int $ownerUserId): bool
{
    if (($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'GET' || analytics_device_class() === 'bot') {
        return false;
    }
    $uid = function_exists('auth_user_id') ? auth_user_id() : null;

    return !($ownerUserId !== null && $uid !== null && $ownerUserId === $uid);
}

/** Перегляд сторінки оголошення: 1 раз на сесію на оголошення на день. */
function mpst_count_view(PDO $pdo, int $listingId, ?int $ownerUserId): void
{
    if ($listingId <= 0 || !mpst_countable($ownerUserId) || !mpst_ready($pdo)) {
        return;
    }
    $day = date('Y-m-d');
    $seen = is_array($_SESSION['mpst_seen'] ?? null) ? $_SESSION['mpst_seen'] : [];
    if (($seen[$listingId] ?? '') === $day) {
        return;
    }
    $seen = array_filter($seen, static fn($d): bool => $d === $day);
    $seen[$listingId] = $day;
    $_SESSION['mpst_seen'] = array_slice($seen, -300, null, true);
    try {
        $pdo->prepare('INSERT INTO mp_listing_views_daily (listing_id, stat_date, views) VALUES (:id, CURDATE(), 1)
                       ON DUPLICATE KEY UPDATE views = views + 1')->execute([':id' => $listingId]);
    } catch (Throwable $e) {
        error_log('[mp-stats] ' . $e->getMessage());
    }
}

/** Безпечний підрахунок (таблиці може не бути). */
function mpst_scalar(PDO $pdo, string $sql, array $params): int
{
    try {
        $st = $pdo->prepare($sql);
        $st->execute($params);

        return (int) $st->fetchColumn();
    } catch (Throwable $e) {
        return 0;
    }
}

/**
 * Показники за періоди 7 / 30 / 60 днів (включно з сьогодні).
 *
 * @return array<int,array{views:int,reveals:int,favorites:int,clicks:int}>
 */
function mpst_periods(PDO $pdo, int $id): array
{
    $out = [];
    foreach (MPST_PERIODS as $d) {
        $from = date('Y-m-d', strtotime('-' . ($d - 1) . ' days'));
        $out[$d] = [
            'views' => mpst_scalar($pdo, 'SELECT COALESCE(SUM(views), 0) FROM mp_listing_views_daily WHERE listing_id = :id AND stat_date >= :d', [':id' => $id, ':d' => $from]),
            'reveals' => mpst_scalar($pdo, 'SELECT COUNT(*) FROM mp_contact_reveals WHERE listing_id = :id AND created_at >= :d', [':id' => $id, ':d' => $from . ' 00:00:00']),
            'favorites' => mpst_scalar($pdo, 'SELECT COUNT(*) FROM mp_favorites WHERE listing_id = :id AND created_at >= :d', [':id' => $id, ':d' => $from . ' 00:00:00']),
            'clicks' => mpst_scalar($pdo, 'SELECT COALESCE(SUM(clicks), 0) FROM mp_listing_stats_daily WHERE listing_id = :id AND day >= :d', [':id' => $id, ':d' => $from]),
        ];
    }

    return $out;
}

/** Перегляди за 30 днів для кількох оголошень (список «Мої оголошення»). @return array<int,int> */
function mpst_views_30(PDO $pdo, array $ids): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids))));
    if ($ids === [] || !mpst_ready($pdo)) {
        return [];
    }
    $st = $pdo->query('SELECT listing_id, SUM(views) FROM mp_listing_views_daily WHERE stat_date >= CURDATE() - INTERVAL 29 DAY AND listing_id IN ('
        . implode(',', $ids) . ') GROUP BY listing_id');

    return array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR));
}

/** Перегляди по днях за N днів (усі дні, нулі включно). @return array<string,int> дата => перегляди */
function mpst_series(PDO $pdo, int $id, int $days = MPST_CHART_DAYS): array
{
    $series = [];
    for ($i = $days - 1; $i >= 0; $i--) {
        $series[date('Y-m-d', strtotime("-$i days"))] = 0;
    }
    if (!mpst_ready($pdo)) {
        return $series;
    }
    $st = $pdo->prepare('SELECT stat_date, views FROM mp_listing_views_daily WHERE listing_id = :id AND stat_date >= :d');
    $st->execute([':id' => $id, ':d' => array_key_first($series)]);
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        if (isset($series[(string) $r['stat_date']])) {
            $series[(string) $r['stat_date']] = (int) $r['views'];
        }
    }

    return $series;
}

/**
 * Простий SVG-стовпчиковий графік (масштабується за шириною, без бібліотек). Кольори — бренд (#2116ad).
 * Підписи осі X — перша, середня й остання дати; Y — максимум. Під графіком — текстова альтернатива (aria).
 */
function mpst_chart_svg(array $series, string $title): string
{
    $n = max(1, count($series));
    $max = max(1, max($series ?: [0]));
    $w = 360;
    $h = 170;
    $padL = 30;
    $padB = 26;
    $padT = 10;
    $plotW = $w - $padL - 6;
    $plotH = $h - $padB - $padT;
    $bw = $plotW / $n;
    $bars = '';
    $i = 0;
    foreach ($series as $date => $v) {
        $bh = $v > 0 ? max(2.0, $plotH * $v / $max) : 0.0;
        $x = $padL + $i * $bw + $bw * 0.15;
        $y = $padT + $plotH - $bh;
        if ($bh > 0) {
            $bars .= sprintf('<rect x="%.2f" y="%.2f" width="%.2f" height="%.2f" rx="1.5" fill="#2116ad"><title>%s: %d</title></rect>',
                $x, $y, $bw * 0.7, $bh, mp_e(date('d.m', (int) strtotime((string) $date))), $v);
        }
        $i++;
    }
    $dates = array_keys($series);
    $lbl = static fn(string $d): string => date('d.m', (int) strtotime($d));
    $axis = sprintf('<line x1="%d" y1="%.2f" x2="%d" y2="%.2f" stroke="#c9cbe0" stroke-width="1"/>', $padL, $padT + $plotH, $w - 6, $padT + $plotH)
        . sprintf('<text x="%d" y="%d" font-size="11" fill="#55577a">%s</text>', $padL, $h - 6, $lbl($dates[0]))
        . sprintf('<text x="%.2f" y="%d" font-size="11" fill="#55577a" text-anchor="middle">%s</text>', $padL + $plotW / 2, $h - 6, $lbl($dates[intdiv($n, 2)]))
        . sprintf('<text x="%d" y="%d" font-size="11" fill="#55577a" text-anchor="end">%s</text>', $w - 6, $h - 6, $lbl($dates[$n - 1]))
        . sprintf('<text x="%d" y="%d" font-size="11" fill="#55577a" text-anchor="end">%d</text>', $padL - 4, $padT + 10, $max)
        . sprintf('<text x="%d" y="%.2f" font-size="11" fill="#55577a" text-anchor="end">0</text>', $padL - 4, $padT + $plotH);
    $total = array_sum($series);

    return '<figure class="mpst-chart"><svg viewBox="0 0 ' . $w . ' ' . $h . '" role="img" aria-label="' . mp_e($title . ': ' . $total) . '">'
        . $axis . $bars . '</svg><figcaption class="mp-hint">' . mp_e($title) . ' — ' . (int) $total . '</figcaption></figure>';
}

/** Очищення переглядів старших за 90 днів (єдиний DELETE модуля). */
function mpst_cleanup(PDO $pdo): int
{
    if (!mpst_ready($pdo)) {
        return 0;
    }
    $st = $pdo->prepare('DELETE FROM mp_listing_views_daily WHERE stat_date < CURDATE() - INTERVAL ' . MPST_KEEP_DAYS . ' DAY');
    $st->execute();

    return $st->rowCount();
}

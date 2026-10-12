<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перегляди сайту за день / тиждень / місяць і рекорди за весь час
 * (блок «Перегляди сайту» на public/admin-stats.php і рядок у кабінеті account.php).
 *
 * Перегляд = один рядок у page_views (app/analytics.php: головна, каталог,
 * категорії, картки продуктів, статті блогу; кабінет і адмінка не пишуться).
 * Унікальні сеанси = різні session_hash.
 *
 * Добові агрегати — таблиця page_views_daily (день за Europe/Kyiv), щоб рекорди
 * не залежали від сирих даних. Оновлення: site_stats_sync() під час відкриття
 * статистики (і в щоденному cron) перераховує з page_views лише «незакриті» дні:
 * яких ще нема в таблиці або які востаннє рахувалися до кінця своєї доби (сьогодні).
 * Закритий день (updated_at після його київської півночі) більше не змінюється.
 *
 * Межі доби рахуються в PHP (Europe/Kyiv з літнім часом) і порівнюються з page_views
 * у UTC: на час запитів сесія MySQL переводиться в '+00:00' і потім повертається.
 * Схема — database/migration-2026-10-12-site-stats.sql.
 */

require_once __DIR__ . '/site-settings.php';

/** Менше стільки днів даних — рекорд дня / тижня позначається «даних поки мало». */
const SITE_STATS_FEW_DAYS_DAY = 7;
const SITE_STATS_FEW_DAYS_WEEK = 14;

function site_stats_tz(): DateTimeZone
{
    static $tz = null;
    if ($tz === null) {
        try {
            $tz = new DateTimeZone('Europe/Kyiv');
        } catch (Throwable $e) {
            $tz = new DateTimeZone('Europe/Kiev'); // стара база часових поясів
        }
    }

    return $tz;
}

/** Київська дата (Y-m-d) сьогодні або зі зсувом у днях. */
function site_stats_day(int $offsetDays = 0, ?DateTimeImmutable $now = null): string
{
    $d = ($now ?? new DateTimeImmutable('now'))->setTimezone(site_stats_tz());

    return ($offsetDays !== 0 ? $d->modify(($offsetDays > 0 ? '+' : '') . $offsetDays . ' days') : $d)->format('Y-m-d');
}

/** Зсув київської дати на N днів. */
function site_stats_shift(string $day, int $days): string
{
    return (new DateTimeImmutable($day . ' 00:00:00', site_stats_tz()))
        ->modify(($days >= 0 ? '+' : '') . $days . ' days')->format('Y-m-d');
}

/** Межі київської доби в UTC: [північ, наступна північ) — з урахуванням літнього часу. */
function site_stats_bounds_utc(string $day): array
{
    $start = new DateTimeImmutable($day . ' 00:00:00', site_stats_tz());
    $utc = new DateTimeZone('UTC');

    return [
        $start->setTimezone($utc)->format('Y-m-d H:i:s'),
        $start->modify('+1 day')->setTimezone($utc)->format('Y-m-d H:i:s'),
    ];
}

/** Запити до page_views у UTC; часовий пояс сесії MySQL повертається після виконання. */
function site_stats_in_utc(PDO $pdo, callable $fn): mixed
{
    $prev = (string) $pdo->query('SELECT @@session.time_zone')->fetchColumn();
    $pdo->exec("SET time_zone = '+00:00'");
    try {
        return $fn();
    } finally {
        $pdo->prepare('SET time_zone = :tz')->execute([':tz' => $prev]);
    }
}

/** Кількість переглядів і унікальних сеансів у проміжку UTC [from, to). */
function site_stats_raw_count(PDO $pdo, string $fromUtc, string $toUtc): array
{
    $st = $pdo->prepare(
        'SELECT COUNT(*), COUNT(DISTINCT session_hash) FROM page_views
         WHERE viewed_at >= :a AND viewed_at < :b'
    );
    $st->execute([':a' => $fromUtc, ':b' => $toUtc]);
    $r = $st->fetch(PDO::FETCH_NUM) ?: [0, 0];

    return ['views' => (int) $r[0], 'sessions' => (int) $r[1]];
}

/**
 * Оновити page_views_daily з page_views: дні від першого перегляду до сьогодні,
 * яких нема в таблиці або які ще не закриті. $force — перерахувати всі дні,
 * для яких є сирі дані (лише CLI backfill). Повертає кількість перерахованих днів.
 */
function site_stats_sync(PDO $pdo, bool $force = false, ?DateTimeImmutable $now = null): int
{
    return site_stats_in_utc($pdo, static function () use ($pdo, $force, $now): int {
        $first = $pdo->query('SELECT MIN(viewed_at) FROM page_views')->fetchColumn();
        if ($first === null || $first === false) {
            return 0;
        }
        $firstDay = (new DateTimeImmutable((string) $first, new DateTimeZone('UTC')))->setTimezone(site_stats_tz())->format('Y-m-d');
        $today = site_stats_day(0, $now);
        $nowUtc = ($now ?? new DateTimeImmutable('now'))->setTimezone(new DateTimeZone('UTC'))->format('Y-m-d H:i:s');

        $known = $pdo->query('SELECT day, updated_at FROM page_views_daily')->fetchAll(PDO::FETCH_KEY_PAIR);
        $up = $pdo->prepare(
            'INSERT INTO page_views_daily (day, views, sessions, updated_at) VALUES (:d, :v, :s, :u)
             ON DUPLICATE KEY UPDATE views = VALUES(views), sessions = VALUES(sessions), updated_at = VALUES(updated_at)'
        );

        $n = 0;
        for ($day = $firstDay; $day <= $today; $day = site_stats_shift($day, 1)) {
            [$a, $b] = site_stats_bounds_utc($day);
            $closed = isset($known[$day]) && (string) $known[$day] >= $b;
            if ($closed && !$force) {
                continue;
            }
            $c = site_stats_raw_count($pdo, $a, $b);
            if ($closed && $c['views'] === 0) {
                continue; // сирих даних за закритий день уже нема — агрегат не чіпаємо
            }
            $up->execute([':d' => $day, ':v' => $c['views'], ':s' => $c['sessions'], ':u' => $nowUtc]);
            $n++;
        }

        return $n;
    });
}

/** Безпечна обгортка для сторінок: без таблиці (міграцію не застосовано) — false. */
function site_stats_try_sync(PDO $pdo): bool
{
    try {
        site_stats_sync($pdo);

        return true;
    } catch (Throwable $e) {
        error_log('[site-stats] sync: ' . $e->getMessage());

        return false;
    }
}

/** Відсоток зміни: null, якщо попереднього значення нема або воно 0. */
function site_stats_delta(int $cur, ?int $prev): ?array
{
    if ($prev === null) {
        return null;
    }

    return ['diff' => $cur - $prev, 'pct' => $prev > 0 ? (int) round(($cur - $prev) / $prev * 100) : null];
}

/** Частка від рекорду у % (null, якщо рекорду ще нема). */
function site_stats_share(int $value, int $record): ?int
{
    return $record > 0 ? (int) round($value / $record * 100) : null;
}

/**
 * Усі цифри блоку. $full = false — лише перегляди (для рядка в кабінеті, без
 * запитів унікальних сеансів за періоди). null, якщо таблиці ще нема.
 */
function site_stats_summary(PDO $pdo, bool $full = true, ?DateTimeImmutable $now = null): ?array
{
    try {
        $rows = $pdo->query('SELECT day, views, sessions FROM page_views_daily ORDER BY day')->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable $e) {
        error_log('[site-stats] summary: ' . $e->getMessage());

        return null;
    }

    $today = site_stats_day(0, $now);
    $views = [];
    $sessions = [];
    foreach ($rows as $r) {
        $views[(string) $r['day']] = (int) $r['views'];
        $sessions[(string) $r['day']] = (int) $r['sessions'];
    }
    $firstDay = null;
    foreach ($views as $d => $v) {
        if ($v > 0) {
            $firstDay = $d;
            break;
        }
    }
    $dataDays = $firstDay === null ? 0
        : (int) (new DateTimeImmutable($firstDay))->diff(new DateTimeImmutable($today))->days + 1;

    $sum = static function (string $from, string $to) use ($views): int {
        $s = 0;
        foreach ($views as $d => $v) {
            if ($d >= $from && $d <= $to) {
                $s += $v;
            }
        }

        return $s;
    };
    // Попередній період повний, якщо почався пізніше за перший (неповний) день даних.
    $complete = static fn (string $from): bool => $firstDay !== null && $from > $firstDay;

    // --- Рекорди за весь час ---
    $bestDay = null;
    $prevBestDay = 0;
    $prevDays = 0;
    foreach ($views as $d => $v) {
        if ($d > $today) {
            continue;
        }
        if ($bestDay === null || $v > $bestDay['views']) {
            $bestDay = ['day' => $d, 'views' => $v, 'sessions' => $sessions[$d]];
        }
        if ($d < $today) {
            $prevBestDay = max($prevBestDay, $v);
            $prevDays++;
        }
    }

    $bestWeek = null;
    $prevBestWeek = null;
    $months = [];
    if ($firstDay !== null) {
        for ($end = $firstDay; $end <= $today; $end = site_stats_shift($end, 1)) {
            $start = site_stats_shift($end, -6);
            $w = $sum($start, $end);
            if ($bestWeek === null || $w > $bestWeek['views']) {
                $bestWeek = ['from' => max($start, $firstDay), 'to' => $end, 'views' => $w];
            }
            if ($end < $today && $complete($start)) {
                $prevBestWeek = max($prevBestWeek ?? 0, $w);
            }
        }
        foreach ($views as $d => $v) {
            $months[substr($d, 0, 7)] = ($months[substr($d, 0, 7)] ?? 0) + $v;
        }
    }
    $bestMonth = null;
    foreach ($months as $m => $v) {
        if ($bestMonth === null || $v > $bestMonth['views']) {
            $bestMonth = ['month' => $m, 'views' => $v];
        }
    }
    // Попередній рекорд місяця — серед календарних місяців до поточного;
    // «даних поки мало», доки немає жодного повного календарного місяця.
    $prevBestMonth = null;
    $hasFullMonth = false;
    foreach ($months as $m => $v) {
        if ($m < substr($today, 0, 7)) {
            $prevBestMonth = max($prevBestMonth ?? 0, $v);
            $hasFullMonth = $hasFullMonth || $complete($m . '-01');
        }
    }

    // --- Картки ---
    $card = function (string $from, string $to, int $len, string $kind) use ($pdo, $full, $sum, $complete, $now, $today): array {
        $cur = $sum($from, $to);
        $prevFrom = site_stats_shift($from, -$len);
        $prevTo = site_stats_shift($to, -$len);
        $out = ['from' => $from, 'to' => $to, 'views' => $cur, 'sessions' => null,
            'prev_views' => null, 'prev_sessions' => null];
        $hasPrev = $complete($prevFrom);

        if ($kind === 'day') {
            // Сьогодні неповне — порівнюємо з учора до тієї самої хвилини.
            $nowTs = ($now ?? new DateTimeImmutable('now'))->getTimestamp();
            [$todayStart] = site_stats_bounds_utc($today);
            $elapsed = $nowTs - (new DateTimeImmutable($todayStart, new DateTimeZone('UTC')))->getTimestamp();
            [$yStart, $yEnd] = site_stats_bounds_utc($prevFrom);
            $yCut = (new DateTimeImmutable($yStart, new DateTimeZone('UTC')))->modify('+' . $elapsed . ' seconds');
            $yCutStr = min($yCut->format('Y-m-d H:i:s'), $yEnd);
            $res = site_stats_in_utc($pdo, static fn () => [
                site_stats_raw_count($pdo, ...site_stats_bounds_utc($today)),
                site_stats_raw_count($pdo, $yStart, $yCutStr),
            ]);
            $out['sessions'] = $res[0]['sessions'];
            if ($hasPrev) {
                $out['prev_views'] = $res[1]['views'];
                $out['prev_sessions'] = $res[1]['sessions'];
            }

            return $out;
        }
        if ($full) {
            $res = site_stats_in_utc($pdo, static fn () => [
                site_stats_raw_count($pdo, site_stats_bounds_utc($from)[0], site_stats_bounds_utc($to)[1]),
                site_stats_raw_count($pdo, site_stats_bounds_utc($prevFrom)[0], site_stats_bounds_utc($prevTo)[1]),
            ]);
            $out['sessions'] = $res[0]['sessions'];
            if ($hasPrev) {
                $out['prev_sessions'] = $res[1]['sessions'];
            }
        }
        if ($hasPrev) {
            $out['prev_views'] = $sum($prevFrom, $prevTo);
        }

        return $out;
    };

    $todayCard = $full ? $card($today, $today, 1, 'day') : ['from' => $today, 'to' => $today, 'views' => $views[$today] ?? 0];
    $weekCard = $card(site_stats_shift($today, -6), $today, 7, 'week');
    $monthCard = $card(site_stats_shift($today, -29), $today, 30, 'month');

    $todayCard['share'] = site_stats_share($todayCard['views'], $bestDay['views'] ?? 0);
    $todayCard['new_record'] = $prevDays >= 3 && $todayCard['views'] > $prevBestDay;
    $weekCard['share'] = site_stats_share($weekCard['views'], $bestWeek['views'] ?? 0);
    $weekCard['new_record'] = $prevBestWeek !== null && $weekCard['views'] > $prevBestWeek;
    $monthCard['share'] = site_stats_share($monthCard['views'], $bestMonth['views'] ?? 0);
    $monthCard['new_record'] = $prevBestMonth !== null && $monthCard['views'] > $prevBestMonth;
    $cards = ['today' => $todayCard, 'week' => $weekCard, 'month' => $monthCard];
    foreach ($cards as &$c) {
        $c['delta_views'] = site_stats_delta($c['views'], $c['prev_views'] ?? null);
        $c['delta_sessions'] = isset($c['sessions'])
            ? site_stats_delta((int) $c['sessions'], $c['prev_sessions'] ?? null) : null;
    }
    unset($c);

    // Стовпчики за останні 30 днів.
    $chart = [];
    for ($d = site_stats_shift($today, -29); $d <= $today; $d = site_stats_shift($d, 1)) {
        $chart[] = ['day' => $d, 'views' => $views[$d] ?? 0];
    }

    return [
        'today' => $cards['today'],
        'week' => $cards['week'],
        'month' => $cards['month'],
        'record_day' => $bestDay !== null && $bestDay['views'] > 0 ? $bestDay : null,
        'record_week' => $bestWeek !== null && $bestWeek['views'] > 0 ? $bestWeek : null,
        'record_month' => $bestMonth !== null && $bestMonth['views'] > 0 ? $bestMonth : null,
        'few_day' => $dataDays < SITE_STATS_FEW_DAYS_DAY,
        'few_week' => $dataDays < SITE_STATS_FEW_DAYS_WEEK,
        'few_month' => !$hasFullMonth,
        'data_days' => $dataDays,
        'first_day' => $firstDay,
        'chart' => $chart,
    ];
}

/** Число з пробілом як роздільником тисяч: 12 345 (нерозривний пробіл). */
function site_stats_num(int|float|null $n): string
{
    return number_format((float) ($n ?? 0), 0, '', "\u{00A0}");
}

/** Дата Y-m-d → d.m.Y (або d.m з $short). */
function site_stats_date(string $day, bool $short = false): string
{
    $p = explode('-', $day);

    return $short ? $p[2] . '.' . $p[1] : $p[2] . '.' . $p[1] . '.' . $p[0];
}

/** Не рахувати перегляди адмінів і працівників (налаштування stats_exclude_staff, типово увімкнено). */
function site_stats_skip_view(PDO $pdo): bool
{
    if (!function_exists('auth_role') || !in_array(auth_role(), ['admin', 'employee'], true)) {
        return false;
    }

    return site_setting($pdo, 'stats_exclude_staff', '1') === '1';
}

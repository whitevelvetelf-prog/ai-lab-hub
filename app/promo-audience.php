<?php

declare(strict_types=1);

/**
 * AI LAB HUB — агрегована статистика аудиторії для медіакіту (public/advertise.php).
 *
 * Лише реальні дані власної аналітики (page_views, app/analytics.php): кількість
 * переглядів, унікальних анонімних сеансів (session_hash), частки мов і класів
 * пристроїв, топ категорій за переглядами. Жодних персональних даних.
 *
 * Період — останні 30 повних київських діб (без сьогоднішньої). Результат
 * кешується в promo_audience_stats (оновлює cron/promo-daily.php); сторінка
 * лише читає кеш. Якщо кешу ще немає (cron не запускався) — рахує один раз сама.
 *
 * Боти (device_class = 'bot') не враховуються там, де клас відомий. Мова й
 * пристрій пишуться лише з 2026-10-12, тож частки рахуються тільки від
 * переглядів, для яких вони відомі, і показуються, коли таких даних достатньо.
 */

require_once __DIR__ . '/promo.php';

/** Менше переглядів за період — показуємо «статистика накопичується», а не слабкі цифри. */
const PROMO_AUDIENCE_MIN_VIEWS = 1000;
const PROMO_AUDIENCE_DAYS = 30;
const PROMO_AUDIENCE_TOP = 6;

/**
 * Порахувати агрегати за період і записати в promo_audience_stats.
 *
 * @return array{period_from:string,period_to:string,page_views:int}
 */
function promo_audience_compute(PDO $pdo): array
{
    $to = promo_today(-1);
    $from = promo_today(-PROMO_AUDIENCE_DAYS);
    [$fromUtc] = promo_day_bounds_utc($from);
    [, $toUtc] = promo_day_bounds_utc($to);

    // viewed_at — TIMESTAMP: порівнюємо в UTC, потім повертаємо часовий пояс сесії.
    $prevTz = (string) $pdo->query('SELECT @@session.time_zone')->fetchColumn();
    $pdo->exec("SET time_zone = '+00:00'");
    try {
        $where = "viewed_at >= :f AND viewed_at < :t AND (device_class IS NULL OR device_class <> 'bot')";
        $one = static function (string $sql) use ($pdo, $fromUtc, $toUtc): array {
            $st = $pdo->prepare($sql);
            $st->execute([':f' => $fromUtc, ':t' => $toUtc]);

            return $st->fetchAll(PDO::FETCH_NUM);
        };

        $rows = [];
        $totals = $one("SELECT COUNT(*), COUNT(DISTINCT session_hash) FROM page_views WHERE {$where}")[0];
        $rows[] = ['page_views', '', (int) $totals[0]];
        $rows[] = ['sessions', '', (int) $totals[1]];

        $langKnown = 0;
        foreach ($one("SELECT lang, COUNT(*) FROM page_views WHERE {$where} AND lang IS NOT NULL GROUP BY lang") as [$lang, $n]) {
            $rows[] = ['lang', (string) $lang, (int) $n];
            $langKnown += (int) $n;
        }
        $rows[] = ['lang_known', '', $langKnown];

        $devKnown = 0;
        foreach ($one("SELECT device_class, COUNT(*) FROM page_views WHERE {$where} AND device_class IS NOT NULL GROUP BY device_class") as [$dev, $n]) {
            $rows[] = ['device', (string) $dev, (int) $n];
            $devKnown += (int) $n;
        }
        $rows[] = ['device_known', '', $devKnown];

        // Топ категорій: перегляди сторінок категорій + сторінок продуктів цієї категорії.
        $cats = [];
        foreach ($one("SELECT page_id, COUNT(*) FROM page_views WHERE {$where} AND page_type = 'category' AND page_id IS NOT NULL GROUP BY page_id") as [$id, $n]) {
            $cats[(int) $id] = ($cats[(int) $id] ?? 0) + (int) $n;
        }
        foreach ($one("SELECT pc.category_id, COUNT(*) FROM page_views v JOIN product_categories pc ON pc.product_id = v.page_id
                       WHERE " . str_replace(['viewed_at', 'device_class'], ['v.viewed_at', 'v.device_class'], $where) . " AND v.page_type = 'product'
                       GROUP BY pc.category_id") as [$id, $n]) {
            $cats[(int) $id] = ($cats[(int) $id] ?? 0) + (int) $n;
        }
        arsort($cats);
        foreach (array_slice($cats, 0, PROMO_AUDIENCE_TOP, true) as $id => $n) {
            $rows[] = ['top_category', (string) $id, $n];
        }
    } finally {
        $restore = $pdo->prepare('SET time_zone = :tz');
        $restore->execute([':tz' => $prevTz]);
    }

    $now = promo_utc_now();
    $pdo->beginTransaction();
    try {
        $pdo->prepare('DELETE FROM promo_audience_stats WHERE period_to = :t OR period_to < :old')
            ->execute([':t' => $to, ':old' => promo_today(-120)]);
        $ins = $pdo->prepare(
            'INSERT INTO promo_audience_stats (period_from, period_to, metric, dim, value, computed_at)
             VALUES (:f, :t, :m, :d, :v, :c)'
        );
        foreach ($rows as [$metric, $dim, $value]) {
            $ins->execute([':f' => $from, ':t' => $to, ':m' => $metric, ':d' => $dim, ':v' => $value, ':c' => $now]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }

    return ['period_from' => $from, 'period_to' => $to, 'page_views' => (int) $totals[0]];
}

/**
 * Останній кеш агрегатів. null — кешу немає й порахувати не вдалося
 * (наприклад, міграцію ще не застосовано).
 *
 * @return array{period_from:string,period_to:string,computed_at:string,page_views:int,sessions:int,
 *               lang:array<string,int>,lang_known:int,device:array<string,int>,device_known:int,
 *               top_categories:array<int,int>}|null
 */
function promo_audience_get(PDO $pdo): ?array
{
    try {
        $latest = $pdo->query('SELECT MAX(period_to) FROM promo_audience_stats')->fetchColumn();
        if ($latest === null || $latest === false || (string) $latest < promo_today(-3)) {
            // Кешу немає або cron давно не працював — рахуємо раз (результат кешується).
            promo_audience_compute($pdo);
            $latest = $pdo->query('SELECT MAX(period_to) FROM promo_audience_stats')->fetchColumn();
        }
        if ($latest === null || $latest === false) {
            return null;
        }
        $st = $pdo->prepare('SELECT * FROM promo_audience_stats WHERE period_to = :t');
        $st->execute([':t' => $latest]);
        $rows = $st->fetchAll();
    } catch (Throwable $e) {
        error_log('[promo] audience: ' . $e->getMessage());

        return null;
    }
    if ($rows === []) {
        return null;
    }

    $out = [
        'period_from' => (string) $rows[0]['period_from'],
        'period_to' => (string) $rows[0]['period_to'],
        'computed_at' => (string) $rows[0]['computed_at'],
        'page_views' => 0, 'sessions' => 0, 'lang' => [], 'lang_known' => 0,
        'device' => [], 'device_known' => 0, 'top_categories' => [],
    ];
    foreach ($rows as $r) {
        $v = (int) $r['value'];
        match ($r['metric']) {
            'page_views', 'sessions', 'lang_known', 'device_known' => $out[$r['metric']] = $v,
            'lang' => $out['lang'][(string) $r['dim']] = $v,
            'device' => $out['device'][(string) $r['dim']] = $v,
            'top_category' => $out['top_categories'][(int) $r['dim']] = $v,
            default => null,
        };
    }
    arsort($out['lang']);
    arsort($out['device']);
    arsort($out['top_categories']);

    return $out;
}

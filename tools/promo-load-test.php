<?php

declare(strict_types=1);

/**
 * AI LAB HUB — навантажувальний тест відбору реклами (app/promo-select.php).
 *
 *   php tools/promo-load-test.php [кількість кампаній, за замовчуванням 5000]
 *
 * Тимчасово створює N активних платних кампаній (рекламодавець 'LOADTEST'), кожна з
 * креативом і 2–5 таргетами (~60% на «усі категорії», решта — конкретна категорія чи
 * підкатегорія), вмикає рекламу й міряє на кількох контекстах сторінки:
 *   * promo_candidates без кешу (кеш скинуто перед кожним викликом) і з кешем;
 *   * promo_pick_set повністю (кандидати + фільтри сеансу + зважений вибір + повні рядки).
 * Після вимірів ПОВНІСТЮ видаляє тестові рядки й повертає налаштування як були
 * (у блоці finally — навіть якщо щось упало). Лише локально / на тестовій базі.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$_SERVER['HTTP_USER_AGENT'] = 'Mozilla/5.0 (load-test) Chrome/130';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/site-settings.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$n = max(100, (int) ($argv[1] ?? 5000));
$runs = 30;
$marker = 'LOADTEST';

$one = static function (string $sql, array $p = []) use ($pdo): mixed {
    $st = $pdo->prepare($sql);
    $st->execute($p);

    return $st->fetchColumn();
};

$userId = (int) $one("SELECT id FROM users WHERE role <> 'admin' ORDER BY id DESC LIMIT 1");
$oldEnabled = promo_setting($pdo, 'enabled', '0');
$oldMpPublic = site_setting($pdo, 'marketplace_public', '0');
$oldBalance = $pdo->prepare('SELECT * FROM ad_balances WHERE user_id = :u');
$oldBalance->execute([':u' => $userId]);
$oldBalance = $oldBalance->fetch() ?: null;

$cleanup = static function () use ($pdo, $marker): int {
    $ids = $pdo->query("SELECT id FROM ad_campaigns WHERE advertiser_name = " . $pdo->quote($marker))->fetchAll(PDO::FETCH_COLUMN);
    foreach (array_chunk($ids, 500) as $chunk) {
        $in = implode(',', array_map('intval', $chunk));
        foreach (['ad_events', 'ad_stats_daily', 'ad_targets', 'ad_transactions', 'promo_event_log'] as $t) {
            $pdo->exec("DELETE FROM {$t} WHERE campaign_id IN ({$in})");
        }
        $pdo->exec("DELETE FROM ad_creative_translations WHERE creative_id IN (SELECT id FROM ad_creatives WHERE campaign_id IN ({$in}))");
        $pdo->exec("DELETE FROM ad_creatives WHERE campaign_id IN ({$in})");
        $pdo->exec("DELETE FROM ad_campaigns WHERE id IN ({$in})");
    }

    return count($ids);
};

$stats = static function (array $ms): string {
    sort($ms);
    $p = static fn(float $q): float => $ms[min(count($ms) - 1, (int) floor($q * (count($ms) - 1)))];

    return sprintf('медіана %6.2f мс · p95 %6.2f мс · макс %6.2f мс', $p(0.5), $p(0.95), max($ms));
};

try {
    if ($cleanup() > 0) {
        echo "Прибрано залишки попереднього запуску.\n";
    }
    promo_admin_set_setting($pdo, 'enabled', '1');
    promo_settings($pdo, true);
    site_settings_save($pdo, ['marketplace_public' => '1']);   // місця маркетплейсу доступні
    if (!promo_video_ready($pdo)) {
        throw new RuntimeException('promo_video_ready = false: немає config/promo.php із секретом');
    }
    $pdo->prepare('INSERT INTO ad_balances (user_id, balance, currency) VALUES (:u, 100000000, :c)
                   ON DUPLICATE KEY UPDATE balance = 100000000, currency = :c2')->execute([':u' => $userId, ':c' => PROMO_CURRENCY, ':c2' => PROMO_CURRENCY]);

    $subs = $pdo->query('SELECT id, category_id FROM subcategories ORDER BY id')->fetchAll(PDO::FETCH_KEY_PAIR);
    $subIds = array_keys($subs);
    $catIds = array_values(array_unique(array_values($subs)));
    $placements = ['subcategory_list', 'search_results', 'category_page', 'product_page', 'blog_list', 'marketplace_feed', 'marketplace_search'];

    // --- Генерація -------------------------------------------------------------
    $t0 = microtime(true);
    mt_srand(42);
    $today = promo_today();
    $pdo->beginTransaction();
    for ($done = 0; $done < $n; $done += 500) {
        $batch = min(500, $n - $done);
        $rows = [];
        for ($i = 0; $i < $batch; $i++) {
            $rows[] = sprintf("('paid','video',%d,%s,%s,'load@example.test','clicks','cpc',25,%d,%s,'active',%s,'ai_tools')",
                $userId, $pdo->quote($marker . '-' . ($done + $i)), $pdo->quote($marker), mt_rand(5000, 500000), $pdo->quote($today), $pdo->quote(PROMO_CURRENCY));
        }
        $pdo->exec('INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective, pricing_model,
                        unit_price, total_budget, start_date, status, currency, advertiser_category) VALUES ' . implode(',', $rows));
        $first = (int) $pdo->lastInsertId();   // multi-row INSERT: id першого рядка, далі підряд
        $cr = [];
        $tg = [];
        for ($i = 0; $i < $batch; $i++) {
            $cid = $first + $i;
            $cr[] = sprintf("(%d,%s,'load test','learn_more','https://example.com/','youtube','dQw4w9WgXcQ','approved','video',1)", $cid, $pdo->quote($marker . ' ' . $cid));
            foreach ((array) array_rand(array_flip($placements), mt_rand(2, 5)) as $pl) {
                $r = mt_rand(1, 100);
                if ($r <= 60) {
                    $tg[] = sprintf("(%d,'%s',NULL,NULL,25)", $cid, $pl);
                } elseif ($r <= 80) {
                    $tg[] = sprintf("(%d,'%s',%d,NULL,25)", $cid, $pl, $catIds[array_rand($catIds)]);
                } else {
                    $s = $subIds[array_rand($subIds)];
                    $tg[] = sprintf("(%d,'%s',NULL,%d,25)", $cid, $pl, $s);
                }
            }
        }
        $pdo->exec('INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, youtube_id, status, creative_type, weight) VALUES ' . implode(',', $cr));
        foreach (array_chunk($tg, 1000) as $chunk) {
            $pdo->exec('INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, unit_price) VALUES ' . implode(',', $chunk));
        }
    }
    $pdo->commit();
    $targets = (int) $one('SELECT COUNT(*) FROM ad_targets t JOIN ad_campaigns c ON c.id = t.campaign_id WHERE c.advertiser_name = :m', [':m' => $marker]);
    printf("Створено: %d кампаній, %d креативів, %d таргетів за %.1f с\n", $n, $n, $targets, microtime(true) - $t0);
    printf("Кеш: %s\n\n", promo_cache_apcu() ? 'APCu' : 'файли storage/cache/promo (APCu немає)');

    // --- Виміри ----------------------------------------------------------------
    $sub = $subIds[intdiv(count($subIds), 2)];
    $contexts = [
        'підкатегорія (subcategory_list)' => ['subcategory_list', [$subs[$sub]], [$sub], []],
        'категорія (category_page)' => ['category_page', [$catIds[0]], [], []],
        'пошук (search_results)' => ['search_results', [], [], []],
        'Marketplace (marketplace_feed)' => ['marketplace_feed', [], [], ['mp' => ['board', 'solutions']]],
    ];
    // План запиту кандидатів (підкатегорія).
    [$pl0, $c0, $s0] = $contexts['підкатегорія (subcategory_list)'];
    [$sql, $params] = promo_candidates_sql($pdo, $pl0, $c0, $s0, 'uk', 'desktop', [], false, promo_today());
    $ex = $pdo->prepare('EXPLAIN ' . $sql);
    $ex->execute($params);
    echo "EXPLAIN запиту кандидатів (підкатегорія):\n";
    foreach ($ex->fetchAll(PDO::FETCH_ASSOC) as $r) {
        printf("  %-18s %-6s %-7s key=%-34s rows=%-6s %s\n", (string) $r['select_type'], (string) $r['table'], (string) $r['type'], (string) ($r['key'] ?? '—'), (string) $r['rows'], (string) ($r['Extra'] ?? ''));
    }
    echo "\n";

    foreach ($contexts as $label => [$pl, $cats, $ss, $page]) {
        $cold = [];
        $first = [];
        $warm = [];
        $setCold = [];
        $setWarm = [];
        $count = 0;
        for ($i = 0; $i < $runs; $i++) {
            promo_cache_flush();
            $t = hrtime(true);
            $count = count(promo_candidates($pdo, $pl, $cats, $ss, 'uk', 'desktop', (array) ($page['mp'] ?? [])));
            $cold[] = (hrtime(true) - $t) / 1e6;
            // Перше читання щойно записаного файлу (на Windows його ще сканує антивірус), далі — звичайні читання.
            $t = hrtime(true);
            promo_candidates($pdo, $pl, $cats, $ss, 'uk', 'desktop', (array) ($page['mp'] ?? []));
            $first[] = (hrtime(true) - $t) / 1e6;
            $t = hrtime(true);
            promo_candidates($pdo, $pl, $cats, $ss, 'uk', 'desktop', (array) ($page['mp'] ?? []));
            $warm[] = (hrtime(true) - $t) / 1e6;

            $sh = hash('sha256', 'load' . $i . $label);
            promo_cache_flush();
            $t = hrtime(true);
            $set = promo_pick_set($pdo, $pl, $cats, $ss, 'uk', 'desktop', $sh, $page);
            $setCold[] = (hrtime(true) - $t) / 1e6;
            promo_pick_set($pdo, $pl, $cats, $ss, 'uk', 'desktop', $sh, $page);   // перше читання файлу — не міряємо
            $t = hrtime(true);
            promo_pick_set($pdo, $pl, $cats, $ss, 'uk', 'desktop', $sh, $page, array_map(static fn($r) => (int) $r['id'], $set));
            $setWarm[] = (hrtime(true) - $t) / 1e6;
        }
        printf("%s — допустимих кандидатів: %d, обрано %d (%d вимірів)\n", $label, $count, count($set), $runs);
        printf("  кандидати без кешу:          %s\n", $stats($cold));
        printf("  кеш, 1-ше читання файлу:     %s\n", $stats($first));
        printf("  кандидати з кешем:           %s\n", $stats($warm));
        printf("  повний вибір 5, без кешу:    %s\n", $stats($setCold));
        printf("  повний вибір 5, з кешем:     %s\n\n", $stats($setWarm));
    }
} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    echo 'ПОМИЛКА: ' . $e->getMessage() . "\n";
} finally {
    $removed = $cleanup();
    if ($oldBalance === null) {
        $pdo->prepare('DELETE FROM ad_balances WHERE user_id = :u')->execute([':u' => $userId]);
    } else {
        $pdo->prepare('UPDATE ad_balances SET balance = :b, currency = :c WHERE user_id = :u')->execute([':b' => $oldBalance['balance'], ':c' => $oldBalance['currency'], ':u' => $userId]);
    }
    promo_admin_set_setting($pdo, 'enabled', $oldEnabled);
    site_settings_save($pdo, ['marketplace_public' => $oldMpPublic]);
    promo_cache_flush();
    promo_cache_gc();
    $left = (int) $one('SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = :m', [':m' => $marker]);
    printf("Прибирання: видалено %d тестових кампаній (з креативами й таргетами), залишилось %d.\n", $removed, $left);
}

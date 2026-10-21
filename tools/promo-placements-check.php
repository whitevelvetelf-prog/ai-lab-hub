<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка місць показу реклами (ЛИШЕ локально, CLI):
 *   php tools/promo-placements-check.php [http://ai-lab-hub.test]
 *
 * Для КОЖНОГО місця: відбір (promo_pick), облік показу й кліку (ad_events,
 * ad_stats_daily), списання CPC з балансу; вимкнене місце не показується; місце без
 * ціни не обирається; сторінка no_promo без реклами; стара кампанія (catalog_card,
 * blog_inline) показується й списується як раніше; виключення повторів (exclude).
 * HTTP: слоти є на сторінках місць і немає на головній, у Елі, на вході, реєстрації,
 * у кабінеті й на сторінці no_promo; promo-serve віддає креатив / 204.
 * Маркетплейс (з 2026-10-20): п'ять місць; таргетинг за розділом; кампанія лише з місцями
 * закритого маркетплейсу — «Очікує показу», без показу й списань, після відкриття показ без
 * повторної модерації; старий ключ marketplace_listing працює як marketplace_feed; реклами
 * немає на сторінках подачі й редагування оголошень і в «Моїх оголошеннях».
 *
 * Створює тимчасові кампанії й тимчасово вмикає рекламу (ad_settings.enabled) —
 * у finally все повертається як було, тестові рядки видаляються. Виводить PASS/FAIL.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$_SERVER['HTTP_USER_AGENT'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) promo-placements-check';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/promo-placement-picker.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');

$fails = 0;
$results = [];
$check = static function (string $group, string $name, bool $ok, string $info = '') use (&$fails, &$results): void {
    $results[$group][] = [$ok, $name, $info];
    if (!$ok) {
        $fails++;
    }
};
$one = static function (string $sql, array $p = []) use ($pdo): mixed {
    $st = $pdo->prepare($sql);
    $st->execute($p);

    return $st->fetchColumn();
};
$http = static function (string $path) use ($base): array {
    $ctx = stream_context_create(['http' => ['header' => "User-Agent: Mozilla/5.0 (Windows NT 10.0) promo-check\r\n", 'ignore_errors' => true, 'timeout' => 30, 'follow_location' => 1]]);
    $body = @file_get_contents($base . '/' . ltrim($path, '/'), false, $ctx);
    $code = 0;
    foreach ($http_response_header ?? [] as $h) {
        if (preg_match('~^HTTP/\S+\s+(\d+)~', $h, $m)) {
            $code = (int) $m[1];
        }
    }

    return [$code, (string) $body];
};

// --- Знімок стану, який тест змінює ------------------------------------------
$userId = (int) $one("SELECT id FROM users WHERE role <> 'admin' ORDER BY id DESC LIMIT 1");
$oldEnabled = promo_setting($pdo, 'enabled', '0');
$oldCap = promo_setting($pdo, 'frequency_cap_per_session', '3');
$oldBalance = $pdo->prepare('SELECT * FROM ad_balances WHERE user_id = :u');
$oldBalance->execute([':u' => $userId]);
$oldBalance = $oldBalance->fetch() ?: null;
$oldPlacements = $pdo->query('SELECT placement_key, enabled, slots_per_page FROM ad_placements')->fetchAll();
$oldMpPublic = site_setting($pdo, 'marketplace_public', '0');
$oldRates = $pdo->query('SELECT id, active FROM ad_rate_card')->fetchAll(PDO::FETCH_KEY_PAIR);
$campaignIds = [];
$tmpRates = [];

$mkCampaign = static function (string $name, array $targets, string $type = 'paid') use ($pdo, $userId, &$campaignIds): array {
    $pdo->prepare(
        "INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective, pricing_model,
             unit_price, total_budget, start_date, status, currency, advertiser_category)
         VALUES (:t, 'video', :u, :n, 'check', 'check@example.test', 'clicks', 'cpc', 25, 100000, :d, 'active', :cur, 'ai_tools')"
    )->execute([':t' => $type, ':u' => $userId, ':n' => $name, ':d' => promo_today(), ':cur' => PROMO_CURRENCY]);
    $cid = (int) $pdo->lastInsertId();
    $campaignIds[] = $cid;
    $pdo->prepare(
        "INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, youtube_id, status)
         VALUES (:c, :t, 'check', 'learn_more', 'https://example.com/', 'youtube', 'dQw4w9WgXcQ', 'approved')"
    )->execute([':c' => $cid, ':t' => $name]);
    $crid = (int) $pdo->lastInsertId();
    $ins = $pdo->prepare('INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, language, device, unit_price) VALUES (:c, :p, NULL, NULL, NULL, NULL, :pr)');
    foreach ($targets as $pl => $price) {
        $ins->execute([':c' => $cid, ':p' => $pl, ':pr' => $price]);
    }

    promo_cache_flush();   // нова кампанія — кеш кандидатів (app/promo-select.php) застарів
    return [$cid, $crid];
};

try {
    // Підготовка: реклама ввімкнена, маркетплейс відкритий, усі місця ввімкнені, баланс.
    promo_admin_set_setting($pdo, 'enabled', '1');
    promo_admin_set_setting($pdo, 'frequency_cap_per_session', '0');
    promo_settings($pdo, true);
    site_settings_save($pdo, ['marketplace_public' => '1']);
    $pdo->exec("UPDATE ad_placements SET enabled = 1, slots_per_page = 1 WHERE placement_key <> 'marketplace_listing'");
    promo_placements($pdo, true);
    $pdo->prepare('INSERT INTO ad_balances (user_id, balance, currency) VALUES (:u, 100000, :c)
                   ON DUPLICATE KEY UPDATE balance = 100000, currency = :c2')->execute([':u' => $userId, ':c' => PROMO_CURRENCY, ':c2' => PROMO_CURRENCY]);
    if (!promo_video_ready($pdo)) {
        throw new RuntimeException('promo_video_ready = false: немає config/promo.php із секретом');
    }

    $catId = (int) $one('SELECT c.id FROM categories c WHERE c.no_promo = 0 ORDER BY c.id LIMIT 1');
    $subId = (int) $one('SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE s.no_promo = 0 AND c.no_promo = 0 ORDER BY s.id LIMIT 1');
    $productId = (int) $one("SELECT p.id FROM products p WHERE p.status = 'published' AND p.no_promo = 0
                             AND NOT EXISTS (SELECT 1 FROM product_categories pc JOIN categories c ON c.id = pc.category_id WHERE pc.product_id = p.id AND c.no_promo = 1)
                             AND NOT EXISTS (SELECT 1 FROM product_subcategories ps JOIN subcategories s ON s.id = ps.subcategory_id WHERE ps.product_id = p.id AND s.no_promo = 1)
                             ORDER BY p.id LIMIT 1");
    $article = (string) (parse_url((string) promo_admin_placement_preview_url($pdo, 'blog_article'), PHP_URL_QUERY) ?: '');
    parse_str($article, $aq);
    $article = (string) ($aq['slug'] ?? '');
    $flagged = (string) ($one('SELECT slug FROM promo_blog_flags WHERE no_promo = 1 LIMIT 1') ?: '');
    // Живе оголошення компанії (сторінка оголошення маркетплейсу).
    $lstRow = $pdo->query("SELECT id, section FROM mp_listings WHERE section IN ('job', 'course', 'service') AND status = 'published' AND expires_at > NOW() ORDER BY id LIMIT 1")->fetch();
    $lstUrl = $lstRow ? 'listing.php?id=' . (int) $lstRow['id'] : 'marketplace-offer.php?id=' . (int) $one("SELECT id FROM mp_listings WHERE section = 'solution' AND status = 'published' ORDER BY id LIMIT 1");
    $lstSec = $lstRow ? (string) $lstRow['section'] : 'solutions';

    $ctx = [
        'category_page' => [[$catId], [], [], 'category.php?id=' . $catId],
        'subcategory_list' => [[], [$subId], [], 'catalog.php?subcategory=' . $subId],
        'search_results' => [[], [], [], 'catalog.php?search=ai'],
        'product_page' => [[], [], ['product' => $productId], 'product.php?id=' . $productId],
        'blog_list' => [[], [], [], 'blog.php'],
        'blog_article' => [[], [], ['article' => $article], 'blog-post.php?slug=' . rawurlencode($article)],
        'marketplace_home' => [[], [], ['mp' => ['board', 'solutions']], 'marketplace.php'],
        'marketplace_feed' => [[], [], ['mp' => ['board', 'solutions']], 'marketplace.php'],
        'marketplace_category' => [[], [], ['mp' => ['course']], 'listings.php?type=course'],
        'marketplace_search' => [[], [], ['mp' => ['board', 'solutions']], 'marketplace.php?q=a'],
        'marketplace_listing_page' => [[], [], ['mp' => [$lstSec]], $lstUrl],
        'popup' => [[], [], [], 'catalog.php?subcategory=' . $subId],
    ];
    // З 2026-10-21 реклама в списках — спливаюче вікно: місця-списки вимкнені й слотів на сторінках не мають,
    // а 'popup' підключає лише скрипт (вікно показує JS через /ad-next.php).
    $noSlot = ['category_page', 'subcategory_list', 'search_results', 'marketplace_feed', 'marketplace_category', 'marketplace_search', 'popup'];
    $serveQs = static fn(array $cats, array $subs, array $page): string => '&category=' . implode(',', $cats) . '&subcategory=' . implode(',', $subs)
        . (!empty($page['product']) ? '&product=' . $page['product'] : '') . (!empty($page['article']) ? '&article=' . $page['article'] : '')
        . (!empty($page['mp']) ? '&mp=' . implode(',', $page['mp']) : '');

    $targets = [];
    foreach (PROMO_PLACEMENTS as $pl) {
        $targets[$pl] = 25;
    }
    [$mainCid, $mainCr] = $mkCampaign('CHECK main', $targets);
    $balanceOf = static fn(): int => (int) $one('SELECT balance FROM ad_balances WHERE user_id = :u', [':u' => $userId]);

    // --- Кожне місце: показ, облік, списання, вимкнення ------------------------
    foreach (PROMO_PLACEMENTS as $i => $pl) {
        [$cats, $subs, $page] = $ctx[$pl];
        $g = $pl;
        promo_cache_flush();
        $sh = hash('sha256', 'check-' . $pl . '-' . microtime());
        $picked = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', $sh, $page);
        $check($g, 'відбір повертає креатив', $picked !== null && (int) $picked['id'] === $mainCr);

        $before = $balanceOf();
        $imp = promo_record_event($pdo, $mainCr, 'impression', $pl, $sh);
        $clk = promo_record_event($pdo, $mainCr, 'click', $pl, $sh);
        // З 2026-10-21 сирий рядок пишеться лише для кліку; показ — тільки агрегат ad_stats_daily.
        $events = (int) $one('SELECT COUNT(*) FROM ad_events WHERE creative_id = :c AND placement = :p', [':c' => $mainCr, ':p' => $pl]);
        $stats = $pdo->prepare('SELECT impressions, clicks, spend FROM ad_stats_daily WHERE creative_id = :c AND placement = :p AND stat_date = :d');
        $stats->execute([':c' => $mainCr, ':p' => $pl, ':d' => promo_today()]);
        $st = $stats->fetch() ?: ['impressions' => 0, 'clicks' => 0, 'spend' => 0];
        $check($g, 'облік показу (лише ad_stats_daily) і кліку (ad_events + ad_stats_daily)', $imp && $clk && $events === 1 && (int) $st['impressions'] === 1 && (int) $st['clicks'] === 1,
            "events={$events}, stats={$st['impressions']}/{$st['clicks']}");
        $check($g, 'списання CPC 0,25 $ з балансу', $before - $balanceOf() === 25 && (int) $st['spend'] === 25, 'списано ' . ($before - $balanceOf()));

        $pdo->prepare('UPDATE ad_placements SET enabled = 0 WHERE placement_key = :k')->execute([':k' => $pl]);
        promo_placements($pdo, true);
        $off = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', hash('sha256', 'off' . $pl), $page);
        [$code] = $http('promo-serve.php?placement=' . $pl . $serveQs($cats, $subs, $page));
        [, $html] = $http($ctx[$pl][3]);
        $check($g, 'вимкнене місце не показується (відбір, promo-serve 204, без слота на сторінці)',
            $off === null && $code === 204 && !str_contains($html, 'sponsored-slot--' . $pl), "serve={$code}");
        $pdo->prepare('UPDATE ad_placements SET enabled = 1 WHERE placement_key = :k')->execute([':k' => $pl]);
        promo_placements($pdo, true);

        [$code, $body] = $http('promo-serve.php?placement=' . $pl . $serveQs($cats, $subs, $page));
        $json = json_decode($body, true);
        $check($g, 'promo-serve віддає креатив', $code === 200 && (int) ($json['creative']['id'] ?? 0) === $mainCr, "serve={$code}");
        [$code] = $http('promo-serve.php?placement=' . $pl . '&exclude=' . $mainCr . $serveQs($cats, $subs, $page));
        $check($g, 'той самий креатив не повторюється на сторінці (exclude → 204)', $code === 204, "serve={$code}");
        [$code, $html] = $http($ctx[$pl][3]);
        // Списки — нативна картка (app/ad-card.php, data-native), блоки — порожній слот promo_slot.
        if ($pl === 'popup') {
            $check($g, 'скрипт вікна на сторінці ' . $ctx[$pl][3], $code === 200 && str_contains($html, 'id="ad-popup-config"'), "http={$code}");
        } elseif (in_array($pl, $noSlot, true)) {
            $check($g, 'у списку на ' . $ctx[$pl][3] . ' рекламних карток немає', $code === 200 && !str_contains($html, 'sponsored-slot--' . $pl), "http={$code}");
        } else {
            $check($g, 'слот на сторінці ' . $ctx[$pl][3], $code === 200 && preg_match_all('~class="sponsored-slot sponsored-slot--' . $pl . '"~', $html) === 1, "http={$code}");
        }

        // Без ціни місце не обирається (майстер і зміна місць).
        $rates = promo_rate_card($pdo);
        unset($rates[$pl]['cpc']);
        $check($g, 'без ціни не обирається в майстрі', !in_array($pl, promo_placements_selectable($pdo, $rates, 'cpc'), true));
        $pdo->prepare('UPDATE ad_rate_card SET active = 0 WHERE placement = :p AND pricing_model = \'cpc\'')->execute([':p' => $pl]);
        [$ok, $msg] = promo_update_placements($pdo, $userId, $mainCid, [$pl]);
        $check($g, 'без ціни не зберігається в «Місця показу»', !$ok && $msg === 'err_no_price', $msg);
        foreach ($oldRates as $rid => $active) {
            $pdo->prepare('UPDATE ad_rate_card SET active = :a WHERE id = :id')->execute([':a' => $active, ':id' => $rid]);
        }
    }

    // --- Ліміт блоків на сторінку ----------------------------------------------
    $s1 = promo_slot($pdo, 'search_results');
    $s2 = promo_slot($pdo, 'search_results');
    $check('загальне', 'не більше slots_per_page блоків місця на сторінку', $s1 !== '' && $s2 === '');
    foreach (['marketplace_home', 'marketplace_feed', 'marketplace_category', 'marketplace_search', 'marketplace_listing_page'] as $pl) {
        $m1 = promo_slot($pdo, $pl, [], [], ['mp' => ['board']]);
        $m2 = promo_slot($pdo, $pl, [], [], ['mp' => ['board']]);
        $check($pl, 'не більше slots_per_page блоків на сторінку; блок позначено групою маркетплейсу', $m1 !== '' && $m2 === '' && str_contains($m1, 'data-group="marketplace"'));
    }
    // Позиції в стрічці: 4-та, далі кожні 10 справжніх карток, не більше slots_per_page.
    $pdo->exec("UPDATE ad_placements SET slots_per_page = 3 WHERE placement_key = 'marketplace_feed'");
    promo_placements($pdo, true);
    $pos30 = promo_placement_positions($pdo, 'marketplace_feed', 30);
    $pos12 = promo_placement_positions($pdo, 'marketplace_feed', 12);
    $pos2 = promo_placement_positions($pdo, 'marketplace_feed', 2);
    $pdo->exec("UPDATE ad_placements SET slots_per_page = 1 WHERE placement_key = 'marketplace_feed'");
    promo_placements($pdo, true);
    $check('marketplace_feed', 'позиції: 3-тя й далі кожні 8 (30 карток → 3, 11, 19; 12 → 3, 11; 2 → у кінці)',
        $pos30 === [2, 10, 18] && $pos12 === [2, 10] && $pos2 === [2], json_encode([$pos30, $pos12, $pos2]));
    $check('marketplace_feed', 'slots_per_page = 1 → одна картка навіть у довгій стрічці', promo_placement_positions($pdo, 'marketplace_feed', 30) === [2]);

    // --- Маркетплейс: таргетинг за розділом ---------------------------------------
    [$jobCid, $jobCr] = $mkCampaign('CHECK mp job', []);
    $pdo->prepare("INSERT INTO ad_targets (campaign_id, placement, mp_section, unit_price) VALUES (:c, 'marketplace_category', 'job', 25)")->execute([':c' => $jobCid]);
    promo_cache_flush();
    $pJob = promo_pick($pdo, 'marketplace_category', [], [], 'uk', 'desktop', hash('sha256', 'job' . microtime()), ['mp' => ['job']], [$mainCr]);
    $pCourse = promo_pick($pdo, 'marketplace_category', [], [], 'uk', 'desktop', hash('sha256', 'course' . microtime()), ['mp' => ['course']], [$mainCr]);
    $pCat = promo_pick($pdo, 'marketplace_category', [$catId], [], 'uk', 'desktop', hash('sha256', 'cat' . microtime()), ['mp' => ['job']], [$mainCr]);
    $check('маркетплейс: розділи', 'реклама для «Вакансій» — лише у вакансіях; категорії каталогу на маркетплейс не впливають',
        $pJob !== null && (int) $pJob['id'] === $jobCr && $pCourse === null && $pCat !== null,
        json_encode([$pJob['id'] ?? null, $pCourse['id'] ?? null, $pCat['id'] ?? null, $jobCr]));
    $boardCat = (int) $one("SELECT id FROM mp_categories WHERE section = 'board' AND is_active = 1 ORDER BY id LIMIT 1");
    if ($boardCat > 0) {
        $pdo->prepare("UPDATE ad_targets SET mp_section = :s WHERE campaign_id = :c")->execute([':s' => 'board:' . $boardCat, ':c' => $jobCid]);
        promo_cache_flush();
        $pIn = promo_pick($pdo, 'marketplace_category', [], [], 'uk', 'desktop', hash('sha256', 'b1' . microtime()), ['mp' => promo_mp_page_sections('board', $boardCat)], [$mainCr]);
        $pOut = promo_pick($pdo, 'marketplace_category', [], [], 'uk', 'desktop', hash('sha256', 'b2' . microtime()), ['mp' => ['board']], [$mainCr]);
        $check('маркетплейс: розділи', 'категорія оголошень: показ лише в цій категорії', $pIn !== null && (int) $pIn['id'] === $jobCr && $pOut === null);
    }
    $wizard = promo_mp_sections_from_input($pdo, ['mp_sections' => ['job', 'board', 'bogus'], 'mp_board_cats' => [$boardCat]]);
    $check('маркетплейс: розділи', 'форма: зайві значення відкидаються, «Оголошення» цілком поглинає їхні категорії', $wizard === ['job', 'board'], json_encode($wizard));

    // --- Маркетплейс ще не відкрито: «Очікує показу» ------------------------------
    [$waitCid, $waitCr] = $mkCampaign('CHECK mp waiting', ['marketplace_feed' => 25, 'marketplace_listing_page' => 25]);
    site_settings_save($pdo, ['marketplace_public' => '0']);
    $before = $balanceOf();
    $wPlaces = promo_campaign_targeting($pdo, $waitCid)['placements'];
    $check('маркетплейс закрито', 'місця можна обрати (ad_allow_marketplace_preselect = 1), але вони недоступні для показу',
        promo_placement_selectable_now($pdo, 'marketplace_feed') && !promo_placement_available($pdo, 'marketplace_feed') && promo_placement_pending($pdo, 'marketplace_feed'));
    $check('маркетплейс закрито', 'кампанія лише з місцями маркетплейсу — «Очікує показу»', promo_placements_waiting($pdo, $wPlaces));
    $check('маркетплейс закрито', 'кампанія з місцями сайту — НЕ «Очікує показу»', !promo_placements_waiting($pdo, ['marketplace_feed', 'product_page']));
    $wPick = promo_pick($pdo, 'marketplace_feed', [], [], 'uk', 'desktop', hash('sha256', 'w' . microtime()), ['mp' => ['board']]);
    [$wCode] = $http('promo-serve.php?placement=marketplace_feed&mp=board');
    [, $wHtml] = $http('marketplace.php');
    $check('маркетплейс закрито', 'реклама не показується (відбір, promo-serve 204, без слотів), бюджет не списується',
        $wPick === null && $wCode === 204 && !str_contains($wHtml, 'sponsored-slot') && $balanceOf() === $before, "serve={$wCode}");
    // Ціни для місць маркетплейсу (локально їх може не бути) — тимчасові рядки прайсу.
    foreach (['marketplace_feed', 'marketplace_home'] as $pl) {
        if (!$one("SELECT COUNT(*) FROM ad_rate_card WHERE placement = :p AND pricing_model = 'cpc' AND currency = :c", [':p' => $pl, ':c' => PROMO_CURRENCY])) {
            $pdo->prepare("INSERT INTO ad_rate_card (placement, pricing_model, price, currency, active) VALUES (:p, 'cpc', 25, :c, 1)")->execute([':p' => $pl, ':c' => PROMO_CURRENCY]);
            $tmpRates[] = (int) $pdo->lastInsertId();
        }
    }
    [$okUp, $msgUp] = promo_update_placements($pdo, $userId, $waitCid, ['marketplace_feed', 'marketplace_home']);
    promo_cache_flush();
    $check('маркетплейс закрито', 'зміна місць на маркетплейс-місця до відкриття дозволена', $okUp, $msgUp);
    $pdo->prepare("UPDATE ad_settings SET setting_value = '0' WHERE setting_key = 'ad_allow_marketplace_preselect'")->execute();
    $check('маркетплейс закрито', 'ad_allow_marketplace_preselect = 0 → місця не обираються', !promo_placement_selectable_now($pdo, 'marketplace_feed'));
    $pdo->prepare("UPDATE ad_settings SET setting_value = '1' WHERE setting_key = 'ad_allow_marketplace_preselect'")->execute();
    site_settings_save($pdo, ['marketplace_public' => '1']);
    $status = (string) $one('SELECT status FROM ad_campaigns WHERE id = :c', [':c' => $waitCid]);
    $oPick = promo_pick($pdo, 'marketplace_feed', [], [], 'uk', 'desktop', hash('sha256', 'o' . microtime()), ['mp' => ['board']], [$mainCr]);
    $check('маркетплейс закрито', 'після відкриття показ починається без повторної модерації',
        $status === 'active' && $oPick !== null && (int) $oPick['id'] === $waitCr && !promo_placements_waiting($pdo, promo_campaign_targeting($pdo, $waitCid)['placements']));

    // --- Старий ключ marketplace_listing → marketplace_feed -----------------------
    [$oldMpCid, $oldMpCr] = $mkCampaign('CHECK mp legacy', ['marketplace_listing' => 30]);
    $sh = hash('sha256', 'mpl' . microtime());
    $lp = promo_pick($pdo, 'marketplace_feed', [], [], 'uk', 'desktop', $sh, ['mp' => ['board', 'solutions']], [$mainCr, $waitCr]);
    $before = $balanceOf();
    promo_record_event($pdo, $oldMpCr, 'click', 'marketplace_feed', $sh);
    $check('стара кампанія', 'marketplace_listing показується в стрічці маркетплейсу й списує свою ціну (0,30 $)',
        $lp !== null && (int) $lp['id'] === $oldMpCr && $before - $balanceOf() === 30, 'списано ' . ($before - $balanceOf()) . ' picked=' . ($lp['id'] ?? 'null') . ' want=' . $oldMpCr);
    $check('стара кампанія', 'у майстрі marketplace_listing показується як «Стрічка оголошень»',
        promo_campaign_targeting($pdo, $oldMpCid)['placements'] === ['marketplace_feed']);

    // --- no_promo --------------------------------------------------------------
    if ($flagged !== '') {
        $check('загальне', 'стаття no_promo без реклами (відбір)', promo_pick($pdo, 'blog_article', [], [], 'uk', 'desktop', hash('sha256', 'np'), ['article' => $flagged]) === null);
        [$code, $html] = $http('blog-post.php?slug=' . rawurlencode($flagged));
        $check('загальне', 'стаття no_promo без слота (' . $flagged . ')', $code === 200 && !str_contains($html, 'sponsored-slot'), "http={$code}");
    } else {
        $check('загальне', 'стаття no_promo — у локальній базі немає позначених статей', true, 'пропущено');
    }

    // --- Стара кампанія (catalog_card, blog_inline, product_page) ---------------
    [$legacyCid, $legacyCr] = $mkCampaign('CHECK legacy', ['catalog_card' => 30, 'product_page' => 30, 'blog_inline' => 30]);
    foreach (['subcategory_list', 'search_results', 'product_page', 'blog_article'] as $pl) {
        [$cats, $subs, $page] = $ctx[$pl];
        $sh = hash('sha256', 'legacy-' . $pl . microtime());
        $p = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', $sh, $page, [$mainCr]);
        $before = $balanceOf();
        promo_record_event($pdo, $legacyCr, 'click', $pl, $sh);
        $check('стара кампанія', $pl . ': показується й списує ціну зі свого таргету (0,30 $)', $p !== null && (int) $p['id'] === $legacyCr && $before - $balanceOf() === 30,
            'списано ' . ($before - $balanceOf()));
    }
    foreach (['category_page', 'blog_list'] as $pl) {
        [$cats, $subs, $page] = $ctx[$pl];
        $p = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', hash('sha256', 'legacy2' . $pl), $page, [$mainCr]);
        $check('стара кампанія', $pl . ': не з\'являється на нових місцях, яких не мала', $p === null);
    }
    $check('стара кампанія', 'у майстрі старі ключі показуються як нові місця',
        promo_campaign_targeting($pdo, $legacyCid)['placements'] === ['subcategory_list', 'search_results', 'product_page', 'blog_article']);

    // --- Сторінки, де реклами не буває -----------------------------------------
    foreach (['index.php' => 'головна', 'eli.php' => 'Еля', 'login.php' => 'вхід', 'register.php' => 'реєстрація', 'account.php' => 'кабінет (без входу → вхід)'] as $path => $label) {
        [$code, $html] = $http($path);
        $check('без реклами', $label . ' — немає слота відеореклами', $code === 200 && !str_contains($html, 'sponsored-slot'), "http={$code}");
    }
    $eliCode = '';
    foreach (['public/api-eli-chat.php', 'app/eli.php', 'app/eli-search.php', 'public/eli.php', 'app/footer.php', 'public/account.php', 'public/login.php', 'public/register.php', 'public/index.php'] as $f) {
        $eliCode .= (string) @file_get_contents(__DIR__ . '/../' . $f);
    }
    $check('без реклами', 'Еля, підвал, кабінет, вхід, реєстрація, головна не викликають promo_slot', !str_contains($eliCode, 'promo_slot'));
    $mpNoAds = '';
    foreach (['public/listing-post.php', 'public/marketplace-post.php', 'public/mp-post.php', 'public/mp-add-offer.php', 'public/marketplace-my.php', 'public/mp-my.php',
              'public/marketplace-favorites.php', 'public/mp-favorites.php', 'app/listing-account.php', 'app/listing-admin-cabinet.php', 'public/marketplace-join.php', 'public/marketplace-rules.php'] as $f) {
        $mpNoAds .= (string) @file_get_contents(__DIR__ . '/../' . $f);
    }
    $check('без реклами', 'подача й редагування оголошень, «Мої оголошення», вибране, правила маркетплейсу не викликають promo_slot', !str_contains($mpNoAds, 'promo_slot'));
} catch (Throwable $e) {
    $check('загальне', 'виняток: ' . $e->getMessage(), false);
} finally {
    // --- Прибирання: тестові рядки й налаштування як були ------------------------
    foreach ($campaignIds as $cid) {
        foreach (['ad_events', 'ad_stats_daily', 'ad_targets', 'ad_transactions'] as $tbl) {
            $pdo->prepare("DELETE FROM {$tbl} WHERE campaign_id = :c")->execute([':c' => $cid]);
        }
        $pdo->prepare('DELETE FROM ad_creatives WHERE campaign_id = :c')->execute([':c' => $cid]);
        $pdo->prepare('DELETE FROM promo_event_log WHERE campaign_id = :c')->execute([':c' => $cid]);
        $pdo->prepare('DELETE FROM ad_campaigns WHERE id = :c')->execute([':c' => $cid]);
    }
    if ($oldBalance === null) {
        $pdo->prepare('DELETE FROM ad_balances WHERE user_id = :u')->execute([':u' => $userId]);
    } else {
        $pdo->prepare('UPDATE ad_balances SET balance = :b, currency = :c WHERE user_id = :u')->execute([':b' => $oldBalance['balance'], ':c' => $oldBalance['currency'], ':u' => $userId]);
    }
    foreach ($oldPlacements as $r) {
        $pdo->prepare('UPDATE ad_placements SET enabled = :e, slots_per_page = :s WHERE placement_key = :k')->execute([':e' => $r['enabled'], ':s' => $r['slots_per_page'], ':k' => $r['placement_key']]);
    }
    foreach ($oldRates as $rid => $active) {
        $pdo->prepare('UPDATE ad_rate_card SET active = :a WHERE id = :id')->execute([':a' => $active, ':id' => $rid]);
    }
    foreach ($tmpRates as $rid) {
        $pdo->prepare('DELETE FROM ad_rate_card WHERE id = :id')->execute([':id' => $rid]);
    }
    promo_admin_set_setting($pdo, 'frequency_cap_per_session', $oldCap);
    promo_admin_set_setting($pdo, 'enabled', $oldEnabled);
    site_settings_save($pdo, ['marketplace_public' => $oldMpPublic]);
}

foreach ($results as $group => $rows) {
    $groupOk = !in_array(false, array_column($rows, 0), true);
    echo ($groupOk ? 'PASS ' : 'FAIL ') . $group . "\n";
    foreach ($rows as [$ok, $name, $info]) {
        echo '   ' . ($ok ? 'ok   ' : 'FAIL ') . $name . ($info !== '' && !$ok ? ' — ' . $info : '') . "\n";
    }
}
echo $fails === 0 ? "\nУСЕ PASS\n" : "\nFAIL: {$fails}\n";
exit($fails === 0 ? 0 : 1);

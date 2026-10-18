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
$oldRates = $pdo->query('SELECT id, active FROM ad_rate_card')->fetchAll(PDO::FETCH_KEY_PAIR);
$campaignIds = [];

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

    return [$cid, $crid];
};

try {
    // Підготовка: реклама ввімкнена, усі місця (крім маркетплейсу) ввімкнені, баланс.
    promo_admin_set_setting($pdo, 'enabled', '1');
    promo_admin_set_setting($pdo, 'frequency_cap_per_session', '0');
    promo_settings($pdo, true);
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

    $ctx = [
        'category_page' => [[$catId], [], [], 'category.php?id=' . $catId],
        'subcategory_list' => [[], [$subId], [], 'catalog.php?subcategory=' . $subId],
        'search_results' => [[], [], [], 'catalog.php?search=ai'],
        'product_page' => [[], [], ['product' => $productId], 'product.php?id=' . $productId],
        'blog_list' => [[], [], [], 'blog.php'],
        'blog_article' => [[], [], ['article' => $article], 'blog-post.php?slug=' . rawurlencode($article)],
        'marketplace_listing' => [[], [], [], 'marketplace.php'],
    ];

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
        $sh = hash('sha256', 'check-' . $pl . '-' . microtime());
        $picked = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', $sh, $page);
        if ($pl === 'marketplace_listing') {
            $check($g, 'недоступне місце не показується (' . (promo_placement_block_reason($pdo, $pl) ?? 'доступне') . ')', $picked === null);
            continue;
        }
        $check($g, 'відбір повертає креатив', $picked !== null && (int) $picked['id'] === $mainCr);

        $before = $balanceOf();
        $imp = promo_record_event($pdo, $mainCr, 'impression', $pl, $sh);
        $clk = promo_record_event($pdo, $mainCr, 'click', $pl, $sh);
        $events = (int) $one('SELECT COUNT(*) FROM ad_events WHERE creative_id = :c AND placement = :p', [':c' => $mainCr, ':p' => $pl]);
        $stats = $pdo->prepare('SELECT impressions, clicks, spend FROM ad_stats_daily WHERE creative_id = :c AND placement = :p AND stat_date = :d');
        $stats->execute([':c' => $mainCr, ':p' => $pl, ':d' => promo_today()]);
        $st = $stats->fetch() ?: ['impressions' => 0, 'clicks' => 0, 'spend' => 0];
        $check($g, 'облік показу й кліку (ad_events, ad_stats_daily)', $imp && $clk && $events === 2 && (int) $st['impressions'] === 1 && (int) $st['clicks'] === 1,
            "events={$events}, stats={$st['impressions']}/{$st['clicks']}");
        $check($g, 'списання CPC 0,25 $ з балансу', $before - $balanceOf() === 25 && (int) $st['spend'] === 25, 'списано ' . ($before - $balanceOf()));

        $pdo->prepare('UPDATE ad_placements SET enabled = 0 WHERE placement_key = :k')->execute([':k' => $pl]);
        promo_placements($pdo, true);
        $off = promo_pick($pdo, $pl, $cats, $subs, 'uk', 'desktop', hash('sha256', 'off' . $pl), $page);
        [$code] = $http('promo-serve.php?placement=' . $pl . '&category=' . implode(',', $cats) . '&subcategory=' . implode(',', $subs)
            . (!empty($page['product']) ? '&product=' . $page['product'] : '') . (!empty($page['article']) ? '&article=' . $page['article'] : ''));
        [, $html] = $http($ctx[$pl][3]);
        $check($g, 'вимкнене місце не показується (відбір, promo-serve 204, без слота на сторінці)',
            $off === null && $code === 204 && !str_contains($html, 'sponsored-slot--' . $pl), "serve={$code}");
        $pdo->prepare('UPDATE ad_placements SET enabled = 1 WHERE placement_key = :k')->execute([':k' => $pl]);
        promo_placements($pdo, true);

        [$code, $body] = $http('promo-serve.php?placement=' . $pl . '&category=' . implode(',', $cats) . '&subcategory=' . implode(',', $subs)
            . (!empty($page['product']) ? '&product=' . $page['product'] : '') . (!empty($page['article']) ? '&article=' . $page['article'] : ''));
        $json = json_decode($body, true);
        $check($g, 'promo-serve віддає креатив', $code === 200 && (int) ($json['creative']['id'] ?? 0) === $mainCr, "serve={$code}");
        [$code] = $http('promo-serve.php?placement=' . $pl . '&exclude=' . $mainCr . '&category=' . implode(',', $cats) . '&subcategory=' . implode(',', $subs)
            . (!empty($page['product']) ? '&product=' . $page['product'] : '') . (!empty($page['article']) ? '&article=' . $page['article'] : ''));
        $check($g, 'той самий креатив не повторюється на сторінці (exclude → 204)', $code === 204, "serve={$code}");
        [$code, $html] = $http($ctx[$pl][3]);
        $check($g, 'слот на сторінці ' . $ctx[$pl][3], $code === 200 && substr_count($html, 'class="sponsored-slot sponsored-slot--' . $pl . '"') === 1, "http={$code}");

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
    promo_admin_set_setting($pdo, 'frequency_cap_per_session', $oldCap);
    promo_admin_set_setting($pdo, 'enabled', $oldEnabled);
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

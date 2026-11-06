<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест дерева категорій Marketplace (HTTP до локального сайту + перевірки в БД).
 *   php tests/mp-tree-e2e.php [http://ai-lab-hub.test]
 *
 * Перевіряє: ланцюжок «головна → блок → підкатегорія → оголошення» (ПК і мобільний User-Agent) з хлібними крихтами;
 * оголошення з двома підкатегоріями видно в обох, у блоці рахується один раз; лічильник +1 після схвалення, −1 після
 * архівації й після завершення терміну (без cron); порожні підкатегорії приховані, блоки з always_visible_blocks видно,
 * порожній блок поза списком прихований; оголошення колишньої дошки після міграції в правильному блоці;
 * імпорт marketplace-seed/manifest.json (dry-run) без змін; admin змінює назву й порядок — кеш скидається;
 * кнопки «Подати оголошення» і «Безкоштовні рішення»; позначки «Від AI LAB HUB» / «Від автора»; get.php не віддає
 * оголошення користувача; англомовне оголошення видно в інтерфейсі українською; старі адреси — 301.
 * Тестові записи видаляються за id наприкінці. Лише CLI, лише локально.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$_SESSION = [];
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

$fails = 0;
$total = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}

/** @return array{code:int,loc:string,body:string} */
function http(string $jar, string $url, ?array $post = null, bool $mobile = false): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60,
        CURLOPT_USERAGENT => $mobile ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 Mobile/15E148 tree-test'
            : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) tree-test',
    ]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    preg_match('/^Location:\s*(\S+)/mi', substr($raw, 0, $hs), $m);

    return ['code' => $code, 'loc' => $m[1] ?? '', 'body' => substr($raw, $hs)];
}

/** Число на плитці з посиланням на категорію $id (або null, якщо плитки немає). */
function tile_count(string $html, int $id): ?int
{
    return preg_match('~href="marketplace-category\.php\?id=' . $id . '">.*?direction-card__count">(\d+)~su', $html, $m) === 1 ? (int) $m[1] : null;
}

$tmp = sys_get_temp_dir() . '/mptree_' . bin2hex(random_bytes(4));
@mkdir($tmp);
$jar = $tmp . '/guest.txt';
$jarAdm = $tmp . '/adm.txt';
$jarU = $tmp . '/user.txt';
$stamp = date('His') . random_int(100, 999);
$pass = 'Test12345!';
$created = ['users' => [], 'listings' => [], 'renamed' => null];

$tree = mpt_tree($pdo, 'uk');
$blk = static fn(string $s): array => mpt_block($tree, $s) ?? [];
$service = $blk('service');
$solution = $blk('solution');
$goods = $blk('goods');
$subA = $service['children'][0]['id'];   // AI-консультації та впровадження (колишня ai-services)
$subB = $service['children'][1]['id'];   // Автоматизація, боти й інтеграції

try {
    $ins = $pdo->prepare('INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, :h, :r)');
    $ins->execute([':n' => 'Tree Admin', ':e' => "tree-admin-{$stamp}@example.test", ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'admin']);
    $admId = (int) $pdo->lastInsertId();
    $created['users'][] = $admId;
    $ins->execute([':n' => 'Tree User', ':e' => "tree-user-{$stamp}@example.test", ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'user']);
    $userId = (int) $pdo->lastInsertId();
    $created['users'][] = $userId;
    $pdo->prepare('INSERT INTO mp_email_verifications (user_id, email, token_hash, expires_at, verified_at) VALUES (:u, :e, :h, NOW() + INTERVAL 1 DAY, NOW())')
        ->execute([':u' => $userId, ':e' => "tree-user-{$stamp}@example.test", ':h' => hash('sha256', 'tree' . $stamp)]);
    $sellerId = mpb_seller_for_user($pdo, $userId, 'Tree User');

    /** Оголошення користувача (post_form='ad') у блоці $section з категоріями $cats; текст мовою $lang. */
    $mk = static function (string $section, array $cats, string $status, string $title, string $lang = 'uk') use ($pdo, $sellerId, $userId, &$created): int {
        $pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, delivery_type, source_lang, created_by, price_type, is_remote,
                                                published_at, expires_at)
                       VALUES (:s, 'ad', :sid, :st, 'contact', :l, :u, 'free', 1, IF(:st2 = 'published', NOW(), NULL), IF(:st3 = 'published', NOW() + INTERVAL 30 DAY, NULL))")
            ->execute([':s' => $section, ':sid' => $sellerId, ':st' => $status, ':st2' => $status, ':st3' => $status, ':l' => $lang, ':u' => $userId]);
        $id = (int) $pdo->lastInsertId();
        $created['listings'][] = $id;
        $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, :l, :t, 'Тестовий опис', 0)")
            ->execute([':id' => $id, ':l' => $lang, ':t' => $title]);
        foreach ($cats as $c) {
            $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:id, :c)')->execute([':id' => $id, ':c' => $c]);
        }
        mpt_cache_reset();

        return $id;
    };

    echo "Міграція\n";
    $r = $pdo->query("SELECT section, post_form FROM mp_listings WHERE id = 285")->fetch(PDO::FETCH_ASSOC);
    if ($r !== false) {
        check($r['section'] === 'service' && $r['post_form'] === 'ad', 'оголошення #285 колишньої дошки (ai-services) — блок «Послуги», post_form=ad');
        check((int) $pdo->query('SELECT COUNT(*) FROM mp_listing_categories WHERE listing_id = 285 AND category_id = 8')->fetchColumn() === 1, 'прив\'язка #285 → категорія 8 збережена');
    }
    check((int) $pdo->query("SELECT COUNT(*) FROM mp_listings WHERE section = 'board'")->fetchColumn() === 0, "section='board' більше не існує (оголошення)");
    check((int) $pdo->query("SELECT COUNT(*) FROM mp_categories WHERE section = 'board'")->fetchColumn() === 0, "section='board' більше не існує (категорії)");
    $cat8 = $pdo->query('SELECT section, parent_id FROM mp_categories WHERE id = 8')->fetch(PDO::FETCH_ASSOC);
    check($cat8['section'] === 'service' && (int) $cat8['parent_id'] === $service['id'], 'категорія 8 (id збережено) — підкатегорія блока «Послуги»');
    $solSlugs = $pdo->query("SELECT slug FROM mp_categories WHERE section = 'solution' AND parent_id = {$solution['id']} AND is_active = 1 ORDER BY sort_order")->fetchAll(PDO::FETCH_COLUMN);
    check($solSlugs === ['prompts', 'workflows', 'custom-assistants', 'scripts', 'guides', 'design-resources', 'datasets'], '«Готові рішення»: 7 підкатегорій, slug без змін');
    check((int) $pdo->query("SELECT is_active FROM mp_categories WHERE section = 'solution' AND slug = 'prompts-templates'")->fetchColumn() === 0, 'prompts-templates злито з prompts (неактивна)');

    echo "Імпорт manifest.json (dry-run)\n";
    // Тека marketplace-seed/ видалена з репозиторію (коміт 93fc361) — беремо manifest.json і файли з історії git у тимчасову теку.
    $seedDir = __DIR__ . '/../marketplace-seed';
    if (!is_file($seedDir . '/manifest.json')) {
        $seedDir = $tmp . '/seed/marketplace-seed';
        @mkdir($tmp . '/seed');
        exec('git -C ' . escapeshellarg(dirname(__DIR__)) . ' archive 93fc361~1 marketplace-seed | tar -x -C ' . escapeshellarg($tmp . '/seed') . ' 2>&1');
    }
    $out = [];
    exec('php ' . escapeshellarg(__DIR__ . '/../scripts/mp-import-seed.php') . ' --dry-run ' . escapeshellarg('--seed-dir=' . $seedDir) . ' 2>&1', $out, $code);
    $txt = implode("\n", $out);
    check($code === 0 && str_contains($txt, 'Буде створено') && !str_contains($txt, 'не знайдено'), 'mp-import-seed.php --dry-run: код ' . $code . ', усі категорії manifest.json знайдено');

    echo "Ланцюжок головна → блок → підкатегорія → оголошення\n";
    $two = $mk('service', [$subA, $subB], 'published', "Tree дві підкатегорії {$stamp}");
    foreach ([false => 'ПК', true => 'мобільний'] as $mobile => $label) {
        $hub = http($jar, "$base/marketplace.php", null, (bool) $mobile);
        check($hub['code'] === 200 && str_contains($hub['body'], 'href="marketplace-category.php?id=' . $service['id'] . '"'), "$label: головна → плитка блока «Послуги»");
        $b = http($jar, "$base/marketplace-category.php?id={$service['id']}", null, (bool) $mobile);
        check($b['code'] === 200 && str_contains($b['body'], 'href="marketplace-category.php?id=' . $subA . '"') && str_contains($b['body'], 'mpt-crumbs'), "$label: блок → плитка підкатегорії, хлібні крихти");
        $s = http($jar, "$base/marketplace-category.php?id=$subA", null, (bool) $mobile);
        check($s['code'] === 200 && str_contains($s['body'], 'marketplace-offer.php?id=' . $two), "$label: підкатегорія → картка оголошення");
        $o = http($jar, "$base/marketplace-offer.php?id=$two", null, (bool) $mobile);
        check($o['code'] === 200 && str_contains($o['body'], 'href="marketplace-category.php?id=' . $service['id'] . '"') && str_contains($o['body'], 'href="marketplace-category.php?id=' . $subA . '"'),
            "$label: оголошення — хлібні крихти до блока й підкатегорії");
    }
    $css = (string) file_get_contents(__DIR__ . '/../public/assets/css/mp-public.css');
    check(preg_match('~@media \(max-width: 900px\)\s*\{\s*\.direction-grid\s*\{\s*grid-template-columns: repeat\(2, 1fr\)~', $css) === 1
        && !preg_match('~\.direction-grid\s*\{[^}]*grid-template-columns: 1fr~', $css), 'мобільний: 2 плитки в ряд (і на 390 px)');

    echo "Дві підкатегорії, лічильник блока\n";
    $c = mpt_counts($pdo);
    $sA = http($jar, "$base/marketplace-category.php?id=$subA")['body'];
    $sB = http($jar, "$base/marketplace-category.php?id=$subB")['body'];
    check(str_contains($sA, "Tree дві підкатегорії {$stamp}") && str_contains($sB, "Tree дві підкатегорії {$stamp}"), 'оголошення з двома підкатегоріями — в обох списках');
    $cnt = $pdo->prepare('SELECT COUNT(*) FROM mp_listings l WHERE ' . mpt_live_sql() . " AND l.section = 'service'");
    $cnt->execute();
    check(($c['blocks']['service'] ?? -1) === (int) $cnt->fetchColumn(), 'блок «Послуги»: оголошення рахується один раз (' . ($c['blocks']['service'] ?? '?') . ')');
    $hub = http($jar, "$base/marketplace.php")['body'];
    check(tile_count($hub, $service['id']) === $c['blocks']['service'], 'плитка блока на головній = лічильник блока');

    echo "Лічильник: схвалення, архівація, завершення терміну\n";
    $p = $mk('service', [$subB], 'pending', "Tree на модерації {$stamp}");
    $before = tile_count(http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'], $subB) ?? 0;
    // кеш прогріто; схвалення має його скинути
    check(mpb_approve($pdo, $p, $admId), 'mpb_approve: схвалено');
    $after = tile_count(http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'], $subB) ?? 0;
    check($after === $before + 1, "після схвалення лічильник зріс: $before → $after");
    $own = mpb_own_listing($pdo, $p, $userId);
    check($own !== null && mpb_archive($pdo, $own, $userId), 'mpb_archive: знято');
    $arch = tile_count(http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'], $subB) ?? 0;
    check($arch === $after - 1, "після архівації лічильник зменшився: $after → $arch");
    $e = $mk('service', [$subB], 'published', "Tree термін {$stamp}");
    $pdo->prepare('UPDATE mp_listings SET expires_at = NOW() + INTERVAL 3 SECOND WHERE id = :id')->execute([':id' => $e]);
    mpt_cache_reset();
    $withE = tile_count(http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'], $subB) ?? 0;
    sleep(4);
    $noE = tile_count(http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'], $subB) ?? 0;
    check($noE === $withE - 1, "після завершення терміну (без cron) лічильник зменшився: $withE → $noE");

    echo "Порожні категорії й блоки\n";
    $c = mpt_counts($pdo);
    $b = http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'];
    $emptySub = null;
    foreach ($service['children'] as $ch) {
        if (($c['cats'][$ch['id']] ?? 0) === 0) {
            $emptySub = $ch['id'];
            break;
        }
    }
    check($emptySub === null || !str_contains($b, 'href="marketplace-category.php?id=' . $emptySub . '"'), 'порожні підкатегорії приховані');
    $hub = http($jar, "$base/marketplace.php")['body'];
    foreach (['job', 'course', 'service', 'solution'] as $sec) {
        check(str_contains($hub, 'href="marketplace-category.php?id=' . $blk($sec)['id'] . '"'), "блок «{$blk($sec)['name']}» (always_visible_blocks) видно на головній");
    }
    if (($c['blocks']['goods'] ?? 0) === 0) {
        check(!str_contains($hub, 'href="marketplace-category.php?id=' . $goods['id'] . '"'), 'порожній блок «Обладнання» (не з always_visible_blocks) приховано');
    }
    $course = $blk('course');
    if (($c['blocks']['course'] ?? 0) === 0) {
        $cp = http($jar, "$base/marketplace-category.php?id={$course['id']}")['body'];
        check(str_contains($cp, 'Оголошень поки немає. Станьте першим') && str_contains($cp, 'listing-post.php?type=course'), 'порожній блок «Курси»: напис і кнопка «Подати оголошення»');
    }

    echo "Кнопки, позначки, мова, get.php\n";
    check(str_contains($hub, 'mpt-cta__btn--post" href="marketplace-post.php"') && str_contains($hub, 'mpt-cta__btn--free" href="marketplace-category.php?id=' . $solution['id'] . '"'),
        'головна: «Подати оголошення» → marketplace-post.php, «Безкоштовні рішення» → блок «Готові рішення»');
    $authorSol = $mk('solution', [$solution['children'][0]['id']], 'published', "Tree рішення автора {$stamp}");
    $sp = http($jar, "$base/marketplace-category.php?id={$solution['children'][0]['id']}")['body'];
    check(str_contains($sp, 'Від AI LAB HUB') && str_contains($sp, 'Від автора'), '«Готові рішення»: позначки «Від AI LAB HUB» і «Від автора»');
    $g = http($jar, "$base/get.php?id=$authorSol");
    check($g['code'] === 404, 'get.php не віддає оголошення користувача в «Готових рішеннях» (' . $g['code'] . ')');
    $en = $mk('service', [$subA], 'published', "Tree English service {$stamp}", 'en');
    $sA = http($jar, "$base/marketplace-category.php?id=$subA")['body'];
    check(str_contains($sA, 'marketplace-offer.php?id=' . $en . '"'), 'англомовне оголошення видно в «Послугах» при інтерфейсі українською');

    echo "Подача: вибір блока\n";
    http($jarU, "$base/login.php", ['email' => "tree-user-{$stamp}@example.test", 'password' => $pass]);
    $r = http($jarU, "$base/marketplace-post.php");
    check($r['code'] === 200 && str_contains($r['body'], 'href="listing-post.php?type=job"') && str_contains($r['body'], 'href="marketplace-post.php?block=goods"'), 'крок 1: картки блоків');
    $r = http($jarU, "$base/marketplace-post.php?block=service");
    check($r['code'] === 303 && $r['loc'] === 'listing-post.php?type=service', 'блок «Послуги» → форма listing-post.php');
    $r = http($jarU, "$base/marketplace-post.php?block=goods");
    $goodsSub = $goods['children'][0]['id'];
    check(str_contains($r['body'], 'name="cats[]" value="' . $goodsSub . '"') && !str_contains($r['body'], 'name="cats[]" value="' . $subA . '"'), 'блок «Обладнання»: лише його підкатегорії');
    $r = http($jarU, "$base/listing-post.php?type=job");
    $jobSub = $blk('job')['children'][0]['id'];
    check(str_contains($r['body'], 'name="cats[]" value="' . $jobSub . '"') && str_contains($r['body'], 'class="mpt-focus"'), 'вакансія: підкатегорії обов\'язкові, AI-спрямування згорнуто');

    echo "Старі адреси (301)\n";
    $r = http($jar, "$base/listings.php?type=service&format=remote");
    check($r['code'] === 301 && str_contains($r['loc'], 'marketplace-category.php?id=' . $service['id']) && str_contains($r['loc'], 'format=online'), 'listings.php?type=service → блок «Послуги»');
    $r = http($jar, "$base/marketplace.php?category=solutions&sub=5");
    check($r['code'] === 301 && str_ends_with($r['loc'], 'marketplace-category.php?id=5'), 'marketplace.php?category=solutions&sub=5 → підкатегорія');
    $r = http($jar, "$base/marketplace-solutions.php");
    check($r['code'] === 301 && str_ends_with($r['loc'], 'marketplace-category.php?id=' . $solution['id']), 'marketplace-solutions.php → блок «Готові рішення»');

    echo "Admin: назва й порядок, скидання кешу\n";
    http($jarAdm, "$base/login.php", ['email' => "tree-admin-{$stamp}@example.test", 'password' => $pass]);
    $page = http($jarAdm, "$base/mp-categories.php");
    check($page['code'] === 200 && str_contains($page['body'], 'Категорії Marketplace'), 'mp-categories.php відкривається для admin');
    check(http($jar, "$base/mp-categories.php")['code'] === 404, 'mp-categories.php для гостя — 404');
    preg_match('/name="csrf" value="([a-f0-9]{64})"/', $page['body'], $cm);
    $node = mpt_node(mpt_tree($pdo, 'uk', true), $subB)['sub'];
    $created['renamed'] = $node;
    mpt_counts($pdo);   // прогріти кеш
    clearstatcache();
    $cacheBefore = is_file(mpt_cache_file());
    $r = http($jarAdm, "$base/mp-categories.php", ['csrf' => $cm[1] ?? '', 'action' => 'save', 'id' => $subB, 'name_uk' => "Tree перейменовано {$stamp}",
        'name_en' => 'Tree renamed', 'sort' => '0', 'icon' => 'bot', 'active' => '1']);
    check($r['code'] === 303, 'збереження → 303');
    clearstatcache();
    check($cacheBefore && !is_file(mpt_cache_file()), 'кеш лічильників скинуто');
    $b = http($jar, "$base/marketplace-category.php?id={$service['id']}")['body'];
    $posB = strpos($b, "Tree перейменовано {$stamp}");
    $posA = strpos($b, 'href="marketplace-category.php?id=' . $subA . '"');
    check($posB !== false && $posA !== false && $posB < $posA, 'нова назва на сайті, порядок 0 — перша плитка');
} finally {
    echo "Прибирання тестових записів\n";
    if (is_array($created['renamed'])) {
        $n = $created['renamed'];
        $pdo->prepare('UPDATE mp_categories SET sort_order = :s, icon = :i WHERE id = :id')->execute([':s' => $n['sort'], ':i' => $n['icon'], ':id' => $n['id']]);
        $u = $pdo->prepare('UPDATE mp_category_translations SET name = :n WHERE category_id = :id AND lang = :l');
        $u->execute([':n' => $n['name_uk'], ':id' => $n['id'], ':l' => 'uk']);
        $u->execute([':n' => $n['name_en'], ':id' => $n['id'], ':l' => 'en']);
    }
    foreach ($created['listings'] as $id) {
        foreach (['mp_listing_categories', 'mp_listing_translations', 'mp_listing_stats_daily', 'mp_moderation_log', 'mp_listing_places'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE listing_id = :id")->execute([':id' => $id]);
            } catch (Throwable $e) {
            }
        }
        $pdo->prepare('DELETE FROM mp_listings WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($created['users'] as $id) {
        $pdo->prepare('DELETE FROM mp_email_verifications WHERE user_id = :u')->execute([':u' => $id]);
        $pdo->prepare('DELETE FROM mp_form_drafts WHERE user_id = :u')->execute([':u' => $id]);
        $pdo->prepare('DELETE FROM mp_sellers WHERE user_id = :u')->execute([':u' => $id]);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    mpt_cache_reset();
    echo '  видалено: users ' . implode(',', $created['users']) . '; listings ' . implode(',', $created['listings'])
        . (is_array($created['renamed']) ? '; назву й порядок категорії #' . $created['renamed']['id'] . ' відновлено' : '') . "\n";
    exec('rm -rf ' . escapeshellarg($tmp));
}

echo "\nРазом: " . ($total - $fails) . ' / ' . $total . ($fails === 0 ? " — усе гаразд\n" : " — є помилки\n");
exit($fails === 0 ? 0 : 1);

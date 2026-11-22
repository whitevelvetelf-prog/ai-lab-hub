<?php

declare(strict_types=1);

/**
 * AI LAB HUB — оголошення самої платформи в Marketplace з маніфесту marketplace-seed/promos.json.
 *
 *   php scripts/mp-seed-promos.php                 — dry-run: підставлені тексти, лінт, умови й план (нічого не пише)
 *   php scripts/mp-seed-promos.php --apply         — створити в локальній БД ті, що пройшли лінт і умови
 *   php scripts/mp-seed-promos.php --emit-sql[=hosting-upload/promos-seed.sql]
 *                                                  — SQL для хостингу (не заливається автоматично)
 *   --db=<схема>                                   — інша локальна схема (напр. rehearsal_promos)
 *   --manifest=<файл>                              — інший маніфест (для перевірки лінта)
 *
 * Правила (див. docs/PROMO_LISTINGS.md):
 *   • продавець — mp_sellers.slug = seller_slug з is_platform = 1; немає — нічого не створюється;
 *   • ідемпотентність: оголошення з таким самим українським заголовком у цього продавця (або з тим самим slug) уже є —
 *     пропускається; наявні оголошення НЕ оновлюються й не видаляються;
 *   • тексти uk — оригінал (source_lang = 'uk'), en — переклад вручну з маніфесту (is_auto = 0), API перекладу не викликається;
 *   • змінні {FREE_UNTIL}, {LISTING_DAYS}, {REVIEW_HOURS}, {EXAMPLES} — з налаштувань і БД; речення зі змінною,
 *     якої не знайдено, прибирається (у заголовку — оголошення не створюється);
 *   • лінт, що не пройшов, блокує створення; status 'skip' — не створюється (причина в маніфесті);
 *   • кнопка: локально /register.php?ref=…, у SQL для хостингу — https://ailabhub-directory.com/register.php?ref=…;
 *   • дії в mp_moderation_log: 'platform_seed'. Відкладене (draft) публікує scripts/mp-publish-promos.php.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$root = dirname(__DIR__);
require_once $root . '/app/mp-legal-config.php';   // MP_LISTING_LIFETIME_DAYS (п. 7.6 Правил)
require_once $root . '/app/mp-platform-promo.php';  // mpp_cta_href(): той самий перелік дозволених сторінок, що й на сторінці

const MPS_LIVE_BASE = 'https://ailabhub-directory.com';
date_default_timezone_set('Europe/Kyiv');

$args = array_slice($argv, 1);
$apply = in_array('--apply', $args, true);
$emit = null;
$db = 'ailabhub_db';
$manifestFile = $root . '/marketplace-seed/promos.json';
foreach ($args as $a) {
    if (str_starts_with($a, '--manifest=')) {
        $manifestFile = substr($a, 11);
    }
    if (str_starts_with($a, '--emit-sql')) {
        $emit = str_contains($a, '=') ? substr($a, strpos($a, '=') + 1) : 'hosting-upload/promos-seed.sql';
    } elseif (str_starts_with($a, '--db=')) {
        $db = substr($a, 5);
    }
}
if (preg_match('/^[A-Za-z0-9_]+$/', $db) !== 1) {
    fwrite(STDERR, "Недозволена назва схеми.\n");
    exit(2);
}

$cfg = require $root . '/config/database.php';   // PDO локальної БД (лише щоб узяти параметри підключення)
$pdo = $cfg instanceof PDO ? $cfg : null;
if ($db !== 'ailabhub_db' || $pdo === null) {
    $pdo = new PDO('mysql:host=127.0.0.1;dbname=' . $db . ';charset=utf8mb4', 'root', '', [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
}
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

$manifest = json_decode((string) file_get_contents($manifestFile), true, 32, JSON_THROW_ON_ERROR);

// --- Значення змінних із налаштувань ---------------------------------------------------------------------

function mps_setting(PDO $pdo, string $key): ?string
{
    $st = $pdo->prepare('SELECT setting_value FROM site_settings WHERE setting_key = :k');
    $st->execute([':k' => $key]);
    $v = $st->fetchColumn();

    return $v === false ? null : (string) $v;
}

/** Дата «безкоштовно до» мовою (як promo_free_until_text у app/promo.php); null — не задано або минула. */
function mps_free_until(?string $raw, string $lang): ?string
{
    $raw = trim((string) $raw);
    $d = DateTime::createFromFormat('!Y-m-d', $raw);
    if ($d === false || $d->format('Y-m-d') !== $raw || $raw < date('Y-m-d')) {
        return null;
    }
    if ($lang === 'en') {
        return $d->format('F j, Y');
    }
    $uk = ['січня', 'лютого', 'березня', 'квітня', 'травня', 'червня', 'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня'];

    return $d->format('j') . ' ' . $uk[(int) $d->format('n') - 1] . ' ' . $d->format('Y');
}

$freeRaw = mps_setting($pdo, 'marketplace_free_until');
$reviewRaw = mps_setting($pdo, 'marketplace_review_hours');
$reviewHours = max(1, min(720, (int) ($reviewRaw ?? '48')));     // як lst_settings(): типово 48
$listingDays = max(1, (int) MP_LISTING_LIFETIME_DAYS);

$sellerSt = $pdo->prepare('SELECT id FROM mp_sellers WHERE slug = :s AND is_platform = 1');
$sellerSt->execute([':s' => (string) $manifest['seller_slug']]);
$sellerId = $sellerSt->fetchColumn();
$sellerId = $sellerId === false ? null : (int) $sellerId;

/** Опубліковані матеріали платформи: [uk title => en title|null], а також лічильники для умов. */
$sol = $pdo->prepare(
    "SELECT l.id, l.license, l.pricing_model, tu.title AS uk, te.title AS en
     FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id AND s.is_platform = 1
     LEFT JOIN mp_listing_translations tu ON tu.listing_id = l.id AND tu.lang = 'uk'
     LEFT JOIN mp_listing_translations te ON te.listing_id = l.id AND te.lang = 'en'
     WHERE l.section = 'solution' AND l.post_form = '' AND l.status = 'published'"
);
$sol->execute();
$solutions = $sol->fetchAll();

// --- Лінт -----------------------------------------------------------------------------------------------

/** @return list<string> помилки */
function mps_lint(array $uk, array $en): array
{
    $err = [];
    foreach (['uk' => $uk, 'en' => $en] as $lang => $t) {
        $all = [$t['title'], $t['short_desc'], $t['full_desc'], implode("\n", $t['features']), $t['for_whom']];
        $joined = implode("\n", $all);
        if (str_contains($joined, '{') || str_contains($joined, '}')) {
            $err[] = "$lang: лишилася непідставлена змінна { }";
        }
        if (preg_match('/<\s*[a-z\/!]/i', $joined) === 1) {
            $err[] = "$lang: HTML у тексті";
        }
        if (preg_match('~https?://|www\.|[a-z0-9-]+\.(com|php|net|org|ua)\b~i', $joined) === 1) {
            $err[] = "$lang: посилання в тексті (дозволена лише кнопка)";
        }
        if (mb_strlen($t['title']) > 100) {
            $err[] = "$lang: заголовок довший за 100 символів (" . mb_strlen($t['title']) . ')';
        }
        if (mb_strlen($t['short_desc']) > 500) {
            $err[] = "$lang: короткий опис довший за 500 символів";
        }
        if (trim($t['title']) === '' || trim($t['short_desc']) === '') {
            $err[] = "$lang: порожній заголовок чи короткий опис";
        }
        if ($lang === 'uk') {
            $noBrand = str_replace('AI LAB HUB', '', $joined);
            foreach (['/штучн/iu' => '«штучн»', '/ШІ/u' => '«ШІ»', '/AI/' => '«AI» (окрім назви AI LAB HUB)', '/найкращ/iu' => '«найкращ»',
                         '/гарант/iu' => '«гарант»', '/№\s*1/u' => '«№1»', '/тисяч/iu' => '«тисяч»', '/лише сьогодні|тільки сьогодні/iu' => 'тиск «лише сьогодні»',
                         '/\d[\d\s]*\+?\s*(користувач|відвідувач|людей|клієнт|акаунт)/iu' => 'число про кількість користувачів'] as $re => $what) {
                if (preg_match($re, $re === '/AI/' ? $noBrand : $joined) === 1) {
                    $err[] = "uk: заборонене $what";
                }
            }
        } else {
            foreach (['/\bbest\b/i' => '«best»', '/guarantee/i' => '«guarantee»', '/#\s*1\b|\bno\.?\s*1\b|number one/i' => '«#1»',
                         '/today only|only today|limited time/i' => 'тиск «today only»', '/\bthousands?\b/i' => '«thousands»',
                         '/\d[\d,\s]*\+?\s*(users|visitors|people|customers|accounts)/i' => 'число про кількість користувачів'] as $re => $what) {
                if (preg_match($re, $joined) === 1) {
                    $err[] = "en: заборонене $what";
                }
            }
        }
    }
    if (count($uk['features']) !== count($en['features'])) {
        $err[] = 'різна кількість рядків функцій uk (' . count($uk['features']) . ') і en (' . count($en['features']) . ')';
    }

    return $err;
}

/** Підставити змінні; речення з ненайденою змінною прибирається. Заголовок із ненайденою — null. */
function mps_fill(array $t, array $vars): ?array
{
    $sub = static function (string $s) use ($vars): string {
        return (string) preg_replace_callback('/\{([A-Z_]+)\}/', static fn($m) => array_key_exists($m[1], $vars) && $vars[$m[1]] !== null ? (string) $vars[$m[1]] : $m[0], $s);
    };
    $unresolved = static fn(string $s): bool => preg_match('/\{[A-Z_]+\}/', $s) === 1;
    $title = $sub($t['title']);
    if ($unresolved($title)) {
        return null;
    }
    $sentences = static function (string $s) use ($sub, $unresolved): string {
        $parts = preg_split('/(?<=[.!?])\s+/u', $sub($s)) ?: [];

        return implode(' ', array_filter($parts, static fn($p) => !$unresolved($p)));
    };
    $features = array_values(array_filter(array_map($sub, $t['features']), static fn($f) => !$unresolved($f)));

    return ['title' => $title, 'short_desc' => $sentences($t['short_desc']), 'full_desc' => $sentences($t['full_desc']),
        'features' => $features, 'for_whom' => $sentences($t['for_whom'])];
}

// --- План -----------------------------------------------------------------------------------------------

$exists = $pdo->prepare(
    "SELECT l.id, l.status FROM mp_listings l
     WHERE l.seller_id = :sid AND (l.slug = :slug OR EXISTS (SELECT 1 FROM mp_listing_translations t
            WHERE t.listing_id = l.id AND t.lang = 'uk' AND t.title = :title)) ORDER BY l.id LIMIT 1"
);
$catSt = $pdo->prepare('SELECT id FROM mp_categories WHERE section = :s AND slug = :g AND is_active = 1 ORDER BY parent_id IS NOT NULL, id LIMIT 1');

$plan = [];
$blocked = 0;
foreach ($manifest['listings'] as $m) {
    $code = (string) $m['code'];
    $p = ['m' => $m, 'code' => $code, 'action' => 'create', 'notes' => [], 'errors' => [], 'uk' => null, 'en' => null, 'cat' => null, 'guards' => []];

    // Змінні
    $vars = ['FREE_UNTIL' => null, 'LISTING_DAYS' => (string) $listingDays, 'REVIEW_HOURS' => (string) $reviewHours, 'EXAMPLES' => null];
    $varsEn = $vars;
    $vars['FREE_UNTIL'] = mps_free_until($freeRaw, 'uk');
    $varsEn['FREE_UNTIL'] = mps_free_until($freeRaw, 'en');
    if (!empty($m['examples'])) {
        $byUk = [];
        foreach ($solutions as $s) {
            $byUk[(string) $s['uk']] = $s['en'] !== null && trim((string) $s['en']) !== '' ? (string) $s['en'] : null;
        }
        $found = array_values(array_filter($m['examples'], static fn($e) => array_key_exists($e, $byUk) && $byUk[$e] !== null));
        $found = array_slice($found, 0, 4);
        if (count($found) >= 2) {
            $vars['EXAMPLES'] = implode(', ', array_map(static fn($e) => '«' . $e . '»', $found));
            $varsEn['EXAMPLES'] = implode(', ', array_map(static fn($e) => '"' . $byUk[$e] . '"', $found));
            $p['examples'] = $found;
        } else {
            $p['errors'][] = 'приклади матеріалів: опубліковано лише ' . count($found) . ' з потрібних 2–4';
        }
    }
    if (str_contains(json_encode($m['uk'], JSON_UNESCAPED_UNICODE), '{FREE_UNTIL}') && $vars['FREE_UNTIL'] === null) {
        $p['notes'][] = 'дату «безкоштовно до» не задано або вона минула — речення з нею прибрано';
    }

    // Умови за кодом і даними
    $chk = (array) ($m['checks'] ?? []);
    foreach ((array) ($chk['code'] ?? []) as [$file, $needle]) {
        $src = @file_get_contents($root . '/' . $file);
        if (!is_string($src) || !str_contains($src, $needle)) {
            $p['errors'][] = "умова за кодом не підтвердилась: $file не містить «{$needle}»";
        }
    }
    if (isset($chk['min_platform_solutions']) && count($solutions) < (int) $chk['min_platform_solutions']) {
        $p['errors'][] = 'опублікованих матеріалів платформи ' . count($solutions) . ' < ' . (int) $chk['min_platform_solutions'];
    }
    if (!empty($chk['all_platform_solutions_licensed']) && array_filter($solutions, static fn($s) => trim((string) $s['license']) === '') !== []) {
        $p['errors'][] = 'не біля всіх матеріалів платформи вказано ліцензію';
    }
    if (!empty($chk['all_platform_solutions_free']) && array_filter($solutions, static fn($s) => (string) $s['pricing_model'] !== 'free') !== []) {
        $p['errors'][] = 'не всі матеріали платформи безкоштовні';
    }

    // Тексти й лінт
    $uk = mps_fill($m['uk'], $vars);
    $en = mps_fill($m['en'], $varsEn);
    if ($uk === null || $en === null) {
        $p['errors'][] = 'у заголовку лишилася змінна без значення';
    } else {
        $p['uk'] = $uk;
        $p['en'] = $en;
        foreach (mps_lint($uk, $en) as $e) {
            $p['errors'][] = 'лінт: ' . $e;
        }
    }
    $p['vars'] = ['uk' => $vars, 'en' => $varsEn];

    // Кнопка
    $local = '/register.php?ref=' . $m['ref'];
    if (mpp_cta_href($local) === null || mpp_cta_href(MPS_LIVE_BASE . $local) === null) {
        $p['errors'][] = 'адреса кнопки не з переліку дозволених внутрішніх сторінок';
    }
    $p['url_local'] = $local;
    $p['url_live'] = MPS_LIVE_BASE . $local;

    // Продавець, категорія, наявність
    $catSt->execute([':s' => $m['section'], ':g' => $m['category_slug']]);
    $cat = $catSt->fetchColumn();
    $p['cat'] = $cat === false ? null : (int) $cat;
    if ($sellerId === null) {
        $p['errors'][] = 'немає продавця ' . $manifest['seller_slug'] . ' з is_platform = 1';
    }
    if ($p['cat'] === null) {
        $p['errors'][] = "немає активної категорії {$m['section']}/{$m['category_slug']}";
    }
    if ($sellerId !== null && $uk !== null) {
        $exists->execute([':sid' => $sellerId, ':slug' => $m['slug'], ':title' => $uk['title']]);
        $ex = $exists->fetch();
        if ($ex !== false) {
            $p['action'] = 'exists';
            $p['notes'][] = 'уже є: id ' . $ex['id'] . ', статус ' . $ex['status'] . ' — не змінюється';
        }
    }
    if ($m['status'] === 'skip') {
        $p['action'] = 'skip';
        $p['notes'][] = 'відкладено: ' . ($m['skip_reason'] ?? '');
    } elseif ($p['errors'] !== [] && $p['action'] === 'create') {
        $p['action'] = 'blocked';
        $blocked++;
    }
    // Умови SQL на хостингу: ті самі дані, що й тут, перевіряються вже в БД хостингу.
    if (!empty($chk['min_platform_solutions'])) {
        $p['guards'][] = "(SELECT COUNT(*) FROM mp_listings x JOIN mp_sellers xs ON xs.id = x.seller_id AND xs.is_platform = 1
            WHERE x.section = 'solution' AND x.post_form = '' AND x.status = 'published') >= " . (int) $chk['min_platform_solutions'];
    }
    if (!empty($chk['all_platform_solutions_licensed'])) {
        $p['guards'][] = "NOT EXISTS (SELECT 1 FROM mp_listings x JOIN mp_sellers xs ON xs.id = x.seller_id AND xs.is_platform = 1
            WHERE x.section = 'solution' AND x.post_form = '' AND x.status = 'published' AND COALESCE(x.license, '') = '')";
    }
    if (!empty($chk['all_platform_solutions_free'])) {
        $p['guards'][] = "NOT EXISTS (SELECT 1 FROM mp_listings x JOIN mp_sellers xs ON xs.id = x.seller_id AND xs.is_platform = 1
            WHERE x.section = 'solution' AND x.post_form = '' AND x.status = 'published' AND x.pricing_model <> 'free')";
    }
    foreach ((array) ($p['examples'] ?? []) as $ex) {
        $p['guards'][] = "EXISTS (SELECT 1 FROM mp_listings x JOIN mp_sellers xs ON xs.id = x.seller_id AND xs.is_platform = 1
            JOIN mp_listing_translations xt ON xt.listing_id = x.id AND xt.lang = 'uk'
            WHERE x.section = 'solution' AND x.status = 'published' AND xt.title = " . $pdo->quote($ex) . ')';
    }
    if (str_contains(json_encode($m['uk'], JSON_UNESCAPED_UNICODE), '{FREE_UNTIL}')) {
        $p['guards'][] = $freeRaw !== null
            ? '(SELECT setting_value FROM site_settings WHERE setting_key = \'marketplace_free_until\') = ' . $pdo->quote((string) $freeRaw)
            : 'FALSE';
    }
    if (str_contains(json_encode($m['uk'], JSON_UNESCAPED_UNICODE), '{REVIEW_HOURS}')) {
        $p['guards'][] = "COALESCE((SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_review_hours'), '48') = " . $pdo->quote((string) $reviewHours);
    }
    $plan[] = $p;
}

// --- Вивід плану ----------------------------------------------------------------------------------------

$out = static fn(string $s) => fwrite(STDOUT, $s . "\n");
$out('Схема: ' . $db . ' · продавець: ' . ($sellerId !== null ? '#' . $sellerId : 'НЕМАЄ') . ' · безкоштовно до: ' . ($freeRaw ?? 'не задано')
    . ' · строк: ' . $listingDays . ' дн. · мета розгляду: ' . $reviewHours . ' год · матеріалів платформи: ' . count($solutions));
foreach ($plan as $p) {
    $m = $p['m'];
    $out('');
    $out(sprintf('[%s] %s → %s · %s/%s · статус %s · кнопка %s', $p['code'], $m['slug'], strtoupper($p['action']), $m['section'], $m['category_slug'], $m['status'], $p['url_local']));
    if ($p['uk'] !== null) {
        $out('   uk: ' . $p['uk']['title']);
        $out('   en: ' . $p['en']['title']);
    }
    foreach ($p['errors'] as $e) {
        $out('   ✗ ' . $e);
    }
    foreach ($p['notes'] as $n) {
        $out('   · ' . $n);
    }
    if ($p['errors'] === [] && $p['action'] !== 'skip') {
        $out('   ✓ лінт і умови пройдено');
    }
}

// --- SQL (спільний для --apply і --emit-sql) ------------------------------------------------------------

/** @return list<string> інструкції SQL для одного оголошення */
function mps_sql(PDO $pdo, array $p, string $sellerSlug, string $url, int $days): array
{
    $m = $p['m'];
    $q = static fn(?string $v): string => $v === null ? 'NULL' : $pdo->quote($v);
    $published = $m['status'] === 'published';
    $code = $m['code'];
    $guard = $p['guards'] !== [] ? ' AND ' . implode("\n   AND ", $p['guards']) : '';
    $sql = [];
    $sql[] = "-- [{$code}] {$m['slug']} — {$p['uk']['title']}";
    $sql[] = 'SET @sid := (SELECT id FROM mp_sellers WHERE slug = ' . $q($sellerSlug) . ' AND is_platform = 1 ORDER BY id LIMIT 1)';
    $sql[] = 'SET @cat := (SELECT id FROM mp_categories WHERE section = ' . $q($m['section']) . ' AND slug = ' . $q($m['category_slug'])
        . ' AND is_active = 1 ORDER BY parent_id IS NOT NULL, id LIMIT 1)';
    $sql[] = "SET @dup := (SELECT COUNT(*) FROM mp_listings l WHERE l.seller_id = @sid AND (l.slug = " . $q($m['slug'])
        . " OR EXISTS (SELECT 1 FROM mp_listing_translations t WHERE t.listing_id = l.id AND t.lang = 'uk' AND t.title = " . $q($p['uk']['title']) . ')))';
    $sql[] = "SET @ok := (@sid IS NOT NULL AND @cat IS NOT NULL AND @dup = 0{$guard})";
    $sql[] = "INSERT INTO mp_listings
  (section, post_form, seller_id, status, pricing_model, price_type, delivery_type, delivery_url, source_lang,
   is_remote, city, work_format, service_scope, slug, created_by, moderated_by, moderated_at, published_at, expires_at, status_changed_at)
SELECT " . $q($m['section']) . ", 'ad', @sid, " . $q($m['status']) . ", 'free', 'free', 'link', " . $q($url) . ", 'uk',
   1, NULL, 'online', 'worldwide', " . $q($m['slug']) . ', NULL, NULL, NULL, '
        . ($published ? "NOW(), NOW() + INTERVAL {$days} DAY" : 'NULL, NULL') . ', NOW()
FROM DUAL WHERE @ok';
    $sql[] = 'SET @lid := IF(ROW_COUNT() = 1, LAST_INSERT_ID(), NULL)';
    foreach (['uk', 'en'] as $lang) {
        $t = $p[$lang];
        $sql[] = 'INSERT IGNORE INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, features, for_whom, is_auto)
SELECT @lid, ' . $q($lang) . ', ' . $q($t['title']) . ', ' . $q($t['short_desc']) . ', ' . $q($t['full_desc']) . ', '
            . $q(implode("\n", $t['features'])) . ', ' . $q($t['for_whom']) . ', 0 FROM DUAL WHERE @lid IS NOT NULL';
    }
    $sql[] = 'INSERT IGNORE INTO mp_listing_categories (listing_id, category_id) SELECT @lid, @cat FROM DUAL WHERE @lid IS NOT NULL';
    $sql[] = "INSERT INTO mp_moderation_log (listing_id, actor_id, action, note)
SELECT @lid, NULL, 'platform_seed', " . $q('оголошення платформи ' . $code . ' (' . $m['slug'] . '), статус ' . $m['status'] . ', ref ' . $m['ref']) . ' FROM DUAL WHERE @lid IS NOT NULL';
    $sql[] = "SELECT CONCAT('{$code} {$m['slug']}: ', CASE WHEN @lid IS NOT NULL THEN CONCAT('створено, id ', @lid)
    WHEN @dup > 0 THEN 'уже є, не змінено' WHEN @sid IS NULL THEN 'пропущено: немає продавця платформи'
    WHEN @cat IS NULL THEN 'пропущено: немає категорії' ELSE 'пропущено: умову не виконано' END) AS result";

    return $sql;
}

$ready = array_values(array_filter($plan, static fn($p) => $p['action'] !== 'skip' && $p['errors'] === [] && $p['uk'] !== null));

if ($emit !== null) {
    $lines = [];
    $lines[] = '-- =====================================================================';
    $lines[] = '-- AI LAB HUB — оголошення самої платформи в Marketplace (згенеровано scripts/mp-seed-promos.php ' . date('Y-m-d H:i') . ').';
    $lines[] = '-- НЕ заливається автоматично. Порядок: після міграцій категорій (№ 18–19) і релізу етапу A та після';
    $lines[] = '-- database/migration-2026-11-22-mp-platform-promos-ui.sql (написи кнопки). Код сторінки — app/mp-platform-promo.php.';
    $lines[] = '-- Безпечно повторювати: оголошення з тим самим українським заголовком або slug у продавця платформи пропускається;';
    $lines[] = '-- наявні записи не оновлюються й не видаляються. Немає продавця (slug ' . $manifest['seller_slug'] . ', is_platform = 1),';
    $lines[] = '-- категорії чи не виконано умову (кількість матеріалів, дата «безкоштовно до» тощо) — нічого не робиться.';
    $lines[] = '-- Без DROP / TRUNCATE / DELETE; id не задаються. Кнопка — абсолютна адреса ' . MPS_LIVE_BASE . '.';
    $lines[] = '-- Відкладено: ' . implode('; ', array_map(static fn($p) => $p['code'] . ' ' . $p['m']['slug'] . ' (' . ($p['action'] === 'skip' ? 'skip' : 'лінт/умови') . ')',
        array_filter($plan, static fn($p) => !in_array($p, $ready, true)))) . '.';
    $lines[] = '-- =====================================================================';
    $lines[] = '';
    $lines[] = 'SET NAMES utf8mb4;';
    foreach ($ready as $p) {
        $lines[] = '';
        foreach (mps_sql($pdo, $p, (string) $manifest['seller_slug'], $p['url_live'], $listingDays) as $s) {
            $lines[] = str_starts_with($s, '--') ? $s : $s . ';';
        }
    }
    $lines[] = '';
    $lines[] = "SELECT 'OK оголошення платформи' AS result;";
    $path = str_starts_with($emit, '/') || preg_match('/^[A-Za-z]:/', $emit) === 1 ? $emit : $root . '/' . $emit;
    if (!is_dir(dirname($path))) {
        mkdir(dirname($path), 0775, true);
    }
    $body = implode("\n", $lines) . "\n";
    if (preg_match('/^\s*(DROP|TRUNCATE|DELETE|USE)\b/im', $body) === 1) {
        fwrite(STDERR, "Відмова: у згенерованому SQL з'явився DROP/TRUNCATE/DELETE/USE.\n");
        exit(1);
    }
    file_put_contents($path, $body);
    $out('');
    $out('SQL для хостингу: ' . $emit . ' (' . count($ready) . ' оголош., ' . strlen($body) . ' байт). На хостинг не заливається.');
}

if (!$apply) {
    $out('');
    $out('Dry-run: нічого не записано. Для запису — --apply.');
    exit($blocked > 0 ? 1 : 0);
}

$out('');
foreach ($ready as $p) {
    if ($p['action'] !== 'create') {
        $out($p['code'] . ': уже є — пропущено');
        continue;
    }
    $pdo->beginTransaction();
    try {
        $res = null;
        foreach (mps_sql($pdo, $p, (string) $manifest['seller_slug'], $p['url_local'], $listingDays) as $s) {
            if (str_starts_with($s, '--')) {
                continue;
            }
            $st = $pdo->query($s);
            if (str_starts_with($s, 'SELECT')) {
                $res = $st->fetchColumn();
            }
        }
        $pdo->commit();
        $out((string) $res);
    } catch (Throwable $e) {
        $pdo->rollBack();
        $out($p['code'] . ': ПОМИЛКА ' . $e->getMessage());
        exit(1);
    }
}
@unlink($root . '/storage/cache/mp-tree-counts.json');   // лічильники блоків (app/mp-tree.php) перерахуються
exit($blocked > 0 ? 1 : 0);

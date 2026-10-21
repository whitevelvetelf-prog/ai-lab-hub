<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тестові оголошення для ручної перевірки нативних карток (локально).
 *
 *   php tools/promo-demo-ads.php create [відео1.mp4 відео2.mp4 відео3.mp4]
 *   php tools/promo-demo-ads.php delete
 *
 * create: вмикає рекламу й 6 платних кампаній рекламодавця 'DEMO' (CPC — покази не
 * списуються): 3 зображення (згенеровані GD-постери без тексту — текст лише в
 * заголовку й підписі) і 3 відео (наявні файли з public/uploads/promo/; постери — GD).
 * Таргет — усі категорії на місцях-списках. Попередній стан зберігається в
 * storage/cache/promo-demo-state.json.
 * delete: видаляє кампанії DEMO, їхні рядки й згенеровані файли, повертає налаштування.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/site-settings.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

const DEMO_MARKER = 'DEMO';
const DEMO_STATE = __DIR__ . '/../storage/cache/promo-demo-state.json';
$uploadDir = __DIR__ . '/../public/uploads/promo';
$placements = ['subcategory_list', 'search_results', 'category_page', 'marketplace_feed', 'marketplace_search', 'marketplace_category'];

$one = static function (string $sql, array $p = []) use ($pdo): mixed {
    $st = $pdo->prepare($sql);
    $st->execute($p);

    return $st->fetchColumn();
};

/** Постер 1280×720 без тексту: градієнт і кілька фігур. */
$poster = static function (string $file, array $from, array $to, int $seed): void {
    $w = 1280;
    $h = 720;
    $im = imagecreatetruecolor($w, $h);
    for ($y = 0; $y < $h; $y++) {
        $t = $y / ($h - 1);
        $c = imagecolorallocate($im, (int) ($from[0] + ($to[0] - $from[0]) * $t), (int) ($from[1] + ($to[1] - $from[1]) * $t), (int) ($from[2] + ($to[2] - $from[2]) * $t));
        imageline($im, 0, $y, $w, $y, $c);
    }
    mt_srand($seed);
    for ($i = 0; $i < 7; $i++) {
        $c = imagecolorallocatealpha($im, 255, 255, 255, mt_rand(85, 115));
        $r = mt_rand(80, 260);
        imagefilledellipse($im, mt_rand(0, $w), mt_rand(0, $h), $r, $r, $c);
    }
    imagepng($im, $file);
    imagedestroy($im);
};

$action = $argv[1] ?? '';
if ($action === 'create') {
    if ((int) $one('SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = :m', [':m' => DEMO_MARKER]) > 0) {
        exit("Тестові оголошення вже є — спершу: php tools/promo-demo-ads.php delete\n");
    }
    $videos = array_slice($argv, 2);
    if ($videos === []) {
        $videos = array_map('basename', array_slice(glob($uploadDir . '/*.mp4') ?: [], 0, 3));
    }
    if (count($videos) < 3) {
        exit("Потрібно 3 відео в public/uploads/promo/\n");
    }
    $userId = (int) $one("SELECT id FROM users WHERE role <> 'admin' ORDER BY id DESC LIMIT 1");
    $bal = $pdo->prepare('SELECT * FROM ad_balances WHERE user_id = :u');
    $bal->execute([':u' => $userId]);
    $state = [
        'user_id' => $userId,
        'balance' => $bal->fetch() ?: null,
        'enabled' => promo_setting($pdo, 'enabled', '0'),
        'marketplace_public' => site_setting($pdo, 'marketplace_public', '0'),
        'files' => [],
    ];
    $pdo->prepare('INSERT INTO ad_balances (user_id, balance, currency) VALUES (:u, 100000, :c)
                   ON DUPLICATE KEY UPDATE balance = 100000, currency = :c2')->execute([':u' => $userId, ':c' => PROMO_CURRENCY, ':c2' => PROMO_CURRENCY]);

    $ads = [
        ['image', 'Хмарне сховище для команди', 'Спільні папки, історія версій і доступ з телефона. 14 днів безкоштовно.', [0, 3, 44], [33, 22, 173]],
        ['image', 'Курс англійської для роботи', 'Розмовні заняття в малих групах увечері та на вихідних.', [10, 60, 90], [20, 140, 160]],
        ['image', 'Кавова підписка для офісу', 'Свіжообсмажене зерно щотижня з доставкою по Україні.', [70, 30, 10], [160, 90, 40]],
        ['video', 'Монтаж відео за хвилини', 'Шаблони, субтитри й експорт для соцмереж в одному редакторі.', [20, 10, 60], [120, 40, 160]],
        ['video', 'Бухгалтерія для ФОП', 'Звіти, податки й нагадування про платежі без зайвих таблиць.', [5, 50, 40], [30, 150, 110]],
        ['video', 'Конструктор сайтів', 'Лендинг для вашого бізнесу без програміста — за один вечір.', [40, 10, 30], [170, 40, 90]],
    ];
    $vi = 0;
    foreach ($ads as $i => [$type, $title, $desc, $from, $to]) {
        $pdo->prepare(
            "INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective, pricing_model,
                 unit_price, total_budget, start_date, status, currency, advertiser_category)
             VALUES ('paid', 'video', :u, :n, :m, 'demo@example.test', 'clicks', 'cpc', 20, 100000, :d, 'active', :cur, 'other')"
        )->execute([':u' => $userId, ':n' => 'DEMO ' . ($i + 1), ':m' => DEMO_MARKER, ':d' => promo_today(), ':cur' => PROMO_CURRENCY]);
        $cid = (int) $pdo->lastInsertId();
        $posterName = 'demo-poster-' . ($i + 1) . '.png';
        $poster($uploadDir . '/' . $posterName, $from, $to, $i + 1);
        $state['files'][] = $posterName;
        $video = $type === 'video' ? $videos[$vi++] : null;
        $pdo->prepare(
            "INSERT INTO ad_creatives (campaign_id, creative_type, weight, title, description, cta_key, destination_url, video_type, video_path,
                 poster_path, status, mime, size_bytes, duration_sec)
             VALUES (:c, :ct, 1, :t, :d, 'learn_more', 'https://example.com/', :vt, :vp, :pp, 'approved', :mime, :size, :dur)"
        )->execute([
            ':c' => $cid, ':ct' => $type === 'image' ? 'image' : 'video', ':t' => $title, ':d' => $desc,
            ':vt' => $video !== null ? 'upload' : null, ':vp' => $video !== null ? 'uploads/promo/' . $video : null,
            ':pp' => 'uploads/promo/' . $posterName,
            ':mime' => $video !== null ? 'video/mp4' : null,
            ':size' => $video !== null ? filesize($uploadDir . '/' . $video) : null,
            ':dur' => $video !== null ? (int) ceil((float) promo_mp4_duration_safe($uploadDir . '/' . $video)) : null,
        ]);
        $ins = $pdo->prepare('INSERT INTO ad_targets (campaign_id, placement, unit_price) VALUES (:c, :p, 20)');
        foreach ($placements as $pl) {
            $ins->execute([':c' => $cid, ':p' => $pl]);
        }
    }
    @file_put_contents(DEMO_STATE, json_encode($state));
    promo_admin_set_setting($pdo, 'enabled', '1');
    site_settings_save($pdo, ['marketplace_public' => '1']);
    promo_cache_flush();
    echo "Створено 6 тестових оголошень (3 зображення, 3 відео: " . implode(', ', array_slice($videos, 0, 3)) . ").\n";
    exit;
}

if ($action === 'delete') {
    $state = json_decode((string) @file_get_contents(DEMO_STATE), true) ?: [];
    $ids = $pdo->query('SELECT id FROM ad_campaigns WHERE advertiser_name = ' . $pdo->quote(DEMO_MARKER))->fetchAll(PDO::FETCH_COLUMN);
    foreach ($ids as $cid) {
        foreach (['ad_events', 'ad_stats_daily', 'ad_targets', 'ad_transactions', 'promo_event_log', 'ad_reports'] as $t) {
            try {
                $pdo->prepare("DELETE FROM {$t} WHERE campaign_id = :c")->execute([':c' => $cid]);
            } catch (Throwable $e) {
                // у таблиці може не бути campaign_id (ad_reports — за креативом)
            }
        }
        $pdo->prepare('DELETE FROM ad_creative_translations WHERE creative_id IN (SELECT id FROM ad_creatives WHERE campaign_id = :c)')->execute([':c' => $cid]);
        $pdo->prepare('DELETE FROM ad_creatives WHERE campaign_id = :c')->execute([':c' => $cid]);
        $pdo->prepare('DELETE FROM ad_campaigns WHERE id = :c')->execute([':c' => $cid]);
    }
    foreach ((array) ($state['files'] ?? []) as $f) {
        if (preg_match('/^demo-poster-\d+\.png$/', (string) $f)) {
            @unlink($uploadDir . '/' . $f);
        }
    }
    if (isset($state['user_id'])) {
        if ($state['balance'] === null) {
            $pdo->prepare('DELETE FROM ad_balances WHERE user_id = :u')->execute([':u' => $state['user_id']]);
        } else {
            $pdo->prepare('UPDATE ad_balances SET balance = :b, currency = :c WHERE user_id = :u')
                ->execute([':b' => $state['balance']['balance'], ':c' => $state['balance']['currency'], ':u' => $state['user_id']]);
        }
        promo_admin_set_setting($pdo, 'enabled', (string) $state['enabled']);
        site_settings_save($pdo, ['marketplace_public' => (string) $state['marketplace_public']]);
    }
    @unlink(DEMO_STATE);
    promo_cache_flush();
    printf("Видалено тестових кампаній: %d, залишилось: %d.\n", count($ids), (int) $one('SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = :m', [':m' => DEMO_MARKER]));
    exit;
}

echo "Використання: php tools/promo-demo-ads.php create|delete\n";

/** Тривалість mp4 з app/promo-advertiser.php, якщо доступна. */
function promo_mp4_duration_safe(string $path): ?float
{
    require_once __DIR__ . '/../app/promo-advertiser.php';

    return promo_mp4_duration($path);
}

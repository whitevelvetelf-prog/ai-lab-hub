<?php

declare(strict_types=1);

/**
 * AI LAB HUB — швидка публікація відкладеного (draft) оголошення платформи з marketplace-seed/promos.json.
 *
 *   php scripts/mp-publish-promos.php --slug=platform-post-free             — перевірка умов (нічого не пише)
 *   php scripts/mp-publish-promos.php --slug=platform-post-free --apply     — опублікувати в локальній БД
 *   php scripts/mp-publish-promos.php --slug=platform-post-free --emit-sql  — SQL для phpMyAdmin на хостингу
 *                                                                             (друкується в консоль, не виконується)
 *
 * Умови (publish_requires у маніфесті): posting_enabled = true у конфігу; дата «безкоштовно до» з налаштувань не
 * минула й збігається з датою в заголовку (інакше текст застарів — спершу виправте його). Публікує лише status='draft'
 * продавця платформи: status → published, published_at = NOW(), expires_at = NOW() + строк (MP_LISTING_LIFETIME_DAYS),
 * запис 'platform_publish' у mp_moderation_log. Нічого не видаляє.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
date_default_timezone_set('Europe/Kyiv');

$root = dirname(__DIR__);
require_once $root . '/app/mp-legal-config.php';
require_once $root . '/app/marketplace.php';   // mp_config(): прапори з config/marketplace(.local).php

$slug = '';
foreach (array_slice($argv, 1) as $a) {
    if (str_starts_with($a, '--slug=')) {
        $slug = substr($a, 7);
    }
}
$apply = in_array('--apply', $argv, true);
$emit = in_array('--emit-sql', $argv, true);
$manifest = json_decode((string) file_get_contents($root . '/marketplace-seed/promos.json'), true, 32, JSON_THROW_ON_ERROR);
$m = null;
foreach ($manifest['listings'] as $x) {
    if ($x['slug'] === $slug) {
        $m = $x;
    }
}
if ($m === null || preg_match('/^[a-z0-9-]{1,140}$/', $slug) !== 1) {
    fwrite(STDERR, "Невідомий --slug. Доступні: " . implode(', ', array_column($manifest['listings'], 'slug')) . "\n");
    exit(2);
}
$days = max(1, (int) MP_LISTING_LIFETIME_DAYS);
$req = (array) ($m['publish_requires'] ?? []);

if ($emit) {
    // На хостингу немає CLI: ті самі умови перевіряє сам SQL (дата з налаштувань і статус draft); прапор
    // posting_enabled — у config/marketplace.local.php, його SQL не бачить: перевірте вручну перед виконанням.
    $free = null;
    if (!empty($req['free_until_matches'])) {
        $pdo = require $root . '/config/database.php';
        $st = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_free_until'");
        $st->execute();
        $free = $st->fetchColumn() ?: null;
    }
    $q = static fn(string $v): string => "'" . str_replace(["\\", "'"], ["\\\\", "''"], $v) . "'";
    echo "-- Публікація оголошення платформи {$m['code']} ({$slug}). Перед виконанням: posting_enabled = true на хостингу.\n";
    echo "-- Нічого не видаляє; повторне виконання нічого не змінить (лише status = 'draft').\n";
    echo "UPDATE mp_listings l JOIN mp_sellers s ON s.id = l.seller_id AND s.is_platform = 1\n"
        . "SET l.status = 'published', l.published_at = NOW(), l.expires_at = NOW() + INTERVAL {$days} DAY, l.status_changed_at = NOW()\n"
        . "WHERE l.slug = " . $q($slug) . " AND l.post_form = 'ad' AND l.status = 'draft'"
        . ($free !== null ? "\n  AND (SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_free_until') = " . $q((string) $free)
            . "\n  AND " . $q((string) $free) . ' >= CURDATE()' : '') . ";\n";
    echo "SET @n := ROW_COUNT();\n";
    echo "INSERT INTO mp_moderation_log (listing_id, actor_id, action, note)\n"
        . "SELECT l.id, NULL, 'platform_publish', " . $q("публікація оголошення платформи {$m['code']} ({$slug})") . " FROM mp_listings l\n"
        . "WHERE @n = 1 AND l.slug = " . $q($slug) . " AND l.status = 'published' LIMIT 1;\n";
    echo "SELECT IF(@n = 1, 'OK: опубліковано', 'Нічого не змінено: немає чернетки або дата «безкоштовно до» інша') AS result;\n";
    exit(0);
}

/** @var PDO $pdo */
$pdo = require $root . '/config/database.php';
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$st = $pdo->prepare(
    "SELECT l.id, l.status, t.title FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id AND s.is_platform = 1
     LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk' WHERE l.slug = :s AND l.post_form = 'ad' LIMIT 1"
);
$st->execute([':s' => $slug]);
$row = $st->fetch(PDO::FETCH_ASSOC);
$errors = [];
if ($row === false) {
    $errors[] = 'оголошення немає в БД — спершу php scripts/mp-seed-promos.php --apply';
} elseif ($row['status'] !== 'draft') {
    $errors[] = 'статус «' . $row['status'] . '», а не draft — нічого не роблю';
}
if (!empty($req['posting_enabled']) && mp_config()['posting_enabled'] !== true) {
    $errors[] = 'posting_enabled = false: подачу оголошень ще не відкрито';
}
if (!empty($req['free_until_matches'])) {
    $fs = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_free_until'");
    $fs->execute();
    $raw = (string) ($fs->fetchColumn() ?: '');
    $d = DateTime::createFromFormat('!Y-m-d', $raw);
    $uk = ['січня', 'лютого', 'березня', 'квітня', 'травня', 'червня', 'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня'];
    $text = $d !== false && $d->format('Y-m-d') === $raw ? $d->format('j') . ' ' . $uk[(int) $d->format('n') - 1] . ' ' . $d->format('Y') : '';
    if ($text === '' || $raw < date('Y-m-d')) {
        $errors[] = 'дату «безкоштовно до» не задано або вона минула';
    } elseif ($row !== false && !str_contains((string) $row['title'], $text)) {
        $errors[] = "дата в заголовку не збігається з налаштуванням ({$text}) — оновіть текст";
    }
}
echo "{$m['code']} {$slug}" . ($row !== false ? " (id {$row['id']}, {$row['status']})" : '') . "\n";
foreach ($errors as $e) {
    echo "  ✗ {$e}\n";
}
if ($errors !== []) {
    exit(1);
}
echo "  ✓ умови виконано\n";
if (!$apply) {
    echo "Перевірка: нічого не записано. Для публікації — --apply.\n";
    exit(0);
}
$pdo->prepare("UPDATE mp_listings SET status = 'published', published_at = NOW(), expires_at = NOW() + INTERVAL {$days} DAY, status_changed_at = NOW()
               WHERE id = :id AND status = 'draft'")->execute([':id' => (int) $row['id']]);
$pdo->prepare("INSERT INTO mp_moderation_log (listing_id, actor_id, action, note) VALUES (:id, NULL, 'platform_publish', :n)")
    ->execute([':id' => (int) $row['id'], ':n' => "публікація оголошення платформи {$m['code']} ({$slug})"]);
@unlink($root . '/storage/cache/mp-tree-counts.json');
echo "Опубліковано: id {$row['id']}, діє {$days} днів.\n";

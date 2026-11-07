<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: «Перевірка зображень» (лише admin; іншим — 404). ЛИШЕ ЧИТАННЯ.
 *
 * Звіряє записи БД з файлами на диску:
 *   - фото оголошень користувачів: mp_listing_photos (file_name, thumb_name) → config 'photo_dir' (поза webroot);
 *   - обкладинки матеріалів платформи: mp_listings.cover_image ('covers/…') → public/assets/images/marketplace/.
 * Показує лічильник і список оголошень, у яких бракує хоча б одного файла. Нічого не видаляє, не змінює й не
 * переміщує: на місці відсутнього фото сайт показує заглушку (public/mp-photo.php), а файл можна повернути
 * з резервної копії (scripts/backup-uploads.php) — тоді він з'явиться без змін у БД.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-tree.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (mp_live_role() !== 'admin') {
    mp_not_found();
}
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex, nofollow');

$photoDir = rtrim((string) mp_config()['photo_dir'], '/\\');
$coverDir = __DIR__ . '/assets/images/marketplace';
$photoDirOk = is_dir($photoDir);

$title = static function (PDO $pdo, int $id): string {
    $st = $pdo->prepare(
        'SELECT COALESCE(NULLIF(t.title, \'\'), (SELECT t2.title FROM mp_listing_translations t2 WHERE t2.listing_id = l.id ORDER BY t2.lang = \'uk\' DESC LIMIT 1))
         FROM mp_listings l LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang WHERE l.id = :id'
    );
    $st->execute([':id' => $id]);

    return (string) ($st->fetchColumn() ?: '');
};

// listing_id => ['section','status','post_form','files'=>[[name, kind, missing]]]
$byListing = [];
$filesTotal = 0;
$filesMissing = 0;
$rows = $pdo->query(
    'SELECT p.listing_id, p.file_name, p.thumb_name, l.section, l.status, l.post_form
     FROM mp_listing_photos p JOIN mp_listings l ON l.id = p.listing_id ORDER BY p.listing_id DESC, p.sort_order, p.id'
)->fetchAll(PDO::FETCH_ASSOC);
foreach ($rows as $r) {
    $id = (int) $r['listing_id'];
    $byListing[$id] ??= ['section' => (string) $r['section'], 'status' => (string) $r['status'], 'post_form' => (string) $r['post_form'], 'files' => []];
    foreach (['file_name' => 'фото', 'thumb_name' => 'мініатюра'] as $col => $kind) {
        $name = (string) $r[$col];
        $ok = preg_match(MPB_PHOTO_NAME_RE, $name) === 1 && is_file($photoDir . '/' . $name);
        $filesTotal++;
        if (!$ok) {
            $filesMissing++;
        }
        $byListing[$id]['files'][] = [$name, $kind, !$ok, $ok ? (int) filesize($photoDir . '/' . $name) : 0];
    }
}
$covers = $pdo->query("SELECT id, section, status, post_form, cover_image FROM mp_listings WHERE cover_image IS NOT NULL AND cover_image <> '' ORDER BY id DESC")
    ->fetchAll(PDO::FETCH_ASSOC);
foreach ($covers as $r) {
    $id = (int) $r['id'];
    $name = (string) $r['cover_image'];
    $ok = preg_match('~^covers/[A-Za-z0-9._-]+$~', $name) === 1 && is_file($coverDir . '/' . $name);
    $filesTotal++;
    if (!$ok) {
        $filesMissing++;
    }
    $byListing[$id] ??= ['section' => (string) $r['section'], 'status' => (string) $r['status'], 'post_form' => (string) $r['post_form'], 'files' => []];
    $byListing[$id]['files'][] = [$name, 'обкладинка', !$ok, $ok ? (int) filesize($coverDir . '/' . $name) : 0];
}
$broken = array_filter($byListing, static fn(array $l): bool => in_array(true, array_column($l['files'], 2), true));
krsort($broken);

mpt_open('Перевірка зображень Marketplace', 'Оголошення Marketplace, у яких бракує файлів зображень', 'mp-photo-check.php', true, '');
?>
    <div class="mp-page">
        <?= mpt_crumbs([['CRM', 'account.php'], [t('mp_heading'), 'marketplace.php'], ['Перевірка зображень', null]]) ?>
        <h1 class="mp-title">Перевірка зображень Marketplace</h1>
        <p class="mp-subtitle">Лише читання: сторінка нічого не видаляє і не змінює. Відсутній файл на сайті показується заглушкою; повернути його можна з резервної копії теки фото.</p>
        <?php if (!$photoDirOk): ?>
            <div class="mp-alert" role="alert">Теки фото <code><?= mp_e($photoDir) ?></code> не існує — перевірте config 'photo_dir' на сервері.</div>
        <?php endif; ?>
        <div class="mp-note mp-note--box" role="status">
            Оголошень з файлами: <strong><?= count($byListing) ?></strong> ·
            файлів у БД: <strong><?= $filesTotal ?></strong> ·
            відсутніх файлів: <strong><?= $filesMissing ?></strong> ·
            оголошень з відсутніми файлами: <strong><?= count($broken) ?></strong>
        </div>
        <?php if ($broken === []): ?>
            <p class="mp-text">Усі файли зображень на місці.</p>
        <?php else: ?>
            <div class="mp-table-wrap">
            <table class="mp-table">
                <thead><tr><th>ID</th><th>Назва</th><th>Розділ</th><th>Статус</th><th>Відсутні файли</th></tr></thead>
                <tbody>
                <?php foreach ($broken as $id => $l): ?>
                    <tr>
                        <td><a href="<?= $l['post_form'] === 'ad' ? 'mp-moderation.php?id=' . $id : 'marketplace-offer.php?id=' . $id ?>"><?= $id ?></a></td>
                        <td><?= mp_e($title($pdo, $id)) ?></td>
                        <td><?= mp_e($l['section']) ?><?= $l['post_form'] === 'ad' ? ' · оголошення' : '' ?></td>
                        <td><?= mp_e($l['status']) ?></td>
                        <td>
                            <?php foreach ($l['files'] as [$name, $kind, $missing]): ?>
                                <?php if ($missing): ?><div><?= mp_e($kind) ?>: <code><?= mp_e($name) ?></code></div><?php endif; ?>
                            <?php endforeach; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
        <?php endif; ?>
        <p class="mp-hint">Тека фото оголошень: <code><?= mp_e($photoDir) ?></code> (поза Git). Обкладинки: <code>public/assets/images/marketplace/covers/</code> (поза Git). Резервна копія — <code>php scripts/backup-uploads.php</code>.</p>
    </div>
<?php mpt_close(); ?>

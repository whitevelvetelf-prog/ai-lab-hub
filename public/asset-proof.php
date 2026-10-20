<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Підтвердження публікації» для автора активу (і співробітників): SHA-256 оригіналу, час
 * завантаження (UTC), акаунт, декларації походження й прав, адреса оголошення. Друкується або зберігається
 * як PDF засобами браузера. Чесно: це технічний запис, а не юридичне свідоцтво.
 *
 *   asset-proof.php?id=N
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$userId = mpb_require_login();
$id = (int) ($_GET['id'] ?? 0);
$row = $id > 0 ? ast_listing($pdo, $id, 'uk') : null;
if ($row === null || ((int) $row['seller_user_id'] !== $userId && !mp_is_staff())) {
    mp_not_found();
}
$u = $pdo->prepare('SELECT id, email FROM users WHERE id = :u');
$u->execute([':u' => (int) $row['ownership_user_id']]);
$owner = $u->fetch(PDO::FETCH_ASSOC) ?: ['id' => $row['ownership_user_id'], 'email' => ''];
$mask = static function (string $email): string {
    [$l, $d] = array_pad(explode('@', $email, 2), 2, '');

    return $l === '' ? '' : mb_substr($l, 0, 2) . '…@' . $d;
};
$url = mail_site_url_safe() . '/asset.php?id=' . $id;
$lic = ast_licenses($pdo)[(string) $row['license_code']] ?? null;
$lang = ast_lang();
?>
<!DOCTYPE html>
<html lang="<?= ast_e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title><?= ast_e(ast_tr('proof_title')) ?> #<?= $id ?></title>
    <style>
        body { font-family: Arial, sans-serif; color: #111; background: #fff; max-width: 760px; margin: 24px auto; padding: 0 16px; line-height: 1.5; }
        h1 { font-size: 1.5rem; }
        dl { display: grid; grid-template-columns: minmax(0, 220px) minmax(0, 1fr); gap: 6px 16px; }
        dt { font-weight: bold; }
        dd { margin: 0; overflow-wrap: anywhere; }
        code { font-size: 0.92rem; }
        .note { border: 1px solid #999; padding: 10px 14px; border-radius: 8px; background: #f6f6f6; }
        a { color: #1d4ed8; }
        @media (max-width: 520px) { dl { grid-template-columns: 1fr; } }
        @media print { .noprint { display: none; } }
    </style>
</head>
<body>
    <h1><?= ast_e(ast_tr('proof_title')) ?> — AI LAB HUB</h1>
    <p class="note"><?= ast_e(ast_tr('proof_note')) ?></p>
    <dl>
        <dt>№</dt><dd><?= $id ?></dd>
        <dt><?= ast_e(ast_tr('f_title')) ?></dt><dd><?= ast_e($row['title']) ?></dd>
        <dt><?= ast_e(ast_tr('proof_sha')) ?></dt><dd><code><?= ast_e($row['orig_sha256']) ?></code></dd>
        <dt><?= ast_e(ast_tr('proof_size')) ?></dt><dd><?= (int) $row['width'] ?>×<?= (int) $row['height'] ?> px, <?= number_format((int) $row['orig_size'] / 1048576, 2) ?> MB, <?= ast_e($row['orig_mime']) ?></dd>
        <dt><?= ast_e(ast_tr('proof_uploaded')) ?></dt><dd><?= ast_e($row['uploaded_at']) ?></dd>
        <dt><?= ast_e(ast_tr('proof_account')) ?></dt><dd>#<?= (int) $owner['id'] ?> <?= ast_e($mask((string) $owner['email'])) ?> (<?= ast_e($row['seller_name']) ?>)</dd>
        <dt><?= ast_e(ast_tr('origin_label')) ?></dt><dd><?= ast_e(ast_tr('origin_' . $row['origin'])) ?></dd>
        <dt><?= ast_e(ast_tr('f_ownership')) ?></dt><dd><?= ast_e($row['ownership_declared_at']) ?> UTC</dd>
        <dt><?= ast_e(ast_tr('license')) ?></dt><dd><?= $lic !== null ? ast_e(ast_license_title($lic, $lang)) : ast_e($row['license_code']) ?></dd>
        <dt>URL</dt><dd><a href="<?= ast_e($url) ?>"><?= ast_e($url) ?></a></dd>
        <dt><?= ast_e(ast_tr('published')) ?></dt><dd><?= ast_e((string) ($row['published_at'] ?? '—')) ?></dd>
    </dl>
    <p class="noprint"><button type="button" onclick="window.print()"><?= ast_e(ast_tr('proof_print')) ?></button></p>
</body>
</html>

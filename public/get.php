<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: єдина точка видачі пропозиції (?id=N).
 *
 *   link    — перевіряє, що URL http/https, записує claim, робить редирект;
 *   file    — лише для залогінених: записує claim і віддає файл через PHP
 *             (Content-Disposition: attachment, X-Content-Type-Options: nosniff, MIME з білого списку;
 *             файли лежать ПОЗА webroot під випадковим іменем);
 *   contact — записує claim і показує контакт.
 *
 * Claim: не частіше 1 разу на добу для пари (користувач або сесія + пропозиція), mp_register_claim().
 * Чернетки/архів/невідомий id і вимкнений перемикач → 404. Тільки GET; prefetch/HEAD claim не створюють.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace.php';

mp_public_require();

header('X-Robots-Tag: noindex, nofollow');
header('Cache-Control: private, no-store');

// Лише GET: HEAD, POST тощо claim не створюють. Браузерний prefetch/prerender — теж.
if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'GET') {
    http_response_code(405);
    header('Allow: GET');
    exit;
}
$purpose = strtolower((string) ($_SERVER['HTTP_SEC_PURPOSE'] ?? $_SERVER['HTTP_PURPOSE'] ?? $_SERVER['HTTP_X_MOZ'] ?? ''));
if ($purpose !== '' && (str_contains($purpose, 'prefetch') || str_contains($purpose, 'prerender'))) {
    http_response_code(204);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$id = (int) ($_GET['id'] ?? 0);
$stmt = $pdo->prepare(
    "SELECT id, delivery_type, delivery_url, file_id
     FROM mp_listings
     WHERE id = :id AND section = 'solution' AND status = 'published'"
);
$stmt->execute([':id' => $id]);
$offer = $id > 0 ? $stmt->fetch(PDO::FETCH_ASSOC) : false;
if ($offer === false) {
    mp_not_found();
}

$userId = auth_user_id();

/** Claim, що не ламає видачу при збої обліку (помилка — у лог, користувач усе одно отримує пропозицію). */
$claim = static function () use ($pdo, $offer, $userId): void {
    try {
        mp_register_claim($pdo, (int) $offer['id'], $userId);
    } catch (Throwable $e) {
        error_log('[marketplace] claim failed for listing ' . (int) $offer['id'] . ': ' . $e->getMessage());
    }
};

/** Сторінка-повідомлення (вхід потрібен / недоступно / контакт) у стилі Marketplace. */
$render = static function (int $status, string $title, string $bodyHtml) use ($offer): never {
    http_response_code($status);
    $lang = current_lang();
    ?>
<!DOCTYPE html>
<html lang="<?= mp_e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title><?= mp_e($title) ?> — <?= mp_e(t('title_marketplace')) ?></title>
    <?php include __DIR__ . '/../app/header.php'; ?>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <link rel="stylesheet" href="<?= css_asset('mp-public.css') ?>">
</head>
<body class="mp-body">
    <?php include __DIR__ . '/../app/site-header.php'; ?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="offer.php?id=<?= (int) $offer['id'] ?>"><?= mp_e(t('mp_back')) ?></a>
        <section class="mp-panel">
            <h1 class="mp-panel__title"><?= mp_e($title) ?></h1>
            <?= $bodyHtml ?>
        </section>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
    <?php
    exit;
};

$unavailable = static fn() => $render(
    503,
    t('mp_unavailable_title'),
    '<p class="mp-text">' . mp_e(t('mp_unavailable_text')) . '</p>'
);

$type = (string) $offer['delivery_type'];

// --- link ---------------------------------------------------------------
if ($type === 'link') {
    $url = (string) ($offer['delivery_url'] ?? '');
    if (!mp_safe_redirect_url($url)) {
        $unavailable();
    }
    $claim();
    header('Location: ' . $url, true, 302);
    exit;
}

// --- contact ------------------------------------------------------------
if ($type === 'contact') {
    $contact = trim((string) ($offer['delivery_url'] ?? ''));
    if (!mp_is_contact($contact)) {
        $unavailable();
    }
    $claim();
    if (mp_is_http_url($contact)) {
        $shown = '<a class="mp-contact" href="' . mp_e($contact) . '" target="_blank" rel="noopener nofollow">' . mp_e($contact) . '</a>';
    } else {
        $shown = '<a class="mp-contact" href="mailto:' . mp_e($contact) . '">' . mp_e($contact) . '</a>';
    }
    $render(200, t('mp_contact_title'), '<p class="mp-text">' . mp_e(t('mp_contact_text')) . '</p>' . $shown);
}

// --- file ---------------------------------------------------------------
if ($type === 'file') {
    if (!auth_check()) {
        $render(
            401,
            t('mp_login_title'),
            '<p class="mp-text">' . mp_e(t('mp_login_text')) . '</p>'
            . '<p style="margin-top:18px;display:flex;gap:12px;flex-wrap:wrap;">'
            . '<a class="mp-btn mp-btn--primary" href="login.php">' . mp_e(t('nav_login')) . '</a>'
            . '<a class="mp-btn" href="register.php">' . mp_e(t('mp_register')) . '</a></p>'
        );
    }

    $fileStmt = $pdo->prepare('SELECT original_name, stored_name, size_bytes, scan_status FROM mp_files WHERE id = :id');
    $fileStmt->execute([':id' => (int) ($offer['file_id'] ?? 0)]);
    $file = $fileStmt->fetch(PDO::FETCH_ASSOC);
    if ($file === false || in_array((string) $file['scan_status'], ['infected', 'blocked'], true)) {
        $unavailable();
    }

    // Білий список MIME за розширенням (розширення й реальний MIME перевірені ще при завантаженні).
    $mimeByExt = [
        'pdf'  => 'application/pdf',
        'md'   => 'text/markdown; charset=utf-8',
        'txt'  => 'text/plain; charset=utf-8',
        'json' => 'application/json',
        'csv'  => 'text/csv; charset=utf-8',
        'zip'  => 'application/zip',
    ];
    $original = (string) $file['original_name'];
    $ext = strtolower(pathinfo($original, PATHINFO_EXTENSION));
    $stored = (string) $file['stored_name'];
    $dir = realpath((string) mp_config()['file_storage_dir']);
    $path = ($dir !== false && preg_match('/^[A-Za-z0-9]{8,64}$/', $stored) === 1) ? realpath($dir . DIRECTORY_SEPARATOR . $stored) : false;
    if (
        !isset($mimeByExt[$ext]) || !in_array($ext, (array) mp_config()['allowed_extensions'], true)
        || $path === false || !str_starts_with($path, $dir . DIRECTORY_SEPARATOR) || !is_file($path) || !is_readable($path)
    ) {
        error_log('[marketplace] file for listing ' . (int) $offer['id'] . ' is missing or invalid');
        $unavailable();
    }

    $claim();

    $clean = preg_replace('/[\x00-\x1F\x7F"\\\\\/]+/', '_', $original) ?? 'file.' . $ext;
    $ascii = preg_replace('/[^A-Za-z0-9._-]+/', '_', $clean) ?? 'file.' . $ext;
    while (ob_get_level() > 0) {
        ob_end_clean();
    }
    header('Content-Type: ' . $mimeByExt[$ext]);
    header('Content-Length: ' . (string) filesize($path));
    header('Content-Disposition: attachment; filename="' . $ascii . '"; filename*=UTF-8\'\'' . rawurlencode($clean));
    header('X-Content-Type-Options: nosniff');
    header("Content-Security-Policy: default-src 'none'; sandbox");
    readfile($path);
    exit;
}

$unavailable();

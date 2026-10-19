<?php

declare(strict_types=1);

/**
 * AI LAB HUB — скарга на оголошення компанії (POST + CSRF, лише залогінені). Повертає на сторінку оголошення.
 * Скарги — спільна таблиця mp_reports; достатньо унікальних скарг → оголошення знову на модерації (lst_report()).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';

mp_public_or_staff_require();
mpb_require_post();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$id = (int) ($_POST['id'] ?? 0);
$uid = auth_user_id();
if ($uid === null) {
    header('Location: login.php', true, 303);
    exit;
}
$res = lst_report($pdo, $id, $uid, (string) ($_POST['reason'] ?? ''), trim((string) ($_POST['note'] ?? '')));
$text = match ($res) {
    'ok' => t('mpb_report_ok'),
    'duplicate' => t('mpb_report_duplicate'),
    'own' => t('mpb_report_own'),
    'invalid' => t('mpb_report_invalid'),
    'rate' => t('mpb_rate_limited'),
    default => t('mpb_report_notfound'),
};
$_SESSION['lst_report_msg'] = ['ok' => $res === 'ok', 'text' => $text];
header('Location: listing.php?id=' . $id, true, 303);
exit;

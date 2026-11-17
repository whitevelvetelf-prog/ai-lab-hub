<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: дії автора за Правилами (POST + CSRF, лише залогінений власник оголошення).
 *   counter — заперечення на скаргу правовласника (п. 10.3): текст + https-посилання на докази, до MP_COUNTER_NOTICE_DAYS робочих днів;
 *   appeal  — оскарження рішення модерації (п. 7.5): відхилено / знято / приховано, до MP_APPEAL_WINDOW_DAYS днів;
 *   read    — позначити повідомлення прочитаними.
 * Після дії — назад у «Мої оголошення» (блок рішень і скарг).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_or_staff_require();
mpb_require_post();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$action = (string) ($_POST['action'] ?? '');
$text = is_string($_POST['text'] ?? null) ? (string) $_POST['text'] : '';

if ($action === 'counter') {
    $res = mpl_counter_submit($pdo, (int) ($_POST['complaint_id'] ?? 0), $userId, $text, is_string($_POST['url'] ?? null) ? (string) $_POST['url'] : '');
    mpb_flash($res === 'ok' ? 'ok' : 'error', mpl_tr(match ($res) {
        'ok' => 'my_counter_sent',
        'closed' => 'my_counter_closed',
        'err_text' => 'my_counter_err',
        default => 'c_err_notfound',
    }));
    mpb_redirect('marketplace-my.php#decisions');
}
if ($action === 'appeal') {
    $res = mpl_appeal_create($pdo, (int) ($_POST['listing_id'] ?? 0), $userId, $text, 'cabinet');
    if ($res === 'ok') {
        mpb_flash('ok', mpl_tr('my_appeal_sent', (int) MP_APPEAL_ANSWER_DAYS));
    } else {
        mpb_flash('error', mpl_tr($res === 'err_text' ? 'my_appeal_err_text' : ($res === 'err_window' ? 'my_appeal_err_window' : 'c_err_notfound')));
    }
    mpb_redirect('marketplace-my.php#decisions');
}
if ($action === 'read') {
    mpl_notifications_mark_read($pdo, $userId);
}
mpb_redirect('marketplace-my.php#notifications');

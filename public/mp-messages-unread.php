<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: лічильник непрочитаних повідомлень (JSON) для значка в шапці й списку розмов.
 *
 *   GET mp-messages-unread.php          → {ok, total}
 *   GET mp-messages-unread.php?list=1   → {ok, total, convs:[{id, unread, preview, time, last}]}  (перші 50 розмов «Усі»)
 *
 * Викликає assets/js/msg-unread.js кожні msg_unread_poll_seconds (30 с) лише на видимій вкладці. Лише свої дані
 * (auth_user_id); гість → 401. Частота: не частіше 1 запиту на 8 с у сесії (429) + добовий IP-ліміт ip_limit_poll.
 * Тексту повідомлень, крім короткого фрагмента для власного списку розмов, не повертає.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_private_headers();
header('Content-Type: application/json; charset=utf-8');

$fail = static function (int $status, string $code): never {
    http_response_code($status);
    echo json_encode(['ok' => false, 'error' => $code]);
    exit;
};
if (!msg_enabled($pdo)) {
    $fail(404, 'disabled');
}
if (!auth_check()) {
    $fail(401, 'login');
}
$uid = (int) auth_user_id();
$now = microtime(true);
if (isset($_SESSION['msg_unread_poll']) && $now - (float) $_SESSION['msg_unread_poll'] < 8.0) {
    header('Retry-After: 10');
    $fail(429, 'rate');
}
$_SESSION['msg_unread_poll'] = $now;
if (!mpb_is_staff() && !mpb_ip_hit($pdo, 'msg_poll', (int) msg_cfg('ip_limit_poll'))) {
    header('Retry-After: 60');
    $fail(429, 'rate');
}

unset($_SESSION['msg_unread_cache']);   // свіже число (кеш сесії — для звичайних сторінок)
$out = ['ok' => true, 'total' => msg_unread_total($pdo, $uid)];
if (($_GET['list'] ?? '') === '1') {
    $today = date('Y-m-d');
    $dayFmt = current_lang() === 'uk' ? 'd.m.y' : 'y-m-d';
    $out['convs'] = [];
    foreach (array_slice(msg_inbox($pdo, $uid, 'all', 1), 0, MSG_PAGE_SIZE) as $r) {
        $ts = strtotime((string) $r['time']) ?: time();
        $out['convs'][] = [
            'id' => (int) $r['id'], 'unread' => (int) $r['unread'], 'last' => (int) $r['last_message_id'],
            'preview' => ($r['last_mine'] ? t('msg_you') . ': ' : '') . (string) $r['preview'],
            'time' => date(date('Y-m-d', $ts) === $today ? 'H:i' : $dayFmt, $ts),
        ];
    }
}
session_write_close();
echo json_encode($out, JSON_UNESCAPED_UNICODE);

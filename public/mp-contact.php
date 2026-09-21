<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: показати контакти оголошення (POST + CSRF).
 *
 * Контактів немає в HTML offer.php до кліку. Гість → 401 з пропозицією увійти. Залогований: до
 * reveals_per_day (30) розкриттів за добу (журнал mp_contact_reveals), решта → 429.
 * Відповідь: JSON (fetch із offer.php, заголовок Accept: application/json) або проста HTML-сторінка
 * (форма без JS).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_require();

$json = str_contains((string) ($_SERVER['HTTP_ACCEPT'] ?? ''), 'application/json');
mpb_require_post($json);
header('Cache-Control: no-store');

$id = (int) ($_POST['id'] ?? 0);
$back = 'offer.php?id=' . $id;

/** Відповідь-помилка у потрібному форматі. */
$fail = static function (int $status, string $code, string $message, bool $withLogin = false) use ($json, $back): never {
    if ($json) {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => $code, 'message' => $message, 'login_url' => $withLogin ? 'login.php' : null], JSON_UNESCAPED_UNICODE);
        exit;
    }
    $body = '<p class="mp-text">' . mp_e($message) . '</p>';
    if ($withLogin) {
        $body .= '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="login.php">' . mp_e(t('nav_login')) . '</a>'
            . '<a class="mp-btn" href="register.php">' . mp_e(t('mp_register')) . '</a></p>';
    }
    mpb_message_page($status, t('mpb_contact_title'), $body, $back);
};

if (!auth_check()) {
    $fail(401, 'login', t('mpb_contact_login'), true);
}
if ($id <= 0) {
    $fail(404, 'notfound', t('mpb_contact_notfound'));
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$res = mpb_reveal($pdo, $id, (int) auth_user_id());
if ($res['status'] === 'notfound') {
    $fail(404, 'notfound', t('mpb_contact_notfound'));
}
if ($res['status'] === 'limit') {
    $fail(429, 'limit', sprintf(t('mpb_contact_limit'), (int) mp_config()['reveals_per_day']));
}

if ($json) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => true, 'contacts' => $res['contacts']], JSON_UNESCAPED_UNICODE);
    exit;
}

$html = '<ul class="mp-contact-list">';
foreach ($res['contacts'] as $c) {
    $val = $c['href'] !== null
        ? '<a class="mp-contact" href="' . mp_e($c['href']) . '" rel="nofollow noopener">' . mp_e($c['value']) . '</a>'
        : '<span class="mp-contact">' . mp_e($c['value']) . '</span>';
    $html .= '<li><span class="mp-contact-list__label">' . mp_e($c['label']) . '</span> ' . $val . '</li>';
}
$html .= '</ul><p class="mp-note">' . mp_e(t('mpb_disclaimer')) . '</p>';
mpb_message_page(200, t('mpb_contact_title'), $html, $back);

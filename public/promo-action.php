<?php

declare(strict_types=1);

/**
 * AI LAB HUB — обробник дій кабінету рекламодавця (розділ «Реклама» в account.php).
 *
 * POST (CSRF обов'язковий, лише власні кампанії):
 *   action=save_draft | submit            — майстер кампанії (multipart: video, poster);
 *                                           house=1 — власна реклама сайту (лише admin)
 *   action=pause | resume | complete | duplicate  campaign_id=N
 *   action=topup  amount=123.45           — заявка на поповнення (ручний переказ)
 *   action=notify_prefs  low_balance=1    — листи про низький баланс (решта обов'язкові)
 * GET:
 *   action=export  campaign=N|0  from=Y-m-d  to=Y-m-d   — CSV статистики
 *
 * Після POST — редирект назад у кабінет (account.php?promo_tab=…#acc-promo)
 * з повідомленням у $_SESSION['promo_flash'].
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-admin.php';

$userId = auth_user_id();
if ($userId === null) {
    header('Location: login.php');
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$back = static function (string $tab, array $flash, array $extra = []): never {
    $_SESSION['promo_flash'] = $flash + ['tab' => $tab];
    $query = http_build_query(['promo_tab' => $tab] + $extra);
    header('Location: account.php?' . $query . '#acc-promo', true, 303);
    exit;
};

$action = (string) ($_POST['action'] ?? $_GET['action'] ?? '');

// --- CSV-експорт (GET, лише власні дані) ------------------------------------
if ($action === 'export' && ($_SERVER['REQUEST_METHOD'] ?? '') === 'GET') {
    $campaignId = (int) ($_GET['campaign'] ?? 0);
    if ($campaignId > 0 && promo_owned_campaign($pdo, $userId, $campaignId) === null) {
        http_response_code(404);
        exit;
    }
    $date = static function (string $key, string $default): string {
        $v = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
        $d = DateTime::createFromFormat('!Y-m-d', $v);

        return ($d !== false && $d->format('Y-m-d') === $v) ? $v : $default;
    };
    $from = $date('from', promo_today(-29));
    $to = $date('to', promo_today());

    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="promo-stats-' . $from . '_' . $to . '.csv"');
    header('Cache-Control: no-store');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, ['date', 'campaign_id', 'campaign', 'placement', 'impressions', 'views', 'clicks', 'ctr_percent', 'spend_uah']);
    foreach (promo_stats_rows($pdo, $userId, $campaignId ?: null, $from, $to, 'day_campaign_placement') as $r) {
        $ctr = (int) $r['impressions'] > 0 ? round((int) $r['clicks'] / (int) $r['impressions'] * 100, 2) : 0;
        // Назва — текст рекламодавця: нейтралізуємо формули в Excel.
        $name = preg_match('/^[=+\-@\t\r]/', (string) $r['name']) ? "'" . $r['name'] : (string) $r['name'];
        fputcsv($out, [$r['d'], $r['campaign_id'], $name, $r['placement'], $r['impressions'], $r['views'], $r['clicks'], $ctr, number_format((int) $r['spend'] / 100, 2, '.', '')]);
    }
    fclose($out);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: account.php#acc-promo');
    exit;
}

// Перевищено post_max_size — PHP віддає порожні $_POST/$_FILES.
if ($_POST === [] && (int) ($_SERVER['CONTENT_LENGTH'] ?? 0) > 0) {
    $back('create', ['ok' => false, 'msgs' => ['err_video_too_big']]);
}

if (!promo_csrf_verify()) {
    $back('campaigns', ['ok' => false, 'msgs' => ['err_csrf']]);
}

switch ($action) {
    case 'save_draft':
    case 'submit':
        // Власна реклама сайту (без білінгу) — лише для admin (перевірка за БД).
        $house = !empty($_POST['house']) && promo_is_admin($pdo, $userId);
        $result = promo_save_campaign($pdo, $userId, $_POST, $_FILES, $action === 'submit', $house);
        $edit = $result['id'] !== null ? ['promo_edit' => $result['id']] : [];
        if ($house) {
            $edit['promo_house'] = 1;
        }
        if ($house && $result['submitted']) {
            $_SESSION['padm_flash'] = ['ok' => true, 'msgs' => ['Власну рекламу запущено.']];
            header('Location: account.php?padm_tab=house#acc-promo-admin', true, 303);
            exit;
        }
        if (!$result['saved']) {
            // Нічого не збережено — повертаємо введене (файли треба вибрати знову).
            $_SESSION['promo_old'] = array_diff_key($_POST, ['csrf' => 1, 'poster_data' => 1, 'action' => 1]);
            $back('create', ['ok' => false, 'msgs' => $result['errors']], $edit);
        }
        if ($result['submitted']) {
            $back('campaigns', ['ok' => true, 'msgs' => ['ok_submitted']]);
        }
        if ($action === 'submit') {
            // Збережено як чернетку, але для надсилання чогось бракує.
            $back('create', ['ok' => false, 'msgs' => array_merge(['warn_saved_not_submitted'], $result['errors'])], $edit);
        }
        $back('create', ['ok' => true, 'msgs' => ['ok_draft_saved']], $edit);

    case 'pause':
    case 'resume':
    case 'complete':
    case 'duplicate':
        [$ok, $msg, $id] = promo_campaign_action($pdo, $userId, (int) ($_POST['campaign_id'] ?? 0), $action);
        if ($ok && $action === 'duplicate') {
            $back('create', ['ok' => true, 'msgs' => [$msg]], ['promo_edit' => $id]);
        }
        $back('campaigns', ['ok' => $ok, 'msgs' => [$msg]]);

    case 'notify_prefs':
        require_once __DIR__ . '/../app/promo-mail.php';
        promo_notify_set_low_balance($pdo, $userId, !empty($_POST['low_balance']));
        $back('balance', ['ok' => true, 'msgs' => ['ok_notify_saved']]);

    case 'topup':
        [$ok, $msg, $request] = promo_request_topup($pdo, $userId, $_POST['amount'] ?? '');
        $back('balance', ['ok' => $ok, 'msgs' => [$msg], 'topup' => $request]);
}

$back('campaigns', ['ok' => false, 'msgs' => ['err_generic']]);

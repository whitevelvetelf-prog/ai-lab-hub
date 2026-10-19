<?php

declare(strict_types=1);

/**
 * AI LAB HUB — дії адмінки оголошень компаній (POST + CSRF). Модерація — employee/admin (роль з БД),
 * налаштування — лише admin. Повертає у вкладку account.php?ladm_tab=…#acc-listings-admin.
 *
 *   approve | reject (template, comment) | bulk_approve | bulk_reject (ids[], template) | remove | to_pending | recheck | settings
 * Інші дії (ліди, аутріч) обробляє olead_admin_action(), якщо підключено app/outreach-admin.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing-admin-cabinet.php';
if (is_file(__DIR__ . '/../app/outreach-admin.php')) {
    require_once __DIR__ . '/../app/outreach-admin.php';
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (!mp_is_staff() || ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: account.php', true, 303);
    exit;
}
$returnTab = preg_match('/^[a-z_]{1,20}$/', (string) ($_POST['return_tab'] ?? '')) === 1 ? (string) $_POST['return_tab'] : 'mod';
$back = static function (bool $ok, array $msgs) use ($returnTab): never {
    $_SESSION['ladm_flash'] = ['ok' => $ok, 'msgs' => $msgs];
    header('Location: account.php?ladm_tab=' . $returnTab . '#acc-listings-admin', true, 303);
    exit;
};
if (!mp_csrf_verify()) {
    $back(false, ['Сесія застаріла — оновіть сторінку й повторіть.']);
}
$actor = (int) auth_user_id();
$isAdmin = mp_live_role() === 'admin';
$action = (string) ($_POST['action'] ?? '');
$id = (int) ($_POST['id'] ?? 0);

$reasonText = static function (): string {
    $tpl = (string) ($_POST['template'] ?? 'other');
    if (!in_array($tpl, LST_REJECT_TEMPLATES, true)) {
        $tpl = 'other';
    }
    $comment = mb_substr(trim(strip_tags((string) ($_POST['comment'] ?? ''))), 0, 300);

    return LST_I18N['rej_' . $tpl][0] . ($comment !== '' ? ' ' . $comment : '');
};

switch ($action) {
    case 'approve':
        $ok = lst_approve($pdo, $id, $actor);
        $back($ok, [$ok ? 'Оголошення #' . $id . ' схвалено й опубліковано, автору надіслано лист.' : 'Не вдалося схвалити (оголошення вже не на модерації?).']);
    case 'reject':
        $ok = lst_reject($pdo, $id, $actor, $reasonText());
        $back($ok, [$ok ? 'Оголошення #' . $id . ' відхилено, автору надіслано лист.' : 'Не вдалося відхилити (статус змінився?).']);
    case 'bulk_approve':
    case 'bulk_reject':
        $ids = array_values(array_unique(array_filter(array_map('intval', is_array($_POST['ids'] ?? null) ? $_POST['ids'] : []))));
        if ($ids === []) {
            $back(false, ['Нічого не позначено.']);
        }
        $n = 0;
        $reason = $reasonText();
        foreach (array_slice($ids, 0, 100) as $one) {
            $n += (int) ($action === 'bulk_approve' ? lst_approve($pdo, $one, $actor) : lst_reject($pdo, $one, $actor, $reason));
        }
        $back($n > 0, [($action === 'bulk_approve' ? 'Схвалено: ' : 'Відхилено: ') . $n . ' з ' . count($ids) . '.']);
    case 'remove':
        $ok = lst_remove($pdo, $id, $actor, 'знято модератором');
        $back($ok, [$ok ? 'Оголошення #' . $id . ' знято з публікації.' : 'Не вдалося зняти.']);
    case 'to_pending':
        $st = $pdo->prepare("UPDATE mp_listings SET status = 'pending' WHERE id = :id AND status IN ('rejected', 'archived', 'expired') AND section IN ('job', 'course', 'service')");
        $st->execute([':id' => $id]);
        if ($st->rowCount() > 0) {
            mp_log($pdo, $id, $actor, 'to_pending', 'повернуто на модерацію');
        }
        $back($st->rowCount() > 0, [$st->rowCount() > 0 ? 'Оголошення #' . $id . ' повернуто на модерацію.' : 'Не вдалося.']);
    case 'recheck':
        $st = $pdo->prepare("SELECT delivery_url FROM mp_listings WHERE id = :id AND section IN ('job', 'course', 'service')");
        $st->execute([':id' => $id]);
        $url = (string) $st->fetchColumn();
        if (!lst_url_valid($url)) {
            $back(false, ['Некоректне посилання.']);
        }
        $check = lst_link_check($pdo, $url);
        $pdo->prepare('UPDATE mp_listings SET link_check_status = :s, link_check_json = :j, link_checked_at = NOW() WHERE id = :id')
            ->execute([':s' => $check['status'], ':j' => json_encode($check, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), ':id' => $id]);
        $back(true, ['Посилання #' . $id . ' перевірено: ' . $check['status'] . '.']);
    case 'settings':
        if (!$isAdmin) {
            $back(false, ['Налаштування змінює лише адміністратор.']);
        }
        $free = trim((string) ($_POST['free_until'] ?? ''));
        $d = DateTime::createFromFormat('!Y-m-d', $free);
        if ($free !== '' && ($d === false || $d->format('Y-m-d') !== $free)) {
            $back(false, ['Некоректна дата.']);
        }
        site_settings_save($pdo, [
            'marketplace_free_until' => $free,
            'marketplace_listing_days' => (string) max(1, min(365, (int) ($_POST['listing_days'] ?? 60))),
            'marketplace_review_hours' => (string) max(1, min(720, (int) ($_POST['review_hours'] ?? 48))),
        ]);
        $back(true, ['Налаштування збережено.']);
}

if ($isAdmin && function_exists('olead_admin_action')) {
    olead_admin_action($pdo, $action, $actor, $back);
}
$back(false, ['Невідома дія.']);


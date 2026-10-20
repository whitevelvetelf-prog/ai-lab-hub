<?php

declare(strict_types=1);

/**
 * AI LAB HUB — дії адмінки «Цифрових матеріалів» (POST + CSRF; роль із БД). Модерація, скарги й блокування —
 * employee/admin; налаштування — лише admin. Повертає у вкладку account.php?ladm_tab=…#acc-listings-admin.
 *
 *   approve | reject (template, comment) | request_proof (template, comment)    — id
 *   claim_decide (claim_id, status, note, note_extra)
 *   block | unblock (hash)
 *   settings (s[ключ])
 * GET export=claims — CSV скарг.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset-admin.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!mp_is_staff()) {
    header('Location: account.php', true, 303);
    exit;
}
$actor = (int) auth_user_id();
$isAdmin = mp_live_role() === 'admin';

if (($_GET['export'] ?? '') === 'claims') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="copyright-claims-' . date('Y-m-d') . '.csv"');
    header('Cache-Control: no-store');
    $out = fopen('php://output', 'wb');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, ['id', 'created_at', 'status', 'listing_id', 'listing_ref', 'claimant_name', 'claimant_email', 'what_infringed', 'evidence', 'auto_hidden', 'counter_at', 'counter_text', 'decision_note']);
    foreach ($pdo->query('SELECT * FROM copyright_claims ORDER BY id') as $c) {
        fputcsv($out, [$c['id'], $c['created_at'], $c['status'], $c['listing_id'], $c['listing_ref'], $c['claimant_name'], $c['claimant_email'],
            $c['what_infringed'], $c['evidence'], $c['auto_hidden'], $c['counter_at'], $c['counter_text'], $c['decision_note']]);
    }
    exit;
}

$action = (string) ($_POST['action'] ?? '');
$tabFor = ['approve' => 'assets', 'reject' => 'assets', 'request_proof' => 'assets', 'claim_decide' => 'claims', 'block' => 'asset_susp', 'unblock' => 'asset_susp', 'settings' => 'asset_set'];
$back = static function (bool $ok, string $msg) use ($action, $tabFor): never {
    $_SESSION['ladm_flash'] = ['ok' => $ok, 'msgs' => [$msg]];
    header('Location: account.php?ladm_tab=' . ($tabFor[$action] ?? 'assets') . '#acc-listings-admin', true, 303);
    exit;
};
if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST' || !mp_csrf_verify()) {
    $back(false, 'Сесія застаріла — оновіть сторінку й повторіть.');
}
$id = (int) ($_POST['id'] ?? 0);
$reason = static function (): string {
    $tpl = (string) ($_POST['template'] ?? '');
    $comment = mb_substr(trim(strip_tags((string) ($_POST['comment'] ?? ''))), 0, 300);

    return trim((AST_REJECT_TEMPLATES[$tpl] ?? '') . ' ' . $comment);
};

switch ($action) {
    case 'approve':
        $ok = ast_approve($pdo, $id, $actor);
        $back($ok, $ok ? 'Матеріал #' . $id . ' схвалено й опубліковано, автору надіслано лист.' : 'Не вдалося схвалити (матеріал уже не на модерації?).');
    case 'reject':
        $r = $reason();
        $ok = $r !== '' && ast_reject($pdo, $id, $actor, $r);
        $back($ok, $ok ? 'Матеріал #' . $id . ' відхилено, автору надіслано лист.' : 'Не вдалося відхилити (оберіть причину; статус змінився?).');
    case 'request_proof':
        $r = $reason();
        $ok = ast_mail($pdo, $id, 'asset_proof', ['reason' => $r !== '' ? $r : 'потрібні докази авторства']);
        mp_log($pdo, $id, $actor, 'proof_requested', $r);
        $back($ok, $ok ? 'Автору матеріалу #' . $id . ' надіслано запит доказів. Матеріал лишається на модерації.' : 'Не вдалося надіслати лист.');
    case 'claim_decide':
        $note = trim((string) ($_POST['note'] ?? '') . ' ' . mb_substr(trim(strip_tags((string) ($_POST['note_extra'] ?? ''))), 0, 500));
        $cid = (int) ($_POST['claim_id'] ?? 0);
        $ok = ast_claim_decide($pdo, $cid, $actor, (string) ($_POST['status'] ?? ''), $note);
        $back($ok, $ok ? 'Рішення за скаргою №' . $cid . ' збережено' . ((string) ($_POST['status'] ?? '') !== 'under_review' ? ', обом сторонам надіслано лист.' : '.') : 'Не вдалося зберегти рішення.');
    case 'block':
    case 'unblock':
        $hash = (string) ($_POST['hash'] ?? '');
        if (preg_match('/^[a-f0-9]{64}$/', $hash) !== 1) {
            $back(false, 'Некоректний хеш.');
        }
        if ($action === 'block') {
            $pdo->prepare('INSERT INTO asset_blocked_hashes (anon_hash, reason, blocked_by, expires_at, created_at) VALUES (:h, :r, :a, NULL, NOW())
                           ON DUPLICATE KEY UPDATE expires_at = NULL, reason = VALUES(reason), blocked_by = VALUES(blocked_by)')
                ->execute([':h' => $hash, ':r' => 'вручну', ':a' => $actor]);
            $back(true, 'Хеш заблоковано безстроково.');
        }
        $pdo->prepare('DELETE FROM asset_blocked_hashes WHERE anon_hash = :h')->execute([':h' => $hash]);
        $back(true, 'Хеш розблоковано.');
    case 'settings':
        if (!$isAdmin) {
            $back(false, 'Лише адміністратор.');
        }
        $in = is_array($_POST['s'] ?? null) ? $_POST['s'] : [];
        $values = [];
        foreach (AST_ADMIN_SETTINGS as $k => [, $type]) {
            $values[$k] = $type === 'bool' ? (isset($in[$k]) ? '1' : '0') : (string) max(0, min(100000, (int) ($in[$k] ?? 0)));
        }
        site_settings_save($pdo, $values);
        $back(true, 'Налаштування активів збережено.');
}
$back(false, 'Невідома дія.');

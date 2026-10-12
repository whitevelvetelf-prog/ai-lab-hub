<?php

declare(strict_types=1);

/**
 * AI LAB HUB — скарга відвідувача на рекламу (кнопка «Поскаржитись» у картці).
 *
 * POST t=<токен з promo-serve.php>  reason=misleading|inappropriate|scam|irrelevant|other
 * Одна скарга на креатив від сеансу (UNIQUE у ad_reports). JSON {ok:bool}.
 * Розглядає адмін у кабінеті («Реклама: адмін» → «Звіти й скарги»).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

$ok = false;
$reason = is_string($_POST['reason'] ?? null) ? $_POST['reason'] : '';
$data = promo_token_read(is_string($_POST['t'] ?? null) ? $_POST['t'] : '');

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && $data !== null && $data['own']
    && in_array($reason, PROMO_REPORT_REASONS, true) && !promo_is_bot()) {
    try {
        /** @var PDO $pdo */
        $pdo = require __DIR__ . '/../config/database.php';
        $ins = $pdo->prepare(
            'INSERT IGNORE INTO ad_reports (creative_id, session_hash, reason) VALUES (:c, :sh, :r)'
        );
        $ins->execute([':c' => $data['c'], ':sh' => analytics_session_hash(), ':r' => $reason]);
        $ok = true;
        if ($ins->rowCount() > 0) {
            promo_event_notify($pdo, 'report_new', ['creative_id' => (int) $data['c'], 'reason' => $reason]);
        }
    } catch (Throwable $e) {
        error_log('[promo] report: ' . $e->getMessage());
    }
}

echo json_encode(['ok' => $ok]);

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — експорт CSV (лише admin): ліди (фільтри як у вкладці «Ліди»: lf_type, lf_source, lf_country,
 * lf_lang, lf_status, lf_score, lf_q), ?report=suppression — список заборон, ?report=metrics — показники аутрічу.
 * Лише дані рівня компанії; клітинки захищені від формул.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing-admin-cabinet.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (mp_live_role() !== 'admin') {
    header('Location: account.php', true, 303);
    exit;
}
$report = (string) ($_GET['report'] ?? 'leads');
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="' . (in_array($report, ['metrics', 'suppression'], true) ? $report : 'leads') . '-' . date('Y-m-d') . '.csv"');
$out = fopen('php://output', 'w');
fwrite($out, "\xEF\xBB\xBF");

// ?report=suppression — список заборон (для резервної копії / перенесення); ?report=metrics — показники аутрічу.
if ($report === 'suppression' && function_exists('omail_suppress')) {
    fputcsv($out, ['kind', 'value', 'reason', 'note', 'created_at']);
    foreach ($pdo->query('SELECT kind, value, reason, note, created_at FROM outreach_suppression ORDER BY id') as $r) {
        fputcsv($out, array_map('outreach_csv_cell', [$r['kind'], $r['value'], $r['reason'], $r['note'], $r['created_at']]));
    }
    fclose($out);
    exit;
}
if ($report === 'metrics' && function_exists('omail_metrics')) {
    $m = omail_metrics($pdo);
    fputcsv($out, ['section', 'key', 'leads', 'sent', 'replied', 'listed', 'unsubscribed', 'bounced']);
    foreach ($m['funnel'] as $k => $n) {
        fputcsv($out, ['funnel', $k, $n, '', '', '', '', '']);
    }
    foreach ($m['weeks'] as $w) {
        fputcsv($out, ['week', $w['week'], '', $w['sent'], $w['replied'], $w['listed'], $w['unsubscribed'], $w['bounced']]);
    }
    foreach ($m['sources'] as $r) {
        fputcsv($out, ['source', $r['source_key'], $r['leads'], $r['contacted'], $r['replied'], $r['listed'], '', '']);
    }
    foreach ($m['templates'] as $r) {
        fputcsv($out, ['template', $r['template_key'] . ':' . $r['lang'] . ((int) $r['paraphrased'] === 1 ? ':paraphrased' : ''), '', $r['sent'], $r['replied'], $r['listed'], '', '']);
    }
    fputcsv($out, ['summary_30d', 'sent/unsub/bounce', '', $m['sent30'], '', '', $m['unsub30'], $m['bounce30']]);
    fputcsv($out, ['summary', 'avg_reply_hours', (string) ($m['avg_reply_hours'] ?? ''), '', '', '', '', '']);
    fclose($out);
    exit;
}

$res = outreach_leads_search($pdo, olead_filters(), 2000);
$cols = ['id', 'company_name', 'company_domain', 'company_website', 'lead_type', 'title', 'country', 'language', 'relevance_score', 'status',
    'in_catalog', 'contact_email', 'contact_url', 'contact_source_url', 'source_key', 'source_name', 'source_url', 'found_at', 'last_action_at', 'notes'];
fputcsv($out, $cols);
foreach ($res['rows'] as $r) {
    fputcsv($out, array_map(static fn($c) => outreach_csv_cell($r[$c] ?? ''), $cols));
}
fclose($out);
exit;

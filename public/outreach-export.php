<?php

declare(strict_types=1);

/**
 * AI LAB HUB — експорт лідів у CSV (лише admin; фільтри — як у вкладці «Ліди»: lf_type, lf_source, lf_country,
 * lf_lang, lf_status, lf_score, lf_q). Лише дані рівня компанії; клітинки захищені від формул.
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
$res = outreach_leads_search($pdo, olead_filters(), 2000);
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="leads-' . date('Y-m-d') . '.csv"');
$out = fopen('php://output', 'w');
fwrite($out, "\xEF\xBB\xBF");
$cols = ['id', 'company_name', 'company_domain', 'company_website', 'lead_type', 'title', 'country', 'language', 'relevance_score', 'status',
    'in_catalog', 'contact_email', 'contact_url', 'contact_source_url', 'source_key', 'source_name', 'source_url', 'found_at', 'last_action_at', 'notes'];
fputcsv($out, $cols);
foreach ($res['rows'] as $r) {
    fputcsv($out, array_map(static fn($c) => outreach_csv_cell($r[$c] ?? ''), $cols));
}
fclose($out);
exit;

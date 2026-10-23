<?php
// Допоміжний скрипт tests/promo-quiet-e2e.sh: save | test | minutes N | restore — ЛОКАЛЬНІ ad_settings
// (вмикає рекламу й прибирає затримки вікна на час тесту, потім повертає як було). Лише CLI.
if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }
$pdo = require __DIR__ . '/../config/database.php';
$keys = ['enabled', 'ad_popup_visit_delay_seconds', 'ad_popup_min_interval_seconds', 'promo_suppress_after_auth_minutes'];
$bak = sys_get_temp_dir() . '/alh-promo-quiet-settings.json';
$set = function ($k, $v) use ($pdo) {
    if ($v === null) { $pdo->prepare('DELETE FROM ad_settings WHERE setting_key = ?')->execute([$k]); return; }
    $pdo->prepare('INSERT INTO ad_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)')->execute([$k, $v]);
};
$mode = $argv[1] ?? '';
if ($mode === 'save') {
    $cur = [];
    foreach ($keys as $k) { $st = $pdo->prepare('SELECT setting_value FROM ad_settings WHERE setting_key = ?'); $st->execute([$k]); $v = $st->fetchColumn(); $cur[$k] = $v === false ? null : $v; }
    if (!is_file($bak)) file_put_contents($bak, json_encode($cur));
    echo json_encode($cur), "\n";
} elseif ($mode === 'test') {
    $set('enabled', '1'); $set('ad_popup_visit_delay_seconds', '0'); $set('ad_popup_min_interval_seconds', '0'); $set('promo_suppress_after_auth_minutes', '10');
} elseif ($mode === 'minutes') {
    $set('promo_suppress_after_auth_minutes', $argv[2]);
} elseif ($mode === 'cleanup') {
    echo 'test users deleted: ', $pdo->exec("DELETE FROM users WHERE email LIKE 'quiet-test-%@example.test'"), "
";
} elseif ($mode === 'restore') {
    foreach (json_decode(file_get_contents($bak), true) as $k => $v) $set($k, $v);
    unlink($bak);
    echo "restored\n";
}

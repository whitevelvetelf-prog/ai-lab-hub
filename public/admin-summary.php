<?php

declare(strict_types=1);

/**
 * AI LAB HUB — зведення для медіакіту (лише admin): один блок звичайного тексту за 30 днів
 * і кнопка «Скопіювати». Лише агрегати (app/outbound-stats.php: outbound_site_summary()).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/outbound-stats.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin') {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');

$text = outbound_summary_text(outbound_site_summary($pdo, 30));
$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
?>
<!DOCTYPE html>
<html lang="<?= $e(current_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Зведення для медіакіту</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="admin-stats.php">← Статистика сайту</a>
        <h1 class="rep__title">Зведення для медіакіту</h1>
        <p class="rep__sub">Агрегати за 30 днів звичайним текстом — скопіюйте й вставте в чат. Без персональних даних.</p>
        <div class="rep-bar">
            <button class="rep-btn" type="button" id="copyBtn">Скопіювати</button>
            <a class="rep-btn" href="admin-outbound.php">Переходи на сайти продуктів</a>
            <span class="rep-copied" id="copyStatus" role="status" hidden>Скопійовано</span>
        </div>
        <textarea class="rep-summary" id="summaryText" readonly><?= $e($text) ?></textarea>
        <p class="rep__note">Перегляди з позначкою «бот» визначаються за User-Agent (з 12.10.2026); частина ботів маскується під браузер, тож «без ботів» — оцінка зверху. Країни не збираються.</p>
    </main>
    <script>
    (function () {
        var btn = document.getElementById('copyBtn');
        var area = document.getElementById('summaryText');
        var status = document.getElementById('copyStatus');
        function done() {
            status.hidden = false;
            setTimeout(function () { status.hidden = true; }, 2500);
        }
        btn.addEventListener('click', function () {
            if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(area.value).then(done, function () { area.select(); document.execCommand('copy'); done(); });
            } else {
                area.select();
                document.execCommand('copy');
                done();
            }
        });
    })();
    </script>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: пошук продуктів (лише admin, роль перевіряється за БД).
 *
 *   1. Стан індексу й кнопка «Перебудувати пошуковий індекс» — порціями по rebuild_batch продуктів
 *      (POST action=rebuild, JSON), бо на хостингу CLI може бути недоступний.
 *   2. Синоніми (search_synonyms): перегляд груп, нова група, слово в наявну групу. Видалення немає.
 *   3. Запити без результатів (search_log) за останні log_keep_days днів — згруповані, з лічильником.
 * POST — лише з CSRF; форми — PRG, перебудова — JSON.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/search.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$uid = auth_user_id();
$roleSt = $pdo->prepare('SELECT role FROM users WHERE id = :u');
$roleSt->execute([':u' => (int) $uid]);
if ($uid === null || $roleSt->fetchColumn() !== 'admin') {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');

if (empty($_SESSION['search_admin_csrf']) || !is_string($_SESSION['search_admin_csrf'])) {
    $_SESSION['search_admin_csrf'] = bin2hex(random_bytes(32));
}
$csrf = $_SESSION['search_admin_csrf'];
$csrfOk = static fn(): bool => is_string($_POST['csrf'] ?? null) && hash_equals($csrf, (string) $_POST['csrf']);
$ready = search_ready($pdo);

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $action = (string) ($_POST['action'] ?? '');
    if ($action === 'rebuild') {
        header('Content-Type: application/json; charset=utf-8');
        if (!$csrfOk() || !$ready) {
            http_response_code($ready ? 403 : 409);
            echo json_encode(['ok' => false, 'error' => $ready ? 'csrf' : 'no_tables']);
            exit;
        }
        @set_time_limit(120);
        try {
            $r = search_index_rebuild_batch($pdo, max(0, (int) ($_POST['after'] ?? 0)));
            echo json_encode(['ok' => true] + $r);
        } catch (Throwable $e) {
            error_log('[search] rebuild: ' . $e->getMessage());
            http_response_code(500);
            echo json_encode(['ok' => false, 'error' => 'server']);
        }
        exit;
    }
    $flash = ['ok' => false, 'msg' => 'Невідома дія.'];
    if (!$csrfOk()) {
        $flash = ['ok' => false, 'msg' => 'Сесія застаріла. Оновіть сторінку й спробуйте ще раз.'];
    } elseif ($ready && ($action === 'syn_add' || $action === 'syn_new')) {
        $words = array_values(array_unique(array_filter(array_map(
            static fn(string $w): string => mb_substr(trim((string) preg_replace('/\s+/u', ' ', $w)), 0, 100),
            explode(',', (string) ($_POST['words'] ?? ''))
        ), static fn(string $w): bool => $w !== '' && search_query_tokens($w) !== [])));
        $group = $action === 'syn_new'
            ? (int) $pdo->query('SELECT COALESCE(MAX(group_id), 0) + 1 FROM search_synonyms')->fetchColumn()
            : (int) ($_POST['group_id'] ?? 0);
        $exists = $pdo->prepare('SELECT COUNT(*) FROM search_synonyms WHERE group_id = :g');
        $exists->execute([':g' => $group]);
        if ($words === [] || $group <= 0 || ($action === 'syn_add' && (int) $exists->fetchColumn() === 0)
            || ($action === 'syn_new' && count($words) < 2)) {
            $flash = ['ok' => false, 'msg' => $action === 'syn_new' ? 'Нова група — щонайменше два слова через кому.' : 'Вкажіть слова й наявну групу.'];
        } else {
            $ins = $pdo->prepare('INSERT IGNORE INTO search_synonyms (group_id, word) VALUES (:g, :w)');
            $added = 0;
            foreach ($words as $w) {
                $ins->execute([':g' => $group, ':w' => $w]);
                $added += $ins->rowCount();
            }
            $flash = ['ok' => true, 'msg' => "Група {$group}: додано слів — {$added}. Синоніми діють одразу, перебудова індексу не потрібна."];
        }
    }
    $_SESSION['search_admin_flash'] = $flash;
    header('Location: crm-search.php', true, 303);
    exit;
}

$flash = $_SESSION['search_admin_flash'] ?? null;
unset($_SESSION['search_admin_flash']);
$status = search_index_status($pdo);
$cfg = search_config();
$groups = [];
$zero = [];
if ($ready) {
    foreach ($pdo->query('SELECT group_id, word FROM search_synonyms ORDER BY group_id, id') as $r) {
        $groups[(int) $r['group_id']][] = (string) $r['word'];
    }
    try {
        $zero = $pdo->query(
            'SELECT LOWER(query) AS q, COUNT(*) AS cnt, MAX(created_at) AS last_at, GROUP_CONCAT(DISTINCT lang) AS langs
             FROM search_log WHERE created_at >= NOW() - INTERVAL ' . $cfg['log_keep_days'] . ' DAY
             GROUP BY LOWER(query) ORDER BY cnt DESC, last_at DESC LIMIT 300'
        )->fetchAll();
    } catch (PDOException $e) {
        $zero = [];
    }
}
$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Пошук (CRM)</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <style>
        .sx-form { display: flex; flex-wrap: wrap; gap: 10px; align-items: flex-end; margin: 0 0 14px; }
        .sx-form label { display: flex; flex-direction: column; gap: 5px; font-size: 0.86rem; font-weight: 600; flex: 1 1 220px; min-width: 0; }
        .sx-form input, .sx-form select {
            box-sizing: border-box; width: 100%; padding: 8px 10px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.25);
            background: #11163f; color: #ffffff; font: inherit; font-size: 0.92rem;
        }
        .sx-btn { padding: 9px 20px; border-radius: 999px; border: 0; background: var(--accent); color: #ffffff; font: inherit; font-weight: 600; cursor: pointer; }
        .sx-btn[disabled] { opacity: .6; cursor: progress; }
        .sx-flash { margin: 0 0 16px; padding: 10px 14px; border-radius: 10px; }
        .sx-flash--ok { background: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.5); }
        .sx-flash--error { background: rgba(248, 113, 113, 0.15); border: 1px solid rgba(248, 113, 113, 0.55); }
        .sx-progress { margin: 10px 0 0; font-size: 0.9rem; color: var(--text-muted); }
        .sx-words { display: flex; flex-wrap: wrap; gap: 6px; }
        .sx-word { padding: 2px 10px; border-radius: 999px; border: 1px solid var(--card-border); font-size: 0.85rem; }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="account.php#acc-crm">← Кабінет</a>
        <h1 class="rep__title">Пошук продуктів</h1>
        <p class="rep__sub">Пошук у шапці й на сторінці результатів працює за словниковим індексом (назви, категорії, описи всіма мовами). Продукти, додані через CRM, потрапляють в індекс одразу; додані SQL-імпортом — під час найближчих пошуків (до <?= (int) $cfg['sync_budget'] ?> за запит) або кнопкою нижче.</p>

        <?php if (is_array($flash)): ?>
        <div class="sx-flash <?= !empty($flash['ok']) ? 'sx-flash--ok' : 'sx-flash--error' ?>" role="status"><?= $e($flash['msg'] ?? '') ?></div>
        <?php endif; ?>

        <?php if (!$ready): ?>
        <div class="sx-flash sx-flash--error">Таблиць пошуку ще немає — застосуйте database/migration-2026-11-03-search-index.sql. Доти пошук не працює.</div>
        <?php else: ?>

        <h2 class="rep__h2">Індекс</h2>
        <div class="rep-cards">
            <div class="rep-card"><p class="rep-card__label">Опубліковано продуктів</p><p class="rep-card__value"><?= $status['published'] ?></p></div>
            <div class="rep-card"><p class="rep-card__label">В індексі</p><p class="rep-card__value"><?= $status['indexed'] ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Потребують оновлення</p><p class="rep-card__value"><?= $status['outdated'] ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Слів в індексі</p><p class="rep-card__value"><?= number_format($status['rows'], 0, ',', ' ') ?></p></div>
        </div>
        <p style="margin-top: 14px;">
            <button type="button" class="sx-btn" id="sxRebuild">Перебудувати пошуковий індекс</button>
        </p>
        <p class="sx-progress" id="sxProgress" aria-live="polite"></p>

        <h2 class="rep__h2">Запити без результатів (<?= (int) $cfg['log_keep_days'] ?> днів)</h2>
        <p class="rep__sub">Лише запити зі сторінки результатів, що нічого не знайшли; без IP і без користувачів. Видно, чого шукають і чого бракує в каталозі (або якого синоніма).</p>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>Запит</th><th class="num">Разів</th><th>Мова</th><th>Останній</th></tr></thead>
                <tbody>
                <?php if ($zero === []): ?><tr><td class="rep-empty" colspan="4">Поки немає.</td></tr><?php endif; ?>
                <?php foreach ($zero as $z): ?>
                <tr><td><a href="catalog.php?search=<?= $e(rawurlencode((string) $z['q'])) ?>" target="_blank" rel="noopener"><?= $e($z['q']) ?></a></td><td class="num"><?= (int) $z['cnt'] ?></td><td><?= $e($z['langs']) ?></td><td><?= $e($z['last_at']) ?></td></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h2 class="rep__h2">Синоніми</h2>
        <p class="rep__sub">Слова однієї групи взаємозамінні в запиті («відео» знаходить і «video»). Фраза з кількох слів («штучний інтелект») спрацьовує, коли в запиті саме ці слова підряд.</p>
        <form class="sx-form" method="post" action="crm-search.php">
            <input type="hidden" name="csrf" value="<?= $e($csrf) ?>">
            <input type="hidden" name="action" value="syn_new">
            <label>Нова група <input type="text" name="words" maxlength="500" placeholder="подкаст, podcast, подкасти"></label>
            <button type="submit" class="sx-btn">Створити групу</button>
        </form>
        <form class="sx-form" method="post" action="crm-search.php">
            <input type="hidden" name="csrf" value="<?= $e($csrf) ?>">
            <input type="hidden" name="action" value="syn_add">
            <label>Група
                <select name="group_id">
                    <?php foreach ($groups as $gid => $words): ?><option value="<?= $gid ?>"><?= $gid ?>: <?= $e(implode(', ', array_slice($words, 0, 4))) ?></option><?php endforeach; ?>
                </select>
            </label>
            <label>Додати слова <input type="text" name="words" maxlength="500" placeholder="через кому"></label>
            <button type="submit" class="sx-btn">Додати</button>
        </form>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th class="num">Група</th><th>Слова</th></tr></thead>
                <tbody>
                <?php foreach ($groups as $gid => $words): ?>
                <tr><td class="num"><?= $gid ?></td><td><div class="sx-words"><?php foreach ($words as $w): ?><span class="sx-word"><?= $e($w) ?></span><?php endforeach; ?></div></td></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php endif; ?>
    </main>
    <script>
    (function () {
        var btn = document.getElementById('sxRebuild');
        var out = document.getElementById('sxProgress');
        if (!btn) { return; }
        var csrf = <?= json_encode($csrf) ?>;
        btn.addEventListener('click', function () {
            btn.disabled = true;
            var done = 0;
            var step = function (after) {
                var body = new URLSearchParams({ action: 'rebuild', csrf: csrf, after: String(after) });
                fetch('crm-search.php', { method: 'POST', body: body, credentials: 'same-origin' })
                    .then(function (r) { return r.json(); })
                    .then(function (d) {
                        if (!d.ok) { throw new Error(d.error || 'error'); }
                        done += d.processed;
                        out.textContent = 'Оброблено ' + done + ' з ' + d.total + '…';
                        if (d.next !== null) { step(d.next); return; }
                        out.textContent = 'Готово: перебудовано ' + done + ' продуктів. Оновіть сторінку, щоб побачити стан.';
                        btn.disabled = false;
                    })
                    .catch(function (e) {
                        out.textContent = 'Помилка (' + e.message + '). Натисніть ще раз — перебудова почнеться спочатку.';
                        btn.disabled = false;
                    });
            };
            out.textContent = 'Починаю…';
            step(0);
        });
    })();
    </script>
</body>
</html>

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: популярні запити Marketplace (лише admin, роль перевіряється за БД). app/mp-popular.php.
 *
 *   Таблиця запитів за 30 днів (search_query_stats, без IP і користувачів) з лічильником; дії: «Закріпити»,
 *   «Сховати», «Зняти рішення», мітки uk/en, порядок. Можна вручну додати й закріпити запит, якого ще немає.
 *   Вкладка scope 'catalog' — лише структура (запис для каталогу не ведеться, чипи вимкнено: popular_queries_catalog).
 *   Рядки не видаляються: «зняти» — status ''. POST — лише з CSRF, PRG.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-popular.php';

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
header('Cache-Control: no-store');

$scope = is_string($_GET['scope'] ?? null) && in_array($_GET['scope'], MPQ_SCOPES, true) ? (string) $_GET['scope'] : 'marketplace';
$ready = mpq_ready($pdo);
$flash = $_SESSION['mpq_admin_flash'] ?? null;
unset($_SESSION['mpq_admin_flash']);

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $ok = false;
    if (!mp_csrf_verify()) {
        $msg = 'Сесія застаріла. Оновіть сторінку й спробуйте ще раз.';
    } elseif (!$ready) {
        $msg = 'Таблиць ще немає — застосуйте міграцію 2026-11-09.';
    } else {
        $postScope = is_string($_POST['scope'] ?? null) && in_array($_POST['scope'], MPQ_SCOPES, true) ? (string) $_POST['scope'] : 'marketplace';
        $status = is_string($_POST['status'] ?? null) ? (string) $_POST['status'] : '';
        $ok = mpq_admin_save(
            $pdo, $postScope, is_string($_POST['query'] ?? null) ? (string) $_POST['query'] : '', $status,
            (int) ($_POST['sort_order'] ?? 0), is_string($_POST['label_uk'] ?? null) ? (string) $_POST['label_uk'] : '',
            is_string($_POST['label_en'] ?? null) ? (string) $_POST['label_en'] : ''
        );
        $msg = $ok ? 'Збережено.' : 'Не збережено: порожній запит або запит із персональними даними (@, 6+ цифр поспіль, посилання).';
        $scope = $postScope;
    }
    $_SESSION['mpq_admin_flash'] = ['ok' => $ok, 'msg' => $msg];
    header('Location: admin-popular-queries.php?scope=' . $scope, true, 303);
    exit;
}

$rows = $ready ? mpq_admin_rows($pdo, $scope) : [];
$preview = $ready ? mpq_chips($pdo, $scope, 'uk') : [];
$minHits = (int) (mp_config()['popular_min_hits'] ?? 10);
$csrf = mp_csrf_field();
$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$statusLabel = ['pin' => 'Закріплено', 'hide' => 'Сховано', '' => '—'];
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Популярні запити (CRM)</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <style>
        .pq-tabs { display: flex; gap: 8px; flex-wrap: wrap; margin: 0 0 16px; }
        .pq-tab { padding: 10px 16px; min-height: 44px; box-sizing: border-box; display: inline-flex; align-items: center; border-radius: 999px; border: 1px solid var(--card-border); color: inherit; text-decoration: none; }
        .pq-tab.is-active { background: var(--accent); border-color: var(--accent); color: #fff; }
        .pq-form { display: flex; flex-wrap: wrap; gap: 6px; align-items: center; }
        .pq-form input { box-sizing: border-box; padding: 8px 10px; min-height: 44px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.25); background: #11163f; color: #fff; font: inherit; font-size: 0.9rem; }
        .pq-form input[type=text] { width: 9rem; max-width: 100%; }
        .pq-form input[type=number] { width: 4.5rem; }
        .pq-btn { min-height: 44px; padding: 8px 14px; border-radius: 999px; border: 1px solid var(--card-border); background: transparent; color: inherit; font: inherit; cursor: pointer; }
        .pq-btn--pin { background: var(--accent); border-color: var(--accent); color: #fff; }
        .pq-flash { margin: 0 0 16px; padding: 10px 14px; border-radius: 10px; }
        .pq-flash--ok { background: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.5); }
        .pq-flash--error { background: rgba(248, 113, 113, 0.15); border: 1px solid rgba(248, 113, 113, 0.55); }
        .pq-chips { display: flex; flex-wrap: wrap; gap: 6px; }
        .pq-chip { padding: 4px 12px; border-radius: 999px; border: 1px solid var(--card-border); font-size: 0.88rem; }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="account.php#acc-crm">← Кабінет</a>
        <h1 class="rep__title">Популярні запити</h1>
        <p class="rep__sub">Агреговані запити пошуку Marketplace за 30 днів: лише текст запиту, дата й лічильник (без IP, користувачів і сесій). Записуються лише пошуки з результатом, один раз за сесію на запит на день; запити з «@», 6+ цифрами поспіль і посиланнями не записуються. Чипи під пошуком: спершу закріплені (за порядком), далі автоматично — від <?= $minHits ?> пошуків за 30 днів, до <?= MPQ_CHIPS ?> штук; сховані не показуються. Дані старші за 90 днів видаляє mp-cron-expire.php.</p>

        <nav class="pq-tabs" aria-label="Розділ">
            <?php foreach (MPQ_SCOPES as $sc): ?>
                <a class="pq-tab<?= $sc === $scope ? ' is-active' : '' ?>" href="admin-popular-queries.php?scope=<?= $sc ?>"><?= $sc === 'marketplace' ? 'Marketplace' : 'Каталог (вимкнено)' ?></a>
            <?php endforeach; ?>
        </nav>

        <?php if (is_array($flash)): ?>
            <div class="pq-flash <?= !empty($flash['ok']) ? 'pq-flash--ok' : 'pq-flash--error' ?>" role="status"><?= $e($flash['msg'] ?? '') ?></div>
        <?php endif; ?>
        <?php if (!$ready): ?>
            <div class="pq-flash pq-flash--error">Таблиць ще немає — застосуйте database/migration-2026-11-09-marketplace-wave1.sql.</div>
        <?php else: ?>
            <?php if ($scope === 'catalog'): ?>
                <p class="rep__sub">Для каталогу структура закладена, але запити не записуються й чипи на головній каталогу не показуються (config 'popular_queries_catalog' => false).</p>
            <?php endif; ?>

            <h2 class="rep__h2">Зараз під пошуком</h2>
            <?php if ($preview === []): ?>
                <p class="rep__sub">Чипів немає — блок під пошуком не показується.</p>
            <?php else: ?>
                <div class="pq-chips"><?php foreach ($preview as $c): ?><span class="pq-chip"><?= $e($c['label']) ?></span><?php endforeach; ?></div>
            <?php endif; ?>

            <h2 class="rep__h2">Додати й закріпити запит</h2>
            <form class="pq-form" method="post" action="admin-popular-queries.php">
                <?= $csrf ?><input type="hidden" name="scope" value="<?= $e($scope) ?>"><input type="hidden" name="status" value="pin">
                <input type="text" name="query" maxlength="60" placeholder="запит" required aria-label="Запит">
                <input type="text" name="label_uk" maxlength="60" placeholder="мітка uk" aria-label="Мітка українською">
                <input type="text" name="label_en" maxlength="60" placeholder="label en" aria-label="Мітка англійською">
                <input type="number" name="sort_order" value="0" min="-999" max="999" aria-label="Порядок">
                <button class="pq-btn pq-btn--pin" type="submit">Закріпити</button>
            </form>

            <h2 class="rep__h2">Запити за 30 днів</h2>
            <div class="rep-table-wrap">
                <table class="rep-table">
                    <thead><tr><th>Запит</th><th class="num">Пошуків</th><th>Стан</th><th>Мітки, порядок, дії</th></tr></thead>
                    <tbody>
                    <?php if ($rows === []): ?><tr><td class="rep-empty" colspan="4">Поки немає.</td></tr><?php endif; ?>
                    <?php foreach ($rows as $r): ?>
                        <tr>
                            <td><a href="marketplace.php?<?= $e(http_build_query(['q' => $r['query_norm']])) ?>" target="_blank" rel="noopener"><?= $e($r['query_norm']) ?></a></td>
                            <td class="num"><?= (int) $r['hits'] ?></td>
                            <td><?= $e($statusLabel[$r['status']] ?? '—') ?></td>
                            <td>
                                <form class="pq-form" method="post" action="admin-popular-queries.php">
                                    <?= $csrf ?><input type="hidden" name="scope" value="<?= $e($scope) ?>"><input type="hidden" name="query" value="<?= $e($r['query_norm']) ?>">
                                    <input type="text" name="label_uk" maxlength="60" value="<?= $e($r['label_uk']) ?>" placeholder="мітка uk" aria-label="Мітка українською">
                                    <input type="text" name="label_en" maxlength="60" value="<?= $e($r['label_en']) ?>" placeholder="label en" aria-label="Мітка англійською">
                                    <input type="number" name="sort_order" value="<?= (int) $r['sort_order'] ?>" min="-999" max="999" aria-label="Порядок">
                                    <button class="pq-btn pq-btn--pin" type="submit" name="status" value="pin">Закріпити</button>
                                    <button class="pq-btn" type="submit" name="status" value="hide">Сховати</button>
                                    <?php if ($r['status'] !== ''): ?><button class="pq-btn" type="submit" name="status" value="">Зняти рішення</button><?php endif; ?>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>
    </main>
</body>
</html>

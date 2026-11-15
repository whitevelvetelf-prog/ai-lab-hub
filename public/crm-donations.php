<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: облік донатів (лише admin, перевірка ролі за БД).
 *
 * Донати надходять повз сайт, тож адмін вносить їх тут вручну: дата, сума в USD (або оригінальна
 * сума в UAH — перерахунок за курсом НБУ), статус, спосіб оплати, необов'язково — e-mail
 * зареєстрованого користувача (тоді запис з'явиться в його кабінеті) та ім'я донора.
 * Список — з фільтрами за датою й статусом, нові зверху, пагінація.
 * POST (додати / змінити статус / видалити) — лише з CSRF, далі редирект (PRG).
 * Жодних номерів карток і реквізитів: вільні поля перевіряються в donhist_validate().
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/donations.php';
require_once __DIR__ . '/../app/donation-history.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$adminId = auth_user_id();
if (!donate_is_admin($pdo, $adminId)) {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');

$tableOk = donhist_table_ok($pdo);
$filters = donhist_admin_filters($_GET);
$selfUrl = static function (array $f, array $over = []): string {
    $q = array_filter(array_merge(['from' => $f['from'], 'to' => $f['to'], 'status' => $f['status'], 'page' => $f['page'] > 1 ? $f['page'] : ''], $over), static fn($v) => $v !== '' && $v !== null);

    return 'crm-donations.php' . ($q === [] ? '' : '?' . http_build_query($q));
};

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && $tableOk) {
    $back = static function (bool $ok, array $msgs, ?array $old = null) use ($selfUrl, $filters): never {
        $_SESSION['donhist_flash'] = ['ok' => $ok, 'msgs' => $msgs];
        if ($old !== null) {
            $_SESSION['donhist_old'] = $old;
        }
        header('Location: ' . $selfUrl($filters), true, 303);
        exit;
    };
    if (!donate_csrf_verify()) {
        $back(false, ['Сесія застаріла. Оновіть сторінку й спробуйте ще раз.']);
    }
    $action = (string) ($_POST['action'] ?? '');
    $id = (int) ($_POST['id'] ?? 0);
    try {
        if ($action === 'add') {
            [$row, $errors] = donhist_validate($pdo, $_POST);
            if ($row === null) {
                $back(false, $errors, array_map(static fn($v) => is_string($v) ? $v : '', $_POST));
            }
            donhist_insert($pdo, $row, (int) $adminId);
            $back(true, ['Донат додано.']);
        }
        if ($action === 'status' && $id > 0) {
            $ok = donhist_set_status($pdo, $id, (string) ($_POST['status'] ?? ''));
            $back($ok, [$ok ? "Статус запису #{$id} змінено." : 'Невідомий статус.']);
        }
        if ($action === 'delete' && $id > 0) {
            donhist_delete($pdo, $id);
            $back(true, ["Запис #{$id} видалено."]);
        }
    } catch (Throwable $ex) {
        error_log('[donations] ' . $action . ': ' . $ex->getMessage());
        $back(false, ['Не вдалося зберегти. Деталі — у журналі помилок сервера.']);
    }
    $back(false, ['Невідома дія.']);
}

$flash = $_SESSION['donhist_flash'] ?? null;
$old = $_SESSION['donhist_old'] ?? [];
unset($_SESSION['donhist_flash'], $_SESSION['donhist_old']);
$list = $tableOk ? donhist_admin_list($pdo, $filters) : ['rows' => [], 'total' => 0, 'pages' => 1, 'page' => 1, 'sum_minor' => 0];

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$oldv = static fn(string $k, string $def = ''): string => is_string($old[$k] ?? null) ? $old[$k] : $def;
$csrf = donate_csrf_token();
?>
<!DOCTYPE html>
<html lang="<?= $e(current_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Донати (CRM)</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <style>
        .dh-form { display: grid; grid-template-columns: repeat(auto-fit, minmax(190px, 1fr)); gap: 12px 16px; padding: 16px; border: 1px solid var(--card-border); border-radius: 14px; background: var(--card-bg); }
        .dh-form label, .dh-filter label { display: flex; flex-direction: column; gap: 5px; font-size: 0.86rem; font-weight: 600; min-width: 0; }
        .dh-form small { font-weight: 400; color: var(--text-muted); }
        .dh-form input, .dh-form select, .dh-filter input, .dh-filter select, .dh-inline select {
            box-sizing: border-box; width: 100%; padding: 8px 10px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.25);
            background: #11163f; color: #ffffff; font: inherit; font-size: 0.92rem;
        }
        .dh-form .dh-wide { grid-column: 1 / -1; }
        .dh-form button, .dh-filter button { justify-self: start; padding: 9px 20px; border-radius: 999px; border: 0; background: var(--accent); color: #ffffff; font: inherit; font-weight: 600; cursor: pointer; }
        .dh-filter { display: flex; flex-wrap: wrap; gap: 10px 14px; align-items: flex-end; margin: 0 0 14px; }
        .dh-filter label { flex: 1 1 150px; }
        .dh-filter button { flex: 0 0 auto; }
        .dh-inline { display: flex; gap: 6px; align-items: center; margin: 0; }
        .dh-inline select { width: auto; padding: 4px 8px; font-size: 0.85rem; }
        .dh-inline button { padding: 4px 10px; border-radius: 999px; border: 1px solid var(--card-border); background: transparent; color: #e4ebff; font: inherit; font-size: 0.82rem; cursor: pointer; }
        .dh-inline button.dh-del { border-color: rgba(248, 113, 113, 0.6); color: #fecaca; }
        .dh-muted { color: var(--text-muted); font-size: 0.82rem; }
        .dh-flash { margin: 0 0 16px; padding: 10px 14px; border-radius: 10px; }
        .dh-flash p { margin: 3px 0; }
        .dh-flash--ok { background: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.5); }
        .dh-flash--error { background: rgba(248, 113, 113, 0.15); border: 1px solid rgba(248, 113, 113, 0.55); }
        .donhist-orig { display: block; font-size: 0.8rem; color: var(--text-muted); }
        .dh-pager { display: flex; gap: 14px; align-items: center; justify-content: center; margin-top: 14px; }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="account.php#acc-crm">← Кабінет</a>
        <h1 class="rep__title">Донати</h1>
        <?= donate_status_warning_html($pdo) ?>
        <p class="rep__sub">Донати надходять через банку, картку чи IBAN повз сайт, тому кожен запис вносимо тут вручну. Якщо вказати e-mail зареєстрованого користувача, запис побачить лише він у кабінеті («Мої підтримки проєкту»). Номери карток і реквізити не вносимо.</p>

        <?php if (!$tableOk): ?>
        <div class="dh-flash dh-flash--error"><p>Таблиці donations ще немає — застосуйте database/migration-2026-10-31-donations-history.sql.</p></div>
        <?php else: ?>

        <?php if (is_array($flash) && !empty($flash['msgs'])): ?>
        <div class="dh-flash <?= !empty($flash['ok']) ? 'dh-flash--ok' : 'dh-flash--error' ?>" role="status">
            <?php foreach ($flash['msgs'] as $m): ?><p><?= $e($m) ?></p><?php endforeach; ?>
        </div>
        <?php endif; ?>

        <h2 class="rep__h2">Додати донат</h2>
        <form class="dh-form" method="post" action="<?= $e($selfUrl($filters)) ?>" autocomplete="off">
            <input type="hidden" name="csrf" value="<?= $e($csrf) ?>">
            <input type="hidden" name="action" value="add">
            <label>Дата <input type="date" name="donated_at" required max="<?= date('Y-m-d') ?>" value="<?= $e($oldv('donated_at', date('Y-m-d'))) ?>"></label>
            <label>Сплачена сума <small>необов'язково</small><input type="text" inputmode="decimal" name="original_amount" placeholder="500" value="<?= $e($oldv('original_amount')) ?>"></label>
            <label>Валюта сплати <input type="text" name="original_currency" maxlength="3" placeholder="UAH" value="<?= $e($oldv('original_currency', 'UAH')) ?>"></label>
            <label>Сума в USD <small>порожньо — за курсом НБУ (для UAH)</small><input type="text" inputmode="decimal" name="amount_usd" placeholder="12.00" value="<?= $e($oldv('amount_usd')) ?>"></label>
            <label>Статус
                <select name="status">
                    <?php foreach (DONHIST_STATUSES as $s): ?><option value="<?= $s ?>"<?= $oldv('status', 'received') === $s ? ' selected' : '' ?>><?= $e(t('donhist_status_' . $s)) ?></option><?php endforeach; ?>
                </select>
            </label>
            <label>Спосіб оплати
                <select name="method">
                    <?php foreach (DONHIST_METHODS as $m): ?><option value="<?= $m ?>"<?= $oldv('method', 'jar') === $m ? ' selected' : '' ?>><?= $e(t('donhist_method_' . $m)) ?></option><?php endforeach; ?>
                </select>
            </label>
            <label>E-mail користувача <small>якщо донор зареєстрований</small><input type="email" name="user_email" value="<?= $e($oldv('user_email')) ?>"></label>
            <label>Ім'я донора <small>як у виписці, необов'язково</small><input type="text" name="donor_name" maxlength="100" value="<?= $e($oldv('donor_name')) ?>"></label>
            <label class="dh-wide">Примітка <small>службова, бачить лише адмін; без реквізитів</small><input type="text" name="note" maxlength="255" value="<?= $e($oldv('note')) ?>"></label>
            <button type="submit">Додати</button>
        </form>

        <h2 class="rep__h2">Усі донати</h2>
        <form class="dh-filter" method="get" action="crm-donations.php">
            <label>З дати <input type="date" name="from" value="<?= $e($filters['from']) ?>"></label>
            <label>По дату <input type="date" name="to" value="<?= $e($filters['to']) ?>"></label>
            <label>Статус
                <select name="status">
                    <option value="">усі</option>
                    <?php foreach (DONHIST_STATUSES as $s): ?><option value="<?= $s ?>"<?= $filters['status'] === $s ? ' selected' : '' ?>><?= $e(t('donhist_status_' . $s)) ?></option><?php endforeach; ?>
                </select>
            </label>
            <button type="submit">Показати</button>
            <?php if ($filters['from'] !== '' || $filters['to'] !== '' || $filters['status'] !== ''): ?><a class="rep-btn" href="crm-donations.php">Скинути</a><?php endif; ?>
        </form>

        <div class="rep-cards">
            <div class="rep-card"><p class="rep-card__label">Записів за фільтром</p><p class="rep-card__value"><?= $list['total'] ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Сума за фільтром (USD)</p><p class="rep-card__value"><?= $e(formatMoney($list['sum_minor'], 'USD', 'uk')) ?></p></div>
        </div>

        <div class="rep-table-wrap" style="margin-top: 14px;">
            <table class="rep-table">
                <thead><tr><th>#</th><th>Дата</th><th class="num">Сума</th><th>Статус</th><th>Спосіб</th><th>Донор</th><th>Примітка</th><th></th></tr></thead>
                <tbody>
                <?php if ($list['rows'] === []): ?>
                <tr><td class="rep-empty" colspan="8">Записів немає.</td></tr>
                <?php endif; ?>
                <?php foreach ($list['rows'] as $r): ?>
                <tr>
                    <td><?= (int) $r['id'] ?></td>
                    <td style="white-space: nowrap;"><?= $e(donhist_date($r['donated_at'], 'uk')) ?></td>
                    <td class="num"><?= donhist_amount_html($r, 'uk') ?></td>
                    <td>
                        <form class="dh-inline" method="post" action="<?= $e($selfUrl($filters)) ?>">
                            <input type="hidden" name="csrf" value="<?= $e($csrf) ?>">
                            <input type="hidden" name="action" value="status">
                            <input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                            <select name="status" aria-label="Статус запису #<?= (int) $r['id'] ?>">
                                <?php foreach (DONHIST_STATUSES as $s): ?><option value="<?= $s ?>"<?= $r['status'] === $s ? ' selected' : '' ?>><?= $e(t('donhist_status_' . $s)) ?></option><?php endforeach; ?>
                            </select>
                            <button type="submit">OK</button>
                        </form>
                    </td>
                    <td><?= $e(t('donhist_method_' . $r['method'])) ?></td>
                    <td>
                        <?php if ($r['user_id'] !== null): ?><?= $e($r['user_name'] ?? '') ?><br><span class="dh-muted"><?= $e($r['user_email'] ?? '') ?></span><?php endif; ?>
                        <?php if ($r['donor_name'] !== null): ?><?= $r['user_id'] !== null ? '<br>' : '' ?><span class="dh-muted"><?= $e($r['donor_name']) ?></span><?php endif; ?>
                        <?php if ($r['user_id'] === null && $r['donor_name'] === null): ?><span class="dh-muted">анонімно</span><?php endif; ?>
                    </td>
                    <td><span class="dh-muted"><?= $e($r['note'] ?? '') ?></span></td>
                    <td>
                        <form class="dh-inline" method="post" action="<?= $e($selfUrl($filters)) ?>" onsubmit="return window.confirm('Видалити запис #<?= (int) $r['id'] ?>?');">
                            <input type="hidden" name="csrf" value="<?= $e($csrf) ?>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                            <button type="submit" class="dh-del">Видалити</button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php if ($list['pages'] > 1): ?>
        <nav class="dh-pager">
            <?php if ($list['page'] > 1): ?><a class="rep-btn" href="<?= $e($selfUrl($filters, ['page' => $list['page'] - 1])) ?>">← Новіші</a><?php endif; ?>
            <span>Сторінка <?= $list['page'] ?> з <?= $list['pages'] ?></span>
            <?php if ($list['page'] < $list['pages']): ?><a class="rep-btn" href="<?= $e($selfUrl($filters, ['page' => $list['page'] + 1])) ?>">Старіші →</a><?php endif; ?>
        </nav>
        <?php endif; ?>
        <?php endif; ?>
    </main>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>

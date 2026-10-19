<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Маркетплейс: оголошення» в кабінеті (вакансії, курси, послуги компаній).
 *
 * Вкладки: Модерація · Усі оголошення · Налаштування (лише admin) · Стан.
 * Модерують співробітники (role employee — наявна роль модератора) і admin; налаштування — лише admin.
 * Дії — public/listing-admin-action.php. Адмінка лише українською (як решта CRM).
 */

require_once __DIR__ . '/listing.php';
require_once __DIR__ . '/promo-linkcheck.php';

const LST_ADMIN_STATUS_UK = ['draft' => 'Чернетка', 'pending' => 'На модерації', 'published' => 'Опубліковано', 'rejected' => 'Відхилено', 'expired' => 'Термін минув', 'archived' => 'Знято'];
const LST_ADMIN_TYPE_UK = ['job' => 'Вакансія', 'course' => 'Курс', 'service' => 'Послуга'];

/** Ключ CSRF адмінки оголошень (спільний із маркетплейсом). */
function lst_admin_csrf(): string
{
    return mp_csrf_field();
}

function lst_admin_render(PDO $pdo, array $user): void
{
    if (!in_array((string) ($user['role'] ?? ''), ['employee', 'admin'], true) || !mp_is_staff()) {
        return;
    }
    try {
        $pdo->query('SELECT 1 FROM mp_listing_stats_daily LIMIT 1');
    } catch (Throwable $e) {
        echo '<p class="staff-note">Оголошення компаній: застосуйте міграцію database/migration-2026-10-19-marketplace-listings.sql.</p>';

        return;
    }
    $isAdmin = mp_live_role() === 'admin';
    $tabs = ['mod' => 'Модерація', 'all' => 'Усі оголошення'];
    if ($isAdmin) {
        $tabs['settings'] = 'Налаштування';
    }
    $tabs['status'] = 'Стан';
    $tabs = lst_admin_extra_tabs($tabs, $isAdmin);
    $tab = isset($tabs[$_GET['ladm_tab'] ?? '']) ? (string) $_GET['ladm_tab'] : 'mod';
    $flash = $_SESSION['ladm_flash'] ?? null;
    unset($_SESSION['ladm_flash']);
    $settings = lst_settings($pdo);
    $csrf = lst_admin_csrf();

    $pending = $pdo->query(
        "SELECT l.id FROM mp_listings l WHERE l.section IN ('job', 'course', 'service') AND l.status = 'pending' ORDER BY l.updated_at, l.id LIMIT 100"
    )->fetchAll(PDO::FETCH_COLUMN);
    $queue = [];
    foreach ($pending as $pid) {
        $row = lst_listing($pdo, (int) $pid, 'orig');   // 'orig' — не активна мова: тексти мовою оригіналу, без автоперекладу
        if ($row !== null) {
            $row['signals'] = lst_risk_signals($pdo, $row);
            $queue[] = $row;
        }
    }
    $owners = [];
    if ($queue !== []) {
        $uids = array_values(array_unique(array_filter(array_map(static fn($r) => (int) $r['seller_user_id'], $queue))));
        if ($uids !== []) {
            $st = $pdo->prepare('SELECT id, email FROM users WHERE id IN (' . implode(',', array_fill(0, count($uids), '?')) . ')');
            $st->execute($uids);
            $owners = $st->fetchAll(PDO::FETCH_KEY_PAIR);
        }
    }
    $overdue = 0;
    foreach ($queue as $q) {
        if (strtotime((string) $q['updated_at']) < time() - $settings['review_hours'] * 3600) {
            $overdue++;
        }
    }

    // «Усі оголошення»: фільтри
    $fStatus = is_string($_GET['ladm_status'] ?? null) && isset(LST_ADMIN_STATUS_UK[$_GET['ladm_status']]) ? (string) $_GET['ladm_status'] : '';
    $fType = is_string($_GET['ladm_type'] ?? null) && lst_type_valid((string) $_GET['ladm_type']) ? (string) $_GET['ladm_type'] : '';
    $where = "l.section IN ('job', 'course', 'service')";
    $params = [];
    if ($fStatus !== '') {
        $where .= ' AND l.status = :st';
        $params[':st'] = $fStatus;
    }
    if ($fType !== '') {
        $where .= ' AND l.section = :ty';
        $params[':ty'] = $fType;
    }
    $all = [];
    if ($tab === 'all') {
        $st = $pdo->prepare(
            "SELECT l.id, l.section, l.status, l.slug, l.company_name, l.created_at, l.published_at, l.expires_at,
                    (l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed, t.title, u.email
             FROM mp_listings l LEFT JOIN mp_sellers s ON s.id = l.seller_id LEFT JOIN users u ON u.id = s.user_id
             LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
             WHERE $where ORDER BY l.id DESC LIMIT 300"
        );
        $st->execute($params);
        $all = $st->fetchAll(PDO::FETCH_ASSOC);
    }
    $allStats = lst_stats($pdo, array_map(static fn($r) => (int) $r['id'], $all), 30);
    $counts = $pdo->query("SELECT status, COUNT(*) FROM mp_listings WHERE section IN ('job', 'course', 'service') GROUP BY status")->fetchAll(PDO::FETCH_KEY_PAIR);
    $badge = static fn(string $s): string => '<span class="pc-badge pc-badge--' . lst_e($s) . '">' . lst_e(LST_ADMIN_STATUS_UK[$s] ?? $s) . '</span>';
    $rejectSelect = static function (string $name, string $form = ''): string {
        $h = '<select class="pc-input" name="' . $name . '"' . ($form !== '' ? ' form="' . $form . '"' : '') . '>';
        foreach (LST_REJECT_TEMPLATES as $k) {
            $h .= '<option value="' . $k . '">' . lst_e(LST_I18N['rej_' . $k][0]) . '</option>';
        }

        return $h . '</select>';
    };
    ?>
            <div class="accordion" id="acc-listings-admin">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-listings-admin-panel">
                    <span class="accordion__title">Маркетплейс: оголошення<?= $queue !== [] ? ' · ' . count($queue) . ' на модерації' : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-listings-admin-panel">
                    <div class="accordion__panel-inner pc" data-pc-param="ladm_tab" data-pc-hash="acc-listings-admin">
                        <div class="pc-box pc-system">
                            <p><strong>Маркетплейс для відвідувачів: <?= mp_public_enabled() ? 'ПОКАЗАНО' : 'ПРИХОВАНО' ?></strong>
                                <span class="pc-muted">Перемикач — у розділі CRM. Поки приховано, сторінки вакансій, курсів і послуг бачать лише співробітники.</span></p>
                            <p class="pc-muted">Розділи: <a href="listings.php?type=job">вакансії</a> · <a href="listings.php?type=course">курси</a> · <a href="listings.php?type=service">послуги</a>
                                · безкоштовно до: <strong><?= $settings['free_until'] !== '' ? lst_e(date('d.m.Y', (int) strtotime($settings['free_until']))) : 'не задано' ?></strong>
                                · строк: <strong><?= $settings['days'] ?> дн.</strong> · мета розгляду: <strong><?= $settings['review_hours'] ?> год</strong></p>
                            <?php if ($overdue > 0): ?><p class="pc-warn-text">Довше за мету розгляду (<?= $settings['review_hours'] ?> год) чекають: <?= $overdue ?>.</p><?php endif; ?>
                        </div>
                        <?php if (is_array($flash) && !empty($flash['msgs'])): ?>
                            <div class="pc-flash <?= !empty($flash['ok']) ? 'pc-flash--ok' : 'pc-flash--error' ?>" role="status">
                                <?php foreach ($flash['msgs'] as $m): ?><p><?= lst_e($m) ?></p><?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                        <div class="pc-tabs" role="tablist">
                            <?php foreach ($tabs as $k => $label): $n = $k === 'mod' ? count($queue) : 0; ?>
                                <a class="pc-tab<?= $tab === $k ? ' is-active' : '' ?>" role="tab" href="account.php?ladm_tab=<?= $k ?>#acc-listings-admin" data-pc-tab="<?= $k ?>" aria-selected="<?= $tab === $k ? 'true' : 'false' ?>"><?= lst_e($label) ?><?= $n > 0 ? ' (' . $n . ')' : '' ?></a>
                            <?php endforeach; ?>
                        </div>

                        <!-- Модерація -->
                        <section class="pc-panel" data-pc-panel="mod"<?= $tab === 'mod' ? '' : ' hidden' ?>>
                            <?php if ($queue === []): ?>
                                <p class="pc-empty">Черга модерації порожня.</p>
                            <?php else: ?>
                                <form id="ladmBulk" method="post" action="listing-admin-action.php" class="pc-box lst-bulk" data-pc-confirm="Застосувати дію до позначених оголошень?">
                                    <?= $csrf ?><input type="hidden" name="return_tab" value="mod">
                                    <strong>Масові дії з позначеними:</strong>
                                    <button class="pc-btn pc-btn--primary pc-btn--small" type="submit" name="action" value="bulk_approve">Схвалити</button>
                                    <span>або відхилити з причиною</span> <?= $rejectSelect('template') ?>
                                    <button class="pc-btn pc-btn--danger pc-btn--small" type="submit" name="action" value="bulk_reject">Відхилити</button>
                                </form>
                            <?php endif; ?>
                            <?php foreach ($queue as $q):
                                $qid = (int) $q['id'];
                                $check = json_decode((string) $q['link_check_json'], true);
                                $waitH = (int) floor((time() - (int) strtotime((string) $q['updated_at'])) / 3600); ?>
                                <article class="pc-mod lst-mod">
                                    <label class="lst-mod__pick"><input type="checkbox" name="ids[]" value="<?= $qid ?>" form="ladmBulk"> #<?= $qid ?> · <?= lst_e(LST_ADMIN_TYPE_UK[$q['section']] ?? $q['section']) ?></label>
                                    <span class="pc-muted"> · чекає <?= $waitH ?> год<?= $waitH >= $settings['review_hours'] ? ' ⚠' : '' ?> · автор: <?= lst_e($owners[(int) $q['seller_user_id']] ?? '—') ?></span>
                                    <div class="mp-panel lst-preview">
                                        <p class="mp-card__tag"><?= lst_e(LST_ADMIN_TYPE_UK[$q['section']] ?? '') ?> · <?= lst_e($q['company_name']) ?></p>
                                        <h3 class="pc-h3"><?= lst_e($q['title']) ?></h3>
                                        <p><?= lst_e($q['short_desc']) ?></p>
                                        <ul class="lst-facts-admin">
                                            <?php foreach (lst_facts($q) as [$l, $val]): ?><li><strong><?= lst_e($l) ?>:</strong> <?= lst_e($val) ?></li><?php endforeach; ?>
                                            <li><strong>Теги:</strong> <?= lst_e(implode(', ', array_column($q['categories'] ?? [], 'name')) ?: '—') ?></li>
                                            <li><strong>Посилання:</strong> <a href="<?= lst_e($q['delivery_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= lst_e($q['delivery_url']) ?></a></li>
                                        </ul>
                                        <?php if (trim((string) $q['full_desc']) !== ''): ?>
                                            <details><summary>Повний опис</summary><div class="mp-text mp-text--pre"><?= lst_e($q['full_desc']) ?></div></details>
                                        <?php endif; ?>
                                    </div>
                                    <p><strong>Перевірка посилання:</strong> <?= lst_e($q['link_check_status'] ?? 'не виконано') ?><?= !empty($q['link_checked_at']) ? ' (' . lst_e($q['link_checked_at']) . ')' : '' ?>
                                        <?php if (is_array($check)): ?><br><span class="pc-muted"><?= lst_e(implode(' · ', array_filter(array_merge(
                                            [isset($check['http_status']) ? 'HTTP ' . $check['http_status'] : ''],
                                            [!empty($check['final_url']) && $check['final_url'] !== $q['delivery_url'] ? 'кінцева адреса: ' . $check['final_url'] : ''],
                                            (array) ($check['notes'] ?? [])
                                        )))) ?></span><?php endif; ?></p>
                                    <?php if ($q['signals'] !== []): ?>
                                        <ul class="pc-warn-text lst-signals"><?php foreach ($q['signals'] as $sgn): ?><li><?= lst_e($sgn) ?></li><?php endforeach; ?></ul>
                                    <?php else: ?>
                                        <p class="pc-muted">Сигналів ризику не знайдено.</p>
                                    <?php endif; ?>
                                    <div class="lst-mod__actions">
                                        <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="approve"><input type="hidden" name="id" value="<?= $qid ?>"><input type="hidden" name="return_tab" value="mod"><button class="pc-btn pc-btn--primary" type="submit">Схвалити</button></form>
                                        <form method="post" action="listing-admin-action.php" class="pc-inline-form lst-reject"><?= $csrf ?><input type="hidden" name="action" value="reject"><input type="hidden" name="id" value="<?= $qid ?>"><input type="hidden" name="return_tab" value="mod">
                                            <?= $rejectSelect('template') ?>
                                            <input class="pc-input" type="text" name="comment" maxlength="300" placeholder="Коментар (необов'язково)">
                                            <button class="pc-btn pc-btn--danger" type="submit">Відхилити</button>
                                        </form>
                                        <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="recheck"><input type="hidden" name="id" value="<?= $qid ?>"><input type="hidden" name="return_tab" value="mod"><button class="pc-btn pc-btn--small" type="submit">Перевірити посилання ще раз</button></form>
                                        <a class="pc-btn pc-btn--small" href="<?= lst_e(lst_url($q)) ?>" target="_blank" rel="noopener">Як на сайті</a>
                                    </div>
                                </article>
                            <?php endforeach; ?>
                        </section>

                        <!-- Усі оголошення -->
                        <section class="pc-panel" data-pc-panel="all"<?= $tab === 'all' ? '' : ' hidden' ?>>
                            <p class="pc-muted">За статусами: <?php foreach (LST_ADMIN_STATUS_UK as $k => $l): ?><?= lst_e($l) ?> — <?= (int) ($counts[$k] ?? 0) ?>; <?php endforeach; ?></p>
                            <form method="get" action="account.php" class="pc-inline-form">
                                <input type="hidden" name="ladm_tab" value="all">
                                <select class="pc-input" name="ladm_status"><option value="">Усі статуси</option><?php foreach (LST_ADMIN_STATUS_UK as $k => $l): ?><option value="<?= $k ?>"<?= $fStatus === $k ? ' selected' : '' ?>><?= lst_e($l) ?></option><?php endforeach; ?></select>
                                <select class="pc-input" name="ladm_type"><option value="">Усі типи</option><?php foreach (LST_ADMIN_TYPE_UK as $k => $l): ?><option value="<?= $k ?>"<?= $fType === $k ? ' selected' : '' ?>><?= lst_e($l) ?></option><?php endforeach; ?></select>
                                <button class="pc-btn pc-btn--small" type="submit">Показати</button>
                            </form>
                            <?php if ($tab !== 'all'): ?>
                                <p><a class="pc-btn" href="account.php?ladm_tab=all#acc-listings-admin">Відкрити список</a></p>
                            <?php elseif ($all === []): ?>
                                <p class="pc-empty">Нічого не знайдено.</p>
                            <?php else: ?>
                                <div class="pc-table-wrap"><table class="pc-table">
                                    <thead><tr><th>#</th><th>Оголошення</th><th>Статус</th><th>Перегляди / переходи (30 дн.)</th><th>До</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($all as $r): $rid = (int) $r['id']; $s = $allStats[$rid] ?? ['views' => 0, 'clicks' => 0];
                                        $status = (string) $r['status'] === 'published' && (int) $r['elapsed'] === 1 ? 'expired' : (string) $r['status']; ?>
                                        <tr>
                                            <td data-label="#"><?= $rid ?></td>
                                            <td data-label="Оголошення"><a href="<?= lst_e(lst_url($r)) ?>" target="_blank" rel="noopener"><?= lst_e($r['title'] ?? '—') ?></a><br><span class="pc-muted"><?= lst_e(LST_ADMIN_TYPE_UK[$r['section']] ?? '') ?> · <?= lst_e($r['company_name']) ?> · <?= lst_e($r['email'] ?? '') ?></span></td>
                                            <td data-label="Статус"><?= $badge($status) ?></td>
                                            <td data-label="Перегляди / переходи"><?= $s['views'] ?> / <?= $s['clicks'] ?></td>
                                            <td data-label="До"><?= $status === 'published' && !empty($r['expires_at']) ? lst_e(date('d.m.Y', (int) strtotime((string) $r['expires_at']))) : '—' ?></td>
                                            <td data-label="Дії">
                                                <?php if (in_array($status, ['pending', 'published', 'expired', 'rejected'], true)): ?>
                                                    <form method="post" action="listing-admin-action.php" class="pc-inline-form" data-pc-confirm="Зняти оголошення #<?= $rid ?> з публікації?"><?= $csrf ?><input type="hidden" name="action" value="remove"><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="return_tab" value="all"><button class="pc-btn pc-btn--small pc-btn--danger" type="submit">Зняти</button></form>
                                                <?php endif; ?>
                                                <?php if (in_array($status, ['rejected', 'archived', 'expired'], true)): ?>
                                                    <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="to_pending"><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="return_tab" value="all"><button class="pc-btn pc-btn--small" type="submit">На модерацію</button></form>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table></div>
                            <?php endif; ?>
                        </section>

                        <?php if ($isAdmin): ?>
                        <!-- Налаштування -->
                        <section class="pc-panel" data-pc-panel="settings"<?= $tab === 'settings' ? '' : ' hidden' ?>>
                            <form method="post" action="listing-admin-action.php" class="pc-form">
                                <?= $csrf ?><input type="hidden" name="action" value="settings"><input type="hidden" name="return_tab" value="settings">
                                <p><label>Безкоштовне розміщення до (дата; порожньо — напис не показується)<br>
                                    <input class="pc-input" type="date" name="free_until" value="<?= lst_e($settings['free_until']) ?>"></label></p>
                                <p><label>Строк оголошення, днів (1–365)<br>
                                    <input class="pc-input" type="number" name="listing_days" min="1" max="365" value="<?= $settings['days'] ?>"></label></p>
                                <p><label>Мета терміну розгляду модерацією, годин<br>
                                    <input class="pc-input" type="number" name="review_hours" min="1" max="720" value="<?= $settings['review_hours'] ?>"></label></p>
                                <p class="pc-muted">Платежів немає: продовження оголошень безкоштовне. Строк застосовується до нових схвалень і продовжень; для вакансії — не пізніше дати закінчення подання.</p>
                                <button class="pc-btn pc-btn--primary" type="submit">Зберегти</button>
                            </form>
                        </section>
                        <?php endif; ?>

                        <!-- Стан -->
                        <section class="pc-panel" data-pc-panel="status"<?= $tab === 'status' ? '' : ' hidden' ?>>
                            <?= lst_admin_status_html($pdo) ?>
                        </section>

                        <?php lst_admin_extra_panels($pdo, $tab, $isAdmin); ?>
                    </div>
                </div>
            </div>
            <?= promo_cabinet_assets() ?>
    <?php
}

/** Вкладки наступних блоків (ліди, аутріч) — додаються, коли відповідні файли підключено. */
function lst_admin_extra_tabs(array $tabs, bool $isAdmin): array
{
    if ($isAdmin && function_exists('olead_admin_tabs')) {
        $tabs = olead_admin_tabs($tabs);
    }

    return $tabs;
}

function lst_admin_extra_panels(PDO $pdo, string $tab, bool $isAdmin): void
{
    if ($isAdmin && function_exists('olead_admin_panels')) {
        olead_admin_panels($pdo, $tab);
    }
}

/** Стан: останні запуски cron-завдань маркетплейсу, черга пошти, лічильники. */
function lst_admin_status_html(PDO $pdo): string
{
    $jobs = ['marketplace-daily' => 'Оголошення: прострочення, листи, звіти (щодня)'];
    if (function_exists('olead_cron_jobs')) {
        $jobs += olead_cron_jobs();
    }
    $h = '<div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Завдання</th><th>Останній запуск</th><th>Статус</th><th>Повідомлення</th></tr></thead><tbody>';
    foreach ($jobs as $job => $label) {
        $st = $pdo->prepare('SELECT * FROM cron_runs WHERE job = :j ORDER BY id DESC LIMIT 1');
        $st->execute([':j' => $job]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
        $h .= '<tr><td data-label="Завдання">' . lst_e($label) . '<br><span class="pc-muted">' . lst_e($job) . '</span></td>'
            . '<td data-label="Останній запуск">' . ($r ? lst_e($r['started_at']) . ' UTC' : '<span class="pc-warn-text">ще не запускалось</span>') . '</td>'
            . '<td data-label="Статус">' . ($r ? lst_e($r['status']) : '—') . '</td>'
            . '<td data-label="Повідомлення">' . ($r ? lst_e((string) $r['message']) : '—') . '</td></tr>';
    }
    $h .= '</tbody></table></div>';
    try {
        $mail = $pdo->query("SELECT status, COUNT(*) FROM mail_queue GROUP BY status")->fetchAll(PDO::FETCH_KEY_PAIR);
    } catch (Throwable $e) {
        $mail = [];
    }

    return $h . '<p class="pc-muted">Черга пошти (усі листи сайту): очікують — ' . (int) ($mail['pending'] ?? 0) . ', надіслано — ' . (int) ($mail['sent'] ?? 0)
        . ', помилки — ' . (int) ($mail['failed'] ?? 0) . '. Листи надсилає cron/promo-mail.php.</p>'
        . '<p class="pc-muted">Cron (щодня): <code>php …/www/cron/marketplace-daily.php</code></p>';
}

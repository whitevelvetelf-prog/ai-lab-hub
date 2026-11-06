<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Маркетплейс: оголошення» в кабінеті (вакансії, курси, послуги компаній).
 *
 * Вкладки: Модерація · Усі оголошення · Налаштування (лише admin) · Стан · (ліди, аутріч) · Цифрові матеріали …
 * «Модерація» — єдина черга ВСІХ оголошень зі статусом pending з усіх розділів однієї таблиці mp_listings:
 * вакансії, курси, послуги (повна картка й дії тут), дошка й готові рішення (швидкий перегляд + дії тут або
 * в mp-moderation.php). Цифрові матеріали й підозріла активність мають власні вкладки — у «Модерації» їхні
 * лічильники з посиланнями, щоб нічого не ховалося. «Усі оголошення» — усі розділи й статуси, пошук.
 * Модерують співробітники (role employee — наявна роль модератора) і admin; налаштування — лише admin.
 * Дії — public/listing-admin-action.php. Адмінка лише українською (як решта CRM).
 */

require_once __DIR__ . '/listing.php';
require_once __DIR__ . '/asset-admin.php';   // вкладки «Цифрових матеріалів»
require_once __DIR__ . '/promo-linkcheck.php';
foreach (['outreach-admin.php', 'outreach-mail-admin.php'] as $lstExtra) {   // вкладки лідів (M2) і аутрічу (M3), якщо розгорнуто
    if (is_file(__DIR__ . '/' . $lstExtra)) {
        require_once __DIR__ . '/' . $lstExtra;
    }
}

const LST_ADMIN_STATUS_UK = ['draft' => 'Чернетка', 'pending' => 'На модерації', 'published' => 'Опубліковано', 'rejected' => 'Відхилено', 'expired' => 'Термін минув', 'archived' => 'Знято'];
const LST_ADMIN_TYPE_UK = ['job' => 'Вакансія', 'course' => 'Курс', 'service' => 'Послуга'];
/** Усі розділи mp_listings для черги й «Усіх оголошень». */
const LST_ADMIN_ALL_TYPES_UK = LST_ADMIN_TYPE_UK + ['board' => 'Дошка', 'solution' => 'Готове рішення', 'asset' => 'Цифровий матеріал'];
/** Розділи, що потрапляють у вкладку «Модерація» (asset — окрема вкладка «Цифрові матеріали»). */
const LST_ADMIN_QUEUE_TYPES = ['job', 'course', 'service', 'board', 'solution'];

/**
 * Лічильники для бейджів: усі оголошення на модерації (крім матеріалів), матеріали на модерації.
 *
 * @return array{queue:int,assets:int,total:int}
 */
function lst_admin_pending_counts(PDO $pdo): array
{
    try {
        $rows = $pdo->query("SELECT section, COUNT(*) FROM mp_listings WHERE status = 'pending' GROUP BY section")->fetchAll(PDO::FETCH_KEY_PAIR);
    } catch (Throwable $e) {
        return ['queue' => 0, 'assets' => 0, 'total' => 0];
    }
    $queue = 0;
    foreach (LST_ADMIN_QUEUE_TYPES as $t) {
        $queue += (int) ($rows[$t] ?? 0);
    }
    $assets = (int) ($rows['asset'] ?? 0);

    return ['queue' => $queue, 'assets' => $assets, 'total' => $queue + $assets];
}

/** Адреса перегляду оголошення будь-якого розділу для модератора. */
function lst_admin_view_url(array $r): string
{
    return match ((string) $r['section']) {
        'job', 'course', 'service' => lst_url($r),
        'board' => 'mp-moderation.php?id=' . (int) $r['id'],
        'solution' => 'mp-add-offer.php?id=' . (int) $r['id'],
        'asset' => 'asset.php?id=' . (int) $r['id'],
        default => '#',
    };
}

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

    // Єдина черга: усі pending з усіх розділів (крім цифрових матеріалів), від найстаріших. Фільтр за типом.
    $qType = is_string($_GET['ladm_qtype'] ?? null) && in_array($_GET['ladm_qtype'], LST_ADMIN_QUEUE_TYPES, true) ? (string) $_GET['ladm_qtype'] : '';
    $inTypes = "'" . implode("', '", LST_ADMIN_QUEUE_TYPES) . "'";
    $queueByType = $pdo->query("SELECT section, COUNT(*) FROM mp_listings WHERE status = 'pending' AND section IN ($inTypes) GROUP BY section")->fetchAll(PDO::FETCH_KEY_PAIR);
    $qst = $pdo->prepare(
        "SELECT l.id, l.section FROM mp_listings l WHERE l.status = 'pending' AND l.section IN ($inTypes)"
        . ($qType !== '' ? ' AND l.section = :qt' : '') . ' ORDER BY l.updated_at, l.id LIMIT 200'
    );
    $qst->execute($qType !== '' ? [':qt' => $qType] : []);
    $pending = $qst->fetchAll(PDO::FETCH_ASSOC);
    $queue = [];   // вакансії/курси/послуги — повні картки
    $items = [];   // загальний порядок: ['kind' => 'lst'|'gen', 'row' => …]
    $genIds = [];
    foreach ($pending as $p) {
        if (lst_type_valid((string) $p['section'])) {
            $row = lst_listing($pdo, (int) $p['id'], 'orig');   // 'orig' — не активна мова: тексти мовою оригіналу, без автоперекладу
            if ($row !== null) {
                $row['signals'] = lst_risk_signals($pdo, $row);
                $queue[] = $row;
                $items[] = ['kind' => 'lst', 'row' => $row];
            }
        } else {
            $genIds[] = (int) $p['id'];
            $items[] = ['kind' => 'gen', 'id' => (int) $p['id']];
        }
    }
    // Дошка й готові рішення: заголовок, тексти мовою оригіналу, автор (продавець або той, хто створив).
    $gen = [];
    if ($genIds !== []) {
        $gs = $pdo->prepare(
            'SELECT l.id, l.section, l.status, l.updated_at, l.created_at, l.price_type, l.price_amount, l.currency, l.city, l.is_remote,
                    ts.title, ts.short_desc, ts.full_desc, u.email, u.name AS author_name, s.display_name AS seller_name,
                    (SELECT COUNT(*) FROM mp_reports r WHERE r.listing_id = l.id) AS reports_total
             FROM mp_listings l LEFT JOIN mp_sellers s ON s.id = l.seller_id
             LEFT JOIN users u ON u.id = COALESCE(s.user_id, l.created_by)
             LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
             WHERE l.id IN (' . implode(',', array_fill(0, count($genIds), '?')) . ')'
        );
        $gs->execute($genIds);
        foreach ($gs->fetchAll(PDO::FETCH_ASSOC) as $g) {
            $gen[(int) $g['id']] = $g;
        }
    }
    foreach ($items as $i => $it) {
        if ($it['kind'] === 'gen') {
            if (!isset($gen[$it['id']])) {
                unset($items[$i]);
                continue;
            }
            $items[$i]['row'] = $gen[$it['id']];
        }
    }
    $items = array_values($items);
    $pc = lst_admin_pending_counts($pdo);
    try {
        $suspCount = (int) $pdo->query('SELECT COUNT(DISTINCT anon_hash) FROM asset_suspicious WHERE created_at >= NOW() - INTERVAL 7 DAY')->fetchColumn();
    } catch (Throwable $e) {
        $suspCount = 0;
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
    foreach ($items as $it) {
        if (strtotime((string) $it['row']['updated_at']) < time() - $settings['review_hours'] * 3600) {
            $overdue++;
        }
    }

    // «Усі оголошення»: фільтри
    $fStatus = is_string($_GET['ladm_status'] ?? null) && isset(LST_ADMIN_STATUS_UK[$_GET['ladm_status']]) ? (string) $_GET['ladm_status'] : '';
    $fType = is_string($_GET['ladm_type'] ?? null) && isset(LST_ADMIN_ALL_TYPES_UK[$_GET['ladm_type']]) ? (string) $_GET['ladm_type'] : '';
    $fQ = is_string($_GET['ladm_q'] ?? null) ? mb_substr(trim((string) $_GET['ladm_q']), 0, 100) : '';
    $where = "l.section IN ('" . implode("', '", array_keys(LST_ADMIN_ALL_TYPES_UK)) . "')";
    $params = [];
    if ($fQ !== '') {
        // Пошук за назвою (будь-якою мовою) і email автора.
        $where .= " AND (EXISTS (SELECT 1 FROM mp_listing_translations tq WHERE tq.listing_id = l.id AND tq.title LIKE :q1 ESCAPE '\\\\')"
            . " OR u.email LIKE :q2 ESCAPE '\\\\' OR l.company_name LIKE :q3 ESCAPE '\\\\')";
        $like = '%' . addcslashes($fQ, '%_\\') . '%';
        $params[':q1'] = $like;
        $params[':q2'] = $like;
        $params[':q3'] = $like;
    }
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
             FROM mp_listings l LEFT JOIN mp_sellers s ON s.id = l.seller_id LEFT JOIN users u ON u.id = COALESCE(s.user_id, l.created_by)
             LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
             WHERE $where ORDER BY l.id DESC LIMIT 300"
        );
        $st->execute($params);
        $all = $st->fetchAll(PDO::FETCH_ASSOC);
    }
    $allStats = lst_stats($pdo, array_map(static fn($r) => (int) $r['id'], $all), 30);
    $counts = $pdo->query("SELECT status, COUNT(*) FROM mp_listings WHERE section IN ('" . implode("', '", array_keys(LST_ADMIN_ALL_TYPES_UK)) . "') GROUP BY status")->fetchAll(PDO::FETCH_KEY_PAIR);
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
                    <span class="accordion__title">Маркетплейс: оголошення<?= $pc['total'] > 0 ? ' · ' . $pc['total'] . ' на модерації' : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-listings-admin-panel">
                    <div class="accordion__panel-inner pc lst-adm" data-pc-param="ladm_tab" data-pc-hash="acc-listings-admin">
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
                            <?php foreach ($tabs as $k => $label): $n = $k === 'mod' ? $pc['queue'] : ($k === 'assets' ? $pc['assets'] : 0); ?>
                                <a class="pc-tab<?= $tab === $k ? ' is-active' : '' ?>" role="tab" href="account.php?ladm_tab=<?= $k ?>#acc-listings-admin" data-pc-tab="<?= $k ?>" aria-selected="<?= $tab === $k ? 'true' : 'false' ?>"><?= lst_e($label) ?><?= $n > 0 ? ' (' . $n . ')' : '' ?></a>
                            <?php endforeach; ?>
                        </div>

                        <!-- Модерація -->
                        <section class="pc-panel" data-pc-panel="mod"<?= $tab === 'mod' ? '' : ' hidden' ?>>
                            <div class="pc-box lst-mod-summary">
                                <p><strong>На модерації: <?= $pc['queue'] ?></strong>
                                    <?php foreach (LST_ADMIN_QUEUE_TYPES as $t): ?> · <?= lst_e(LST_ADMIN_ALL_TYPES_UK[$t]) ?>: <?= (int) ($queueByType[$t] ?? 0) ?><?php endforeach; ?></p>
                                <p>Окремі черги:
                                    <a href="account.php?ladm_tab=assets#acc-listings-admin" data-pc-tab="assets">Цифрові матеріали — <?= $pc['assets'] ?></a>
                                    · <a href="account.php?ladm_tab=asset_susp#acc-listings-admin" data-pc-tab="asset_susp">Підозріла активність (7 дн.) — <?= $suspCount ?></a>
                                    · <a href="mp-moderation.php?tab=reports">Скарги на дошці</a></p>
                                <form method="get" action="account.php" class="pc-inline-form">
                                    <input type="hidden" name="ladm_tab" value="mod">
                                    <label>Тип <select class="pc-input" name="ladm_qtype"><option value="">Усі типи</option>
                                        <?php foreach (LST_ADMIN_QUEUE_TYPES as $t): ?><option value="<?= $t ?>"<?= $qType === $t ? ' selected' : '' ?>><?= lst_e(LST_ADMIN_ALL_TYPES_UK[$t]) ?> (<?= (int) ($queueByType[$t] ?? 0) ?>)</option><?php endforeach; ?>
                                    </select></label>
                                    <button class="pc-btn pc-btn--small" type="submit">Показати</button>
                                    <span class="pc-muted">Від найстаріших. ⚠ — довше за мету розгляду (<?= $settings['review_hours'] ?> год).</span>
                                </form>
                            </div>
                            <?php if ($items === []): ?>
                                <p class="pc-empty">Черга модерації порожня.</p>
                            <?php endif; ?>
                            <?php if ($queue !== []): ?>
                                <form id="ladmBulk" method="post" action="listing-admin-action.php" class="pc-box lst-bulk" data-pc-confirm="Застосувати дію до позначених оголошень?">
                                    <?= $csrf ?><input type="hidden" name="return_tab" value="mod">
                                    <strong>Масові дії з позначеними:</strong>
                                    <button class="pc-btn pc-btn--primary pc-btn--small" type="submit" name="action" value="bulk_approve">Схвалити</button>
                                    <span>або відхилити з причиною</span> <?= $rejectSelect('template') ?>
                                    <button class="pc-btn pc-btn--danger pc-btn--small" type="submit" name="action" value="bulk_reject">Відхилити</button>
                                </form>
                            <?php endif; ?>
                            <?php foreach ($items as $it):
                                if ($it['kind'] === 'gen') {
                                    echo lst_admin_gen_card($it['row'], $csrf, (int) $settings['review_hours']);
                                    continue;
                                }
                                $q = $it['row'];
                                $qid = (int) $q['id'];
                                $check = json_decode((string) $q['link_check_json'], true);
                                $waitH = (int) floor((time() - (int) strtotime((string) $q['updated_at'])) / 3600); ?>
                                <article class="pc-mod lst-mod<?= $waitH >= $settings['review_hours'] ? ' pc-mod--overdue' : '' ?>">
                                    <label class="lst-mod__pick"><input type="checkbox" name="ids[]" value="<?= $qid ?>" form="ladmBulk"> #<?= $qid ?> · <?= lst_e(LST_ADMIN_TYPE_UK[$q['section']] ?? $q['section']) ?></label>
                                    <span class="pc-muted"> · подано <?= lst_e(date('d.m.Y H:i', (int) strtotime((string) $q['updated_at']))) ?> · чекає <?= $waitH ?> год<?= $waitH >= $settings['review_hours'] ? ' ⚠' : '' ?> · автор: <?= lst_e($owners[(int) $q['seller_user_id']] ?? '—') ?></span>
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
                                <select class="pc-input" name="ladm_type"><option value="">Усі типи</option><?php foreach (LST_ADMIN_ALL_TYPES_UK as $k => $l): ?><option value="<?= $k ?>"<?= $fType === $k ? ' selected' : '' ?>><?= lst_e($l) ?></option><?php endforeach; ?></select>
                                <input class="pc-input" type="search" name="ladm_q" maxlength="100" value="<?= lst_e($fQ) ?>" placeholder="Назва або email автора" aria-label="Пошук за назвою або email автора">
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
                                            <td data-label="Оголошення"><a href="<?= lst_e(lst_admin_view_url($r)) ?>" target="_blank" rel="noopener"><?= lst_e($r['title'] ?? '—') ?></a><br><span class="pc-muted"><?= lst_e(LST_ADMIN_ALL_TYPES_UK[$r['section']] ?? $r['section']) ?><?= ($r['company_name'] ?? '') !== '' ? ' · ' . lst_e($r['company_name']) : '' ?> · <?= lst_e($r['email'] ?? '') ?> · <?= lst_e(date('d.m.Y', (int) strtotime((string) $r['created_at']))) ?></span></td>
                                            <td data-label="Статус"><?= $badge($status) ?></td>
                                            <td data-label="Перегляди / переходи"><?= $s['views'] ?> / <?= $s['clicks'] ?></td>
                                            <td data-label="До"><?= $status === 'published' && !empty($r['expires_at']) ? lst_e(date('d.m.Y', (int) strtotime((string) $r['expires_at']))) : '—' ?></td>
                                            <td data-label="Дії">
                                                <?php if (!lst_type_valid((string) $r['section'])): ?>
                                                    <a class="pc-btn pc-btn--small" href="<?= lst_e(lst_admin_view_url($r)) ?>">Відкрити</a>
                                                <?php elseif (in_array($status, ['pending', 'published', 'expired', 'rejected'], true)): ?>
                                                    <form method="post" action="listing-admin-action.php" class="pc-inline-form" data-pc-confirm="Зняти оголошення #<?= $rid ?> з публікації?"><?= $csrf ?><input type="hidden" name="action" value="remove"><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="return_tab" value="all"><button class="pc-btn pc-btn--small pc-btn--danger" type="submit">Зняти</button></form>
                                                <?php endif; ?>
                                                <?php if (lst_type_valid((string) $r['section']) && in_array($status, ['rejected', 'archived', 'expired'], true)): ?>
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

/**
 * Картка черги для дошки й готових рішень: тип, назва, автор, час подачі, швидкий перегляд і дії.
 * Дошка — схвалити/відхилити тут (POST у mp-moderation.php, return=account); рішення — редактор mp-add-offer.php.
 */
function lst_admin_gen_card(array $r, string $csrf, int $reviewHours): string
{
    $id = (int) $r['id'];
    $waitH = (int) floor((time() - (int) strtotime((string) $r['updated_at'])) / 3600);
    $over = $waitH >= $reviewHours;
    $type = LST_ADMIN_ALL_TYPES_UK[$r['section']] ?? (string) $r['section'];
    $author = trim((string) ($r['seller_name'] ?: $r['author_name'] ?: '')) . ((string) ($r['email'] ?? '') !== '' ? ' · ' . $r['email'] : '');
    $h = '<article class="pc-mod lst-mod' . ($over ? ' pc-mod--overdue' : '') . '">'
        . '<p class="lst-mod__pick">#' . $id . ' · ' . lst_e($type) . '</p>'
        . '<span class="pc-muted"> · подано ' . lst_e(date('d.m.Y H:i', (int) strtotime((string) $r['updated_at']))) . ' · чекає ' . $waitH . ' год' . ($over ? ' ⚠' : '')
        . ' · автор: ' . lst_e($author !== '' ? $author : '—') . ((int) $r['reports_total'] > 0 ? ' · скарг: ' . (int) $r['reports_total'] : '') . '</span>'
        . '<div class="mp-panel lst-preview"><h3 class="pc-h3">' . lst_e((string) ($r['title'] ?? '—')) . '</h3>'
        . '<p>' . lst_e((string) ($r['short_desc'] ?? '')) . '</p>'
        . (trim((string) ($r['full_desc'] ?? '')) !== '' ? '<details><summary>Повний опис</summary><div class="mp-text mp-text--pre">' . lst_e($r['full_desc']) . '</div></details>' : '')
        . '</div><div class="lst-mod__actions">';
    if ($r['section'] === 'board') {
        $h .= '<form method="post" action="mp-moderation.php" class="pc-inline-form">' . $csrf
            . '<input type="hidden" name="id" value="' . $id . '"><input type="hidden" name="return" value="account">'
            . '<button class="pc-btn pc-btn--primary" type="submit" name="action" value="approve">Схвалити</button></form>'
            . '<form method="post" action="mp-moderation.php" class="pc-inline-form lst-reject">' . $csrf
            . '<input type="hidden" name="id" value="' . $id . '"><input type="hidden" name="return" value="account">'
            . '<input class="pc-input" type="text" name="reason" maxlength="500" required placeholder="Причина відхилення (обов\'язково)" aria-label="Причина відхилення">'
            . '<button class="pc-btn pc-btn--danger" type="submit" name="action" value="reject">Відхилити</button></form>'
            . '<a class="pc-btn pc-btn--small" href="mp-moderation.php?id=' . $id . '" target="_blank" rel="noopener">Повний перегляд (фото, контакти)</a>';
    } else {
        $h .= '<a class="pc-btn pc-btn--primary" href="mp-add-offer.php?id=' . $id . '">Відкрити в редакторі рішень</a>';
    }

    return $h . '</div></article>';
}

/** Вкладки наступних блоків (ліди, аутріч) — додаються, коли відповідні файли підключено. */
function lst_admin_extra_tabs(array $tabs, bool $isAdmin): array
{
    if ($isAdmin && function_exists('olead_admin_tabs')) {
        $tabs = olead_admin_tabs($tabs);
    }
    // Цифрові матеріали: модерація, скарги, підозріла активність (employee/admin), налаштування (admin).
    return ast_admin_tabs($tabs, $isAdmin);
}

function lst_admin_extra_panels(PDO $pdo, string $tab, bool $isAdmin): void
{
    if ($isAdmin && function_exists('olead_admin_panels')) {
        olead_admin_panels($pdo, $tab);
    }
    ast_admin_panels($pdo, $tab, $isAdmin);
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

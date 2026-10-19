<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вкладки «Ліди» й «Джерела лідів» у розділі «Маркетплейс: оголошення» (лише admin), блок M2.
 *
 * Підключається з app/listing-admin-cabinet.php і public/listing-admin-action.php (через function_exists):
 *   olead_admin_tabs() / olead_admin_panels() — вкладки й панелі;
 *   olead_admin_action() — дії (POST + CSRF маркетплейсу);
 *   olead_cron_jobs() — завдання для вкладки «Стан».
 * Експорт CSV — public/outreach-export.php. Адмінка лише українською.
 */

require_once __DIR__ . '/outreach.php';

/** @param array<string,string> $tabs */
function olead_admin_tabs(array $tabs): array
{
    $out = [];
    foreach ($tabs as $k => $v) {
        if ($k === 'status') {
            $out['leads'] = 'Ліди';
            $out['sources'] = 'Джерела лідів';
            foreach (function_exists('omail_admin_tabs') ? omail_admin_tabs() : [] as $mk => $mv) {
                $out[$mk] = $mv;
            }
        }
        $out[$k] = $v;
    }

    return $out;
}

/** @return array<string,string> */
function olead_cron_jobs(): array
{
    $jobs = ['outreach-daily' => 'Ліди: збір із джерел і пошук контактів (щодня)'];
    if (function_exists('omail_cron_jobs')) {
        $jobs += omail_cron_jobs();
    }

    return $jobs;
}

/** Фільтри списку лідів із GET. @return array<string,string> */
function olead_filters(): array
{
    $g = static fn(string $k): string => is_string($_GET[$k] ?? null) ? trim((string) $_GET[$k]) : '';

    return [
        'type' => in_array($g('lf_type'), OUTREACH_LEAD_TYPES, true) ? $g('lf_type') : '',
        'source' => preg_match('/^[a-z_]{1,40}$/', $g('lf_source')) === 1 ? $g('lf_source') : '',
        'country' => preg_match('/^[A-Z]{2}$/', strtoupper($g('lf_country'))) === 1 ? strtoupper($g('lf_country')) : '',
        'language' => in_array($g('lf_lang'), ['uk', 'en', 'other'], true) ? $g('lf_lang') : '',
        'status' => in_array($g('lf_status'), OUTREACH_STATUSES, true) ? $g('lf_status') : '',
        'min_score' => (string) max(0, min(100, (int) $g('lf_score'))),
        'q' => mb_substr($g('lf_q'), 0, 80),
    ];
}

function olead_admin_panels(PDO $pdo, string $tab): void
{
    try {
        $pdo->query('SELECT 1 FROM outreach_leads LIMIT 1');
    } catch (Throwable $e) {
        echo '<section class="pc-panel" data-pc-panel="leads"' . ($tab === 'leads' ? '' : ' hidden') . '><p class="pc-warn-text">Застосуйте міграцію database/migration-2026-10-20-outreach-leads.sql.</p></section>';

        return;
    }
    $csrf = mp_csrf_field();
    $f = olead_filters();
    $res = $tab === 'leads' ? outreach_leads_search($pdo, $f, 300) : ['rows' => [], 'total' => 0];
    $counts = $pdo->query('SELECT status, COUNT(*) FROM outreach_leads GROUP BY status')->fetchAll(PDO::FETCH_KEY_PAIR);
    $sources = outreach_sources($pdo);
    $srcNames = array_column($sources, 'name', 'source_key') + ['manual' => 'Додано вручну', 'csv' => 'Імпорт CSV'];
    $e = static fn($v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $exportQs = http_build_query(array_filter(['lf_type' => $f['type'], 'lf_source' => $f['source'], 'lf_country' => $f['country'], 'lf_lang' => $f['language'], 'lf_status' => $f['status'], 'lf_score' => $f['min_score'] !== '0' ? $f['min_score'] : '', 'lf_q' => $f['q']]));
    ?>
                        <!-- Ліди -->
                        <section class="pc-panel" data-pc-panel="leads"<?= $tab === 'leads' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Лише дані рівня компанії: назва, сайт, публічна сторінка контактів і ділова адреса (info@, jobs@…). Імен людей і особистих адрес система не зберігає. Тексти чужих вакансій на сайті не публікуються.</p>
                            <p class="pc-muted">За статусами: <?php foreach (OUTREACH_STATUS_UK as $k => $l): if (!empty($counts[$k])): ?><a href="account.php?ladm_tab=leads&amp;lf_status=<?= $k ?>#acc-listings-admin"><?= $e($l) ?></a> — <?= (int) $counts[$k] ?>; <?php endif; endforeach; ?> усього — <?= array_sum(array_map('intval', $counts)) ?>.</p>
                            <form method="get" action="account.php" class="pc-inline-form lst-bulk">
                                <input type="hidden" name="ladm_tab" value="leads">
                                <input class="pc-input" type="search" name="lf_q" value="<?= $e($f['q']) ?>" placeholder="Компанія або домен">
                                <select class="pc-input" name="lf_type"><option value="">Тип</option><?php foreach (OUTREACH_LEAD_TYPES as $t): ?><option value="<?= $t ?>"<?= $f['type'] === $t ? ' selected' : '' ?>><?= $e(LST_ADMIN_TYPE_UK[$t]) ?></option><?php endforeach; ?></select>
                                <select class="pc-input" name="lf_source"><option value="">Джерело</option><?php foreach ($srcNames as $k => $n): ?><option value="<?= $e($k) ?>"<?= $f['source'] === $k ? ' selected' : '' ?>><?= $e($n) ?></option><?php endforeach; ?></select>
                                <input class="pc-input" type="text" name="lf_country" maxlength="2" size="3" value="<?= $e($f['country']) ?>" placeholder="UA">
                                <select class="pc-input" name="lf_lang"><option value="">Мова</option><?php foreach (['uk', 'en', 'other'] as $l): ?><option value="<?= $l ?>"<?= $f['language'] === $l ? ' selected' : '' ?>><?= $l ?></option><?php endforeach; ?></select>
                                <select class="pc-input" name="lf_status"><option value="">Статус</option><?php foreach (OUTREACH_STATUS_UK as $k => $l): ?><option value="<?= $k ?>"<?= $f['status'] === $k ? ' selected' : '' ?>><?= $e($l) ?></option><?php endforeach; ?></select>
                                <input class="pc-input" type="number" name="lf_score" min="0" max="100" value="<?= $e($f['min_score']) ?>" title="Мінімальна оцінка" style="width:5em">
                                <button class="pc-btn pc-btn--small" type="submit">Показати</button>
                                <a class="pc-btn pc-btn--small" href="outreach-export.php?<?= $e($exportQs) ?>">Експорт CSV</a>
                            </form>

                            <?php if ($tab !== 'leads'): ?>
                                <p><a class="pc-btn" href="account.php?ladm_tab=leads#acc-listings-admin">Відкрити ліди</a></p>
                            <?php else: ?>
                            <form id="oleadBulk" method="post" action="listing-admin-action.php" class="pc-box lst-bulk" data-pc-confirm="Застосувати дію до позначених лідів?">
                                <?= $csrf ?><input type="hidden" name="return_tab" value="leads">
                                <strong>Позначені (<?= count($res['rows']) ?> з <?= $res['total'] ?> на екрані):</strong>
                                <button class="pc-btn pc-btn--primary pc-btn--small" type="submit" name="action" value="lead_bulk_approve">Схвалити для аутрічу</button>
                                <button class="pc-btn pc-btn--danger pc-btn--small" type="submit" name="action" value="lead_bulk_reject">Відхилити</button>
                                <button class="pc-btn pc-btn--small" type="submit" name="action" value="lead_bulk_contacts">Знайти публічні контакти (до 5)</button>
                            </form>
                            <?php if ($res['rows'] === []): ?>
                                <p class="pc-empty">Лідів не знайдено.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap"><table class="pc-table">
                                <thead><tr><th><input type="checkbox" aria-label="Усі" onclick="document.querySelectorAll('.olead-pick').forEach(function(c){c.checked=this.checked}.bind(this))"></th><th>Компанія</th><th>Контекст</th><th>Оцінка</th><th>Контакти</th><th>Статус</th></tr></thead>
                                <tbody>
                                <?php foreach ($res['rows'] as $r): $id = (int) $r['id']; ?>
                                    <tr>
                                        <td data-label="✓"><input class="olead-pick" type="checkbox" name="ids[]" value="<?= $id ?>" form="oleadBulk"></td>
                                        <td data-label="Компанія"><strong><?= $e($r['company_name']) ?></strong>
                                            <?php if (!empty($r['company_website'])): ?><br><a href="<?= $e($r['company_website']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= $e($r['company_domain'] ?: $r['company_website']) ?></a><?php endif; ?>
                                            <?php if ((int) $r['in_catalog'] === 1): ?><br><span class="pc-badge pc-badge--pending">уже в каталозі — запрошувати окремо й обережно</span><?php endif; ?>
                                        </td>
                                        <td data-label="Контекст"><?= $e(LST_ADMIN_TYPE_UK[$r['lead_type']] ?? $r['lead_type']) ?><?= $r['title'] ? ': ' . $e($r['title']) : '' ?>
                                            <br><span class="pc-muted"><?= $e($r['source_name'] ?? $r['source_key']) ?><?php if (!empty($r['source_url'])): ?> · <a href="<?= $e($r['source_url']) ?>" target="_blank" rel="noopener noreferrer nofollow">оригінал</a><?php endif; ?>
                                            <?= $r['country'] ? ' · ' . $e($r['country']) : '' ?><?= $r['language'] ? ' · ' . $e($r['language']) : '' ?> · <?= $e(substr((string) $r['found_at'], 0, 10)) ?></span>
                                        </td>
                                        <td data-label="Оцінка"><?= (int) $r['relevance_score'] ?><br><span class="pc-muted"><?= $e($r['relevance_method']) ?></span></td>
                                        <td data-label="Контакти">
                                            <?php if (!empty($r['contact_email'])): ?><?= $e($r['contact_email']) ?><br><?php endif; ?>
                                            <?php if (!empty($r['contact_url'])): ?><a href="<?= $e($r['contact_url']) ?>" target="_blank" rel="noopener noreferrer nofollow">сторінка контактів</a><br><?php endif; ?>
                                            <?php if (!empty($r['contacts_checked_at']) && empty($r['contact_email']) && empty($r['contact_url'])): ?><span class="pc-muted">не знайдено</span><br><?php endif; ?>
                                            <?php if (!empty($r['company_website'])): ?>
                                                <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="lead_contacts"><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="return_tab" value="leads"><button class="pc-btn pc-btn--small" type="submit">Знайти контакти</button></form>
                                            <?php endif; ?>
                                        </td>
                                        <td data-label="Статус">
                                            <form method="post" action="listing-admin-action.php" class="lst-reject"><?= $csrf ?><input type="hidden" name="action" value="lead_update"><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="return_tab" value="leads">
                                                <select class="pc-input" name="status"><?php foreach (OUTREACH_STATUS_UK as $k => $l): ?><option value="<?= $k ?>"<?= $r['status'] === $k ? ' selected' : '' ?>><?= $e($l) ?></option><?php endforeach; ?></select>
                                                <input class="pc-input" type="text" name="notes" maxlength="1000" value="<?= $e($r['notes']) ?>" placeholder="Нотатки">
                                                <input class="pc-input" type="url" name="company_website" maxlength="500" value="<?= $e($r['company_website']) ?>" placeholder="https://сайт компанії">
                                                <button class="pc-btn pc-btn--small" type="submit">Зберегти</button>
                                            </form>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table></div>
                            <?php endif; ?>
                            <?php endif; ?>

                            <div class="pc-grid-2">
                                <form method="post" action="listing-admin-action.php" class="pc-box pc-form">
                                    <?= $csrf ?><input type="hidden" name="action" value="lead_add"><input type="hidden" name="return_tab" value="leads">
                                    <h3 class="pc-h3">Додати лід вручну</h3>
                                    <p><label>Компанія<br><input class="pc-input" type="text" name="company_name" maxlength="190" required></label></p>
                                    <p><label>Сайт<br><input class="pc-input" type="text" name="website" maxlength="500" placeholder="https://"></label></p>
                                    <p><label>Тип <select class="pc-input" name="lead_type"><?php foreach (OUTREACH_LEAD_TYPES as $t): ?><option value="<?= $t ?>"><?= $e(LST_ADMIN_TYPE_UK[$t]) ?></option><?php endforeach; ?></select></label>
                                        <label>Країна <input class="pc-input" type="text" name="country" maxlength="2" size="3" placeholder="UA"></label>
                                        <label>Мова <select class="pc-input" name="language"><option value="">—</option><option>uk</option><option>en</option><option>other</option></select></label></p>
                                    <p><label>Нотатки<br><input class="pc-input" type="text" name="notes" maxlength="1000"></label></p>
                                    <button class="pc-btn pc-btn--primary" type="submit">Додати</button>
                                </form>
                                <form method="post" action="listing-admin-action.php" class="pc-box pc-form" enctype="multipart/form-data">
                                    <?= $csrf ?><input type="hidden" name="action" value="lead_import"><input type="hidden" name="return_tab" value="leads">
                                    <h3 class="pc-h3">Імпорт CSV</h3>
                                    <p class="pc-muted">Колонки (перший рядок — заголовок): <code>company_name,website,lead_type,country,language,notes</code>. lead_type — job, course або service. Дублікати за доменом пропускаються. Не імпортуйте імена людей чи особисті адреси.</p>
                                    <p><input type="file" name="csv" accept=".csv,text/csv"></p>
                                    <p><textarea class="pc-input" name="csv_text" rows="4" placeholder="або вставте CSV сюди"></textarea></p>
                                    <button class="pc-btn" type="submit">Імпортувати</button>
                                </form>
                            </div>
                        </section>

                        <!-- Джерела лідів -->
                        <section class="pc-panel" data-pc-panel="sources"<?= $tab === 'sources' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Лише офіційні публічні API/RSS. Запити — з User-Agent «<?= $e(OUTREACH_UA) ?>», не частіше заданого інтервалу (cron — раз на добу; «Запустити зараз» — не частіше разу на годину), з ETag/Last-Modified. Перед увімкненням перегляньте умови джерела.</p>
                            <div class="pc-table-wrap"><table class="pc-table">
                                <thead><tr><th>Джерело</th><th>Умови</th><th>Останній запуск</th><th>Дії</th></tr></thead>
                                <tbody>
                                <?php foreach ($sources as $s): $k = (string) $s['source_key']; ?>
                                    <tr>
                                        <td data-label="Джерело"><strong><?= $e($s['name']) ?></strong><br><span class="pc-muted"><?= $e($k) ?> · <?= (int) $s['enabled'] === 1 ? 'увімкнено' : 'вимкнено' ?><?= (int) $s['attribution_required'] === 1 ? ' · потрібне посилання на джерело' : '' ?></span></td>
                                        <td data-label="Умови"><span class="pc-muted"><?= $e($s['terms_note']) ?></span></td>
                                        <td data-label="Останній запуск"><?= $s['last_run_at'] ? $e($s['last_run_at']) . '<br>' : '—<br>' ?><span class="pc-muted"><?= $e($s['last_status']) ?></span></td>
                                        <td data-label="Дії">
                                            <form method="post" action="listing-admin-action.php" class="pc-inline-form"<?= $k === 'remotive' && (int) $s['enabled'] === 0 ? ' data-pc-confirm="Умови Remotive просять не передавати їхні вакансії стороннім сайтам. Увімкнути все одно?"' : '' ?>><?= $csrf ?><input type="hidden" name="action" value="source_toggle"><input type="hidden" name="key" value="<?= $e($k) ?>"><input type="hidden" name="return_tab" value="sources"><button class="pc-btn pc-btn--small<?= (int) $s['enabled'] === 1 ? ' pc-btn--danger' : '' ?>" type="submit"><?= (int) $s['enabled'] === 1 ? 'Вимкнути' : 'Увімкнути' ?></button></form>
                                            <?php if ((int) $s['enabled'] === 1): ?>
                                                <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="source_run"><input type="hidden" name="key" value="<?= $e($k) ?>"><input type="hidden" name="return_tab" value="sources"><button class="pc-btn pc-btn--small" type="submit">Запустити зараз</button></form>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table></div>
                            <form method="post" action="listing-admin-action.php" class="pc-box pc-form">
                                <?= $csrf ?><input type="hidden" name="action" value="lead_settings"><input type="hidden" name="return_tab" value="sources">
                                <h3 class="pc-h3">Налаштування лідів</h3>
                                <p><label>Виключені країни (коди ISO через кому; ліди з них не зберігаються)<br><input class="pc-input" type="text" name="outreach_excluded_countries" value="<?= $e(site_setting($pdo, 'outreach_excluded_countries')) ?>" placeholder="напр. RU, BY"></label></p>
                                <p><label>Виключені домени (через кому або з нового рядка)<br><textarea class="pc-input" name="outreach_excluded_domains" rows="3"><?= $e(site_setting($pdo, 'outreach_excluded_domains')) ?></textarea></label></p>
                                <p><label>Компанії Greenhouse / Lever (по одній на рядок: <code>greenhouse:token</code> або <code>lever:company</code>)<br><textarea class="pc-input" name="outreach_ats_boards" rows="3"><?= $e(site_setting($pdo, 'outreach_ats_boards')) ?></textarea></label></p>
                                <p><label><input type="checkbox" name="outreach_ai_classify" value="1"<?= site_setting($pdo, 'outreach_ai_classify', '0') === '1' ? ' checked' : '' ?>> Уточнювати AI-релевантність моделлю для «сірої зони» оцінок (у промпт іде лише назва вакансії; кеш)</label>
                                    <label>ліміт викликів на добу <input class="pc-input" type="number" name="outreach_ai_daily_cap" min="0" max="1000" value="<?= (int) site_setting($pdo, 'outreach_ai_daily_cap', '50') ?>" style="width:6em"></label></p>
                                <button class="pc-btn pc-btn--primary" type="submit">Зберегти</button>
                            </form>
                        </section>
    <?php
    if (function_exists('omail_admin_panels')) {
        omail_admin_panels($pdo, $tab);
    }
}

/**
 * Дії вкладок лідів. $back(bool, list<string>) — повернення з повідомленням (never).
 */
function olead_admin_action(PDO $pdo, string $action, int $actor, callable $back): void
{
    $ids = array_values(array_unique(array_filter(array_map('intval', is_array($_POST['ids'] ?? null) ? $_POST['ids'] : []))));
    $id = (int) ($_POST['id'] ?? 0);
    switch ($action) {
        case 'lead_bulk_approve':
        case 'lead_bulk_reject':
            if ($ids === []) {
                $back(false, ['Нічого не позначено.']);
            }
            $to = $action === 'lead_bulk_approve' ? 'approved' : 'rejected';
            $in = implode(',', array_fill(0, count($ids), '?'));
            $st = $pdo->prepare("UPDATE outreach_leads SET status = ?, last_action_at = NOW() WHERE id IN ($in) AND status IN ('new', 'approved', 'rejected')");
            $st->execute(array_merge([$to], $ids));
            $back(true, [($to === 'approved' ? 'Схвалено для аутрічу: ' : 'Відхилено: ') . $st->rowCount() . '. Листи на цьому кроці НЕ надсилаються.']);
        case 'lead_bulk_contacts':
            if ($ids === []) {
                $back(false, ['Нічого не позначено.']);
            }
            @set_time_limit(120);
            $msgs = [];
            foreach (array_slice($ids, 0, 5) as $one) {
                $r = outreach_find_contacts($pdo, $one);
                $msgs[] = '#' . $one . ': ' . $r['message'];
            }
            $back(true, $msgs);
        case 'lead_contacts':
            @set_time_limit(60);
            $r = outreach_find_contacts($pdo, $id);
            $back($r['ok'], ['#' . $id . ': ' . $r['message']]);
        case 'lead_update':
            $status = (string) ($_POST['status'] ?? '');
            if (!in_array($status, OUTREACH_STATUSES, true)) {
                $back(false, ['Невідомий статус.']);
            }
            $site = trim((string) ($_POST['company_website'] ?? ''));
            if ($site !== '' && !preg_match('~^https?://~i', $site)) {
                $site = 'https://' . $site;
            }
            if ($site !== '' && (filter_var($site, FILTER_VALIDATE_URL) === false || outreach_domain($site) === '')) {
                $back(false, ['Некоректний сайт.']);
            }
            $domain = outreach_domain($site);
            $catalog = outreach_catalog_domains($pdo);
            $pdo->prepare('UPDATE outreach_leads SET status = :s, notes = :n, company_website = :w, company_domain = COALESCE(:d, company_domain),
                           in_catalog = :ic, last_action_at = NOW() WHERE id = :id')
                ->execute([':s' => $status, ':n' => mb_substr(strip_tags((string) ($_POST['notes'] ?? '')), 0, 1000) ?: null,
                    ':w' => $site !== '' ? mb_substr($site, 0, 500) : null, ':d' => $domain !== '' ? $domain : null,
                    ':ic' => $domain !== '' && isset($catalog[$domain]) ? 1 : 0, ':id' => $id]);
            if (function_exists('omail_on_status')) {
                omail_on_status($pdo, $id, $status, $actor);   // відповідь → replied_at; відмова/відписка/відскок → список заборон
            }
            $back(true, ['Лід #' . $id . ' збережено.']);
        case 'lead_add':
            [$lead, $err] = outreach_validate_manual($_POST + ['website' => '']);
            if ($err !== null) {
                $back(false, ['Не додано: ' . $err]);
            }
            $r = outreach_add_manual($pdo, $lead);
            $back($r === 'ok', [$r === 'ok' ? 'Лід додано.' : ($r === 'duplicate' ? 'Така компанія вже є серед лідів.' : 'Країна або домен у списку виключень.')]);
        case 'lead_import':
            $csv = '';
            if (!empty($_FILES['csv']['tmp_name']) && is_uploaded_file($_FILES['csv']['tmp_name']) && (int) $_FILES['csv']['size'] <= 2097152) {
                $csv = (string) file_get_contents($_FILES['csv']['tmp_name']);
            } elseif (trim((string) ($_POST['csv_text'] ?? '')) !== '') {
                $csv = (string) $_POST['csv_text'];
            }
            if ($csv === '') {
                $back(false, ['Немає CSV (файл до 2 МБ або текст).']);
            }
            $r = outreach_import_csv($pdo, $csv);
            $back($r['added'] > 0 || $r['errors'] === [], array_merge(
                [sprintf('Імпорт: додано %d, дублікатів %d, виключено %d, помилок %d.', $r['added'], $r['duplicates'], $r['excluded'], count($r['errors']))],
                array_slice($r['errors'], 0, 10)
            ));
        case 'source_toggle':
            $key = (string) ($_POST['key'] ?? '');
            $st = $pdo->prepare('UPDATE outreach_sources SET enabled = 1 - enabled WHERE source_key = :k');
            $st->execute([':k' => $key]);
            $back($st->rowCount() > 0, ['Джерело ' . $key . ': перемкнуто.']);
        case 'source_run':
            $st = $pdo->prepare('SELECT * FROM outreach_sources WHERE source_key = :k');
            $st->execute([':k' => (string) ($_POST['key'] ?? '')]);
            $src = $st->fetch(PDO::FETCH_ASSOC);
            if ($src === false) {
                $back(false, ['Невідоме джерело.']);
            }
            @set_time_limit(180);
            $msg = outreach_run_source($pdo, $src, true);
            $back(!str_contains($msg, 'помилка'), [$msg]);
        case 'lead_settings':
            $countries = implode(', ', array_filter(array_map(static fn($c) => preg_match('/^[A-Z]{2}$/', $c) === 1 ? $c : '', array_map('strtoupper', array_map('trim', preg_split('/[\s,;]+/', (string) ($_POST['outreach_excluded_countries'] ?? '')) ?: [])))));
            $domains = implode("\n", array_filter(array_map(static fn($d) => outreach_domain($d), preg_split('/[\s,;]+/', (string) ($_POST['outreach_excluded_domains'] ?? '')) ?: [])));
            $boards = implode("\n", array_filter(array_map('trim', preg_split('/\r\n|\n|\r/', strtolower((string) ($_POST['outreach_ats_boards'] ?? ''))) ?: []), static fn($l) => preg_match('/^(greenhouse|lever):[a-z0-9_-]{2,60}$/', $l) === 1));
            site_settings_save($pdo, [
                'outreach_excluded_countries' => $countries,
                'outreach_excluded_domains' => $domains,
                'outreach_ats_boards' => $boards,
                'outreach_ai_classify' => ($_POST['outreach_ai_classify'] ?? '') === '1' ? '1' : '0',
                'outreach_ai_daily_cap' => (string) max(0, min(1000, (int) ($_POST['outreach_ai_daily_cap'] ?? 50))),
            ]);
            $back(true, ['Налаштування лідів збережено.']);
    }
    if (function_exists('omail_admin_action')) {
        omail_admin_action($pdo, $action, $actor, $back);
    }
}

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вкладки аутрічу (блок M3) у розділі «Маркетплейс: оголошення» (лише admin):
 *   «Аутріч» (схвалені ліди → чернетки → схвалення людиною → черга; ручна відправка; надіслані),
 *   «Налаштування аутрічу» (умови ввімкнення, ліміти, вікно, шаблони UA/EN), «Список заборон», «Показники аутрічу».
 * Підключається з app/listing-admin-cabinet.php; дії — omail_admin_action() через public/listing-admin-action.php.
 */

require_once __DIR__ . '/outreach-mail.php';

/** @return array<string,string> */
function omail_admin_tabs(): array
{
    return ['outreach' => 'Аутріч', 'osettings' => 'Налаштування аутрічу', 'suppress' => 'Список заборон', 'ometrics' => 'Показники аутрічу'];
}

/** @return array<string,string> */
function omail_cron_jobs(): array
{
    return ['outreach-send' => 'Аутріч: перенесення схвалених листів у чергу пошти за правилами (кожні 5–10 хв)'];
}

function omail_admin_panels(PDO $pdo, string $tab): void
{
    try {
        $pdo->query('SELECT 1 FROM outreach_messages LIMIT 1');
    } catch (Throwable $e) {
        echo '<section class="pc-panel" data-pc-panel="outreach"' . ($tab === 'outreach' ? '' : ' hidden') . '><p class="pc-warn-text">Застосуйте міграцію database/migration-2026-10-21-outreach-mail.sql.</p></section>';

        return;
    }
    $e = static fn($v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $csrf = mp_csrf_field();
    $s = omail_settings($pdo);
    $issues = omail_ready_issues($pdo);
    $enabled = $s['enabled'] === '1';
    $metrics = omail_metrics($pdo);
    $approvedLeads = $pdo->query(
        "SELECT * FROM outreach_leads WHERE status = 'approved' ORDER BY relevance_score DESC, id LIMIT 100"
    )->fetchAll(PDO::FETCH_ASSOC);
    $drafts = $pdo->query(
        "SELECT m.*, l.company_name, l.company_domain, l.contact_url, l.title, l.source_name, l.in_catalog FROM outreach_messages m JOIN outreach_leads l ON l.id = m.lead_id
         WHERE m.status = 'draft' ORDER BY m.kind, m.id LIMIT 50"
    )->fetchAll(PDO::FETCH_ASSOC);
    $queued = $pdo->query(
        "SELECT m.*, l.company_name, u.email AS approver FROM outreach_messages m JOIN outreach_leads l ON l.id = m.lead_id LEFT JOIN users u ON u.id = m.approved_by
         WHERE m.status = 'queued' ORDER BY m.approved_at, m.id"
    )->fetchAll(PDO::FETCH_ASSOC);
    $sent = $pdo->query(
        "SELECT m.*, l.company_name, l.status AS lead_status, u.email AS approver, q.status AS q_status, q.last_error
         FROM outreach_messages m JOIN outreach_leads l ON l.id = m.lead_id LEFT JOIN users u ON u.id = m.approved_by LEFT JOIN mail_queue q ON q.id = m.mail_queue_id
         WHERE m.status IN ('sent', 'sent_manual', 'failed') ORDER BY m.sent_at DESC LIMIT 50"
    )->fetchAll(PDO::FETCH_ASSOC);
    $manual = $_SESSION['omail_manual'] ?? null;
    unset($_SESSION['omail_manual']);
    $templates = [];
    foreach ($pdo->query('SELECT * FROM outreach_templates ORDER BY template_key DESC, lang DESC') as $t) {
        $templates[] = $t;
    }
    $supp = $tab === 'suppress' ? $pdo->query('SELECT * FROM outreach_suppression ORDER BY id DESC LIMIT 300')->fetchAll(PDO::FETCH_ASSOC) : [];
    $suppCount = (int) $pdo->query('SELECT COUNT(*) FROM outreach_suppression')->fetchColumn();
    ?>
                        <!-- Аутріч -->
                        <section class="pc-panel" data-pc-panel="outreach"<?= $tab === 'outreach' ? '' : ' hidden' ?>>
                            <div class="pc-box <?= $enabled && $issues === [] ? 'pc-box--accent' : '' ?>">
                                <p><strong>Аутріч: <?= $enabled ? ($issues === [] ? 'УВІМКНЕНО' : 'увімкнено, але не налаштовано — листи не йдуть') : 'ВИМКНЕНО' ?></strong>
                                    <span class="pc-muted">Кожен лист схвалює людина. Диспетчер переносить у чергу пошти не більше одного листа за запуск: робочі години <?= (int) $s['window_start'] ?>:00–<?= (int) $s['window_end'] ?>:00 (Київ, пн–пт), пауза <?= (int) $s['pause_min'] ?>–<?= (int) $s['pause_max'] ?> хв, ліміт сьогодні <?= omail_sent_today($pdo) ?> / <?= omail_effective_cap($pdo) ?>.</span></p>
                                <?php foreach ($issues as $i): ?><p class="pc-warn-text"><?= $e($i) ?></p><?php endforeach; ?>
                                <?php foreach ($metrics['warnings'] as $w): ?><p class="pc-warn-text"><strong>⚠ <?= $e($w) ?></strong></p><?php endforeach; ?>
                            </div>
                            <?php if (is_array($manual)): ?>
                                <div class="pc-box">
                                    <h3 class="pc-h3">Текст для ручної відправки через форму контактів (лист #<?= (int) $manual['id'] ?>)</h3>
                                    <p class="pc-muted">Сторінка контактів: <?php if (!empty($manual['contact_url'])): ?><a href="<?= $e($manual['contact_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= $e($manual['contact_url']) ?></a><?php else: ?>—<?php endif; ?>. Скопіюйте тему й текст, надішліть через форму, потім позначте «надіслано вручну».</p>
                                    <p><input class="pc-input" type="text" readonly value="<?= $e($manual['subject']) ?>" onclick="this.select()"></p>
                                    <p><textarea class="pc-input" rows="12" readonly onclick="this.select()"><?= $e($manual['body']) ?></textarea></p>
                                    <form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="omail_manual_done"><input type="hidden" name="id" value="<?= (int) $manual['id'] ?>"><input type="hidden" name="return_tab" value="outreach"><button class="pc-btn pc-btn--primary" type="submit">Позначити: надіслано вручну</button></form>
                                </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">1. Схвалені ліди без чернетки (<?= count($approvedLeads) ?>)</h3>
                            <?php if ($approvedLeads === []): ?>
                                <p class="pc-empty">Немає. Схваліть ліди у вкладці «Ліди».</p>
                            <?php else: ?>
                                <form method="post" action="listing-admin-action.php" class="pc-inline-form" id="omailPrep"><?= $csrf ?><input type="hidden" name="action" value="omail_prepare_bulk"><input type="hidden" name="return_tab" value="outreach"><button class="pc-btn pc-btn--small" type="submit">Підготувати чернетки для позначених (до 10)</button></form>
                                <div class="pc-table-wrap"><table class="pc-table">
                                    <thead><tr><th>✓</th><th>Компанія</th><th>Контакт</th><th>Дія</th></tr></thead><tbody>
                                    <?php foreach ($approvedLeads as $l): ?>
                                        <tr>
                                            <td data-label="✓"><input type="checkbox" name="ids[]" value="<?= (int) $l['id'] ?>" form="omailPrep"></td>
                                            <td data-label="Компанія"><?= $e($l['company_name']) ?><?= (int) $l['in_catalog'] === 1 ? ' <span class="pc-badge pc-badge--pending">уже в каталозі</span>' : '' ?><br><span class="pc-muted"><?= $e(LST_ADMIN_TYPE_UK[$l['lead_type']] ?? '') ?><?= $l['title'] ? ': ' . $e($l['title']) : '' ?></span></td>
                                            <td data-label="Контакт"><?= $l['contact_email'] ? $e($l['contact_email']) : ($l['contact_url'] ? 'лише форма' : '<span class="pc-warn-text">немає — знайдіть контакти у вкладці «Ліди»</span>') ?></td>
                                            <td data-label="Дія"><form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="omail_prepare"><input type="hidden" name="id" value="<?= (int) $l['id'] ?>"><input type="hidden" name="return_tab" value="outreach"><button class="pc-btn pc-btn--small" type="submit">Підготувати чернетку</button></form></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    </tbody></table></div>
                            <?php endif; ?>

                            <h3 class="pc-h3">2. Чернетки — перегляньте, відредагуйте й схваліть (<?= count($drafts) ?>)</h3>
                            <p class="pc-muted">{sender_name}, {sender_role}, {legal_address}, {free_until}, {site_url} і посилання {join_url}, {unsubscribe_url} підставляються в момент відправки (з актуальних налаштувань; окремі токени для кожного листа). Перед відправкою ще раз перевіряється список заборон.</p>
                            <?php if ($drafts === []): ?><p class="pc-empty">Чернеток немає.</p><?php endif; ?>
                            <?php foreach ($drafts as $d): $did = (int) $d['id']; ?>
                                <article class="pc-mod lst-mod">
                                    <p><strong>#<?= $did ?> · <?= $d['kind'] === 'followup' ? 'Нагадування' : 'Перший лист' ?> · <?= $e($d['company_name']) ?></strong>
                                        <span class="pc-muted"> · <?= $e($d['lang']) ?> · кому: <?= $d['to_email'] ? $e($d['to_email']) : 'адреси немає — ручна відправка через форму' ?><?= (int) $d['paraphrased'] === 1 ? ' · перефразовано моделлю' : '' ?></span></p>
                                    <form method="post" action="listing-admin-action.php" class="pc-form"><?= $csrf ?><input type="hidden" name="id" value="<?= $did ?>"><input type="hidden" name="return_tab" value="outreach">
                                        <p><input class="pc-input" type="text" name="subject" maxlength="200" value="<?= $e($d['subject']) ?>" aria-label="Тема"></p>
                                        <p><textarea class="pc-input" name="body" rows="12" aria-label="Текст"><?= $e($d['body']) ?></textarea></p>
                                        <div class="lst-mod__actions">
                                            <button class="pc-btn pc-btn--small" type="submit" name="action" value="omail_save">Зберегти</button>
                                            <?php if ($d['to_email']): ?>
                                                <button class="pc-btn pc-btn--primary" type="submit" name="action" value="omail_approve">Схвалити й поставити в чергу</button>
                                            <?php else: ?>
                                                <button class="pc-btn pc-btn--primary" type="submit" name="action" value="omail_manual">Підготувати текст для ручної відправки</button>
                                            <?php endif; ?>
                                            <button class="pc-btn pc-btn--small pc-btn--danger" type="submit" name="action" value="omail_cancel">Скасувати</button>
                                        </div>
                                    </form>
                                </article>
                            <?php endforeach; ?>

                            <h3 class="pc-h3">3. Черга (схвалено, чекає відправки за правилами) — <?= count($queued) ?></h3>
                            <?php if ($queued === []): ?><p class="pc-empty">Черга порожня.</p><?php else: ?>
                                <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>#</th><th>Компанія</th><th>Схвалив</th><th>Дія</th></tr></thead><tbody>
                                <?php foreach ($queued as $q): ?>
                                    <tr><td data-label="#"><?= (int) $q['id'] ?></td><td data-label="Компанія"><?= $e($q['company_name']) ?> · <?= $e($q['to_email']) ?><br><span class="pc-muted"><?= $e($q['subject']) ?></span></td>
                                        <td data-label="Схвалив"><?= $e($q['approver'] ?? '—') ?><br><span class="pc-muted"><?= $e($q['approved_at']) ?> UTC</span></td>
                                        <td data-label="Дія"><form method="post" action="listing-admin-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="omail_cancel"><input type="hidden" name="id" value="<?= (int) $q['id'] ?>"><input type="hidden" name="return_tab" value="outreach"><button class="pc-btn pc-btn--small pc-btn--danger" type="submit">Скасувати</button></form></td></tr>
                                <?php endforeach; ?>
                                </tbody></table></div>
                            <?php endif; ?>

                            <h3 class="pc-h3">4. Надіслані (останні 50)</h3>
                            <p class="pc-muted">Відповіді приходять на <?= $e($s['reply_to']) ?>. Статус ліду (відповіли, розмістили, відмовились, відскок) змінюйте вручну у вкладці «Ліди»; відмова й відписка автоматично додають адресу й домен у список заборон.</p>
                            <?php if ($sent === []): ?><p class="pc-empty">Ще нічого не надіслано.</p><?php else: ?>
                                <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>#</th><th>Компанія</th><th>Коли / хто схвалив</th><th>Результат</th></tr></thead><tbody>
                                <?php foreach ($sent as $m): ?>
                                    <tr><td data-label="#"><?= (int) $m['id'] ?> <?= $m['kind'] === 'followup' ? '(нагадування)' : '' ?></td><td data-label="Компанія"><?= $e($m['company_name']) ?><br><span class="pc-muted"><?= $e($m['to_email'] ?? 'форма контактів') ?></span></td>
                                        <td data-label="Коли"><?= $e($m['sent_at']) ?> UTC<br><span class="pc-muted"><?= $e($m['approver'] ?? '—') ?></span></td>
                                        <td data-label="Результат"><?= $e(['sent' => 'передано у відправку', 'sent_manual' => 'надіслано вручну', 'failed' => 'помилка'][$m['status']] ?? $m['status']) ?><?= $m['q_status'] ? ' · пошта: ' . $e($m['q_status']) : '' ?><?= $m['last_error'] ? '<br><span class="pc-warn-text">' . $e($m['last_error']) . '</span>' : '' ?><br><span class="pc-muted">лід: <?= $e(OUTREACH_STATUS_UK[$m['lead_status']] ?? $m['lead_status']) ?></span></td></tr>
                                <?php endforeach; ?>
                                </tbody></table></div>
                            <?php endif; ?>
                        </section>

                        <!-- Налаштування аутрічу -->
                        <section class="pc-panel" data-pc-panel="osettings"<?= $tab === 'osettings' ? '' : ' hidden' ?>>
                            <div class="pc-box">
                                <p><strong>Правила розсилок залежать від країни.</strong> Ділові листи компаніям у різних країнах регулюються по-різному
                                    (наприклад, вимоги до згоди, ідентифікації відправника й відписки). Перед увімкненням перегляньте правила своєї країни
                                    й країн одержувачів; рекомендуємо коротку консультацію юриста. Список виключених країн — у вкладці «Джерела лідів».</p>
                            </div>
                            <form method="post" action="listing-admin-action.php" class="pc-box pc-form">
                                <?= $csrf ?><input type="hidden" name="action" value="omail_settings"><input type="hidden" name="return_tab" value="osettings">
                                <h3 class="pc-h3">Відправник і адреси</h3>
                                <p><label>Ім'я відправника<br><input class="pc-input" type="text" name="sender_name" maxlength="100" value="<?= $e($s['sender_name']) ?>"></label></p>
                                <p><label>Роль відправника<br><input class="pc-input" type="text" name="sender_role" maxlength="100" value="<?= $e($s['sender_role']) ?>" placeholder="напр. менеджер партнерств"></label></p>
                                <p><label>Юридична чи поштова адреса відправника (виводиться в кожному листі)<br><input class="pc-input" type="text" name="legal_address" maxlength="300" value="<?= $e($s['legal_address']) ?>"></label></p>
                                <p><label>Адреса для відписки (mailto у заголовку List-Unsubscribe)<br><input class="pc-input" type="email" name="unsubscribe_email" maxlength="190" value="<?= $e($s['unsubscribe_email']) ?>" placeholder="partners@ailabhub-directory.com"></label></p>
                                <p><label>Адреса для відповідей (Reply-To) — окрема від листів рекламодавцям<br><input class="pc-input" type="email" name="reply_to" maxlength="190" value="<?= $e($s['reply_to']) ?>"></label></p>
                                <p><label>Адреса відправника (From); має бути налаштована в SPF/DKIM/DMARC — див. docs/OUTREACH_PLAYBOOK.md<br><input class="pc-input" type="email" name="from_email" maxlength="190" value="<?= $e($s['from_email']) ?>"></label></p>
                                <h3 class="pc-h3">Ліміти й вікно</h3>
                                <p><label>Стеля листів на добу <input class="pc-input" type="number" name="daily_cap" min="0" max="200" value="<?= (int) $s['daily_cap'] ?>" style="width:6em"></label>
                                    <label>Графік розгону по тижнях (через кому) <input class="pc-input" type="text" name="rampup" maxlength="100" value="<?= $e($s['rampup']) ?>"></label></p>
                                <p class="pc-muted">Діє менше з двох: стеля або значення поточного тижня розгону (тиждень 1 — від першого ввімкнення<?= $s['ramp_start'] !== '' ? ', ' . $e($s['ramp_start']) : '' ?>). Сьогодні: <?= omail_effective_cap($pdo) ?>.</p>
                                <p><label>Пауза між листами, хв: від <input class="pc-input" type="number" name="pause_min" min="1" max="120" value="<?= (int) $s['pause_min'] ?>" style="width:5em"></label>
                                    <label>до <input class="pc-input" type="number" name="pause_max" min="1" max="240" value="<?= (int) $s['pause_max'] ?>" style="width:5em"></label></p>
                                <p><label>Вікно відправки (Київ, пн–пт), год: з <input class="pc-input" type="number" name="window_start" min="0" max="23" value="<?= (int) $s['window_start'] ?>" style="width:5em"></label>
                                    <label>до <input class="pc-input" type="number" name="window_end" min="1" max="24" value="<?= (int) $s['window_end'] ?>" style="width:5em"></label></p>
                                <p><label>Одне нагадування через, днів без відповіді <input class="pc-input" type="number" name="followup_days" min="3" max="30" value="<?= (int) $s['followup_days'] ?>" style="width:5em"></label></p>
                                <p><label><input type="checkbox" name="paraphrase" value="1"<?= $s['paraphrase'] === '1' ? ' checked' : '' ?>> Перефразовувати шаблон моделлю (коротко, ввічливо, фактично; до <?= OMAIL_MAX_WORDS ?> слів; у промпт іде лише шаблон зі змінними, без персональних даних)</label></p>
                                <p><label><input type="checkbox" name="rules_ack" value="1"<?= $s['rules_ack'] !== '' ? ' checked' : '' ?>> Я переглянув(ла) правила розсилок у своїй країні й країні одержувачів; рекомендовано перевірку юриста.</label>
                                    <?= $s['rules_ack'] !== '' ? '<span class="pc-muted">(' . $e($s['rules_ack']) . ')</span>' : '' ?></p>
                                <button class="pc-btn pc-btn--primary" type="submit">Зберегти</button>
                            </form>
                            <form method="post" action="listing-admin-action.php" class="pc-box pc-inline-form" data-pc-confirm="<?= $enabled ? 'Вимкнути аутріч? Листи в черзі чекатимуть.' : 'Увімкнути аутріч? Схвалені листи почнуть іти за правилами.' ?>">
                                <?= $csrf ?><input type="hidden" name="action" value="omail_toggle"><input type="hidden" name="return_tab" value="osettings">
                                <strong>Аутріч: <?= $enabled ? 'увімкнено' : 'вимкнено' ?></strong>
                                <button class="pc-btn <?= $enabled ? 'pc-btn--danger' : 'pc-btn--primary' ?>" type="submit"<?= !$enabled && $issues !== [] ? ' disabled title="Спершу заповніть усі обов\'язкові поля"' : '' ?>><?= $enabled ? 'Вимкнути' : 'Увімкнути' ?></button>
                                <?php if (!$enabled && $issues !== []): ?><span class="pc-warn-text">Увімкнути можна, коли виконано всі умови: <?= $e(implode(' ', $issues)) ?></span><?php endif; ?>
                            </form>
                            <h3 class="pc-h3">Шаблони листів</h3>
                            <p class="pc-muted">Змінні: <?= $e(implode(', ', array_map(static fn($v) => '{' . $v . '}', OMAIL_VARS))) ?>. {unsubscribe_url} обов'язкова (якщо її прибрати, рядок відписки додасться автоматично). Без тверджень про розмір аудиторії чи результати.</p>
                            <?php foreach ($templates as $t): ?>
                                <form method="post" action="listing-admin-action.php" class="pc-box pc-form"><?= $csrf ?><input type="hidden" name="action" value="omail_template"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>"><input type="hidden" name="return_tab" value="osettings">
                                    <p><strong><?= $t['template_key'] === 'invite' ? 'Запрошення' : 'Нагадування' ?> · <?= $e(strtoupper($t['lang'])) ?></strong> <span class="pc-muted">змінено <?= $e($t['updated_at']) ?></span></p>
                                    <p><input class="pc-input" type="text" name="subject" maxlength="200" value="<?= $e($t['subject']) ?>" aria-label="Тема"></p>
                                    <p><textarea class="pc-input" name="body" rows="12" aria-label="Текст"><?= $e($t['body']) ?></textarea></p>
                                    <button class="pc-btn pc-btn--small" type="submit">Зберегти шаблон</button>
                                </form>
                            <?php endforeach; ?>
                        </section>

                        <!-- Список заборон -->
                        <section class="pc-panel" data-pc-panel="suppress"<?= $tab === 'suppress' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Перевіряється перед кожною відправкою (адреса, її домен і батьківські домени). Записів: <?= $suppCount ?>. <a href="outreach-export.php?report=suppression">Експорт CSV</a></p>
                            <div class="pc-grid-2">
                                <form method="post" action="listing-admin-action.php" class="pc-box pc-form"><?= $csrf ?><input type="hidden" name="action" value="omail_suppress"><input type="hidden" name="return_tab" value="suppress">
                                    <h3 class="pc-h3">Додати</h3>
                                    <p><select class="pc-input" name="kind"><option value="email">адреса</option><option value="domain">домен</option></select>
                                        <input class="pc-input" type="text" name="value" maxlength="190" required placeholder="info@company.com або company.com"></p>
                                    <p><select class="pc-input" name="reason"><?php foreach (OMAIL_SUPPRESS_REASONS as $k => $l): ?><option value="<?= $k ?>"<?= $k === 'manual' ? ' selected' : '' ?>><?= $e($l) ?></option><?php endforeach; ?></select>
                                        <input class="pc-input" type="text" name="note" maxlength="300" placeholder="Нотатка"></p>
                                    <button class="pc-btn pc-btn--primary" type="submit">Додати</button>
                                </form>
                                <form method="post" action="listing-admin-action.php" class="pc-box pc-form" enctype="multipart/form-data"><?= $csrf ?><input type="hidden" name="action" value="omail_suppress_import"><input type="hidden" name="return_tab" value="suppress">
                                    <h3 class="pc-h3">Імпорт CSV</h3>
                                    <p class="pc-muted">Колонки: <code>kind,value,reason,note</code> (kind — email або domain; reason — <?= $e(implode(', ', array_keys(OMAIL_SUPPRESS_REASONS))) ?>).</p>
                                    <p><input type="file" name="csv" accept=".csv,text/csv"></p>
                                    <p><textarea class="pc-input" name="csv_text" rows="3" placeholder="або вставте CSV"></textarea></p>
                                    <button class="pc-btn" type="submit">Імпортувати</button>
                                </form>
                            </div>
                            <form method="post" action="listing-admin-action.php" class="pc-box pc-inline-form" data-pc-confirm="Знеособити всі дані компанії й заборонити листи на її домен?"><?= $csrf ?><input type="hidden" name="action" value="omail_erase"><input type="hidden" name="return_tab" value="suppress">
                                <strong>Видалення компанії на прохання:</strong>
                                <input class="pc-input" type="text" name="value" maxlength="190" required placeholder="домен або адреса компанії">
                                <button class="pc-btn pc-btn--danger pc-btn--small" type="submit">Видалити дані й заборонити листи</button>
                                <span class="pc-muted">Домен і адреси лишаються лише в списку заборон (щоб більше не писати); назва, сайт, контакти, нотатки й тексти листів знеособлюються.</span>
                            </form>
                            <?php if ($supp !== []): ?>
                                <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Що</th><th>Причина</th><th>Коли</th></tr></thead><tbody>
                                <?php foreach ($supp as $r): ?>
                                    <tr><td data-label="Що"><?= $e($r['kind'] === 'domain' ? 'домен' : 'адреса') ?>: <?= $e($r['value']) ?></td><td data-label="Причина"><?= $e(OMAIL_SUPPRESS_REASONS[$r['reason']] ?? $r['reason']) ?><?= $r['note'] ? '<br><span class="pc-muted">' . $e($r['note']) . '</span>' : '' ?></td><td data-label="Коли"><?= $e($r['created_at']) ?></td></tr>
                                <?php endforeach; ?>
                                </tbody></table></div>
                            <?php elseif ($tab !== 'suppress'): ?>
                                <p><a class="pc-btn" href="account.php?ladm_tab=suppress#acc-listings-admin">Показати список</a></p>
                            <?php endif; ?>
                        </section>

                        <!-- Показники аутрічу -->
                        <section class="pc-panel" data-pc-panel="ometrics"<?= $tab === 'ometrics' ? '' : ' hidden' ?>>
                            <?php foreach ($metrics['warnings'] as $w): ?><p class="pc-warn-text"><strong>⚠ <?= $e($w) ?></strong></p><?php endforeach; ?>
                            <p class="pc-muted">За 30 днів: передано у відправку <?= $metrics['sent30'] ?>, відписок <?= $metrics['unsub30'] ?>, відскоків <?= $metrics['bounce30'] ?>.
                                Середній час відповіді: <?= $metrics['avg_reply_hours'] !== null ? $metrics['avg_reply_hours'] . ' год' : '—' ?>. <a href="outreach-export.php?report=metrics">Експорт CSV</a></p>
                            <h3 class="pc-h3">Воронка (ліди за статусами)</h3>
                            <p><?php foreach (OUTREACH_STATUS_UK as $k => $l): ?><span class="pc-badge"><?= $e($l) ?>: <?= (int) ($metrics['funnel'][$k] ?? 0) ?></span> <?php endforeach; ?></p>
                            <h3 class="pc-h3">По тижнях</h3>
                            <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Тиждень з</th><th>Надіслано</th><th>Відповіли</th><th>Розмістили</th><th>Відписались</th><th>Відскоки</th></tr></thead><tbody>
                            <?php foreach ($metrics['weeks'] as $w): ?>
                                <tr><td data-label="Тиждень"><?= $e($w['week']) ?></td><td data-label="Надіслано"><?= $w['sent'] ?></td><td data-label="Відповіли"><?= $w['replied'] ?></td><td data-label="Розмістили"><?= $w['listed'] ?></td><td data-label="Відписались"><?= $w['unsubscribed'] ?></td><td data-label="Відскоки"><?= $w['bounced'] ?></td></tr>
                            <?php endforeach; ?>
                            </tbody></table></div>
                            <h3 class="pc-h3">Джерела</h3>
                            <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Джерело</th><th>Лідів</th><th>Написали</th><th>Відповіли</th><th>Розмістили</th></tr></thead><tbody>
                            <?php foreach ($metrics['sources'] as $r): ?>
                                <tr><td data-label="Джерело"><?= $e($r['source_key']) ?></td><td data-label="Лідів"><?= (int) $r['leads'] ?></td><td data-label="Написали"><?= (int) $r['contacted'] ?></td><td data-label="Відповіли"><?= (int) $r['replied'] ?></td><td data-label="Розмістили"><?= (int) $r['listed'] ?></td></tr>
                            <?php endforeach; ?>
                            </tbody></table></div>
                            <h3 class="pc-h3">Шаблони</h3>
                            <div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Шаблон</th><th>Надіслано</th><th>Відповіли</th><th>Розмістили</th></tr></thead><tbody>
                            <?php foreach ($metrics['templates'] as $r): ?>
                                <tr><td data-label="Шаблон"><?= $e($r['template_key'] . ' · ' . $r['lang'] . ((int) $r['paraphrased'] === 1 ? ' · перефразовано' : '')) ?></td><td data-label="Надіслано"><?= (int) $r['sent'] ?></td><td data-label="Відповіли"><?= (int) $r['replied'] ?></td><td data-label="Розмістили"><?= (int) $r['listed'] ?></td></tr>
                            <?php endforeach; ?>
                            </tbody></table></div>
                        </section>
    <?php
}

/** Дії вкладок аутрічу. $back(bool, list<string>) — повернення (never). */
function omail_admin_action(PDO $pdo, string $action, int $actor, callable $back): void
{
    $id = (int) ($_POST['id'] ?? 0);
    switch ($action) {
        case 'omail_prepare':
            $r = omail_prepare_draft($pdo, $id, $actor);
            $back($r['ok'], ['Лід #' . $id . ': ' . $r['message'] . '.']);
        case 'omail_prepare_bulk':
            $ids = array_slice(array_values(array_unique(array_filter(array_map('intval', is_array($_POST['ids'] ?? null) ? $_POST['ids'] : [])))), 0, 10);
            if ($ids === []) {
                $back(false, ['Нічого не позначено.']);
            }
            $msgs = [];
            foreach ($ids as $one) {
                $msgs[] = '#' . $one . ': ' . omail_prepare_draft($pdo, $one, $actor)['message'];
            }
            $back(true, $msgs);
        case 'omail_save':
            $ok = omail_update_draft($pdo, $id, (string) ($_POST['subject'] ?? ''), (string) ($_POST['body'] ?? ''), $actor);
            $back($ok, [$ok ? 'Чернетку #' . $id . ' збережено.' : 'Тема й текст не можуть бути порожніми.']);
        case 'omail_approve':
            omail_update_draft($pdo, $id, (string) ($_POST['subject'] ?? ''), (string) ($_POST['body'] ?? ''), $actor);
            $r = omail_approve($pdo, $id, $actor);
            $back($r === 'ok', [$r === 'ok' ? 'Лист #' . $id . ' схвалено й поставлено в чергу. Він піде за правилами (вікно, ліміт, пауза), якщо аутріч увімкнено.' : 'Не схвалено: ' . $r . '.']);
        case 'omail_manual':
            omail_update_draft($pdo, $id, (string) ($_POST['subject'] ?? ''), (string) ($_POST['body'] ?? ''), $actor);
            $fin = omail_manual_text($pdo, $id);
            if ($fin === null) {
                $back(false, ['Чернетку не знайдено.']);
            }
            $m = omail_message($pdo, $id);
            $_SESSION['omail_manual'] = ['id' => $id, 'subject' => $fin['subject'], 'body' => $fin['body'], 'contact_url' => $m['contact_url'] ?? ''];
            $back(true, ['Текст для ручної відправки готовий (див. угорі вкладки).']);
        case 'omail_manual_done':
            $ok = omail_mark_manual($pdo, $id, $actor);
            $back($ok, [$ok ? 'Лист #' . $id . ' позначено як надісланий вручну.' : 'Не вдалося (чернетку вже оброблено або домен у списку заборон).']);
        case 'omail_cancel':
            $ok = omail_cancel($pdo, $id, $actor);
            $back($ok, [$ok ? 'Лист #' . $id . ' скасовано.' : 'Не вдалося скасувати.']);
        case 'omail_settings':
            $g = static fn(string $k, int $max = 300): string => mb_substr(trim(strip_tags((string) ($_POST[$k] ?? ''))), 0, $max);
            $emails = [];
            foreach (['unsubscribe_email', 'reply_to', 'from_email'] as $k) {
                $v = $g($k, 190);
                if ($v !== '' && filter_var($v, FILTER_VALIDATE_EMAIL) === false) {
                    $back(false, ['Некоректна адреса: ' . $v]);
                }
                $emails['outreach_' . $k] = $v;
            }
            $ramp = implode(',', array_filter(array_map(static fn($x) => (string) max(0, min(500, (int) $x)), explode(',', $g('rampup', 100))), static fn($x) => $x !== '0'));
            $pMin = max(1, min(120, (int) $g('pause_min')));
            $wStart = max(0, min(23, (int) $g('window_start')));
            $prevAck = site_setting($pdo, 'outreach_rules_ack', '');
            site_settings_save($pdo, $emails + [
                'outreach_sender_name' => $g('sender_name', 100), 'outreach_sender_role' => $g('sender_role', 100), 'outreach_legal_address' => $g('legal_address'),
                'outreach_daily_cap' => (string) max(0, min(200, (int) $g('daily_cap'))), 'outreach_rampup' => $ramp,
                'outreach_pause_min' => (string) $pMin, 'outreach_pause_max' => (string) max($pMin, min(240, (int) $g('pause_max'))),
                'outreach_window_start' => (string) $wStart, 'outreach_window_end' => (string) max($wStart + 1, min(24, (int) $g('window_end'))),
                'outreach_followup_days' => (string) max(3, min(30, (int) $g('followup_days'))),
                'outreach_paraphrase' => ($_POST['paraphrase'] ?? '') === '1' ? '1' : '0',
                'outreach_rules_ack' => ($_POST['rules_ack'] ?? '') === '1' ? ($prevAck !== '' ? $prevAck : gmdate('Y-m-d H:i') . ' UTC, user #' . $actor) : '',
            ]);
            omail_log($pdo, null, $actor, 'settings');
            if (omail_ready_issues($pdo) !== [] && site_setting($pdo, 'outreach_enabled', '0') === '1') {
                site_settings_save($pdo, ['outreach_enabled' => '0']);
                $back(false, ['Налаштування збережено, але не всі умови виконано — аутріч вимкнено.']);
            }
            $back(true, ['Налаштування аутрічу збережено.']);
        case 'omail_toggle':
            $on = site_setting($pdo, 'outreach_enabled', '0') === '1';
            if (!$on && ($issues = omail_ready_issues($pdo)) !== []) {
                $back(false, array_merge(['Аутріч не ввімкнено. Бракує:'], $issues));
            }
            $vals = ['outreach_enabled' => $on ? '0' : '1'];
            if (!$on && site_setting($pdo, 'outreach_ramp_start', '') === '') {
                $vals['outreach_ramp_start'] = gmdate('Y-m-d');
            }
            site_settings_save($pdo, $vals);
            omail_log($pdo, null, $actor, $on ? 'disabled' : 'enabled');
            $back(true, [$on ? 'Аутріч вимкнено.' : 'Аутріч увімкнено. Листи йтимуть лише ті, які схвалено, за правилами.']);
        case 'omail_template':
            $subject = mb_substr(trim(strip_tags((string) ($_POST['subject'] ?? ''))), 0, 200);
            $body = mb_substr(trim(strip_tags(str_replace("\r\n", "\n", (string) ($_POST['body'] ?? '')))), 0, 6000);
            if ($subject === '' || $body === '') {
                $back(false, ['Тема й текст шаблону не можуть бути порожніми.']);
            }
            $pdo->prepare('UPDATE outreach_templates SET subject = :s, body = :b, updated_by = :a WHERE id = :id')->execute([':s' => $subject, ':b' => $body, ':a' => $actor, ':id' => $id]);
            omail_log($pdo, null, $actor, 'template', '#' . $id);
            $back(true, ['Шаблон збережено.' . (str_contains($body, '{unsubscribe_url}') ? '' : ' Увага: немає {unsubscribe_url} — рядок відписки додаватиметься автоматично.')]);
        case 'omail_suppress':
            $ok = omail_suppress($pdo, (string) ($_POST['kind'] ?? ''), (string) ($_POST['value'] ?? ''), (string) ($_POST['reason'] ?? 'manual'), (string) ($_POST['note'] ?? ''), $actor);
            $back($ok, [$ok ? 'Додано до списку заборон.' : 'Некоректна адреса або домен.']);
        case 'omail_suppress_import':
            $csv = !empty($_FILES['csv']['tmp_name']) && is_uploaded_file($_FILES['csv']['tmp_name']) && (int) $_FILES['csv']['size'] <= 2097152
                ? (string) file_get_contents($_FILES['csv']['tmp_name']) : (string) ($_POST['csv_text'] ?? '');
            $lines = preg_split('/\r\n|\n|\r/', trim(preg_replace('/^\xEF\xBB\xBF/', '', $csv) ?? '')) ?: [];
            $n = 0;
            $bad = 0;
            foreach ($lines as $i => $line) {
                $c = str_getcsv($line, ',', '"', '\\');
                if ($i === 0 && strtolower(trim((string) ($c[0] ?? ''))) === 'kind') {
                    continue;
                }
                if (trim($line) === '') {
                    continue;
                }
                omail_suppress($pdo, trim((string) ($c[0] ?? '')), trim((string) ($c[1] ?? '')), trim((string) ($c[2] ?? 'manual')), trim((string) ($c[3] ?? '')), $actor) ? $n++ : $bad++;
            }
            $back($n > 0, ['Імпортовано: ' . $n . ', пропущено (некоректні): ' . $bad . '.']);
        case 'omail_erase':
            $n = omail_erase($pdo, (string) ($_POST['value'] ?? ''), $actor);
            $back(true, ['Домен додано до списку заборон; знеособлено лідів: ' . $n . '.']);
    }
}

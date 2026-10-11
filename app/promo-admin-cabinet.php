<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Реклама: адмін» у кабінеті (лише role='admin').
 *
 * Вкладки: Модерація · Кампанії · Платежі · Прайс-лист · Налаштування ·
 * Звіти й скарги · Власна реклама. Над вкладками — стан системи й кнопка
 * екстреного вимкнення/увімкнення всієї реклами.
 * Дії — public/promo-admin-action.php; логіка — app/promo-admin.php.
 * Адмінка лише українською (як решта CRM).
 */

require_once __DIR__ . '/promo-admin.php';
require_once __DIR__ . '/promo-cabinet.php';

/**
 * Блок «Реклама» для CRM: стан системи, що чекає на дію, і переходи до всіх
 * рекламних розділів (вкладки адмінки, CRM банерів, власна реклама, правила,
 * посилання на банку для оплати). Лише для admin; без міграції — порожньо.
 */
function promo_crm_overview_html(PDO $pdo): string
{
    try {
        $enabled = promo_enabled($pdo);
        $count = static fn(string $sql): int => (int) $pdo->query($sql)->fetchColumn();
        $pending = $count("SELECT COUNT(*) FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id WHERE cr.status = 'pending' AND c.status = 'pending_review'");
        $topups = $count("SELECT COUNT(*) FROM ad_transactions WHERE type = 'topup' AND status = 'pending'");
        $reports = $count("SELECT COUNT(*) FROM ad_reports WHERE status = 'new'");
        $active = $count("SELECT COUNT(*) FROM ad_campaigns WHERE format = 'video' AND status = 'active'");
        $banners = $count("SELECT COUNT(*) FROM ad_campaigns WHERE format = 'banner' AND status = 'active'");
        $rates = $count('SELECT COUNT(*) FROM ad_rate_card WHERE active = 1');
    } catch (Throwable $e) {
        return '';
    }
    $jar = promo_payment_jar_url($pdo);
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $tab = static fn(string $t, string $label, int $n = 0): string => '<a href="account.php?padm_tab=' . $t . '#acc-promo-admin">' . $e($label) . '</a>' . ($n > 0 ? ' <strong>(' . $n . ')</strong>' : '');

    return '<div class="staff-note promo-crm">'
        . '<p><strong>Реклама:</strong> ' . ($enabled ? 'увімкнена' : '<strong>вимкнена</strong> (на сайті немає жодної реклами, зокрема банерів)')
        . ' · активних відеокампаній: ' . $active . ' · активних банерних кампаній: ' . $banners
        . ' · цін у прайсі: ' . $rates . ($rates === 0 ? ' (платну рекламу не можна надіслати)' : '') . '</p>'
        . '<p>Відеореклама: ' . $tab('moderation', 'Модерація', $pending)
        . ' · ' . $tab('campaigns', 'Кампанії')
        . ' · ' . $tab('payments', 'Платежі', $topups)
        . ' · ' . $tab('rates', 'Прайс-лист')
        . ' · ' . $tab('settings', 'Налаштування')
        . ' · ' . $tab('reports', 'Звіти й скарги', $reports)
        . ' · ' . $tab('house', 'Власна реклама') . '</p>'
        . '<p>Банери: <a href="crm-ads-list.php">CRM банерів</a> · <a href="crm-add-campaign.php">+ банерна кампанія</a>'
        . ' · Рекламодавцям: <a href="account.php?promo_tab=campaigns#acc-promo">кабінет рекламодавця</a>'
        . ' · <a href="promo-rules.php" target="_blank" rel="noopener">правила реклами</a>'
        . ($jar !== '' ? ' · <a href="' . $e($jar) . '" target="_blank" rel="noopener noreferrer">банка для оплати реклами</a>' : ' · банку для оплати реклами не задано (' . $tab('settings', 'Налаштування') . ')')
        . '</p></div>';
}

function promo_admin_cabinet_render(PDO $pdo, array $user): void
{
    if (!promo_is_admin($pdo, (int) $user['id'])) {
        return;
    }
    $flash = $_SESSION['padm_flash'] ?? null;
    unset($_SESSION['padm_flash']);

    $tabs = [
        'moderation' => 'Модерація',
        'campaigns' => 'Кампанії',
        'payments' => 'Платежі',
        'rates' => 'Прайс-лист',
        'settings' => 'Налаштування',
        'reports' => 'Звіти й скарги',
        'house' => 'Власна реклама',
    ];
    $tab = isset($tabs[$_GET['padm_tab'] ?? '']) ? $_GET['padm_tab'] : 'moderation';

    $enabled = promo_enabled($pdo);
    $secretOk = strlen(promo_config()['secret']) >= 32;
    $rates = promo_rate_card($pdo);
    $settings = promo_settings($pdo, true);
    $serverLimit = promo_server_upload_limit();
    $maxMb = (int) ($settings['max_video_mb'] ?? 30);

    $queue = promo_admin_queue($pdo);
    $pendingTopups = $pdo->query(
        "SELECT t.*, u.email, u.name FROM ad_transactions t LEFT JOIN users u ON u.id = t.user_id
         WHERE t.type = 'topup' AND t.status = 'pending' ORDER BY t.id"
    )->fetchAll();
    $journal = $pdo->query(
        'SELECT t.*, u.email FROM ad_transactions t LEFT JOIN users u ON u.id = t.user_id ORDER BY t.id DESC LIMIT 200'
    )->fetchAll();
    $allCampaigns = $pdo->query(
        "SELECT c.*, u.email AS user_email, COALESCE(b.balance, 0) AS balance,
                (SELECT SUM(impressions) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS impressions,
                (SELECT SUM(clicks) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS clicks
         FROM ad_campaigns c
         LEFT JOIN users u ON u.id = c.user_id
         LEFT JOIN ad_balances b ON b.user_id = c.user_id
         WHERE c.format = 'video' AND c.status <> 'draft'
         ORDER BY FIELD(c.status, 'pending_review', 'active', 'paused', 'rejected', 'completed', 'expired'), c.id DESC
         LIMIT 300"
    )->fetchAll();
    $house = array_values(array_filter(
        $pdo->query("SELECT c.*, (SELECT SUM(impressions) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS impressions,
                            (SELECT SUM(clicks) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS clicks
                     FROM ad_campaigns c WHERE c.format = 'video' AND c.campaign_type = 'internal' ORDER BY c.id DESC")->fetchAll()
    ));
    $reports = promo_admin_reports($pdo);
    $newReports = array_sum(array_map(static fn($r) => (int) $r['new_count'], $reports));

    $validDate = static function (string $key, string $default): string {
        $v = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
        $d = DateTime::createFromFormat('!Y-m-d', $v);

        return ($d !== false && $d->format('Y-m-d') === $v) ? $v : $default;
    };
    $from = $validDate('padm_from', date('Y-m-d', strtotime('-29 days')));
    $to = $validDate('padm_to', date('Y-m-d'));
    $platform = promo_admin_platform_totals($pdo, $from, $to);
    $top = promo_admin_top_campaigns($pdo, $from, $to);

    $plLabel = ['catalog_card' => 'Картка в каталозі', 'product_page' => 'Сторінка продукту', 'blog_inline' => 'Стаття блогу'];
    $statusUk = ['draft' => 'Чернетка', 'pending_review' => 'На модерації', 'active' => 'Активна', 'paused' => 'Пауза', 'rejected' => 'Відхилена', 'completed' => 'Завершена', 'expired' => 'Завершена'];
    $stopUk = ['budget' => 'бюджет вичерпано', 'balance' => 'нема коштів', 'end_date' => 'термін минув', 'user' => 'рекламодавцем', 'admin' => 'адміном'];
    $txUk = ['topup' => 'Поповнення', 'spend' => 'Списання', 'refund' => 'Повернення', 'adjust' => 'Коригування'];
    $txsUk = ['pending' => 'Очікує', 'confirmed' => 'Підтверджено', 'rejected' => 'Відхилено'];
    $badge = static fn(string $s): string => '<span class="pc-badge pc-badge--' . pc_e($s) . '">' . pc_e($statusUk[$s] ?? $s) . '</span>';
    $csrf = promo_csrf_field();
    ?>
            <div class="accordion" id="acc-promo-admin">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-promo-admin-panel">
                    <span class="accordion__title">Реклама: адмін<?= ($queue !== [] || $pendingTopups !== [] || $newReports > 0) ? ' · ' . (count($queue) + count($pendingTopups) + $newReports) . ' нових' : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-promo-admin-panel">
                    <div class="accordion__panel-inner pc" data-pc-param="padm_tab" data-pc-hash="acc-promo-admin">

                        <div class="pc-box <?= $enabled ? 'pc-box--accent' : '' ?> pc-system">
                            <p><strong>Реклама на сайті: <?= $enabled ? 'УВІМКНЕНО' : 'ВИМКНЕНО' ?></strong>
                                <span class="pc-muted">Перемикач керує всією рекламою: відеорекламою й старими банерами (категорії, головна).</span></p>
                            <form method="post" action="promo-admin-action.php" class="pc-inline-form"
                                  data-pc-confirm="<?= $enabled ? 'Вимкнути ВСЮ рекламу на сайті?' : 'Увімкнути рекламу на сайті?' ?>">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="toggle_system">
                                <input type="hidden" name="enabled" value="<?= $enabled ? '0' : '1' ?>">
                                <input type="hidden" name="return_tab" value="<?= pc_e($tab) ?>">
                                <button type="submit" class="pc-btn <?= $enabled ? 'pc-btn--danger' : 'pc-btn--primary' ?>"><?= $enabled ? 'Вимкнути всю рекламу' : 'Увімкнути рекламу' ?></button>
                            </form>
                            <?php if (!$secretOk): ?>
                            <p class="pc-warn-text">Немає config/promo.php із секретом (secret ≥ 32 символи) — відеореклама не показується. Шаблон: config/promo.example.php.</p>
                            <?php endif; ?>
                            <?php if ($rates === []): ?>
                            <p class="pc-warn-text">Прайс порожній — платні кампанії неможливо надіслати на модерацію.</p>
                            <?php endif; ?>
                            <?php if ($serverLimit > 0 && $serverLimit < $maxMb * 1024 * 1024): ?>
                            <p class="pc-warn-text">Ліміт завантаження сервера (<?= round($serverLimit / 1048576, 1) ?> МБ: upload_max_filesize / post_max_size) менший за max_video_mb (<?= $maxMb ?> МБ). Великі відео не завантажаться.</p>
                            <?php endif; ?>
                        </div>

                        <?php if (is_array($flash) && !empty($flash['msgs'])): ?>
                        <div class="pc-flash <?= !empty($flash['ok']) ? 'pc-flash--ok' : 'pc-flash--error' ?>" role="status">
                            <?php foreach ($flash['msgs'] as $m): ?><p><?= pc_e($m) ?></p><?php endforeach; ?>
                        </div>
                        <?php endif; ?>

                        <div class="pc-tabs" role="tablist">
                            <?php foreach ($tabs as $k => $label):
                                $count = match ($k) { 'moderation' => count($queue), 'payments' => count($pendingTopups), 'reports' => $newReports, default => 0 }; ?>
                            <a class="pc-tab<?= $tab === $k ? ' is-active' : '' ?>" role="tab" href="account.php?padm_tab=<?= $k ?>#acc-promo-admin"
                               data-pc-tab="<?= $k ?>" aria-selected="<?= $tab === $k ? 'true' : 'false' ?>"><?= pc_e($label) ?><?= $count > 0 ? ' (' . $count . ')' : '' ?></a>
                            <?php endforeach; ?>
                        </div>

                        <!-- ============ D1. Модерація ============ -->
                        <section class="pc-panel" data-pc-panel="moderation"<?= $tab === 'moderation' ? '' : ' hidden' ?>>
                            <?php if ($queue === []): ?>
                            <p class="pc-empty">Черга модерації порожня.</p>
                            <?php endif; ?>
                            <?php foreach ($queue as $q):
                                $tg = promo_admin_targets_text($pdo, (int) $q['cid']); ?>
                            <article class="pc-mod">
                                <div class="pc-grid-2">
                                    <div>
                                        <article class="sponsored-card pc-preview">
                                            <span class="sponsored-card__label">Реклама</span>
                                            <div class="sponsored-card__media">
                                                <?php if ($q['video_type'] === 'upload' && $q['video_path']): ?>
                                                <video controls muted playsinline preload="metadata"<?= $q['poster_path'] ? ' poster="/' . pc_e($q['poster_path']) . '"' : '' ?> src="/<?= pc_e($q['video_path']) ?>"></video>
                                                <?php elseif ($q['youtube_id']): ?>
                                                <iframe src="https://www.youtube-nocookie.com/embed/<?= pc_e($q['youtube_id']) ?>?rel=0" title="YouTube" loading="lazy" allow="encrypted-media; picture-in-picture" allowfullscreen referrerpolicy="strict-origin-when-cross-origin"></iframe>
                                                <?php endif; ?>
                                            </div>
                                            <h3 class="sponsored-card__title"><?= pc_e($q['title']) ?></h3>
                                            <p class="sponsored-card__desc"><?= pc_e($q['description']) ?></p>
                                            <div class="sponsored-card__footer"><span class="sponsored-card__cta"><?= pc_e(t('promo_cta_' . $q['cta_key'])) ?></span></div>
                                        </article>
                                    </div>
                                    <dl class="pc-summary">
                                        <dt>Кампанія</dt><dd>#<?= (int) $q['cid'] ?> <?= pc_e($q['campaign_name']) ?></dd>
                                        <dt>Рекламодавець</dt><dd><?= pc_e($q['user_name']) ?> · <?= pc_e($q['user_email']) ?> (баланс <?= pc_e(promo_money($q['balance'])) ?>)</dd>
                                        <dt>Адреса переходу</dt><dd><a href="<?= pc_e($q['destination_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= pc_e($q['destination_url']) ?></a></dd>
                                        <dt>Відео</dt><dd><?= $q['video_type'] === 'upload'
                                            ? pc_e(($q['mime'] ?? '') . ' · ' . ($q['duration_sec'] !== null ? $q['duration_sec'] . ' с' : 'тривалість невідома') . ' · ' . round((int) $q['size_bytes'] / 1048576, 1) . ' МБ')
                                            : 'YouTube: ' . pc_e($q['video_url']) ?></dd>
                                        <dt>Модель</dt><dd><?= $q['pricing_model'] === 'cpc' ? 'CPC (за клік)' : 'CPM (за 1000 показів)' ?></dd>
                                        <dt>Ціни (знімок)</dt><dd><?php foreach ($tg['placements'] as $pl => $price): ?><?= pc_e($plLabel[$pl] ?? $pl) ?>: <?= pc_e(promo_money($price)) ?><br><?php endforeach; ?></dd>
                                        <dt>Аудиторія</dt><dd><?= pc_e(['all' => 'усі мови', 'uk' => 'українська', 'en' => 'англійська'][$tg['language']] ?? $tg['language']) ?> · <?= pc_e(['all' => 'усі пристрої', 'mobile' => 'мобільні', 'desktop' => 'комп’ютери'][$tg['device']] ?? $tg['device']) ?><br><?= pc_e(implode(', ', $tg['categories'])) ?></dd>
                                        <dt>Бюджет</dt><dd>загальний <?= pc_e(promo_money($q['total_budget'])) ?><?= $q['daily_budget'] !== null ? ', денний ' . pc_e(promo_money($q['daily_budget'])) : '' ?></dd>
                                        <dt>Дати</dt><dd><?= pc_e($q['start_date']) ?><?= $q['end_date'] ? ' — ' . pc_e($q['end_date']) : ' (без кінця)' ?></dd>
                                        <dt>Надіслано</dt><dd><?= pc_e($q['submitted_at']) ?></dd>
                                    </dl>
                                </div>
                                <div class="pc-mod__actions">
                                    <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                        <?= $csrf ?>
                                        <input type="hidden" name="action" value="moderate">
                                        <input type="hidden" name="creative_id" value="<?= (int) $q['id'] ?>">
                                        <input type="hidden" name="decision" value="approve">
                                        <button type="submit" class="pc-btn pc-btn--primary">Схвалити</button>
                                    </form>
                                    <form method="post" action="promo-admin-action.php" class="pc-reject">
                                        <?= $csrf ?>
                                        <input type="hidden" name="action" value="moderate">
                                        <input type="hidden" name="creative_id" value="<?= (int) $q['id'] ?>">
                                        <input type="hidden" name="decision" value="reject">
                                        <label class="pc-field"><span>Причина відмови (бачить рекламодавець)</span>
                                            <textarea name="reason" rows="2" maxlength="500" required></textarea></label>
                                        <button type="submit" class="pc-btn pc-btn--danger">Відхилити</button>
                                    </form>
                                </div>
                            </article>
                            <?php endforeach; ?>
                        </section>

                        <!-- ============ Кампанії (екстрена зупинка) ============ -->
                        <section class="pc-panel" data-pc-panel="campaigns"<?= $tab === 'campaigns' ? '' : ' hidden' ?>>
                            <?php if ($allCampaigns === []): ?>
                            <p class="pc-empty">Відеокампаній ще немає (чернетки рекламодавців тут не показуються).</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Кампанія</th><th>Власник</th><th>Статус</th><th>Витрачено</th><th>Покази / кліки</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($allCampaigns as $c): $cid = (int) $c['id']; ?>
                                    <tr>
                                        <td data-label="Кампанія">#<?= $cid ?> <?= pc_e($c['name']) ?><span class="pc-muted"><?= $c['campaign_type'] === 'internal' ? 'власна реклама' : strtoupper((string) $c['pricing_model']) ?></span></td>
                                        <td data-label="Власник"><?= $c['campaign_type'] === 'internal' ? 'AI LAB HUB' : pc_e($c['user_email']) ?><?php if ($c['campaign_type'] !== 'internal'): ?><span class="pc-muted">баланс <?= pc_e(promo_money($c['balance'])) ?></span><?php endif; ?></td>
                                        <td data-label="Статус"><?= $badge((string) $c['status']) ?><?php if ($c['stop_reason'] && in_array($c['status'], ['paused', 'completed'], true)): ?><span class="pc-muted"><?= pc_e($stopUk[$c['stop_reason']] ?? $c['stop_reason']) ?></span><?php endif; ?></td>
                                        <td data-label="Витрачено"><?= pc_e(promo_money($c['spent'])) ?><?= $c['total_budget'] !== null ? ' / ' . pc_e(promo_money($c['total_budget'])) : '' ?></td>
                                        <td data-label="Покази / кліки"><?= (int) $c['impressions'] ?> / <?= (int) $c['clicks'] ?></td>
                                        <td data-label="Дії" class="pc-actions">
                                            <?php foreach (array_filter([
                                                in_array($c['status'], ['active', 'pending_review'], true) ? 'stop' : null,
                                                $c['status'] === 'paused' ? 'resume' : null,
                                                $c['status'] !== 'completed' ? 'complete' : null,
                                            ]) as $op): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form"<?= $op === 'complete' ? ' data-pc-confirm="Завершити кампанію #' . $cid . '?"' : '' ?>>
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="campaign_status">
                                                <input type="hidden" name="campaign_id" value="<?= $cid ?>">
                                                <input type="hidden" name="op" value="<?= $op ?>">
                                                <input type="hidden" name="return_tab" value="campaigns">
                                                <button type="submit" class="pc-btn pc-btn--small<?= $op !== 'resume' ? ' pc-btn--danger' : '' ?>"><?= ['stop' => 'Зупинити', 'resume' => 'Відновити', 'complete' => 'Завершити'][$op] ?></button>
                                            </form>
                                            <?php endforeach; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>

                        <!-- ============ D2. Платежі ============ -->
                        <section class="pc-panel" data-pc-panel="payments"<?= $tab === 'payments' ? '' : ' hidden' ?>>
                            <h3 class="pc-h3">Заявки на поповнення</h3>
                            <?php if ($pendingTopups === []): ?>
                            <p class="pc-empty">Нових заявок немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Заявка</th><th>Рекламодавець</th><th>Сума</th><th>Призначення</th><th>Рішення</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($pendingTopups as $tx): ?>
                                    <tr>
                                        <td data-label="Заявка">№<?= (int) $tx['id'] ?><span class="pc-muted"><?= pc_e(substr((string) $tx['created_at'], 0, 16)) ?></span></td>
                                        <td data-label="Рекламодавець"><?= pc_e($tx['name']) ?><span class="pc-muted"><?= pc_e($tx['email']) ?></span></td>
                                        <td data-label="Сума"><strong><?= pc_e(promo_money($tx['amount'])) ?></strong></td>
                                        <td data-label="Призначення"><code><?= pc_e($tx['reference']) ?></code></td>
                                        <td data-label="Рішення" class="pc-actions">
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form"
                                                  data-pc-confirm="Підтвердити надходження <?= pc_e(promo_money($tx['amount'])) ?> за заявкою №<?= (int) $tx['id'] ?>? Сума буде зарахована на баланс.">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="topup_decide">
                                                <input type="hidden" name="tx_id" value="<?= (int) $tx['id'] ?>">
                                                <input type="hidden" name="decision" value="confirm">
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--primary">Підтвердити</button>
                                            </form>
                                            <form method="post" action="promo-admin-action.php" class="pc-reject pc-reject--inline">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="topup_decide">
                                                <input type="hidden" name="tx_id" value="<?= (int) $tx['id'] ?>">
                                                <input type="hidden" name="decision" value="reject">
                                                <input type="text" name="reason" maxlength="500" placeholder="Причина відхилення" required>
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--danger">Відхилити</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">Ручне коригування балансу</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-filter">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="adjust">
                                <label class="pc-field"><span>Email або ID користувача</span><input type="text" name="who" required></label>
                                <label class="pc-field"><span>Тип</span>
                                    <select name="type"><option value="adjust">Коригування (±)</option><option value="refund">Повернення на баланс (+)</option></select></label>
                                <label class="pc-field"><span>Сума, грн (мінус — списати)</span><input type="text" name="amount" inputmode="decimal" required placeholder="напр. 100 або -25.50"></label>
                                <label class="pc-field"><span>Примітка (обов'язково)</span><input type="text" name="note" maxlength="500" required></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Застосувати</button>
                            </form>

                            <h3 class="pc-h3">Журнал (останні 200)</h3>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>№</th><th>Дата</th><th>Користувач</th><th>Тип</th><th>Сума</th><th>Статус</th><th>Деталі</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($journal as $tx): ?>
                                    <tr>
                                        <td data-label="№"><?= (int) $tx['id'] ?></td>
                                        <td data-label="Дата"><?= pc_e(substr((string) $tx['created_at'], 0, 16)) ?></td>
                                        <td data-label="Користувач"><?= pc_e($tx['email']) ?></td>
                                        <td data-label="Тип"><?= pc_e($txUk[$tx['type']] ?? $tx['type']) ?></td>
                                        <td data-label="Сума"><?= pc_e(promo_money($tx['amount'])) ?></td>
                                        <td data-label="Статус"><span class="pc-badge pc-badge--tx-<?= pc_e($tx['status']) ?>"><?= pc_e($txsUk[$tx['status']] ?? $tx['status']) ?></span></td>
                                        <td data-label="Деталі"><?= pc_e(trim(($tx['reference'] ?? '') . ' ' . ($tx['note'] ?? '') . ' ' . ($tx['reject_reason'] ?? ''))) ?><?= $tx['confirmed_by'] ? '<span class="pc-muted">адмін #' . (int) $tx['confirmed_by'] . ', ' . pc_e(substr((string) $tx['confirmed_at'], 0, 16)) . '</span>' : '' ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        </section>

                        <!-- ============ D3. Прайс-лист ============ -->
                        <section class="pc-panel" data-pc-panel="rates"<?= $tab === 'rates' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Ціни в гривнях. CPM — за 1000 показів, CPC — за клік. Порожнє поле — ціни немає: платну кампанію з цим розміщенням і моделлю надіслати не можна. Ціна фіксується в кампанії на момент надсилання — зміна прайсу не впливає на вже надіслані кампанії.</p>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="rates">
                                <div class="pc-table-wrap">
                                    <table class="pc-table">
                                        <thead><tr><th>Розміщення</th><th>CPM, грн / 1000 показів</th><th>CPC, грн / клік</th></tr></thead>
                                        <tbody>
                                        <?php foreach (PROMO_PLACEMENTS as $pl): ?>
                                        <tr>
                                            <td data-label="Розміщення"><?= pc_e($plLabel[$pl]) ?></td>
                                            <?php foreach (['cpm', 'cpc'] as $m): ?>
                                            <td data-label="<?= strtoupper($m) ?>"><input type="text" inputmode="decimal" name="price[<?= $pl ?>][<?= $m ?>]" value="<?= isset($rates[$pl][$m]) ? pc_e(promo_money_input($rates[$pl][$m])) : '' ?>" placeholder="—"></td>
                                            <?php endforeach; ?>
                                        </tr>
                                        <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                                <button type="submit" class="pc-btn pc-btn--primary">Зберегти прайс</button>
                            </form>
                        </section>

                        <!-- ============ D4. Налаштування ============ -->
                        <section class="pc-panel" data-pc-panel="settings"<?= $tab === 'settings' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Сервер: upload_max_filesize = <?= pc_e(ini_get('upload_max_filesize')) ?>, post_max_size = <?= pc_e(ini_get('post_max_size')) ?>. Перемикач усієї реклами — угорі розділу.</p>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="settings">
                                <div class="pc-grid-2">
                                    <label class="pc-field"><span>Макс. розмір відео, МБ</span><input type="text" inputmode="numeric" name="max_video_mb" value="<?= pc_e($settings['max_video_mb'] ?? '30') ?>"></label>
                                    <label class="pc-field"><span>Макс. тривалість відео, с</span><input type="text" inputmode="numeric" name="max_video_sec" value="<?= pc_e($settings['max_video_sec'] ?? '30') ?>"></label>
                                    <label class="pc-field"><span>Мін. поповнення, грн (порожньо — без мінімуму)</span><input type="text" inputmode="decimal" name="min_topup" value="<?= pc_e($settings['min_topup'] ?? '') ?>"></label>
                                    <label class="pc-field"><span>Ліміт показів кампанії одному сеансу на добу (0 — без ліміту)</span><input type="text" inputmode="numeric" name="frequency_cap_per_session" value="<?= pc_e($settings['frequency_cap_per_session'] ?? '3') ?>"></label>
                                </div>
                                <label class="pc-field"><span>Посилання на банку (monobank) для оплати реклами — окреме від донатів. Лише https://; порожньо — кнопки оплати немає.</span>
                                    <input type="text" name="payment_jar_url" value="<?= pc_e($settings['payment_jar_url'] ?? '') ?>" placeholder="https://send.monobank.ua/jar/…" autocomplete="off" spellcheck="false"></label>
                                <label class="pc-field"><span>Реквізити й інструкція з оплати (UA). Якщо порожньо й немає посилання на банку — поповнення недоступне.</span>
                                    <textarea name="payment_instructions_uk" rows="5" maxlength="5000"><?= pc_e($settings['payment_instructions_uk'] ?? '') ?></textarea></label>
                                <label class="pc-field"><span>Реквізити й інструкція з оплати (EN). Порожньо — показується UA.</span>
                                    <textarea name="payment_instructions_en" rows="5" maxlength="5000"><?= pc_e($settings['payment_instructions_en'] ?? '') ?></textarea></label>
                                <label class="pc-field"><span>Заборонені категорії реклами (UA, показується в майстрі)</span>
                                    <textarea name="prohibited_categories_text_uk" rows="4" maxlength="5000"><?= pc_e($settings['prohibited_categories_text_uk'] ?? '') ?></textarea></label>
                                <label class="pc-field"><span>Заборонені категорії реклами (EN)</span>
                                    <textarea name="prohibited_categories_text_en" rows="4" maxlength="5000"><?= pc_e($settings['prohibited_categories_text_en'] ?? '') ?></textarea></label>
                                <label class="pc-field"><span>Правила розміщення реклами (UA) для <a href="promo-rules.php" target="_blank" rel="noopener">promo-rules.php</a>. Порожньо — показується вбудована чернетка (потребує перевірки юристом).</span>
                                    <textarea name="rules_text_uk" rows="8" maxlength="20000"><?= pc_e($settings['rules_text_uk'] ?? '') ?></textarea></label>
                                <label class="pc-field"><span>Правила розміщення реклами (EN). Порожньо — вбудована англійська чернетка.</span>
                                    <textarea name="rules_text_en" rows="8" maxlength="20000"><?= pc_e($settings['rules_text_en'] ?? '') ?></textarea></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Зберегти налаштування</button>
                            </form>
                        </section>

                        <!-- ============ D5. Звіти й скарги ============ -->
                        <section class="pc-panel" data-pc-panel="reports"<?= $tab === 'reports' ? '' : ' hidden' ?>>
                            <form method="get" action="account.php#acc-promo-admin" class="pc-filter">
                                <input type="hidden" name="padm_tab" value="reports">
                                <label class="pc-field"><span>З</span><input type="date" name="padm_from" value="<?= pc_e($from) ?>"></label>
                                <label class="pc-field"><span>По</span><input type="date" name="padm_to" value="<?= pc_e($to) ?>"></label>
                                <button type="submit" class="pc-btn">Показати</button>
                            </form>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th></th><th>Покази</th><th>Перегляди</th><th>Кліки</th><th>CTR</th><th>Витрати рекламодавців</th></tr></thead>
                                    <tbody>
                                    <?php foreach (['paid' => 'Платна реклама', 'internal' => 'Власна реклама'] as $k => $label): $r = $platform[$k] ?? ['impressions' => 0, 'views' => 0, 'clicks' => 0, 'spend' => 0]; ?>
                                    <tr>
                                        <td data-label=""><strong><?= $label ?></strong></td>
                                        <td data-label="Покази"><?= (int) $r['impressions'] ?></td>
                                        <td data-label="Перегляди"><?= (int) $r['views'] ?></td>
                                        <td data-label="Кліки"><?= (int) $r['clicks'] ?></td>
                                        <td data-label="CTR"><?= pc_e(promo_ctr($r['clicks'], $r['impressions'])) ?></td>
                                        <td data-label="Витрати"><?= $k === 'paid' ? pc_e(promo_money($r['spend'])) : '—' ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>

                            <h3 class="pc-h3">Топ кампаній за період</h3>
                            <?php if ($top === []): ?>
                            <p class="pc-empty">Даних за період немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Кампанія</th><th>Власник</th><th>Статус</th><th>Покази</th><th>Кліки</th><th>CTR</th><th>Витрати</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($top as $r): ?>
                                    <tr>
                                        <td data-label="Кампанія">#<?= (int) $r['id'] ?> <?= pc_e($r['name']) ?></td>
                                        <td data-label="Власник"><?= $r['campaign_type'] === 'internal' ? 'AI LAB HUB' : pc_e($r['user_email']) ?></td>
                                        <td data-label="Статус"><?= $badge((string) $r['status']) ?></td>
                                        <td data-label="Покази"><?= (int) $r['impressions'] ?></td>
                                        <td data-label="Кліки"><?= (int) $r['clicks'] ?></td>
                                        <td data-label="CTR"><?= pc_e(promo_ctr($r['clicks'], $r['impressions'])) ?></td>
                                        <td data-label="Витрати"><?= pc_e(promo_money($r['spend'])) ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">Скарги відвідувачів</h3>
                            <?php if ($reports === []): ?>
                            <p class="pc-empty">Скарг немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Креатив</th><th>Кампанія</th><th>Скарги</th><th>Причини</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($reports as $r): ?>
                                    <tr>
                                        <td data-label="Креатив">#<?= (int) $r['creative_id'] ?> <?= pc_e($r['title']) ?><span class="pc-muted"><?= pc_e(['approved' => 'показується', 'suspended' => 'призупинено', 'rejected' => 'відхилено', 'pending' => 'на модерації', 'draft' => 'чернетка'][$r['creative_status']] ?? $r['creative_status']) ?></span></td>
                                        <td data-label="Кампанія">#<?= (int) $r['campaign_id'] ?> <?= pc_e($r['campaign_name']) ?><span class="pc-muted"><?= $r['campaign_type'] === 'internal' ? 'AI LAB HUB' : pc_e($r['user_email']) ?></span></td>
                                        <td data-label="Скарги"><?= (int) $r['total'] ?><?= (int) $r['new_count'] > 0 ? ' <strong>(' . (int) $r['new_count'] . ' нових)</strong>' : '' ?><span class="pc-muted"><?= pc_e(substr((string) $r['last_at'], 0, 16)) ?></span></td>
                                        <td data-label="Причини"><?= pc_e($r['reasons']) ?></td>
                                        <td data-label="Дії" class="pc-actions">
                                            <?php if ($r['creative_status'] !== 'suspended'): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form" data-pc-confirm="Призупинити креатив #<?= (int) $r['creative_id'] ?> і зупинити кампанію?">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="suspend_creative">
                                                <input type="hidden" name="creative_id" value="<?= (int) $r['creative_id'] ?>">
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--danger">Призупинити</button>
                                            </form>
                                            <?php endif; ?>
                                            <?php if ((int) $r['new_count'] > 0): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="reports_reviewed">
                                                <input type="hidden" name="creative_id" value="<?= (int) $r['creative_id'] ?>">
                                                <button type="submit" class="pc-btn pc-btn--small">Розглянуто</button>
                                            </form>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>

                        <!-- ============ D6. Власна реклама ============ -->
                        <section class="pc-panel" data-pc-panel="house"<?= $tab === 'house' ? '' : ' hidden' ?>>
                            <p class="pc-muted">Самопромоція сайту (напр. підписка на розсилку, Еля): без білінгу й модерації, показується у вільних слотах — платні кампанії мають пріоритет.</p>
                            <p><a class="pc-btn pc-btn--primary" href="account.php?promo_tab=create&amp;promo_house=1#acc-promo">Створити власну рекламу</a></p>
                            <?php if ($house === []): ?>
                            <p class="pc-empty">Власної відеореклами ще немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Кампанія</th><th>Статус</th><th>Покази / кліки</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($house as $c): $cid = (int) $c['id']; ?>
                                    <tr>
                                        <td data-label="Кампанія">#<?= $cid ?> <?= pc_e($c['name']) ?><span class="pc-muted"><?= pc_e((string) $c['start_date']) ?><?= $c['end_date'] ? ' — ' . pc_e($c['end_date']) : '' ?></span></td>
                                        <td data-label="Статус"><?= $badge((string) $c['status']) ?></td>
                                        <td data-label="Покази / кліки"><?= (int) $c['impressions'] ?> / <?= (int) $c['clicks'] ?></td>
                                        <td data-label="Дії" class="pc-actions">
                                            <?php if (in_array($c['status'], PROMO_EDITABLE, true) && (int) $c['user_id'] === (int) $user['id']): ?>
                                            <a class="pc-btn pc-btn--small" href="account.php?promo_tab=create&amp;promo_house=1&amp;promo_edit=<?= $cid ?>#acc-promo">Редагувати</a>
                                            <?php endif; ?>
                                            <?php foreach (array_filter([
                                                $c['status'] === 'active' ? 'stop' : null,
                                                $c['status'] === 'paused' ? 'resume' : null,
                                                $c['status'] !== 'completed' ? 'complete' : null,
                                            ]) as $op): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="campaign_status">
                                                <input type="hidden" name="campaign_id" value="<?= $cid ?>">
                                                <input type="hidden" name="op" value="<?= $op ?>">
                                                <input type="hidden" name="return_tab" value="house">
                                                <button type="submit" class="pc-btn pc-btn--small<?= $op !== 'resume' ? ' pc-btn--danger' : '' ?>"><?= ['stop' => 'Пауза', 'resume' => 'Відновити', 'complete' => 'Завершити'][$op] ?></button>
                                            </form>
                                            <?php endforeach; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>
                    </div>
                </div>
            </div>
            <?= promo_cabinet_assets() ?>
    <?php
}

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
require_once __DIR__ . '/promo-house.php';   // «Власна реклама»: картки, варіанти, умови
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
        'placements' => 'Місця показу',
        'settings' => 'Налаштування',
        'reports' => 'Звіти й скарги',
        'house' => 'Власна реклама',
        'links' => 'Перевірка посилань',
        'exclusions' => 'Виключення реклами',
        'status' => 'Стан',
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
    // Пропуски й затримка «Пропустити» (міграція 2026-10-21-ad-popup); без неї — як раніше.
    $popupCols = promo_has_column($pdo, 'ad_stats_daily', 'skips') && promo_has_column($pdo, 'ad_creatives', 'skip_delay_seconds');
    $allCampaigns = $pdo->query(
        "SELECT c.*, u.email AS user_email, COALESCE(b.balance, 0) AS balance, b.currency AS balance_currency,
                (SELECT SUM(impressions) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS impressions,
                (SELECT SUM(clicks) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS clicks" . ($popupCols ? ",
                (SELECT SUM(skips) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS skips,
                (SELECT MIN(cr.skip_delay_seconds) FROM ad_creatives cr WHERE cr.campaign_id = c.id) AS skip_delay" : '') . "
         FROM ad_campaigns c
         LEFT JOIN users u ON u.id = c.user_id
         LEFT JOIN ad_balances b ON b.user_id = c.user_id
         WHERE c.format = 'video' AND c.status <> 'draft'
         ORDER BY FIELD(c.status, 'pending_review', 'active', 'paused', 'rejected', 'completed', 'expired'), c.id DESC
         LIMIT 300"
    )->fetchAll();
    $house = array_values(array_filter(
        $pdo->query("SELECT c.*, (SELECT SUM(impressions) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS impressions,
                            (SELECT SUM(clicks) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS clicks"
                            . ($popupCols ? ', (SELECT SUM(skips) FROM ad_stats_daily s WHERE s.campaign_id = c.id) AS skips' : '') . "
                     FROM ad_campaigns c WHERE c.format = 'video' AND c.campaign_type = 'internal'"
                     . (promo_house_columns($pdo) ? " AND c.house_key IS NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives cr WHERE cr.campaign_id = c.id AND cr.creative_type = 'card')" : '')
                     . ' ORDER BY c.id DESC')->fetchAll()
    ));
    $reports = promo_admin_reports($pdo);
    $newReports = array_sum(array_map(static fn($r) => (int) $r['new_count'], $reports));

    $validDate = static function (string $key, string $default): string {
        $v = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
        $d = DateTime::createFromFormat('!Y-m-d', $v);

        return ($d !== false && $d->format('Y-m-d') === $v) ? $v : $default;
    };
    $from = $validDate('padm_from', promo_today(-29));
    $to = $validDate('padm_to', promo_today());
    $platform = promo_admin_platform_totals($pdo, $from, $to);
    $top = promo_admin_top_campaigns($pdo, $from, $to);

    $sbProvider = promo_safe_browsing_provider();
    $sbOff = $sbProvider instanceof PromoSafeBrowsingDisabled;
    $blocklist = $pdo->query('SELECT * FROM ad_domain_blocklist ORDER BY domain')->fetchAll();
    $recentChecks = $pdo->query(
        'SELECT l.*, cr.campaign_id FROM ad_link_checks l LEFT JOIN ad_creatives cr ON cr.id = l.creative_id ORDER BY l.id DESC LIMIT 50'
    )->fetchAll();
    $eventLog = $pdo->query('SELECT * FROM promo_event_log ORDER BY id DESC LIMIT 50')->fetchAll();
    $flagText = static fn(string $flags): string => implode(', ', array_map(
        static fn($f) => PROMO_LINK_FLAG_LABELS[$f] ?? $f,
        array_filter(explode(',', $flags))
    ));

    $sys = promo_admin_system_status($pdo);
    $sysAlarm = array_filter($sys['jobs'], static fn($j) => $j['stale']) !== [] || $sys['mail_failed'] > 0;
    $readiness = promo_readiness_issues($pdo, $sys);
    $readinessHtml = promo_readiness_html($readiness);
    $failedMails = $tab === 'status' ? promo_admin_failed_mails($pdo) : [];
    $noPromo = promo_no_promo_list($pdo);
    $catRules = promo_rules_list($pdo);
    $taxonomyAll = promo_taxonomy($pdo);
    $diagnoseUrl = is_string($_SESSION['padm_diagnose_url'] ?? null) ? $_SESSION['padm_diagnose_url'] : '';
    $diagnose = $_SESSION['padm_diagnose'] ?? null;
    unset($_SESSION['padm_diagnose'], $_SESSION['padm_diagnose_url']);
    if (!function_exists('blog_article_topics')) {
        require_once __DIR__ . '/blog.php';
    }

    $plLabel = ['catalog_card' => 'Картка в каталозі (до 18.10)', 'blog_inline' => 'Стаття блогу (до 18.10)'];
    foreach (PROMO_PLACEMENTS as $pl) {
        $plLabel[$pl] = promo_placement_title($pdo, $pl);
    }

    // Вкладка «Місця показу»: стан, ємність, приклади сторінок, тестова кампанія, категорії статей.
    $placementRows = [];
    foreach (promo_placements($pdo, true) as $k => $p) {
        $placementRows[$k] = $p + [
            'block' => promo_placement_block_reason($pdo, $k),
            'capacity' => promo_placement_capacity($pdo, $k, [], [], null, null),
            'preview' => promo_admin_placement_preview_url($pdo, $k),
        ];
    }
    require_once __DIR__ . '/blog.php';
    $blogMap = promo_blog_taxonomy_map($pdo);
    $catNames = [];
    foreach ($pdo->query('SELECT id, name FROM categories') as $r) {
        $catNames[(int) $r['id']] = (string) $r['name'];
    }
    $subNames = [];
    foreach ($pdo->query('SELECT id, name FROM subcategories') as $r) {
        $subNames[(int) $r['id']] = (string) $r['name'];
    }
    $placementsTableOk = true;
    try {
        $pdo->query('SELECT 1 FROM ad_placements LIMIT 1');
        $testCandidates = $pdo->query(
            "SELECT c.id, c.name, c.status, c.campaign_type, c.is_test FROM ad_campaigns c
             WHERE c.format = 'video' AND EXISTS (SELECT 1 FROM ad_creatives cr WHERE cr.campaign_id = c.id
                   AND ((cr.video_type = 'upload' AND cr.video_path IS NOT NULL) OR (cr.video_type = 'youtube' AND cr.youtube_id IS NOT NULL)"
                   . (promo_house_columns($pdo) ? " OR cr.creative_type IN ('card', 'image')" : '') . "))
             ORDER BY c.is_test DESC, c.id DESC LIMIT 100"
        )->fetchAll();
    } catch (Throwable $e) {
        $placementsTableOk = false;
        $testCandidates = [];
    }
    $blogSlug = is_string($_GET['padm_blog'] ?? null) ? $_GET['padm_blog'] : '';
    $statusUk = ['draft' => 'Чернетка', 'pending_review' => 'На модерації', 'active' => 'Активна', 'paused' => 'Пауза', 'rejected' => 'Відхилена', 'completed' => 'Завершена', 'expired' => 'Завершена'];
    $stopUk = ['budget' => 'бюджет вичерпано', 'balance' => 'нема коштів', 'end_date' => 'термін минув', 'user' => 'рекламодавцем', 'admin' => 'адміном', 'link_check' => 'перевірка посилання'];
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
                            <?php if ($readiness !== []): ?>
                            <p class="pc-warn-text"><strong>Реклама ввімкнена, але налаштовано не все (<?= count($readiness) ?>)</strong> — подробиці у вкладках <a href="account.php?padm_tab=status#acc-promo-admin">«Стан»</a> і <a href="account.php?padm_tab=settings#acc-promo-admin">«Налаштування»</a>.</p>
                            <?php endif; ?>
                            <?php if ($sysAlarm): ?>
                            <p class="pc-warn-text"><strong>Стан: є проблеми з cron або поштою</strong> — <a href="account.php?padm_tab=status#acc-promo-admin">вкладка «Стан»</a>.</p>
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
                                                <?php elseif (($q['creative_type'] ?? '') === 'image' && $q['poster_path']): ?>
                                                <img src="/<?= pc_e($q['poster_path']) ?>" alt="">
                                                <?php elseif ($q['youtube_id']): ?>
                                                <iframe src="https://www.youtube-nocookie.com/embed/<?= pc_e($q['youtube_id']) ?>?rel=0" title="YouTube" loading="lazy" allow="encrypted-media; picture-in-picture" allowfullscreen referrerpolicy="strict-origin-when-cross-origin"></iframe>
                                                <?php endif; ?>
                                            </div>
                                            <h3 class="sponsored-card__title"><?= pc_e($q['title']) ?></h3>
                                            <p class="sponsored-card__desc"><?= pc_e($q['description']) ?></p>
                                            <div class="sponsored-card__footer"><span class="sponsored-card__cta"><?= pc_e(promo_cta_label($q)) ?></span></div>
                                        </article>
                                    </div>
                                    <dl class="pc-summary">
                                        <dt>Кампанія</dt><dd>#<?= (int) $q['cid'] ?> <?= pc_e($q['campaign_name']) ?></dd>
                                        <dt>Рекламодавець</dt><dd><?= pc_e($q['user_name']) ?> · <?= pc_e($q['user_email']) ?> (баланс <?= pc_e(promo_money($q['balance'], $q['balance_currency'] ?: PROMO_CURRENCY)) ?>)</dd>
                                        <dt>Адреса переходу</dt><dd><a href="<?= pc_e($q['destination_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= pc_e($q['destination_url']) ?></a></dd>
                                        <dt>Медіа</dt><dd><?= ($q['creative_type'] ?? '') === 'image' ? 'зображення (без відео)' : '' ?><?= ($q['creative_type'] ?? '') === 'image' ? '' : ($q['video_type'] === 'upload'
                                            ? pc_e(($q['mime'] ?? '') . ' · ' . ($q['duration_sec'] !== null ? $q['duration_sec'] . ' с' : 'тривалість невідома') . ' · ' . round((int) $q['size_bytes'] / 1048576, 1) . ' МБ')
                                            : 'YouTube: ' . pc_e($q['video_url'])) ?></dd>
                                        <dt>Категорія реклами</dt><dd><?= pc_e(promo_advertiser_category_label($q['advertiser_category'])) ?><?php if (promo_category_blocked_everywhere($pdo, $q['advertiser_category'])): ?> <strong class="pc-warn-text">— заборонена всюди, відхиліть</strong><?php endif; ?><span class="pc-muted">Перевірте, що відео й сторінка відповідають категорії.</span></dd>
                                        <?php if (trim((string) ($q['cta_text'] ?? '')) !== ''): ?>
                                        <dt>Кнопка</dt><dd><strong class="pc-warn-text">свій текст:</strong> «<?= pc_e($q['cta_text']) ?>»<?= trim((string) ($q['cta_text_en'] ?? '')) !== '' ? ' / EN «' . pc_e($q['cta_text_en']) . '»' : '' ?><span class="pc-muted">Перевірте: текст чесно описує дію на сторінці переходу, без обіцянок результату й маскування.</span></dd>
                                        <?php endif; ?>
                                        <dt>Модель</dt><dd><?= $q['pricing_model'] === 'cpc' ? 'CPC (за клік)' : 'CPM (за 1000 показів)' ?></dd>
                                        <dt>Ціни (знімок)</dt><dd><?php foreach ($tg['placements'] as $pl => $price): ?><?= pc_e($plLabel[$pl] ?? $pl) ?>: <?= pc_e(promo_money($price, (string) ($q['campaign_currency'] ?? PROMO_CURRENCY))) ?><br><?php endforeach; ?></dd>
                                        <dt>Аудиторія</dt><dd><?= pc_e(['all' => 'усі мови', 'uk' => 'українська', 'en' => 'англійська'][$tg['language']] ?? $tg['language']) ?> · <?= pc_e(['all' => 'усі пристрої', 'mobile' => 'мобільні', 'desktop' => 'комп’ютери'][$tg['device']] ?? $tg['device']) ?><br><?= pc_e(implode(', ', $tg['categories'])) ?><?php if ($tg['has_marketplace']): ?><br>Маркетплейс: <?= pc_e($tg['mp_sections']) ?><?php endif; ?></dd>
                                        <dt>Бюджет</dt><dd>загальний <?= pc_e(promo_money($q['total_budget'], $q['campaign_currency'])) ?><?= $q['daily_budget'] !== null ? ', денний ' . pc_e(promo_money($q['daily_budget'], $q['campaign_currency'])) : '' ?></dd>
                                        <dt>Дати</dt><dd><?= pc_e($q['start_date']) ?><?= $q['end_date'] ? ' — ' . pc_e($q['end_date']) : ' (без кінця)' ?></dd>
                                        <dt>Надіслано</dt><dd><?= pc_e(promo_local_time($q['submitted_at'])) ?></dd>
                                    </dl>
                                </div>
                                <?php if ($tg['has_marketplace']): ?>
                                <div class="pc-box pc-box--warn">
                                    <p><strong>Обрано місця в маркетплейсі.</strong> Перевірте, що креатив не маскується під оголошення: немає псевдо-ціни чи псевдо-контактів, він не виглядає як вакансія, курс, послуга чи оголошення користувача, позначку «Реклама» не приховано (правила реклами, розділ 2). Якщо маскується — відхиліть із цією причиною.</p>
                                </div>
                                <?php endif; ?>
                                <?php $lc = promo_last_link_check($pdo, (int) $q['id']); $lcFlagged = $q['link_check_status'] !== 'ok'; ?>
                                <div class="pc-box <?= $lcFlagged ? 'pc-box--warn' : '' ?> pc-linkcheck">
                                    <p><strong>Перевірка посилання:</strong>
                                        <?php if ($lc === null): ?>ще не виконувалась
                                        <?php else: ?><?= $q['link_check_status'] === 'ok' ? 'без прапорців' : '<strong class="pc-warn-text">є прапорці</strong>' ?>
                                        <span class="pc-muted"><?= pc_e(promo_local_time($lc['checked_at'])) ?> (Київ)</span><?php endif; ?></p>
                                    <?php if (!empty($q['recheck_reason'])): ?>
                                    <p class="pc-warn-text">Повторна модерація: <?= pc_e($q['recheck_reason']) ?></p>
                                    <?php endif; ?>
                                    <?php if ($lc !== null): ?>
                                    <dl class="pc-summary">
                                        <dt>Кінцевий URL</dt><dd><?= $lc['final_url'] ? pc_e($lc['final_url']) : '—' ?></dd>
                                        <dt>Кінцевий домен</dt><dd><?= pc_e($lc['final_host'] ?? '—') ?><?= $q['link_final_host'] && $q['link_final_host'] !== $lc['final_host'] ? ' (базовий: ' . pc_e($q['link_final_host']) . ')' : '' ?></dd>
                                        <dt>HTTP</dt><dd><?= $lc['http_status'] !== null ? (int) $lc['http_status'] : '—' ?> · переадресацій: <?= (int) $lc['redirect_count'] ?> · <?= (int) $lc['response_ms'] ?> мс</dd>
                                        <dt>Safe Browsing</dt><dd><?= pc_e($lc['safe_browsing_status']) ?></dd>
                                        <dt>Прапорці</dt><dd><?= $lc['flags'] !== '' ? '<strong class="pc-warn-text">' . pc_e($flagText($lc['flags'])) . '</strong>' : 'немає' ?></dd>
                                        <?php if ($lc['notes']): ?><dt>Деталі</dt><dd><?= nl2br(pc_e($lc['notes'])) ?></dd><?php endif; ?>
                                    </dl>
                                    <?php endif; ?>
                                    <?php if ($sbOff): ?>
                                    <p class="pc-warn-text">Автоматичної перевірки на шкідливі сторінки немає (Safe Browsing / Web Risk не налаштовано в config/promo.php) — перевірте сторінку вручну.</p>
                                    <?php endif; ?>
                                    <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                        <?= $csrf ?>
                                        <input type="hidden" name="action" value="link_recheck">
                                        <input type="hidden" name="creative_id" value="<?= (int) $q['id'] ?>">
                                        <button type="submit" class="pc-btn pc-btn--small">Перевірити посилання ще раз</button>
                                    </form>
                                </div>
                                <div class="pc-mod__actions">
                                    <form method="post" action="promo-admin-action.php" class="<?= $lcFlagged ? 'pc-reject' : 'pc-inline-form' ?>"
                                          <?= $lcFlagged ? 'data-pc-confirm="Схвалити креатив #' . (int) $q['id'] . ' попри прапорці перевірки посилання?"' : '' ?>>
                                        <?= $csrf ?>
                                        <input type="hidden" name="action" value="moderate">
                                        <input type="hidden" name="creative_id" value="<?= (int) $q['id'] ?>">
                                        <input type="hidden" name="decision" value="approve">
                                        <?php if ($lcFlagged): ?>
                                        <label class="pc-check"><input type="checkbox" name="confirm_flagged" value="1" required>
                                            <span>Я перевірив(-ла) сторінку вручну й підтверджую схвалення попри прапорці</span></label>
                                        <label class="pc-field"><span>Причина схвалення (у журнал)</span>
                                            <input type="text" name="override_reason" maxlength="500" required></label>
                                        <?php endif; ?>
                                        <button type="submit" class="pc-btn pc-btn--primary">Схвалити</button>
                                    </form>
                                    <form method="post" action="promo-admin-action.php" class="pc-reject"
                                          data-pc-confirm="Відхилити креатив #<?= (int) $q['id'] ?>? Рекламодавець побачить причину відмови.">
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
                                    <thead><tr><th>Кампанія</th><th>Власник</th><th>Статус</th><th>Витрачено</th><th>Покази / кліки / пропуски · CTR</th><th>Пропуск вікна</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($allCampaigns as $c): $cid = (int) $c['id']; ?>
                                    <tr>
                                        <td data-label="Кампанія">#<?= $cid ?> <?= pc_e($c['name']) ?><span class="pc-muted"><?= $c['campaign_type'] === 'internal' ? 'власна реклама' : strtoupper((string) $c['pricing_model']) ?></span></td>
                                        <td data-label="Власник"><?= $c['campaign_type'] === 'internal' ? 'AI LAB HUB' : pc_e($c['user_email']) ?><?php if ($c['campaign_type'] !== 'internal'): ?><span class="pc-muted">баланс <?= pc_e(promo_money($c['balance'], $c['balance_currency'] ?: PROMO_CURRENCY)) ?></span><?php endif; ?></td>
                                        <td data-label="Статус"><?= $badge((string) $c['status']) ?><?php if ($c['stop_reason'] && in_array($c['status'], ['paused', 'completed'], true)): ?><span class="pc-muted"><?= pc_e($stopUk[$c['stop_reason']] ?? $c['stop_reason']) ?></span><?php endif; ?></td>
                                        <td data-label="Витрачено"><?= pc_e(promo_money($c['spent'], $c['currency'])) ?><?= $c['total_budget'] !== null ? ' / ' . pc_e(promo_money($c['total_budget'], $c['currency'])) : '' ?></td>
                                        <td data-label="Покази / кліки / пропуски · CTR"><?= (int) $c['impressions'] ?> / <?= (int) $c['clicks'] ?> / <?= (int) ($c['skips'] ?? 0) ?> · <?= pc_e(promo_ctr((int) $c['clicks'], (int) $c['impressions'])) ?></td>
                                        <td data-label="Пропуск вікна">
                                            <?php if ($popupCols): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="skip_delay">
                                                <input type="hidden" name="campaign_id" value="<?= $cid ?>">
                                                <select name="skip" aria-label="Затримка «Пропустити», с" onchange="this.form.submit()">
                                                    <option value="">за замовч.</option>
                                                    <?php for ($sec = AD_POPUP_SKIP_MIN; $sec <= AD_POPUP_SKIP_MAX; $sec++): ?>
                                                    <option value="<?= $sec ?>"<?= (string) ($c['skip_delay'] ?? '') === (string) $sec ? ' selected' : '' ?>><?= $sec ?> с</option>
                                                    <?php endfor; ?>
                                                </select>
                                                <noscript><button type="submit" class="pc-btn pc-btn--small">OK</button></noscript>
                                            </form>
                                            <?php else: ?>—<?php endif; ?>
                                        </td>
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
                                    <?php foreach ($pendingTopups as $tx):
                                        $txm = promo_tx_money($tx);
                                        $fxTx = !empty($tx['original_currency']);
                                        $expect = $fxTx ? formatMoney((int) $tx['original_amount'], (string) $tx['original_currency'], 'uk') : null; ?>
                                    <tr>
                                        <td data-label="Заявка">№<?= (int) $tx['id'] ?><span class="pc-muted"><?= pc_e(substr((string) $tx['created_at'], 0, 16)) ?></span></td>
                                        <td data-label="Рекламодавець"><?= pc_e($tx['name']) ?><span class="pc-muted"><?= pc_e($tx['email']) ?></span></td>
                                        <td data-label="Сума"><?php if ($fxTx): ?>очікується <strong><?= pc_e($expect) ?></strong><span class="pc-muted">→ на баланс <?= pc_e($txm['main']) ?>; <?= pc_e($txm['original']) ?></span><?php else: ?><strong><?= pc_e($txm['main']) ?></strong><?php endif; ?></td>
                                        <td data-label="Призначення"><code><?= pc_e($tx['reference']) ?></code></td>
                                        <td data-label="Рішення" class="pc-actions">
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form"
                                                  data-pc-confirm="Підтвердити заявку №<?= (int) $tx['id'] ?>? На баланс буде зараховано <?= pc_e($txm['main']) ?><?= $fxTx ? ' (якщо надійшла сума збігається з очікуваною ' . pc_e($expect) . ')' : '' ?>.">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="topup_decide">
                                                <input type="hidden" name="tx_id" value="<?= (int) $tx['id'] ?>">
                                                <input type="hidden" name="decision" value="confirm">
                                                <?php if ($fxTx): ?>
                                                <label class="pc-field"><span>Фактично надійшло, <?= pc_e((string) $tx['original_currency']) ?></span>
                                                    <input type="text" name="received" inputmode="decimal" required placeholder="<?= pc_e(promo_money_input($tx['original_amount'])) ?>"></label>
                                                <label class="pc-check"><input type="checkbox" name="accept_diff" value="1"> <span>Зарахувати за фактичною сумою, якщо вона інша (за курсом заявки)</span></label>
                                                <?php endif; ?>
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--primary">Підтвердити</button>
                                            </form>
                                            <form method="post" action="promo-admin-action.php" class="pc-reject pc-reject--inline"
                                                  data-pc-confirm="Відхилити заявку №<?= (int) $tx['id'] ?> на <?= pc_e($fxTx ? $expect : $txm['main']) ?>?">
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
                            <form method="post" action="promo-admin-action.php" class="pc-filter"
                                  data-pc-confirm="Змінити баланс рекламодавця на вказану суму? Запис потрапить у журнал.">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="adjust">
                                <label class="pc-field"><span>Email або ID користувача</span><input type="text" name="who" required></label>
                                <label class="pc-field"><span>Тип</span>
                                    <select name="type"><option value="adjust">Коригування (±)</option><option value="refund">Повернення на баланс (+)</option></select></label>
                                <label class="pc-field"><span>Сума, $ (мінус — списати)</span><input type="text" name="amount" inputmode="decimal" required placeholder="напр. 100 або -25.50"></label>
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
                                        <?php $txm = promo_tx_money($tx); ?>
                                        <td data-label="Сума"><?= pc_e($txm['main']) ?><?php if ($txm['original'] !== null): ?><span class="pc-muted"><?= pc_e($txm['original']) ?></span><?php endif; ?></td>
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
                            <p class="pc-muted">Ціни в доларах США. CPM — за 1000 показів, CPC — за клік. Порожнє поле — ціни немає: платну кампанію з цим розміщенням і моделлю надіслати не можна. Ціна фіксується в кампанії на момент надсилання — зміна прайсу не впливає на вже надіслані кампанії.</p>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="rates">
                                <div class="pc-table-wrap">
                                    <table class="pc-table">
                                        <thead><tr><th>Розміщення</th><th>CPM, $ / 1000 показів</th><th>CPC, $ / клік</th></tr></thead>
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

                        <!-- ============ Місця показу ============ -->
                        <section class="pc-panel" data-pc-panel="placements"<?= $tab === 'placements' ? '' : ' hidden' ?>>
                            <?php if (!$placementsTableOk): ?>
                            <p class="pc-note pc-note--warn">Таблиці ad_placements ще немає — застосуйте міграцію database/migration-2026-10-18-promo-placements.sql. Доти діють значення за замовчуванням.</p>
                            <?php endif; ?>
                            <p class="pc-muted">Вимкнене місце ніколи не показує рекламу, і рекламодавці не можуть його обрати. Місце без ціни за моделлю в прайсі в майстрі неактивне. Місця маркетплейсу показують рекламу лише коли маркетплейс відкрито (marketplace_public); до відкриття їх можна обрати, якщо ad_allow_marketplace_preselect = 1 (кошти не списуються). Перегляди сторінок маркетплейсу пишуться з 20.10. Ємність — людські перегляди відповідних сторінок за останні 30 днів (без ботів і сторінок no_promo; клас пристрою пишеться з 12.10, види сторінок каталогу й список блогу — з 18.10).</p>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="placements_save">
                                <div class="pc-table-wrap">
                                    <table class="pc-table">
                                        <thead><tr><th>Місце</th><th>Увімкнено</th><th>Блоків на сторінку</th><th>Стан</th><th>Перегляди за 30 днів</th><th>На сайті</th></tr></thead>
                                        <tbody>
                                        <?php foreach ($placementRows as $k => $p):
                                            $state = [];
                                            $mpClosed = $p['group_key'] === 'marketplace' && $p['block'] === 'setting';
                                            if ($mpClosed) {
                                                $state[] = 'маркетплейс не відкрито' . (promo_placement_pending($pdo, $k) ? ' (місце вже можна обрати; показ — після відкриття)' : '');
                                            } elseif ($p['requires_setting'] !== null) {
                                                $state[] = 'залежить від ' . $p['requires_setting'] . (site_setting($pdo, $p['requires_setting'], '0') === '1' ? ' (увімкнено)' : ' (вимкнено)');
                                            }
                                            if (!empty($p['rule']['requires_feature']) && empty(PROMO_PLACEMENT_FEATURES[$p['rule']['requires_feature']])) {
                                                $state[] = 'потрібна позначка «Просунуте» для оголошень (ще не зроблена)';
                                            }
                                            $prices = [];
                                            foreach (['cpm' => 'CPM', 'cpc' => 'CPC'] as $m => $ml) {
                                                if (!empty($rates[$k][$m])) {
                                                    $prices[] = $ml . ' ' . promo_money($rates[$k][$m]);
                                                }
                                            }
                                            $state[] = $prices !== [] ? 'є ціна: ' . implode(' · ', $prices) : 'немає ціни';
                                            ?>
                                        <tr>
                                            <td data-label="Місце"><strong><?= pc_e($p['title_uk']) ?></strong><span class="pc-muted"><?= pc_e($k) ?> · <?= pc_e(['catalog' => 'Каталог', 'blog' => 'Блог', 'marketplace' => 'Маркетплейс'][$p['group_key']] ?? $p['group_key']) ?></span></td>
                                            <td data-label="Увімкнено"><label class="pc-check"><input type="checkbox" name="enabled[<?= pc_e($k) ?>]" value="1"<?= $p['enabled'] ? ' checked' : '' ?>> <span>так</span></label></td>
                                            <td data-label="Блоків на сторінку"><input type="number" name="slots[<?= pc_e($k) ?>]" value="<?= (int) $p['slots_per_page'] ?>" min="1" max="3" style="width:5em"></td>
                                            <td data-label="Стан"><?= pc_e(implode('; ', $state)) ?><?php if ($p['block'] === null && $p['enabled']): ?><span class="pc-muted"><?= $prices !== [] ? 'активно' : 'доступне, але без ціни не обирається' ?></span><?php elseif ($p['block'] === 'disabled'): ?><span class="pc-muted">вимкнене</span><?php endif; ?></td>
                                            <td data-label="Перегляди за 30 днів"><?= $mpClosed ? 'ще немає' : ($p['capacity'] === null ? 'немає даних' : ($p['capacity'] < PROMO_CAPACITY_MIN_VIEWS ? 'даних поки замало (' . (int) $p['capacity'] . ')' : number_format($p['capacity'], 0, ',', ' '))) ?></td>
                                            <td data-label="На сайті"><?php if ($p['preview'] !== null): ?><a href="<?= pc_e($p['preview']) ?>" target="_blank" rel="noopener">Переглянути на сайті</a><?php else: ?>—<?php endif; ?></td>
                                        </tr>
                                        <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                                <button type="submit" class="pc-btn pc-btn--primary">Зберегти місця</button>
                            </form>
                            <p class="pc-muted">«Переглянути на сайті» відкриває сторінку з ?promo_preview=1: адміністратор бачить блок місця з креативом тестової кампанії (навіть коли реклама чи місце вимкнені). Покази, кліки й скарги в перегляді не рахуються й не списуються. Сторінки no_promo блока не мають і в перегляді.</p>

                            <h3 class="pc-h3">Тестова кампанія для перегляду</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-inline-form">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="test_campaign">
                                <select name="campaign_id" aria-label="Тестова кампанія">
                                    <option value="0">— немає —</option>
                                    <?php foreach ($testCandidates as $c): ?>
                                    <option value="<?= (int) $c['id'] ?>"<?= (int) $c['is_test'] === 1 ? ' selected' : '' ?>>#<?= (int) $c['id'] ?> <?= pc_e($c['name']) ?> (<?= pc_e($statusUk[$c['status']] ?? $c['status']) ?><?= $c['campaign_type'] === 'internal' ? ', власна' : '' ?>)</option>
                                    <?php endforeach; ?>
                                </select>
                                <button type="submit" class="pc-btn">Зберегти</button>
                            </form>
                            <p class="pc-muted">Підійде будь-яка відеокампанія з відео (зручно — власна реклама сайту на паузі). Статус кампанії не змінюється.</p>

                            <h3 class="pc-h3">Єдина ціна для всіх місць</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-inline-form" data-pc-confirm="Задати цю ціну для всіх увімкнених місць? Ціни в уже надісланих кампаніях не зміняться.">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="uniform_price">
                                <select name="model" aria-label="Модель">
                                    <option value="cpm">CPM, $ за 1000 показів</option>
                                    <option value="cpc">CPC, $ за клік</option>
                                </select>
                                <input type="text" inputmode="decimal" name="price" placeholder="0.00" aria-label="Ціна, $" style="width:7em">
                                <button type="submit" class="pc-btn pc-btn--primary">Задати для всіх увімкнених</button>
                            </form>
                            <p class="pc-muted">Записується в прайс (ad_rate_card) для кожного увімкненого місця; окремі ціни потім можна змінити на вкладці «Прайс-лист».</p>

                            <h3 class="pc-h3">Категорії статей блогу</h3>
                            <p class="pc-muted">Таргетинг за категорією в блозі працює для статей із категоріями: теми з коду (BLOG_ARTICLE_TOPICS) + призначені тут. Статті без категорій показують лише рекламу для всіх категорій.</p>
                            <?php if ($blogSlug !== '' && isset(BLOG_ARTICLES[$blogSlug])):
                                $assigned = [];
                                foreach (promo_blog_assigned($pdo, $blogSlug) as [$bc, $bs]) {
                                    $assigned[] = $bs > 0 ? $bc . ':' . $bs : (string) $bc;
                                }
                                ?>
                            <form method="post" action="promo-admin-action.php" class="pc-box">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="blog_categories">
                                <input type="hidden" name="slug" value="<?= pc_e($blogSlug) ?>">
                                <p><strong><?= pc_e($blogSlug) ?></strong> — оберіть категорії або окремі підкатегорії (додатково до тем із коду).</p>
                                <div class="pc-cats">
                                    <?php foreach (promo_taxonomy($pdo) as $cid => $cat): ?>
                                    <details class="pc-cat"<?= in_array((string) $cid, $assigned, true) || array_filter($assigned, static fn($a) => str_starts_with($a, $cid . ':')) ? ' open' : '' ?>>
                                        <summary><label class="pc-check" onclick="event.stopPropagation()"><input type="checkbox" name="cats[]" value="<?= $cid ?>"<?= in_array((string) $cid, $assigned, true) ? ' checked' : '' ?>> <span><?= pc_e($cat['name']) ?> <small>(уся категорія)</small></span></label></summary>
                                        <div class="pc-subs">
                                            <?php foreach ($cat['subs'] as $sid => $sub): ?>
                                            <label class="pc-check"><input type="checkbox" name="cats[]" value="<?= $cid ?>:<?= $sid ?>"<?= in_array($cid . ':' . $sid, $assigned, true) ? ' checked' : '' ?>> <span><?= pc_e($sub['name']) ?></span></label>
                                            <?php endforeach; ?>
                                        </div>
                                    </details>
                                    <?php endforeach; ?>
                                </div>
                                <p class="pc-actions"><button type="submit" class="pc-btn pc-btn--primary">Зберегти категорії статті</button>
                                    <a class="pc-btn" href="account.php?padm_tab=placements#acc-promo-admin">Скасувати</a></p>
                            </form>
                            <?php endif; ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Стаття</th><th>Категорії</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach (blog_list_articles('uk') as $art):
                                        $slugA = (string) $art['slug'];
                                        [$ac, $as] = $blogMap[$slugA] ?? [[], []];
                                        $names = array_merge(array_map(static fn($i) => $catNames[$i] ?? ('#' . $i), $ac), array_map(static fn($i) => $subNames[$i] ?? ('#' . $i), $as));
                                        ?>
                                    <tr>
                                        <td data-label="Стаття"><?= pc_e($art['title']) ?><span class="pc-muted"><?= pc_e($slugA) ?></span></td>
                                        <td data-label="Категорії"><?= $names === [] ? '<span class="pc-warn-text">немає — лише реклама для всіх категорій</span>' : pc_e(implode(', ', $names)) ?></td>
                                        <td data-label="Дії"><a class="pc-btn pc-btn--small" href="account.php?padm_tab=placements&amp;padm_blog=<?= pc_e(rawurlencode($slugA)) ?>#acc-promo-admin">Призначити</a></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        </section>

                        <!-- ============ D4. Налаштування ============ -->
                        <section class="pc-panel" data-pc-panel="settings"<?= $tab === 'settings' ? '' : ' hidden' ?>>
                            <?= $readinessHtml ?>
                            <p class="pc-muted">Сервер: upload_max_filesize = <?= pc_e(ini_get('upload_max_filesize')) ?>, post_max_size = <?= pc_e(ini_get('post_max_size')) ?>. Перемикач усієї реклами — угорі розділу.</p>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="settings">
                                <div class="pc-grid-2">
                                    <label class="pc-field"><span>Макс. розмір відео, МБ</span><input type="text" inputmode="numeric" name="max_video_mb" value="<?= pc_e($settings['max_video_mb'] ?? '30') ?>"></label>
                                    <label class="pc-field"><span>Макс. тривалість відео, с</span><input type="text" inputmode="numeric" name="max_video_sec" value="<?= pc_e($settings['max_video_sec'] ?? '30') ?>"></label>
                                    <label class="pc-field"><span>Мін. поповнення, $ (порожньо — без мінімуму)</span><input type="text" inputmode="decimal" name="min_topup" value="<?= pc_e($settings['min_topup'] ?? '') ?>"></label>
                                    <label class="pc-field"><span>Ліміт показів кампанії одному сеансу на добу (0 — без ліміту)</span><input type="text" inputmode="numeric" name="frequency_cap_per_session" value="<?= pc_e($settings['frequency_cap_per_session'] ?? '3') ?>"></label>
                                    <label class="pc-field"><span>Тиша після входу, реєстрації, підтвердження пошти чи виходу, хв (0 — лише на самих сторінках входу)</span><input type="text" inputmode="numeric" name="promo_suppress_after_auth_minutes" value="<?= pc_e($settings['promo_suppress_after_auth_minutes'] ?? (string) PROMO_QUIET_DEFAULT_MINUTES) ?>"></label>
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
                                <label class="pc-field"><span>Строк модерації для медіакіту <a href="advertise.php" target="_blank" rel="noopener">advertise.php</a> (UA). Порожньо — «фіксованого строку немає».</span>
                                    <input type="text" name="moderation_time_text_uk" maxlength="500" value="<?= pc_e($settings['moderation_time_text_uk'] ?? '') ?>"></label>
                                <label class="pc-field"><span>Строк модерації (EN)</span>
                                    <input type="text" name="moderation_time_text_en" maxlength="500" value="<?= pc_e($settings['moderation_time_text_en'] ?? '') ?>"></label>
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

                            <?= promo_house_report_html($pdo) ?>

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

                        <!-- ============ G. Перевірка посилань ============ -->
                        <section class="pc-panel" data-pc-panel="links"<?= $tab === 'links' ? '' : ' hidden' ?>>
                            <p>Провайдер Safe Browsing: <strong><?= pc_e($sbProvider->name()) ?></strong>.
                                <?php if ($sbOff): ?><span class="pc-warn-text">Автоматичної перевірки на шкідливі сторінки немає — ключ вписується в config/promo.php (див. docs/PROMO_OPERATIONS.md).</span><?php endif; ?></p>
                            <p class="pc-muted">Адреса перевіряється при надсиланні на модерацію й при кожній зміні; повторно — активні креативи щодоби, решта щотижня (cron). Автопауза з поверненням на модерацію: зміна кінцевого домену, Safe Browsing/Web Risk «flagged», домен у чорному списку, <?= PROMO_LINK_FAIL_LIMIT ?> помилки поспіль.</p>

                            <h3 class="pc-h3">Чорний список доменів</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-filter">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="blocklist_add">
                                <label class="pc-field"><span>Домен (піддомени теж)</span><input type="text" name="domain" required placeholder="example.com"></label>
                                <label class="pc-field"><span>Причина</span><input type="text" name="reason" maxlength="255"></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Додати</button>
                            </form>
                            <?php if ($blocklist === []): ?>
                            <p class="pc-empty">Чорний список порожній.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Домен</th><th>Причина</th><th>Додано</th><th></th></tr></thead>
                                    <tbody>
                                    <?php foreach ($blocklist as $b): ?>
                                    <tr>
                                        <td data-label="Домен"><?= pc_e($b['domain']) ?></td>
                                        <td data-label="Причина"><?= pc_e($b['reason'] ?? '') ?></td>
                                        <td data-label="Додано"><?= pc_e(promo_local_time($b['created_at'])) ?></td>
                                        <td data-label="" class="pc-actions">
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form" data-pc-confirm="Прибрати <?= pc_e($b['domain']) ?> з чорного списку?">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="blocklist_remove">
                                                <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--danger">Прибрати</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">Скорочувачі посилань</h3>
                            <form method="post" action="promo-admin-action.php">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="shorteners">
                                <label class="pc-field"><span>Домен на рядок. Креатив із таким доменом (на будь-якому кроці переадресації) отримує прапорець.</span>
                                    <textarea name="shortener_domains" rows="6"><?= pc_e(implode("\n", promo_shortener_list($pdo))) ?></textarea></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Зберегти список</button>
                            </form>

                            <h3 class="pc-h3">Останні перевірки</h3>
                            <?php if ($recentChecks === []): ?>
                            <p class="pc-empty">Перевірок ще не було.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Час (Київ)</th><th>Креатив</th><th>Кінцевий домен</th><th>HTTP</th><th>Safe Browsing</th><th>Прапорці</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($recentChecks as $l): ?>
                                    <tr>
                                        <td data-label="Час"><?= pc_e(promo_local_time($l['checked_at'])) ?></td>
                                        <td data-label="Креатив">#<?= (int) $l['creative_id'] ?><span class="pc-muted">кампанія #<?= (int) $l['campaign_id'] ?></span></td>
                                        <td data-label="Домен"><?= pc_e($l['final_host'] ?? '—') ?></td>
                                        <td data-label="HTTP"><?= $l['http_status'] !== null ? (int) $l['http_status'] : '—' ?></td>
                                        <td data-label="Safe Browsing"><?= pc_e($l['safe_browsing_status']) ?></td>
                                        <td data-label="Прапорці"><?= $l['flags'] !== '' ? '<span class="pc-warn-text">' . pc_e($flagText($l['flags'])) . '</span>' : '—' ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">Журнал подій реклами</h3>
                            <?php if ($eventLog === []): ?>
                            <p class="pc-empty">Подій ще немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Час (Київ)</th><th>Подія</th><th>Кампанія / креатив</th><th>Деталі</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($eventLog as $ev): ?>
                                    <tr>
                                        <td data-label="Час"><?= pc_e(promo_local_time($ev['created_at'])) ?></td>
                                        <td data-label="Подія"><?= pc_e($ev['event']) ?><?= $ev['user_id'] ? '<span class="pc-muted">користувач #' . (int) $ev['user_id'] . '</span>' : '' ?></td>
                                        <td data-label="Кампанія"><?= $ev['campaign_id'] ? '#' . (int) $ev['campaign_id'] : '' ?><?= $ev['creative_id'] ? ' / #' . (int) $ev['creative_id'] : '' ?></td>
                                        <td data-label="Деталі"><?= pc_e($ev['details'] ?? '') ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>

                        <!-- ============ I4. Стан ============ -->
                        <section class="pc-panel" data-pc-panel="status"<?= $tab === 'status' ? '' : ' hidden' ?>>
                            <?= $readinessHtml ?>
                            <?php require_once __DIR__ . '/eli.php'; ?>
                            <h3 class="pc-h3">Еля</h3>
                            <?= eli_stats_css() ?>
                            <?= eli_stats_html($pdo) ?>
                            <h3 class="pc-h3">Cron і пошта</h3>
                            <?php foreach ($sys['jobs'] as $job => $j): if ($j['stale']): ?>
                            <div class="pc-box pc-box--danger"><strong><?= pc_e($job) ?></strong>: <?= $j['last_ok'] === null ? 'жодного успішного запуску' : 'не запускалось довше за очікуване (останній успішний — ' . pc_e(promo_local_time($j['last_ok'])) . ')' ?>. Перевірте розклад у панелі хостингу (docs/PROMO_OPERATIONS.md).</div>
                            <?php endif; endforeach; ?>
                            <?php if ($sys['mail_failed'] > 0): ?>
                            <div class="pc-box pc-box--danger">Листів із помилкою відправки: <strong><?= (int) $sys['mail_failed'] ?></strong> — див. нижче й налаштування config/mail.php.</div>
                            <?php endif; ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Завдання</th><th>Останній запуск (Київ)</th><th>Результат</th><th>Останній успішний</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($sys['jobs'] as $job => $j): $last = $j['last']; ?>
                                    <tr>
                                        <td data-label="Завдання"><code>cron/<?= pc_e($job) ?>.php</code><span class="pc-muted"><?= pc_e($j['label']) ?></span></td>
                                        <td data-label="Запуск"><?= $last ? pc_e(promo_local_time($last['started_at'])) : '—' ?></td>
                                        <td data-label="Результат"><?php if ($last): ?><span class="<?= $last['status'] === 'error' ? 'pc-warn-text' : '' ?>"><?= pc_e($last['status']) ?></span><span class="pc-muted"><?= pc_e($last['message'] ?? '') ?></span><?php else: ?>—<?php endif; ?></td>
                                        <td data-label="Успішний"><?= $j['last_ok'] ? pc_e(promo_local_time($j['last_ok'])) : '—' ?><?= $j['stale'] ? ' <strong class="pc-warn-text">!</strong>' : '' ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <dl class="pc-summary">
                                <dt>Пошта</dt><dd>транспорт: <strong><?= pc_e($sys['mail_transport']) ?></strong><?= $sys['mail_transport'] === 'log' ? ' (тестовий режим — листи НЕ відправляються)' : ($sys['mail_transport'] === 'mail' ? ' (PHP mail(); SMTP не налаштовано)' : '') ?></dd>
                                <dt>Черга листів</dt><dd><?= (int) $sys['mail_pending'] ?> в очікуванні<?= $sys['mail_oldest_pending'] ? ' (найстаріший — ' . pc_e(promo_local_time($sys['mail_oldest_pending'])) . ')' : '' ?> · з помилкою: <?= (int) $sys['mail_failed'] ?></dd>
                                <dt>Остання успішна перевірка посилань</dt><dd><?= $sys['last_link_check'] ? pc_e(promo_local_time($sys['last_link_check'])) : '—' ?></dd>
                                <dt>Часовий пояс</dt><dd>час у БД — UTC; тут показано за Києвом; «доба» реклами — київська (сьогодні <?= pc_e(promo_today()) ?>)</dd>
                            </dl>
                            <?php if ($failedMails !== []): ?>
                            <h3 class="pc-h3">Листи з помилкою</h3>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Кому</th><th>Тема</th><th>Спроб</th><th>Помилка</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($failedMails as $fm): ?>
                                    <tr>
                                        <td data-label="Кому"><?= pc_e($fm['to_email']) ?><span class="pc-muted"><?= pc_e(promo_local_time($fm['created_at'])) ?></span></td>
                                        <td data-label="Тема"><?= pc_e($fm['subject']) ?></td>
                                        <td data-label="Спроб"><?= (int) $fm['attempts'] ?></td>
                                        <td data-label="Помилка"><?= pc_e($fm['last_error'] ?? '') ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>

                        <!-- ============ H. Виключення реклами ============ -->
                        <section class="pc-panel" data-pc-panel="exclusions"<?= $tab === 'exclusions' ? '' : ' hidden' ?>>
                            <p class="pc-muted">«Без реклами» (no_promo): на сторінці немає жодного рекламного блоку — ні відео, ні старих банерів, ні порожнього місця. Підкатегорія успадковує прапорець категорії, продукт — прапорці своїх категорій і підкатегорій.</p>

                            <h3 class="pc-h3">Перевірити сторінку</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-filter">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="diagnose_page">
                                <label class="pc-field"><span>Адреса сторінки (product.php?id=…, catalog.php?subcategory=…, blog-post.php?slug=…)</span>
                                    <input type="text" name="url" value="<?= pc_e($diagnoseUrl) ?>" required placeholder="https://ailabhub-directory.com/product.php?id=123"></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Перевірити</button>
                            </form>
                            <?php if (is_array($diagnose)): ?>
                            <ul class="pc-diagnose">
                                <?php foreach ($diagnose as [$okLine, $line]): ?>
                                <li class="<?= $okLine ? '' : 'pc-warn-text' ?>"><?= $okLine ? '✓' : '✗' ?> <?= pc_e($line) ?></li>
                                <?php endforeach; ?>
                            </ul>
                            <?php endif; ?>

                            <h3 class="pc-h3">Сторінки «без реклами»</h3>
                            <form method="post" action="promo-admin-action.php" class="pc-filter">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="no_promo">
                                <input type="hidden" name="on" value="1">
                                <label class="pc-field"><span>Тип</span>
                                    <select name="type"><option value="category">Категорія (ID)</option><option value="subcategory">Підкатегорія (ID)</option><option value="product">Продукт (ID)</option><option value="article">Стаття блогу (slug)</option></select></label>
                                <label class="pc-field"><span>ID або slug</span><input type="text" name="id" required></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Позначити «без реклами»</button>
                            </form>
                            <details class="pc-box">
                                <summary>Довідник ID категорій і підкатегорій, slug статей</summary>
                                <?php foreach ($taxonomyAll as $tcid => $tc): ?>
                                <p><strong>#<?= (int) $tcid ?> <?= pc_e($tc['name']) ?></strong><br>
                                    <span class="pc-muted"><?= pc_e(implode(' · ', array_map(static fn($ts) => '#' . $ts['id'] . ' ' . $ts['name'], $tc['subs']))) ?></span></p>
                                <?php endforeach; ?>
                                <p><strong>Статті:</strong> <span class="pc-muted"><?= pc_e(implode(' · ', array_keys(BLOG_ARTICLES))) ?></span></p>
                            </details>
                            <?php
                            $npRows = [];
                            foreach ($noPromo['categories'] as $r) { $npRows[] = ['category', (string) $r['id'], 'Категорія', '#' . $r['id'] . ' ' . $r['name']]; }
                            foreach ($noPromo['subcategories'] as $r) { $npRows[] = ['subcategory', (string) $r['id'], 'Підкатегорія', '#' . $r['id'] . ' ' . $r['category'] . ' → ' . $r['name']]; }
                            foreach ($noPromo['articles'] as $slug) { $npRows[] = ['article', (string) $slug, 'Стаття', (string) $slug]; }
                            foreach ($noPromo['products'] as $r) { $npRows[] = ['product', (string) $r['id'], 'Продукт', '#' . $r['id'] . ' ' . $r['name']]; }
                            ?>
                            <?php if ($npRows === []): ?>
                            <p class="pc-empty">Виключених сторінок немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Тип</th><th>Сторінка</th><th></th></tr></thead>
                                    <tbody>
                                    <?php foreach ($npRows as [$npType, $npId, $npLabel, $npName]): ?>
                                    <tr>
                                        <td data-label="Тип"><?= pc_e($npLabel) ?></td>
                                        <td data-label="Сторінка"><?= pc_e($npName) ?></td>
                                        <td data-label="" class="pc-actions">
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form" data-pc-confirm="Дозволити рекламу: <?= pc_e($npName) ?>?">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="no_promo">
                                                <input type="hidden" name="on" value="0">
                                                <input type="hidden" name="type" value="<?= pc_e($npType) ?>">
                                                <input type="hidden" name="id" value="<?= pc_e($npId) ?>">
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--danger">Зняти прапорець</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3">Правила категорій реклами</h3>
                            <p class="pc-muted">Реклама обраної категорії не показується на сторінках області правила. Правило «усі сторінки» також забороняє схвалення такої реклами.</p>
                            <form method="post" action="promo-admin-action.php" class="pc-filter">
                                <?= $csrf ?>
                                <input type="hidden" name="action" value="rule_add">
                                <label class="pc-field"><span>Категорія реклами</span>
                                    <select name="advertiser_category" required>
                                        <?php foreach (PROMO_ADVERTISER_CATEGORIES as $k => $labels): ?><option value="<?= $k ?>"><?= pc_e($labels[0]) ?></option><?php endforeach; ?>
                                    </select></label>
                                <label class="pc-field"><span>Де заборонено</span>
                                    <select name="scope">
                                        <option value="all:0">Усі сторінки</option>
                                        <?php foreach ($taxonomyAll as $tcid => $tc): ?>
                                        <option value="category:<?= (int) $tcid ?>">Категорія: <?= pc_e($tc['name']) ?></option>
                                        <?php foreach ($tc['subs'] as $tsid => $ts): ?>
                                        <option value="subcategory:<?= (int) $tsid ?>">&nbsp;&nbsp;↳ <?= pc_e($ts['name']) ?></option>
                                        <?php endforeach; ?>
                                        <?php endforeach; ?>
                                    </select></label>
                                <label class="pc-field"><span>Примітка</span><input type="text" name="note" maxlength="255"></label>
                                <button type="submit" class="pc-btn pc-btn--primary">Додати правило</button>
                            </form>
                            <?php if ($catRules === []): ?>
                            <p class="pc-empty">Правил немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Категорія реклами</th><th>Де заборонено</th><th>Примітка</th><th></th></tr></thead>
                                    <tbody>
                                    <?php foreach ($catRules as $rule): ?>
                                    <tr>
                                        <td data-label="Категорія"><?= pc_e(promo_advertiser_category_label($rule['advertiser_category'])) ?></td>
                                        <td data-label="Де"><?= pc_e($rule['scope_name'] ?? ('#' . $rule['scope_id'])) ?></td>
                                        <td data-label="Примітка"><?= pc_e($rule['note'] ?? '') ?></td>
                                        <td data-label="" class="pc-actions">
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form" data-pc-confirm="Видалити правило?">
                                                <?= $csrf ?>
                                                <input type="hidden" name="action" value="rule_delete">
                                                <input type="hidden" name="id" value="<?= (int) $rule['id'] ?>">
                                                <button type="submit" class="pc-btn pc-btn--small pc-btn--danger">Видалити</button>
                                            </form>
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
                            <?= promo_house_admin_html($pdo, $csrf, $badge) ?>
                            <h3 class="pc-h3">Власна відеореклама</h3>
                            <p class="pc-muted">Самопромоція сайту з відео (напр. підписка на розсилку, Еля): без білінгу й модерації, показується у вільних слотах — платні кампанії мають пріоритет.</p>
                            <p><a class="pc-btn" href="account.php?promo_tab=create&amp;promo_house=1#acc-promo">Створити власну відеорекламу</a></p>
                            <?php if ($house === []): ?>
                            <p class="pc-empty">Власної відеореклами ще немає.</p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th>Кампанія</th><th>Статус</th><th>Покази / кліки / пропуски · CTR</th><th>Дії</th></tr></thead>
                                    <tbody>
                                    <?php foreach ($house as $c): $cid = (int) $c['id']; ?>
                                    <tr>
                                        <td data-label="Кампанія">#<?= $cid ?> <?= pc_e($c['name']) ?><span class="pc-muted"><?= pc_e((string) $c['start_date']) ?><?= $c['end_date'] ? ' — ' . pc_e($c['end_date']) : '' ?></span></td>
                                        <td data-label="Статус"><?= $badge((string) $c['status']) ?></td>
                                        <td data-label="Покази / кліки / пропуски · CTR"><?= (int) $c['impressions'] ?> / <?= (int) $c['clicks'] ?> / <?= (int) ($c['skips'] ?? 0) ?> · <?= pc_e(promo_ctr((int) $c['clicks'], (int) $c['impressions'])) ?></td>
                                        <td data-label="Дії" class="pc-actions">
                                            <?php if (in_array($c['status'], PROMO_EDITABLE, true) && (int) $c['user_id'] === (int) $user['id']): ?>
                                            <a class="pc-btn pc-btn--small" href="account.php?promo_tab=create&amp;promo_house=1&amp;promo_edit=<?= $cid ?>#acc-promo">Редагувати</a>
                                            <?php endif; ?>
                                            <?php foreach (array_filter([
                                                $c['status'] === 'active' ? 'stop' : null,
                                                $c['status'] === 'paused' ? 'resume' : null,
                                                $c['status'] !== 'completed' ? 'complete' : null,
                                            ]) as $op): ?>
                                            <form method="post" action="promo-admin-action.php" class="pc-inline-form"<?= $op === 'complete' ? ' data-pc-confirm="Завершити власну рекламу #' . $cid . '?"' : '' ?>>
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

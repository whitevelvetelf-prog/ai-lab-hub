<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Реклама» в кабінеті (public/account.php).
 *
 * Вкладки: Кампанії · Створити кампанію (майстер із 5 кроків) · Баланс і оплата · Статистика.
 * Дії відправляються на public/promo-action.php. Логіка — app/promo-advertiser.php,
 * клієнтська частина майстра — public/assets/js/promo-cabinet.js.
 *
 * Розділ видно всім зареєстрованим, коли система реклами ввімкнена
 * (ad_settings.enabled); адміністратору — завжди.
 */

require_once __DIR__ . '/promo-advertiser.php';
require_once __DIR__ . '/promo-placement-picker.php';

function pc_e(mixed $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES);
}

/** Чи показувати розділ «Реклама» цьому користувачу. */
function promo_cabinet_visible(PDO $pdo, array $user): bool
{
    try {
        $pdo->query('SELECT 1 FROM ad_settings LIMIT 1');
    } catch (Throwable $e) {
        return false; // міграцію ще не застосовано
    }

    return promo_enabled($pdo) || ($user['role'] ?? '') === 'admin';
}

function promo_status_badge(string $status): string
{
    return '<span class="pc-badge pc-badge--' . pc_e($status) . '">' . pc_e(promo_tr('status_' . $status)) . '</span>';
}

function promo_cabinet_render(PDO $pdo, array $user): void
{
    $userId = (int) $user['id'];
    $flash = $_SESSION['promo_flash'] ?? null;
    $old = $_SESSION['promo_old'] ?? null;
    unset($_SESSION['promo_flash'], $_SESSION['promo_old']);

    $tab = in_array($_GET['promo_tab'] ?? '', ['campaigns', 'create', 'balance', 'stats'], true) ? $_GET['promo_tab'] : 'campaigns';
    $lang = promo_lang();
    require_once __DIR__ . '/promo-mail.php';
    promo_notify_remember_lang($pdo, $userId, $lang);
    $notifyPrefs = promo_notify_prefs($pdo, $userId);

    $campaignsSt = $pdo->prepare("SELECT * FROM ad_campaigns WHERE user_id = :u AND format = 'video' AND campaign_type = 'paid' ORDER BY id DESC");
    $campaignsSt->execute([':u' => $userId]);
    $campaigns = $campaignsSt->fetchAll();
    $totals = promo_campaign_totals($pdo, $userId);
    $balance = promo_balance($pdo, $userId);
    $balanceCur = promo_balance_currency($pdo, $userId);
    $rates = promo_rate_card($pdo);
    $taxonomy = promo_taxonomy($pdo);
    $enabled = promo_enabled($pdo);

    // Форма «Місця показу» для наявної кампанії (draft/paused/active).
    $placesId = (int) ($_GET['promo_places'] ?? 0);
    $placesCampaign = $placesId > 0 ? promo_owned_campaign($pdo, $userId, $placesId) : null;
    if ($placesCampaign !== null && !in_array($placesCampaign['status'], PROMO_PLACES_EDITABLE, true)) {
        $placesCampaign = null;
    }
    // Форма «Бюджет і дати» (без модерації).
    $budgetId = (int) ($_GET['promo_budget'] ?? 0);
    $budgetCampaign = $budgetId > 0 ? promo_owned_campaign($pdo, $userId, $budgetId) : null;
    if ($budgetCampaign !== null && !in_array($budgetCampaign['status'], PROMO_BUDGET_EDITABLE, true)) {
        $budgetCampaign = null;
    }
    // Майстер: нова кампанія, редагування власної (PROMO_EDITABLE) або повернене введення.
    $editId = (int) ($_GET['promo_edit'] ?? 0);
    $editing = $editId > 0 ? promo_owned_campaign($pdo, $userId, $editId) : null;
    if ($editing !== null && !in_array($editing['status'], PROMO_EDITABLE, true)) {
        $editing = null;
    }
    // Режим «власна реклама сайту» (лише admin): без оплати, запуск одразу (етап D6).
    $isAdmin = ($user['role'] ?? '') === 'admin';
    if ($editing !== null && $editing['campaign_type'] === 'internal' && !$isAdmin) {
        $editing = null;
    }
    $house = $isAdmin && (!empty($_GET['promo_house']) || ($editing !== null && $editing['campaign_type'] === 'internal'));
    if ($house && $editing !== null && $editing['campaign_type'] !== 'internal') {
        $house = false;
    }
    $creative = $editing ? promo_campaign_creative($pdo, (int) $editing['id']) : null;
    $targeting = $editing ? promo_campaign_targeting($pdo, (int) $editing['id']) : ['placements' => [], 'cats' => [], 'subs' => [], 'mp' => [], 'language' => 'all', 'device' => 'all'];
    $f = [
        'name' => $editing['name'] ?? '',
        'objective' => $editing['objective'] ?? 'awareness',
        'advertiser_category' => $editing['advertiser_category'] ?? '',
        'video_type' => $creative['video_type'] ?? 'upload',
        'youtube_url' => $creative['video_url'] ?? '',
        'title' => $creative['title'] ?? '',
        'description' => $creative['description'] ?? '',
        'cta_key' => $creative['cta_key'] ?? 'learn_more',
        'destination_url' => $creative['destination_url'] ?? '',
        'language' => $targeting['language'],
        'device' => $targeting['device'],
        'placements' => $targeting['placements'],
        'cats' => $targeting['cats'],
        'subs' => $targeting['subs'],
        'mp' => $targeting['mp'],
        'cat_all' => $editing !== null && $targeting['placements'] !== [] && $targeting['cats'] === [] && $targeting['subs'] === [],
        'daily_budget' => promo_money_input($editing['daily_budget'] ?? null),
        'total_budget' => promo_money_input($editing['total_budget'] ?? null),
        'start_date' => $editing['start_date'] ?? '',
        'end_date' => $editing['end_date'] ?? '',
    ];
    if (is_array($old)) {
        foreach (['name', 'objective', 'advertiser_category', 'video_type', 'youtube_url', 'title', 'description', 'cta_key', 'destination_url', 'language', 'device', 'daily_budget', 'total_budget', 'start_date', 'end_date'] as $k) {
            if (isset($old[$k]) && is_string($old[$k])) {
                $f[$k] = $old[$k];
            }
        }
        $f['placements'] = array_values(array_filter((array) ($old['placements'] ?? []), 'is_string'));
        $f['cats'] = array_map('intval', (array) ($old['cats'] ?? []));
        $f['subs'] = array_map('intval', (array) ($old['subs'] ?? []));
        $f['mp'] = promo_mp_sections_from_input($pdo, $old);
        $f['cat_all'] = !empty($old['cat_all']);
    }
    if ($editing === null && !is_array($old)) {
        $f['cat_all'] = true;
        // Нова кампанія: позначені всі місця, які зараз можна обрати (доступні й з ціною).
        $f['placements'] = promo_placements_selectable($pdo, $rates, $f['objective'] === 'clicks' ? 'cpc' : 'cpm', $house);
        $f['start_date'] = promo_today();
    }
    // Блог: скільки статей мають категорії (таргетинг за категорією працює лише для них).
    require_once __DIR__ . '/blog.php';
    $blogTotal = count(BLOG_ARTICLES);
    $blogWithCats = 0;
    foreach (promo_blog_taxonomy_map($pdo) as $slug => [$blogCats]) {
        if ($blogCats !== [] && isset(BLOG_ARTICLES[$slug])) {
            $blogWithCats++;
        }
    }

    $maxMb = (int) promo_setting($pdo, 'max_video_mb', '30');
    $maxSec = (int) promo_setting($pdo, 'max_video_sec', '30');
    $minTopup = promo_parse_money(promo_setting($pdo, 'min_topup', ''));
    $instructions = promo_payment_instructions($pdo);
    $jarUrl = promo_payment_jar_url($pdo);
    $canTopup = $instructions !== '' || $jarUrl !== '';
    $prohibited = trim(promo_setting($pdo, 'prohibited_categories_text_' . $lang, '')) ?: trim(promo_setting($pdo, 'prohibited_categories_text_uk', ''));

    $txSt = $pdo->prepare('SELECT * FROM ad_transactions WHERE user_id = :u ORDER BY id DESC LIMIT 100');
    $txSt->execute([':u' => $userId]);
    $transactions = $txSt->fetchAll();

    // Статистика: фільтр.
    $statsCampaign = (int) ($_GET['promo_campaign'] ?? 0);
    if ($statsCampaign > 0 && promo_owned_campaign($pdo, $userId, $statsCampaign) === null) {
        $statsCampaign = 0;
    }
    $validDate = static function (string $key, string $default): string {
        $v = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
        $d = DateTime::createFromFormat('!Y-m-d', $v);

        return ($d !== false && $d->format('Y-m-d') === $v) ? $v : $default;
    };
    $statsFrom = $validDate('promo_from', promo_today(-29));
    $statsTo = $validDate('promo_to', promo_today());
    $byDay = promo_stats_rows($pdo, $userId, $statsCampaign ?: null, $statsFrom, $statsTo, 'day');
    $byPlacement = promo_stats_rows($pdo, $userId, $statsCampaign ?: null, $statsFrom, $statsTo, 'placement');
    $maxImpr = max([1, ...array_map(static fn($r) => (int) $r['impressions'], $byDay)]);

    $catName = static fn(array $row): string => $lang === 'en' && !empty($row['name_en']) ? (string) $row['name_en'] : (string) $row['name'];
    // Людська назва місця (ad_placements); старі ключі до 18.10 — з позначкою періоду.
    $placementLabel = static fn(string $pl): string => isset(PROMO_LEGACY_PLACEMENTS[$pl])
        ? promo_tr('placement_legacy', promo_tr('placement_' . $pl))
        : promo_placement_title($pdo, $pl, $lang);
    ?>
            <div class="accordion" id="acc-promo">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-promo-panel">
                    <span class="accordion__title"><?= pc_e(promo_tr('section_title')) ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-promo-panel">
                    <div class="accordion__panel-inner pc" data-pc-param="promo_tab" data-pc-hash="acc-promo">
                        <?php if (!$enabled): ?>
                        <p class="pc-note pc-note--warn"><?= pc_e(promo_tr('system_off_admin')) ?></p>
                        <?php endif; ?>

                        <?php if (is_array($flash) && !empty($flash['msgs'])): ?>
                        <div class="pc-flash <?= !empty($flash['ok']) ? 'pc-flash--ok' : 'pc-flash--error' ?>" role="status">
                            <?php foreach ($flash['msgs'] as $m): ?>
                            <p><?= pc_e(promo_tr((string) $m)) ?></p>
                            <?php endforeach; ?>
                        </div>
                        <?php endif; ?>

                        <p class="pc-muted"><a href="advertise.php" target="_blank" rel="noopener"><?= pc_e(promo_tr('adv_cabinet_link')) ?></a> · <a href="advertise-guide.php" target="_blank" rel="noopener"><?= pc_e(promo_tr('adv_guide_link')) ?></a></p>

                        <div class="pc-tabs" role="tablist">
                            <?php foreach (['campaigns', 'create', 'balance', 'stats'] as $t): ?>
                            <a class="pc-tab<?= $tab === $t ? ' is-active' : '' ?>" role="tab" href="account.php?promo_tab=<?= $t ?>#acc-promo"
                               data-pc-tab="<?= $t ?>" aria-selected="<?= $tab === $t ? 'true' : 'false' ?>"><?= pc_e(promo_tr('tab_' . $t)) ?></a>
                            <?php endforeach; ?>
                        </div>

                        <!-- ============ Кампанії ============ -->
                        <section class="pc-panel" data-pc-panel="campaigns"<?= $tab === 'campaigns' ? '' : ' hidden' ?>>
                            <?php if ($campaigns === []): ?>
                            <p class="pc-empty"><?= pc_e(promo_tr('no_campaigns')) ?>
                                <a href="account.php?promo_tab=create#acc-promo" data-pc-tab="create"><?= pc_e(promo_tr('create_first')) ?></a></p>
                            <?php else: ?>
                            <?php if ($budgetCampaign !== null): $bc = $budgetCampaign; ?>
                            <form method="post" action="promo-action.php" class="pc-box">
                                <h3 class="pc-h3"><?= pc_e(promo_tr('budget_edit_title', $bc['name'] ?: '#' . (int) $bc['id'])) ?></h3>
                                <p class="pc-muted"><?= pc_e(promo_tr('budget_edit_note', promo_money((int) $bc['spent'], (string) $bc['currency']))) ?></p>
                                <?= promo_csrf_field() ?>
                                <input type="hidden" name="campaign_id" value="<?= (int) $bc['id'] ?>">
                                <div class="pc-grid-2">
                                    <label class="pc-field"><span><?= pc_e(promo_tr('field_daily_budget')) ?></span>
                                        <input type="text" inputmode="decimal" name="daily_budget" value="<?= pc_e(promo_money_input($bc['daily_budget'])) ?>" placeholder="0.00"></label>
                                    <label class="pc-field"><span><?= pc_e(promo_tr('field_total_budget')) ?></span>
                                        <input type="text" inputmode="decimal" name="total_budget" value="<?= pc_e(promo_money_input($bc['total_budget'])) ?>" placeholder="0.00"></label>
                                    <label class="pc-field"><span><?= pc_e(promo_tr('field_end')) ?></span>
                                        <input type="date" name="end_date" value="<?= pc_e((string) $bc['end_date']) ?>" min="<?= promo_today() ?>"></label>
                                </div>
                                <p class="pc-actions">
                                    <button type="submit" name="action" value="budget" class="pc-btn pc-btn--primary"><?= pc_e(promo_tr('budget_save')) ?></button>
                                    <a class="pc-btn" href="account.php?promo_tab=campaigns#acc-promo"><?= pc_e(promo_tr('btn_cancel')) ?></a>
                                </p>
                            </form>
                            <?php endif; ?>
                            <?php if ($placesCampaign !== null): $pt = promo_campaign_targeting($pdo, (int) $placesCampaign['id']); ?>
                            <form method="post" action="promo-action.php" class="pc-box pc-places-form">
                                <h3 class="pc-h3"><?= pc_e(promo_tr('places_edit_title', $placesCampaign['name'] ?: '#' . (int) $placesCampaign['id'])) ?></h3>
                                <p class="pc-muted"><?= pc_e(promo_tr('places_edit_note')) ?></p>
                                <?= promo_csrf_field() ?>
                                <input type="hidden" name="campaign_id" value="<?= (int) $placesCampaign['id'] ?>">
                                <?= promo_placement_picker_html($pdo, $pt['placements'], $lang, $rates, $placesCampaign['campaign_type'] === 'internal' ? null : $placesCampaign['pricing_model'], $placesCampaign['campaign_type'] === 'internal', $pt) ?>
                                <p class="pc-actions">
                                    <button type="submit" name="action" value="placements" class="pc-btn pc-btn--primary"><?= pc_e(promo_tr('places_save')) ?></button>
                                    <a class="pc-btn" href="account.php?promo_tab=campaigns#acc-promo"><?= pc_e(promo_tr('btn_cancel')) ?></a>
                                </p>
                            </form>
                            <?php endif; ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead>
                                    <tr>
                                        <th><?= pc_e(promo_tr('col_campaign')) ?></th>
                                        <th><?= pc_e(promo_tr('col_status')) ?></th>
                                        <th><?= pc_e(promo_tr('col_spent')) ?></th>
                                        <th><?= pc_e(promo_tr('col_impressions')) ?></th>
                                        <th><?= pc_e(promo_tr('col_views')) ?></th>
                                        <th><?= pc_e(promo_tr('col_clicks')) ?></th>
                                        <th>CTR</th>
                                        <th><?= pc_e(promo_tr('col_actions')) ?></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach ($campaigns as $c):
                                        $cid = (int) $c['id'];
                                        $t = $totals[$cid] ?? ['impressions' => 0, 'views' => 0, 'clicks' => 0];
                                        ?>
                                    <tr>
                                        <td data-label="<?= pc_e(promo_tr('col_campaign')) ?>">
                                            <strong><?= pc_e($c['name'] ?: ('#' . $cid)) ?></strong>
                                            <span class="pc-muted"><?= pc_e(promo_tr('model_' . ($c['pricing_model'] ?: 'none'))) ?><?php if ($c['start_date']): ?> · <?= pc_e($c['start_date']) ?><?= $c['end_date'] ? ' — ' . pc_e($c['end_date']) : '' ?><?php endif; ?></span>
                                        </td>
                                        <td data-label="<?= pc_e(promo_tr('col_status')) ?>">
                                            <?php
                                            // «Очікує показу»: активна, але всі місця — маркетплейс, який ще не відкрито.
                                            $cPlaces = promo_campaign_targeting($pdo, $cid)['placements'];
                                            $cWaiting = $c['status'] === 'active' && promo_placements_waiting($pdo, $cPlaces);
                                            $cMpLater = !$cWaiting && in_array($c['status'], ['active', 'pending_review'], true)
                                                && array_filter($cPlaces, static fn($pl) => promo_placements_waiting($pdo, [$pl])) !== [];
                                            ?>
                                            <?= $cWaiting ? '<span class="pc-badge pc-badge--waiting">' . pc_e(promo_tr('status_waiting')) . '</span>' : promo_status_badge((string) $c['status']) ?>
                                            <?php if ($cWaiting): ?>
                                            <span class="pc-reason"><?= pc_e(promo_tr('waiting_reason')) ?></span>
                                            <?php elseif ($c['status'] === 'rejected' && $c['rejection_reason']): ?>
                                            <span class="pc-reason"><?= pc_e(promo_tr('rejection_reason')) ?>: <?= pc_e($c['rejection_reason']) ?></span>
                                            <?php elseif ($c['stop_reason'] && (in_array($c['status'], ['paused', 'completed'], true) || $c['stop_reason'] === 'link_check')): ?>
                                            <span class="pc-reason"><?= pc_e(promo_tr('stop_' . $c['stop_reason'])) ?></span>
                                            <?php elseif ($c['status'] === 'active' && $balance <= 0): ?>
                                            <span class="pc-reason"><?= pc_e(promo_tr('stop_balance')) ?></span>
                                            <?php endif; ?>
                                            <?php if ($cMpLater): ?>
                                            <span class="pc-reason"><?= pc_e(promo_tr('waiting_mixed')) ?></span>
                                            <?php endif; ?>
                                        </td>
                                        <td data-label="<?= pc_e(promo_tr('col_spent')) ?>">
                                            <?= pc_e(promo_money($c['spent'], $c['currency'])) ?>
                                            <?php if ($c['total_budget'] !== null): ?><span class="pc-muted">/ <?= pc_e(promo_money($c['total_budget'], $c['currency'])) ?></span><?php endif; ?>
                                        </td>
                                        <td data-label="<?= pc_e(promo_tr('col_impressions')) ?>"><?= (int) $t['impressions'] ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_views')) ?>"><?= (int) $t['views'] ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_clicks')) ?>"><?= (int) $t['clicks'] ?></td>
                                        <td data-label="CTR"><?= pc_e(promo_ctr($t['clicks'], $t['impressions'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_actions')) ?>" class="pc-actions">
                                            <?php if (in_array($c['status'], PROMO_EDITABLE, true)): ?>
                                            <a class="pc-btn pc-btn--small" href="account.php?promo_tab=create&amp;promo_edit=<?= $cid ?>#acc-promo"<?= in_array($c['status'], ['active', 'pending_review'], true) ? ' title="' . pc_e(promo_tr('edit_live_hint')) . '"' : '' ?>><?= pc_e(promo_tr('act_edit')) ?></a>
                                            <?php endif; ?>
                                            <?php if (in_array($c['status'], PROMO_BUDGET_EDITABLE, true)): ?>
                                            <a class="pc-btn pc-btn--small" href="account.php?promo_tab=campaigns&amp;promo_budget=<?= $cid ?>#acc-promo"><?= pc_e(promo_tr('act_budget')) ?></a>
                                            <?php endif; ?>
                                            <?php if (in_array($c['status'], PROMO_PLACES_EDITABLE, true)): ?>
                                            <a class="pc-btn pc-btn--small" href="account.php?promo_tab=campaigns&amp;promo_places=<?= $cid ?>#acc-promo"><?= pc_e(promo_tr('act_places')) ?></a>
                                            <?php endif; ?>
                                            <?php
                                            $actions = [];
                                            if ($c['status'] === 'active') {
                                                $actions[] = 'pause';
                                            }
                                            if ($c['status'] === 'paused') {
                                                $actions[] = 'resume';
                                            }
                                            $actions[] = 'duplicate';
                                            if ($c['status'] !== 'completed') {
                                                $actions[] = 'complete';
                                            }
                                            foreach ($actions as $a): ?>
                                            <form method="post" action="promo-action.php" class="pc-inline-form"<?= $a === 'complete' ? ' data-pc-confirm="' . pc_e(promo_tr('confirm_complete')) . '"' : '' ?>>
                                                <?= promo_csrf_field() ?>
                                                <input type="hidden" name="campaign_id" value="<?= $cid ?>">
                                                <button type="submit" name="action" value="<?= $a ?>" class="pc-btn pc-btn--small<?= $a === 'complete' ? ' pc-btn--danger' : '' ?>"><?= pc_e(promo_tr('act_' . $a)) ?></button>
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

                        <!-- ============ Створити кампанію ============ -->
                        <section class="pc-panel" data-pc-panel="create"<?= $tab === 'create' ? '' : ' hidden' ?>>
                            <?php if ($house): ?>
                            <p class="pc-note pc-note--warn">Власна реклама сайту: без оплати й прайсу, без модерації — після «Запустити» показується одразу (якщо систему ввімкнено). Платні кампанії мають пріоритет; власна заповнює вільні слоти.</p>
                            <?php endif; ?>
                            <?php if ($editing !== null): ?>
                            <p class="pc-note"><?= pc_e(promo_tr('editing_campaign', $editing['name'] ?: ('#' . $editing['id']))) ?>
                                <?php if ($editing['status'] === 'active'): ?> <strong class="pc-warn-text"><?= pc_e(promo_tr('edit_active_warning')) ?></strong>
                                <?php elseif ($editing['status'] === 'pending_review'): ?> <?= pc_e(promo_tr('edit_pending_warning')) ?>
                                <?php elseif ($editing['status'] !== 'draft'): ?> <?= pc_e(promo_tr('edit_needs_review')) ?><?php endif; ?>
                                <?php if (in_array($editing['status'], PROMO_BUDGET_EDITABLE, true) && $editing['status'] !== 'draft'): ?>
                                <a href="account.php?promo_tab=campaigns&amp;promo_budget=<?= (int) $editing['id'] ?>#acc-promo"><?= pc_e(promo_tr('edit_budget_only')) ?></a>
                                <?php endif; ?>
                                <a href="account.php?promo_tab=create#acc-promo"><?= pc_e(promo_tr('new_campaign_link')) ?></a></p>
                            <?php endif; ?>

                            <ol class="pc-steps" aria-label="<?= pc_e(promo_tr('wizard_steps')) ?>">
                                <?php for ($i = 1; $i <= 5; $i++): ?>
                                <li class="pc-steps__item" data-pc-step-nav="<?= $i ?>"><span><?= $i ?></span> <?= pc_e(promo_tr('step' . $i . '_title')) ?></li>
                                <?php endfor; ?>
                            </ol>

                            <form method="post" action="promo-action.php" enctype="multipart/form-data" class="pc-wizard" id="pcWizard"
                                  data-max-mb="<?= $maxMb ?>" data-max-sec="<?= $maxSec ?>" data-balance="<?= $balance ?>"
                                  data-rates="<?= pc_e((string) json_encode($rates)) ?>"
                                  data-i18n="<?= pc_e((string) json_encode(promo_tr_many(['js_video_too_big', 'js_video_too_long', 'js_video_type', 'forecast_cpm', 'forecast_cpc', 'forecast_note', 'no_price_for', 'price_cpm', 'price_cpc', 'balance_warning', 'summary_empty', 'yes', 'no', 'all_label', 'money_fmt', 'poster_captured', 'placement_catalog_card', 'placement_product_page', 'placement_blog_inline', 'categories_all', 'categories_selected'], $lang), JSON_UNESCAPED_UNICODE)) ?>">
                                <?= promo_csrf_field() ?>
                                <input type="hidden" name="campaign_id" value="<?= $editing ? (int) $editing['id'] : 0 ?>">
                                <?php if ($house): ?><input type="hidden" name="house" value="1"><?php endif; ?>
                                <input type="hidden" name="duration_client" value="">
                                <input type="hidden" name="poster_data" value="">

                                <!-- 1. Ціль і назва -->
                                <fieldset class="pc-step" data-pc-step="1">
                                    <legend><?= pc_e(promo_tr('step1_title')) ?></legend>
                                    <label class="pc-field">
                                        <span><?= pc_e(promo_tr('field_name')) ?></span>
                                        <input type="text" name="name" maxlength="120" value="<?= pc_e($f['name']) ?>" data-summary="name">
                                    </label>
                                    <div class="pc-choice-row" role="radiogroup" aria-label="<?= pc_e(promo_tr('field_objective')) ?>">
                                        <?php foreach (['awareness', 'clicks'] as $o): ?>
                                        <label class="pc-choice">
                                            <input type="radio" name="objective" value="<?= $o ?>"<?= $f['objective'] === $o ? ' checked' : '' ?>>
                                            <span><strong><?= pc_e(promo_tr('objective_' . $o)) ?></strong><small><?= pc_e(promo_tr('objective_' . $o . '_hint')) ?></small></span>
                                        </label>
                                        <?php endforeach; ?>
                                    </div>
                                    <?php if (!$house): ?>
                                    <label class="pc-field">
                                        <span><?= pc_e(promo_tr('field_advertiser_category')) ?> *</span>
                                        <select name="advertiser_category" data-summary="advertiser_category">
                                            <option value=""><?= pc_e(promo_tr('choose')) ?></option>
                                            <?php foreach (PROMO_ADVERTISER_CATEGORIES as $k => $labels): ?>
                                            <option value="<?= $k ?>"<?= $f['advertiser_category'] === $k ? ' selected' : '' ?>><?= pc_e($labels[$lang === 'en' ? 1 : 0]) ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                        <small class="pc-muted"><?= pc_e(promo_tr('advertiser_category_hint')) ?></small>
                                    </label>
                                    <?php endif; ?>
                                </fieldset>

                                <!-- 2. Креатив -->
                                <fieldset class="pc-step" data-pc-step="2">
                                    <legend><?= pc_e(promo_tr('step2_title')) ?></legend>
                                    <div class="pc-grid-2">
                                        <div>
                                            <div class="pc-choice-row">
                                                <?php foreach (['upload', 'youtube'] as $vt): ?>
                                                <label class="pc-choice pc-choice--compact">
                                                    <input type="radio" name="video_type" value="<?= $vt ?>"<?= $f['video_type'] === $vt ? ' checked' : '' ?>>
                                                    <span><?= pc_e(promo_tr('video_type_' . $vt)) ?></span>
                                                </label>
                                                <?php endforeach; ?>
                                            </div>
                                            <div data-pc-show="video_type=upload">
                                                <label class="pc-field">
                                                    <span><?= pc_e(promo_tr('field_video', $maxMb, $maxSec)) ?></span>
                                                    <input type="file" name="video" accept="video/mp4,video/webm,.mp4,.webm">
                                                </label>
                                                <p class="pc-warn-text" data-pc-video-error role="alert" hidden></p>
                                                <?php if (!empty($creative['video_path'])): ?>
                                                <p class="pc-muted"><?= pc_e(promo_tr('video_current')) ?><?= $creative['duration_sec'] ? ' · ' . (int) $creative['duration_sec'] . ' ' . pc_e(promo_tr('sec')) : '' ?></p>
                                                <?php endif; ?>
                                            </div>
                                            <label class="pc-field" data-pc-show="video_type=youtube">
                                                <span><?= pc_e(promo_tr('field_youtube')) ?></span>
                                                <input type="url" name="youtube_url" maxlength="500" placeholder="https://www.youtube.com/watch?v=…" value="<?= pc_e($f['youtube_url']) ?>">
                                            </label>
                                            <label class="pc-field">
                                                <span><?= pc_e(promo_tr('field_title')) ?> <small data-pc-count="title">0/60</small></span>
                                                <input type="text" name="title" maxlength="60" value="<?= pc_e($f['title']) ?>" data-summary="title">
                                            </label>
                                            <label class="pc-field">
                                                <span><?= pc_e(promo_tr('field_description')) ?> <small data-pc-count="description">0/150</small></span>
                                                <textarea name="description" maxlength="150" rows="3"><?= pc_e($f['description']) ?></textarea>
                                            </label>
                                            <label class="pc-field">
                                                <span><?= pc_e(promo_tr('field_cta')) ?></span>
                                                <select name="cta_key">
                                                    <?php foreach (PROMO_CTA_KEYS as $k): ?>
                                                    <option value="<?= $k ?>"<?= $f['cta_key'] === $k ? ' selected' : '' ?>><?= pc_e(t('promo_cta_' . $k)) ?></option>
                                                    <?php endforeach; ?>
                                                </select>
                                            </label>
                                            <label class="pc-field">
                                                <span><?= pc_e(promo_tr('field_url')) ?></span>
                                                <input type="url" name="destination_url" maxlength="500" placeholder="https://" value="<?= pc_e($f['destination_url']) ?>" data-summary="destination_url">
                                            </label>
                                            <div class="pc-field">
                                                <span><?= pc_e(promo_tr('field_poster')) ?></span>
                                                <input type="file" name="poster" accept="image/jpeg,image/png,image/webp">
                                                <button type="button" class="pc-btn pc-btn--small" data-pc-capture hidden><?= pc_e(promo_tr('poster_capture')) ?></button>
                                                <?php if (!empty($creative['poster_path'])): ?>
                                                <p class="pc-muted"><?= pc_e(promo_tr('poster_current')) ?></p>
                                                <?php endif; ?>
                                            </div>
                                        </div>
                                        <div>
                                            <p class="pc-preview-title"><?= pc_e(promo_tr('preview')) ?></p>
                                            <article class="sponsored-card pc-preview" aria-label="<?= pc_e(promo_tr('preview')) ?>">
                                                <span class="sponsored-card__label"><?= pc_e(t('promo_label')) ?></span>
                                                <div class="sponsored-card__media" data-pc-preview-media
                                                     data-video="<?= !empty($creative['video_path']) ? '/' . pc_e($creative['video_path']) : '' ?>"
                                                     data-poster="<?= !empty($creative['poster_path']) ? '/' . pc_e($creative['poster_path']) : '' ?>"
                                                     data-youtube="<?= pc_e($creative['youtube_id'] ?? '') ?>"></div>
                                                <h3 class="sponsored-card__title" data-pc-preview="title"></h3>
                                                <p class="sponsored-card__desc" data-pc-preview="description"></p>
                                                <div class="sponsored-card__footer">
                                                    <span class="sponsored-card__cta" data-pc-preview="cta"></span>
                                                    <span class="sponsored-card__report"><?= pc_e(t('promo_report')) ?></span>
                                                </div>
                                            </article>
                                        </div>
                                    </div>
                                </fieldset>

                                <!-- 3. Аудиторія й розміщення -->
                                <fieldset class="pc-step" data-pc-step="3">
                                    <legend><?= pc_e(promo_tr('step3_title')) ?></legend>
                                    <p class="pc-muted"><?= pc_e(promo_tr('targeting_privacy')) ?></p>
                                    <div class="pc-grid-2">
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_language')) ?></span>
                                            <select name="language">
                                                <?php foreach (['all', 'uk', 'en'] as $v): ?>
                                                <option value="<?= $v ?>"<?= $f['language'] === $v ? ' selected' : '' ?>><?= pc_e(promo_tr('lang_' . $v)) ?></option>
                                                <?php endforeach; ?>
                                            </select>
                                        </label>
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_device')) ?></span>
                                            <select name="device">
                                                <?php foreach (['all', 'mobile', 'desktop'] as $v): ?>
                                                <option value="<?= $v ?>"<?= $f['device'] === $v ? ' selected' : '' ?>><?= pc_e(promo_tr('device_' . $v)) ?></option>
                                                <?php endforeach; ?>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="pc-field">
                                        <span><?= pc_e(promo_tr('places_title')) ?></span>
                                        <?= promo_placement_picker_html($pdo, $f['placements'], $lang, $rates, $house ? null : ($f['objective'] === 'clicks' ? 'cpc' : 'cpm'), $house) ?>
                                    </div>
                                    <div class="pc-field">
                                        <span><?= pc_e(promo_tr('field_categories')) ?></span>
                                        <p class="pc-muted" data-pc-cat-summary><?= pc_e(promo_tr('categories_hint')) ?></p>
                                        <p class="pc-muted"><?= pc_e(promo_tr('blog_categories_note', $blogWithCats, $blogTotal)) ?></p>
                                        <div class="pc-cats" data-pc-cats>
                                            <?php foreach ($taxonomy as $cid => $cat): ?>
                                            <details class="pc-cat"<?= in_array($cid, $f['cats'], true) || array_intersect(array_keys($cat['subs']), $f['subs']) ? ' open' : '' ?>>
                                                <summary>
                                                    <label class="pc-check" onclick="event.stopPropagation()">
                                                        <input type="checkbox" name="cats[]" value="<?= $cid ?>"<?= in_array($cid, $f['cats'], true) ? ' checked' : '' ?>>
                                                        <span><?= pc_e($catName($cat)) ?> <small>(<?= pc_e(promo_tr('whole_category')) ?>)</small></span>
                                                    </label>
                                                </summary>
                                                <div class="pc-subs">
                                                    <?php foreach ($cat['subs'] as $sid => $sub): ?>
                                                    <label class="pc-check">
                                                        <input type="checkbox" name="subs[]" value="<?= $sid ?>"<?= in_array($sid, $f['subs'], true) ? ' checked' : '' ?>>
                                                        <span><?= pc_e($catName($sub)) ?></span>
                                                    </label>
                                                    <?php endforeach; ?>
                                                </div>
                                            </details>
                                            <?php endforeach; ?>
                                        </div>
                                    </div>
                                    <?php $mpBoardCats = promo_mp_board_categories($pdo, $lang); ?>
                                    <div class="pc-field pc-mp" data-pc-mp>
                                        <span><?= pc_e(promo_tr('field_mp_sections')) ?></span>
                                        <p class="pc-muted"><?= pc_e(promo_tr('mp_sections_hint')) ?></p>
                                        <div class="pc-mp__list">
                                            <?php foreach (PROMO_MP_SECTIONS as $sec): ?>
                                            <label class="pc-check">
                                                <input type="checkbox" name="mp_sections[]" value="<?= pc_e($sec) ?>"<?= in_array($sec, $f['mp'], true) ? ' checked' : '' ?>>
                                                <span><?= pc_e(promo_tr('mp_sec_' . $sec)) ?></span>
                                            </label>
                                            <?php endforeach; ?>
                                        </div>
                                        <?php if ($mpBoardCats !== []): ?>
                                        <p class="pc-muted"><?= pc_e(promo_tr('mp_board_cats')) ?></p>
                                        <div class="pc-mp__list">
                                            <?php foreach ($mpBoardCats as $mid => $mname): ?>
                                            <label class="pc-check">
                                                <input type="checkbox" name="mp_board_cats[]" value="<?= (int) $mid ?>"<?= in_array('board:' . $mid, $f['mp'], true) ? ' checked' : '' ?>>
                                                <span><?= pc_e($mname) ?></span>
                                            </label>
                                            <?php endforeach; ?>
                                        </div>
                                        <?php endif; ?>
                                    </div>
                                </fieldset>

                                <!-- 4. Бюджет і графік -->
                                <fieldset class="pc-step" data-pc-step="4">
                                    <legend><?= pc_e(promo_tr('step4_title')) ?></legend>
                                    <div class="pc-grid-2">
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_daily_budget')) ?></span>
                                            <input type="text" inputmode="decimal" name="daily_budget" value="<?= pc_e($f['daily_budget']) ?>" placeholder="0.00">
                                        </label>
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_total_budget')) ?></span>
                                            <input type="text" inputmode="decimal" name="total_budget" value="<?= pc_e($f['total_budget']) ?>" placeholder="0.00">
                                        </label>
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_start')) ?></span>
                                            <input type="date" name="start_date" value="<?= pc_e($f['start_date']) ?>" min="<?= promo_today() ?>">
                                        </label>
                                        <label class="pc-field">
                                            <span><?= pc_e(promo_tr('field_end')) ?></span>
                                            <input type="date" name="end_date" value="<?= pc_e($f['end_date']) ?>" min="<?= promo_today() ?>">
                                        </label>
                                    </div>
                                    <?php if (!$house): ?>
                                    <div class="pc-box" data-pc-prices>
                                        <?php if ($rates === []): ?>
                                        <p><?= pc_e(promo_tr('no_rates_yet')) ?></p>
                                        <?php endif; ?>
                                    </div>
                                    <div class="pc-box" data-pc-forecast></div>
                                    <?php endif; ?>
                                </fieldset>

                                <!-- 5. Підтвердження -->
                                <fieldset class="pc-step" data-pc-step="5">
                                    <legend><?= pc_e(promo_tr('step5_title')) ?></legend>
                                    <dl class="pc-summary" data-pc-summary></dl>
                                    <?php if (!$house): ?>
                                    <p class="pc-note pc-note--warn" data-pc-balance-warning hidden>
                                        <?= pc_e(promo_tr('balance_warning_static', promo_money($balance, $balanceCur))) ?>
                                        <a href="account.php?promo_tab=balance#acc-promo" data-pc-tab="balance"><?= pc_e(promo_tr('topup_link')) ?></a>
                                    </p>
                                    <?php if ($prohibited !== ''): ?>
                                    <div class="pc-box"><strong><?= pc_e(promo_tr('prohibited_title')) ?></strong><p><?= nl2br(pc_e($prohibited)) ?></p></div>
                                    <?php endif; ?>
                                    <label class="pc-check">
                                        <input type="checkbox" name="agree" value="1">
                                        <span><?= pc_e(promo_tr('agree_prefix')) ?> <a href="promo-rules.php" target="_blank" rel="noopener"><?= pc_e(promo_tr('rules_link')) ?></a></span>
                                    </label>
                                    <p class="pc-muted"><?= pc_e(promo_tr('moderation_note')) ?></p>
                                    <?php endif; ?>
                                </fieldset>

                                <div class="pc-wizard__nav">
                                    <button type="button" class="pc-btn" data-pc-prev hidden><?= pc_e(promo_tr('btn_back')) ?></button>
                                    <button type="submit" name="action" value="save_draft" class="pc-btn" formnovalidate><?= pc_e(promo_tr('btn_save_draft')) ?></button>
                                    <button type="button" class="pc-btn pc-btn--primary" data-pc-next hidden><?= pc_e(promo_tr('btn_next')) ?></button>
                                    <button type="submit" name="action" value="submit" class="pc-btn pc-btn--primary" data-pc-submit><?= $house ? 'Запустити' : pc_e(promo_tr('btn_submit')) ?></button>
                                </div>
                            </form>
                        </section>

                        <!-- ============ Баланс і оплата ============ -->
                        <section class="pc-panel" data-pc-panel="balance"<?= $tab === 'balance' ? '' : ' hidden' ?>>
                            <p class="pc-balance"><?= pc_e(promo_tr('balance_current')) ?> <strong><?= pc_e(promo_money($balance, $balanceCur)) ?></strong></p>

                            <?php if (is_array($flash) && !empty($flash['topup']) && $canTopup): $req = $flash['topup']; ?>
                            <div class="pc-box pc-box--accent">
                                <p><strong><?= pc_e(promo_tr('topup_created', (int) $req['id'], promo_money($req['amount']))) ?></strong></p>
                                <p><?= pc_e(promo_tr('payment_purpose')) ?> <code><?= pc_e($req['reference']) ?></code></p>
                                <?php if ($jarUrl !== ''): ?>
                                <p><a class="pc-btn pc-btn--primary" href="<?= pc_e($jarUrl) ?>" target="_blank" rel="noopener noreferrer"><?= pc_e(promo_tr('pay_jar_btn')) ?></a></p>
                                <p class="pc-muted"><?= pc_e(promo_tr('pay_jar_hint', promo_money($req['amount']), $req['reference'])) ?></p>
                                <?php endif; ?>
                                <?php if ($instructions !== ''): ?>
                                <div class="pc-instructions"><?= nl2br(pc_e($instructions)) ?></div>
                                <?php endif; ?>
                            </div>
                            <?php endif; ?>

                            <h3 class="pc-h3"><?= pc_e(promo_tr('topup_title')) ?></h3>
                            <?php if (!$canTopup): ?>
                            <p class="pc-note"><?= pc_e(promo_tr('topup_unavailable')) ?></p>
                            <?php else: ?>
                            <form method="post" action="promo-action.php" class="pc-topup">
                                <?= promo_csrf_field() ?>
                                <label class="pc-field">
                                    <span><?= pc_e(promo_tr('topup_amount')) ?><?= $minTopup ? ' · ' . pc_e(promo_tr('topup_min', promo_money($minTopup))) : '' ?></span>
                                    <input type="text" inputmode="decimal" name="amount" required placeholder="0.00">
                                </label>
                                <button type="submit" name="action" value="topup" class="pc-btn pc-btn--primary"><?= pc_e(promo_tr('topup_submit')) ?></button>
                            </form>
                            <?php endif; ?>

                            <details class="pc-box">
                                <summary><strong><?= pc_e(promo_tr('topup_howto_title')) ?></strong></summary>
                                <ol class="pc-howto">
                                    <li><?= pc_e(promo_tr('topup_howto_1')) ?></li>
                                    <li><?= pc_e(promo_tr('topup_howto_2')) ?></li>
                                    <li><?= pc_e(promo_tr('topup_howto_3')) ?></li>
                                    <li><?= pc_e(promo_tr('topup_howto_4')) ?></li>
                                </ol>
                                <?php if ($jarUrl !== ''): ?>
                                <p><a href="<?= pc_e($jarUrl) ?>" target="_blank" rel="noopener noreferrer"><?= pc_e(promo_tr('pay_jar_btn')) ?></a></p>
                                <?php endif; ?>
                                <?php if ($instructions !== ''): ?>
                                <div class="pc-instructions"><?= nl2br(pc_e($instructions)) ?></div>
                                <?php endif; ?>
                            </details>

                            <form method="post" action="promo-action.php" class="pc-box pc-notify">
                                <?= promo_csrf_field() ?>
                                <input type="hidden" name="action" value="notify_prefs">
                                <label class="pc-check">
                                    <input type="checkbox" name="low_balance" value="1"<?= $notifyPrefs['low_balance'] ? ' checked' : '' ?>>
                                    <span><?= pc_e(promo_tr('notify_low_balance')) ?></span>
                                </label>
                                <p class="pc-muted"><?= pc_e(promo_tr('notify_note')) ?></p>
                                <button type="submit" class="pc-btn pc-btn--small"><?= pc_e(promo_tr('notify_save')) ?></button>
                            </form>

                            <h3 class="pc-h3"><?= pc_e(promo_tr('history_title')) ?></h3>
                            <?php if ($transactions === []): ?>
                            <p class="pc-empty"><?= pc_e(promo_tr('history_empty')) ?></p>
                            <?php else: ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr>
                                        <th><?= pc_e(promo_tr('col_date')) ?></th>
                                        <th><?= pc_e(promo_tr('col_type')) ?></th>
                                        <th><?= pc_e(promo_tr('col_amount')) ?></th>
                                        <th><?= pc_e(promo_tr('col_status')) ?></th>
                                        <th><?= pc_e(promo_tr('col_details')) ?></th>
                                    </tr></thead>
                                    <tbody>
                                    <?php foreach ($transactions as $tx): ?>
                                    <tr>
                                        <td data-label="<?= pc_e(promo_tr('col_date')) ?>"><?= pc_e(substr((string) $tx['created_at'], 0, 16)) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_type')) ?>"><?= pc_e(promo_tr('tx_' . $tx['type'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_amount')) ?>"><?= pc_e(promo_money($tx['amount'], (string) $tx['currency'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_status')) ?>"><span class="pc-badge pc-badge--tx-<?= pc_e($tx['status']) ?>"><?= pc_e(promo_tr('txs_' . $tx['status'])) ?></span></td>
                                        <td data-label="<?= pc_e(promo_tr('col_details')) ?>">
                                            <?php if ($tx['type'] === 'topup' && $tx['reference']): ?><code><?= pc_e($tx['reference']) ?></code><?php endif; ?>
                                            <?php if ($tx['type'] === 'spend' && $tx['campaign_id']): ?><?= pc_e(promo_tr('tx_spend_for', (int) $tx['campaign_id'], substr((string) $tx['reference'], -10))) ?><?php endif; ?>
                                            <?php if ($tx['status'] === 'rejected' && $tx['reject_reason']): ?><span class="pc-reason"><?= pc_e($tx['reject_reason']) ?></span><?php endif; ?>
                                            <?php if (in_array($tx['type'], ['adjust', 'refund'], true) && $tx['note']): ?><?= pc_e($tx['note']) ?><?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                            <?php endif; ?>
                        </section>

                        <!-- ============ Статистика ============ -->
                        <section class="pc-panel" data-pc-panel="stats"<?= $tab === 'stats' ? '' : ' hidden' ?>>
                            <form method="get" action="account.php#acc-promo" class="pc-filter">
                                <input type="hidden" name="promo_tab" value="stats">
                                <label class="pc-field">
                                    <span><?= pc_e(promo_tr('col_campaign')) ?></span>
                                    <select name="promo_campaign">
                                        <option value="0"><?= pc_e(promo_tr('all_campaigns')) ?></option>
                                        <?php foreach ($campaigns as $c): ?>
                                        <option value="<?= (int) $c['id'] ?>"<?= $statsCampaign === (int) $c['id'] ? ' selected' : '' ?>><?= pc_e($c['name'] ?: ('#' . $c['id'])) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </label>
                                <label class="pc-field"><span><?= pc_e(promo_tr('from')) ?></span><input type="date" name="promo_from" value="<?= pc_e($statsFrom) ?>"></label>
                                <label class="pc-field"><span><?= pc_e(promo_tr('to')) ?></span><input type="date" name="promo_to" value="<?= pc_e($statsTo) ?>"></label>
                                <button type="submit" class="pc-btn"><?= pc_e(promo_tr('btn_show')) ?></button>
                                <a class="pc-btn" href="promo-action.php?<?= pc_e(http_build_query(['action' => 'export', 'campaign' => $statsCampaign, 'from' => $statsFrom, 'to' => $statsTo])) ?>"><?= pc_e(promo_tr('btn_csv')) ?></a>
                            </form>

                            <?php if ($byDay === []): ?>
                            <p class="pc-empty"><?= pc_e(promo_tr('stats_empty')) ?></p>
                            <?php else: ?>
                            <h3 class="pc-h3"><?= pc_e(promo_tr('stats_by_day')) ?></h3>
                            <div class="pc-table-wrap">
                                <table class="pc-table pc-table--stats">
                                    <thead><tr>
                                        <th><?= pc_e(promo_tr('col_date')) ?></th>
                                        <th><?= pc_e(promo_tr('col_impressions')) ?></th>
                                        <th><?= pc_e(promo_tr('col_views')) ?></th>
                                        <th><?= pc_e(promo_tr('col_clicks')) ?></th>
                                        <th>CTR</th>
                                        <th><?= pc_e(promo_tr('col_spent')) ?></th>
                                    </tr></thead>
                                    <tbody>
                                    <?php foreach ($byDay as $r): ?>
                                    <tr>
                                        <td data-label="<?= pc_e(promo_tr('col_date')) ?>"><?= pc_e($r['k']) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_impressions')) ?>">
                                            <span class="pc-bar" style="--w: <?= round((int) $r['impressions'] / $maxImpr * 100, 1) ?>%"></span><?= (int) $r['impressions'] ?>
                                        </td>
                                        <td data-label="<?= pc_e(promo_tr('col_views')) ?>"><?= (int) $r['views'] ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_clicks')) ?>"><?= (int) $r['clicks'] ?></td>
                                        <td data-label="CTR"><?= pc_e(promo_ctr($r['clicks'], $r['impressions'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_spent')) ?>"><?= pc_e(promo_money($r['spend'])) ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>

                            <h3 class="pc-h3"><?= pc_e(promo_tr('stats_by_placement')) ?></h3>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr>
                                        <th><?= pc_e(promo_tr('col_placement')) ?></th>
                                        <th><?= pc_e(promo_tr('col_impressions')) ?></th>
                                        <th><?= pc_e(promo_tr('col_views')) ?></th>
                                        <th><?= pc_e(promo_tr('col_clicks')) ?></th>
                                        <th>CTR</th>
                                        <th><?= pc_e(promo_tr('col_spent')) ?></th>
                                    </tr></thead>
                                    <tbody>
                                    <?php foreach ($byPlacement as $r): ?>
                                    <tr>
                                        <td data-label="<?= pc_e(promo_tr('col_placement')) ?>"><?= pc_e($placementLabel((string) $r['k'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_impressions')) ?>"><?= (int) $r['impressions'] ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_views')) ?>"><?= (int) $r['views'] ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_clicks')) ?>"><?= (int) $r['clicks'] ?></td>
                                        <td data-label="CTR"><?= pc_e(promo_ctr($r['clicks'], $r['impressions'])) ?></td>
                                        <td data-label="<?= pc_e(promo_tr('col_spent')) ?>"><?= pc_e(promo_money($r['spend'])) ?></td>
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

/** Стилі й скрипт кабінету — один раз на сторінку (рекламодавець і адмінка спільні). */
function promo_cabinet_assets(): string
{
    static $printed = false;
    if ($printed) {
        return '';
    }
    $printed = true;
    $v = static fn(string $f): int => (int) @filemtime(__DIR__ . '/../public/assets/' . $f);

    return '<link rel="stylesheet" href="/assets/css/sponsored.css?v=' . $v('css/sponsored.css') . '">'
        . '<link rel="stylesheet" href="/assets/css/promo-cabinet.css?v=' . $v('css/promo-cabinet.css') . '">'
        . '<script src="/assets/js/promo-cabinet.js?v=' . $v('js/promo-cabinet.js') . '" defer></script>';
}

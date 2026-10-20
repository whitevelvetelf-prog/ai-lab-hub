<?php

declare(strict_types=1);

/**
 * AI LAB HUB — адмінка «Власна реклама» (вкладка «Реклама: адмін» → «Власна реклама»): кампанії-картки платформи
 * (creative_type = 'card'), їхні варіанти (A/B), тексти UA/EN, кнопки, адреси (з ref), місця й умови показу,
 * активація/пауза, дублювання, перегляд на сторінці (через тестову кампанію is_test), статистика й порівняння CTR.
 *
 * Власна реклама безкоштовна: без білінгу й дедлайну, не рахується в доходах і платній статистиці; платні кампанії
 * завжди мають пріоритет (promo_pick). Реклама загалом вмикається лише перемикачем ad_settings.enabled.
 * Дії — public/promo-admin-action.php (house_*).
 */

require_once __DIR__ . '/promo-admin.php';

/** Мінімум показів кожного варіанта, після якого адміну показується порівняння CTR. */
const PROMO_HOUSE_AB_MIN = 100;
/** Умови показу (house_rules) з підписами для адмінки. */
const PROMO_HOUSE_RULES = [
    'hide_if_campaign' => 'Не показувати користувачам, які вже створили рекламну кампанію',
    'hide_if_listing' => 'Не показувати користувачам, які вже публікували оголошення',
    'site_only' => 'Лише на сторінках сайту й блогу (не всередині маркетплейсу)',
    'requires_marketplace' => 'Лише коли маркетплейс відкрито (marketplace_public = 1)',
    'exclude_advertise' => 'Не показувати на advertise.php і в кабінеті рекламодавця',
];

/** Власні кампанії з картками (і засіяні). */
function promo_house_campaigns(PDO $pdo): array
{
    if (!promo_house_columns($pdo)) {
        return [];
    }

    return $pdo->query(
        "SELECT c.* FROM ad_campaigns c
         WHERE c.campaign_type = 'internal' AND c.format = 'video'
           AND (c.house_key IS NOT NULL OR EXISTS (SELECT 1 FROM ad_creatives cr WHERE cr.campaign_id = c.id AND cr.creative_type = 'card'))
         ORDER BY c.house_key IS NULL, c.house_key, c.id"
    )->fetchAll();
}

/** house_rules (JSON) → прапорці форми. */
function promo_house_rules_flags(?string $json): array
{
    $r = json_decode((string) $json, true) ?: [];

    return [
        'hide_if_campaign' => !empty($r['hide_if_campaign']),
        'hide_if_listing' => !empty($r['hide_if_listing']),
        'site_only' => !empty($r['site_only']),
        'requires_marketplace' => ($r['requires_setting'] ?? '') === 'marketplace_public',
        'exclude_advertise' => in_array('advertise', (array) ($r['exclude_pages'] ?? []), true),
    ];
}

function promo_house_rules_json(array $in): string
{
    $r = [];
    foreach (['hide_if_campaign', 'hide_if_listing', 'site_only'] as $k) {
        if (!empty($in[$k])) {
            $r[$k] = 1;
        }
    }
    if (!empty($in['requires_marketplace'])) {
        $r['requires_setting'] = 'marketplace_public';
    }
    if (!empty($in['exclude_advertise'])) {
        $r['exclude_pages'] = ['advertise', 'cabinet'];
    }

    return (string) json_encode($r);
}

/**
 * Статистика варіантів за весь час: покази, кліки (ad_stats_daily) і скільки кампаній/оголошень створено після
 * переходу з варіанта (acquisition_ref = ref_code).
 *
 * @param list<array> $creatives
 * @return array<int,array{impressions:int,clicks:int,campaigns:int,listings:int}>
 */
function promo_house_variant_stats(PDO $pdo, array $creatives): array
{
    $out = [];
    foreach ($creatives as $cr) {
        $id = (int) $cr['id'];
        $st = $pdo->prepare('SELECT COALESCE(SUM(impressions), 0), COALESCE(SUM(clicks), 0) FROM ad_stats_daily WHERE creative_id = :c');
        $st->execute([':c' => $id]);
        [$imp, $clk] = array_map('intval', $st->fetch(PDO::FETCH_NUM) ?: [0, 0]);
        $camps = 0;
        $lists = 0;
        if (!empty($cr['ref_code'])) {
            $q = $pdo->prepare("SELECT COUNT(*) FROM ad_campaigns WHERE acquisition_ref = :r AND campaign_type = 'paid'");
            $q->execute([':r' => $cr['ref_code']]);
            $camps = (int) $q->fetchColumn();
            $q = $pdo->prepare('SELECT COUNT(*) FROM mp_listings WHERE acquisition_ref = :r');
            $q->execute([':r' => $cr['ref_code']]);
            $lists = (int) $q->fetchColumn();
        }
        $out[$id] = ['impressions' => $imp, 'clicks' => $clk, 'campaigns' => $camps, 'listings' => $lists];
    }

    return $out;
}

/** Порівняння CTR варіантів, коли в кожного ≥ PROMO_HOUSE_AB_MIN показів (нічого не вимикає). */
function promo_house_ab_text(array $creatives, array $stats): string
{
    if (count($creatives) < 2) {
        return '';
    }
    $rows = [];
    foreach ($creatives as $cr) {
        $s = $stats[(int) $cr['id']] ?? ['impressions' => 0, 'clicks' => 0];
        if ($s['impressions'] < PROMO_HOUSE_AB_MIN) {
            return 'Порівняння CTR з’явиться, коли кожен варіант набере щонайменше ' . PROMO_HOUSE_AB_MIN . ' показів.';
        }
        $rows[] = [(string) ($cr['ref_code'] ?: '#' . $cr['id']), $s['clicks'] / $s['impressions']];
    }
    usort($rows, static fn($a, $b) => $b[1] <=> $a[1]);
    $parts = array_map(static fn($r) => $r[0] . ' — ' . number_format($r[1] * 100, 2, ',', '') . '%', $rows);

    return 'Порівняння CTR: ' . implode('; ', $parts) . '. Найвищий — ' . $rows[0][0] . '. Автоматично нічого не вимикається.';
}

/** Зберегти назву, місця й умови власної кампанії. @return array{0:bool,1:string} */
function promo_house_save_campaign(PDO $pdo, int $adminId, array $in): array
{
    $id = (int) ($in['campaign_id'] ?? 0);
    $st = $pdo->prepare("SELECT * FROM ad_campaigns WHERE id = :id AND campaign_type = 'internal'");
    $st->execute([':id' => $id]);
    $c = $st->fetch();
    if ($c === false) {
        return [false, 'Кампанію не знайдено.'];
    }
    $name = mb_substr(trim(strip_tags((string) ($in['name'] ?? ''))), 0, 120);
    $flags = array_map(static fn($v) => !empty($v), (array) ($in['rules'] ?? []));
    $places = array_values(array_intersect(PROMO_PLACEMENTS, (array) ($in['placements'] ?? [])));
    if (!empty($flags['site_only'])) {
        $places = array_values(array_filter($places, static fn($p) => !promo_placement_is_marketplace($pdo, $p)));
    }
    if ($places === []) {
        return [false, 'Оберіть хоча б одне місце показу.'];
    }
    $pdo->beginTransaction();
    try {
        $pdo->prepare('UPDATE ad_campaigns SET name = :n, house_rules = :r WHERE id = :id')
            ->execute([':n' => $name !== '' ? $name : $c['name'], ':r' => promo_house_rules_json($flags), ':id' => $id]);
        $pdo->prepare('DELETE FROM ad_targets WHERE campaign_id = :c')->execute([':c' => $id]);
        $ins = $pdo->prepare('INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
                              VALUES (:c, :p, NULL, NULL, NULL, NULL, NULL, NULL)');
        foreach ($places as $p) {
            $ins->execute([':c' => $id, ':p' => $p]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] house save: ' . $e->getMessage());

        return [false, 'Не вдалося зберегти.'];
    }
    promo_log_event($pdo, 'house_campaign_saved', null, $id, 'місця: ' . implode(', ', $places), $adminId);

    return [true, 'Власну кампанію #' . $id . ' збережено.'];
}

/** Адреса переходу власної реклами: відносна (/…) або https; ref_code додається, якщо його немає. */
function promo_house_url(string $url, string $ref): ?string
{
    $url = trim($url);
    $ok = preg_match('#^/(?!/)[A-Za-z0-9._~/?=&%-]*$#', $url) === 1 || (filter_var($url, FILTER_VALIDATE_URL) !== false && str_starts_with($url, 'https://'));
    if (!$ok) {
        return null;
    }
    if ($ref !== '' && !preg_match('~[?&]ref=~', $url)) {
        $url .= (str_contains($url, '?') ? '&' : '?') . 'ref=' . $ref;
    }

    return mb_substr($url, 0, 500);
}

/** Зберегти тексти варіанта (картки). @return array{0:bool,1:string} */
function promo_house_save_variant(PDO $pdo, int $adminId, array $in): array
{
    $id = (int) ($in['creative_id'] ?? 0);
    $st = $pdo->prepare("SELECT cr.* FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id WHERE cr.id = :id AND c.campaign_type = 'internal'");
    $st->execute([':id' => $id]);
    $cr = $st->fetch();
    if ($cr === false) {
        return [false, 'Варіант не знайдено.'];
    }
    $t = static fn(string $k, int $max): string => mb_substr(trim(strip_tags((string) ($in[$k] ?? ''))), 0, $max);
    $title = $t('title', 60);
    $ref = $t('ref_code', 20);
    if ($title === '' || $t('description', 150) === '' || $t('cta_text', 40) === '') {
        return [false, 'Заголовок, опис і текст кнопки (UA) обов’язкові.'];
    }
    if ($ref !== '' && preg_match('/^house-[A-Za-z0-9_-]{1,14}$/', $ref) !== 1) {
        return [false, 'Код ref — у форматі house-A1.'];
    }
    if ($ref !== '') {
        $dup = $pdo->prepare('SELECT COUNT(*) FROM ad_creatives WHERE ref_code = :r AND id <> :id');
        $dup->execute([':r' => $ref, ':id' => $id]);
        if ((int) $dup->fetchColumn() > 0) {
            return [false, 'Код ref ' . $ref . ' уже використано іншим варіантом.'];
        }
    }
    $url = promo_house_url($t('destination_url', 480), $ref);
    if ($url === null) {
        return [false, 'Адреса переходу — відносна (/advertise.php) або https://.'];
    }
    $pdo->prepare(
        "UPDATE ad_creatives SET title = :t, title_en = :te, description = :d, description_en = :de, description_fallback = :f, description_fallback_en = :fe,
                cta_text = :c, cta_text_en = :ce, destination_url = :u, ref_code = :r, card_layout = :l, creative_type = 'card'
         WHERE id = :id"
    )->execute([':t' => $title, ':te' => $t('title_en', 60) ?: null, ':d' => $t('description', 150), ':de' => $t('description_en', 150) ?: null,
        ':f' => $t('description_fallback', 150) ?: null, ':fe' => $t('description_fallback_en', 150) ?: null,
        ':c' => $t('cta_text', 40), ':ce' => $t('cta_text_en', 40) ?: null, ':u' => $url, ':r' => $ref ?: null,
        ':l' => ($in['card_layout'] ?? '') === 'compact' ? 'compact' : 'wide', ':id' => $id]);
    promo_log_event($pdo, 'house_variant_saved', $id, (int) $cr['campaign_id'], (string) $ref, $adminId);

    return [true, 'Варіант ' . ($ref ?: '#' . $id) . ' збережено.'];
}

/** Наступний вільний ref_code для кампанії (house-A3, house-X1…). */
function promo_house_next_ref(PDO $pdo, array $c): string
{
    $letter = $c['house_key'] !== null && preg_match('/^house_([A-Za-z0-9]+)$/', (string) $c['house_key'], $m) ? $m[1] : 'C' . (int) $c['id'];
    for ($n = 1; $n < 100; $n++) {
        $ref = 'house-' . $letter . $n;
        $st = $pdo->prepare('SELECT COUNT(*) FROM ad_creatives WHERE ref_code = :r');
        $st->execute([':r' => $ref]);
        if ((int) $st->fetchColumn() === 0) {
            return $ref;
        }
    }

    return 'house-' . bin2hex(random_bytes(3));
}

/** Додати варіант (копія останнього, новий ref). */
function promo_house_add_variant(PDO $pdo, int $adminId, int $campaignId): array
{
    $st = $pdo->prepare("SELECT * FROM ad_campaigns WHERE id = :id AND campaign_type = 'internal'");
    $st->execute([':id' => $campaignId]);
    $c = $st->fetch();
    if ($c === false) {
        return [false, 'Кампанію не знайдено.'];
    }
    $last = $pdo->prepare("SELECT * FROM ad_creatives WHERE campaign_id = :c AND creative_type = 'card' ORDER BY id DESC LIMIT 1");
    $last->execute([':c' => $campaignId]);
    $src = $last->fetch() ?: ['title' => 'Новий варіант', 'title_en' => null, 'description' => 'Опис', 'description_en' => null, 'description_fallback' => null,
        'description_fallback_en' => null, 'cta_text' => 'Детальніше', 'cta_text_en' => 'Learn more', 'destination_url' => '/advertise.php', 'card_layout' => 'wide'];
    $ref = promo_house_next_ref($pdo, $c);
    $url = (string) preg_replace('~([?&])ref=[^&]*~', '$1ref=' . $ref, (string) $src['destination_url']);
    $url = promo_house_url($url, $ref) ?? '/advertise.php?ref=' . $ref;
    $pdo->prepare(
        "INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, description_fallback, description_fallback_en,
             cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
         VALUES (:c, 'card', :l, :t, :te, :d, :de, :f, :fe, 'learn_more', :ct, :cte, :r, :u, 'approved')"
    )->execute([':c' => $campaignId, ':l' => $src['card_layout'] ?: 'wide', ':t' => $src['title'], ':te' => $src['title_en'], ':d' => $src['description'],
        ':de' => $src['description_en'], ':f' => $src['description_fallback'], ':fe' => $src['description_fallback_en'], ':ct' => $src['cta_text'],
        ':cte' => $src['cta_text_en'], ':r' => $ref, ':u' => $url]);
    promo_log_event($pdo, 'house_variant_added', (int) $pdo->lastInsertId(), $campaignId, $ref, $adminId);

    return [true, 'Додано варіант ' . $ref . ' (копія останнього) — відредагуйте тексти.'];
}

/** Дублювати власну кампанію (на паузі, нові ref). */
function promo_house_duplicate(PDO $pdo, int $adminId, int $campaignId): array
{
    $st = $pdo->prepare("SELECT * FROM ad_campaigns WHERE id = :id AND campaign_type = 'internal'");
    $st->execute([':id' => $campaignId]);
    $c = $st->fetch();
    if ($c === false) {
        return [false, 'Кампанію не знайдено.'];
    }
    $pdo->beginTransaction();
    try {
        $pdo->prepare(
            "INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, status, start_date, currency, house_rules, notes)
             VALUES ('internal', 'video', NULL, :n, 'AI LAB HUB', 'paused', CURDATE(), 'USD', :r, :notes)"
        )->execute([':n' => mb_substr($c['name'] . ' (копія)', 0, 120), ':r' => $c['house_rules'], ':notes' => 'Копія власної кампанії #' . $campaignId]);
        $newId = (int) $pdo->lastInsertId();
        $new = ['id' => $newId, 'house_key' => null];
        $pdo->prepare('INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
                       SELECT :n, placement, category_id, subcategory_id, mp_section, language, device, NULL FROM ad_targets WHERE campaign_id = :c')
            ->execute([':n' => $newId, ':c' => $campaignId]);
        $crs = $pdo->prepare("SELECT * FROM ad_creatives WHERE campaign_id = :c AND creative_type = 'card' ORDER BY id");
        $crs->execute([':c' => $campaignId]);
        foreach ($crs->fetchAll() as $cr) {
            $ref = promo_house_next_ref($pdo, $new);
            $url = (string) preg_replace('~([?&])ref=[^&]*~', '$1ref=' . $ref, (string) $cr['destination_url']);
            $pdo->prepare(
                "INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, description_fallback, description_fallback_en,
                     cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
                 VALUES (:c, 'card', :l, :t, :te, :d, :de, :f, :fe, :ck, :ct, :cte, :r, :u, 'approved')"
            )->execute([':c' => $newId, ':l' => $cr['card_layout'], ':t' => $cr['title'], ':te' => $cr['title_en'], ':d' => $cr['description'], ':de' => $cr['description_en'],
                ':f' => $cr['description_fallback'], ':fe' => $cr['description_fallback_en'], ':ck' => $cr['cta_key'], ':ct' => $cr['cta_text'], ':cte' => $cr['cta_text_en'],
                ':r' => $ref, ':u' => promo_house_url($url, $ref) ?? $url]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] house duplicate: ' . $e->getMessage());

        return [false, 'Не вдалося дублювати.'];
    }
    promo_log_event($pdo, 'house_duplicated', null, $newId, 'з #' . $campaignId, $adminId);

    return [true, 'Створено копію #' . $newId . ' (на паузі).'];
}

/** Розмітка вкладки (картки). $badge — функція статус-бейджа адмінки. */
function promo_house_admin_html(PDO $pdo, string $csrf, callable $badge): string
{
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    if (!promo_house_columns($pdo)) {
        return '<p class="pc-note pc-note--warn">Застосуйте міграцію database/migration-2026-10-23-house-ads.sql — тоді тут з’являться картки власної реклами.</p>';
    }
    $mpOpen = site_setting($pdo, 'marketplace_public', '0') === '1';
    $enabled = promo_enabled($pdo);
    $h = '<div class="pc-box"><p><strong>Як працює:</strong> платна реклама завжди має пріоритет — власна заповнює слот лише тоді, коли для нього немає придатної платної кампанії; '
        . 'не більше одного власного блока на сторінку, ліміт ' . (int) promo_setting($pdo, 'house_frequency_cap', '2') . ' покази кампанії одному сеансу за добу. '
        . 'Безкоштовно, без білінгу, не входить у витрати рекламодавців. Уся реклама — лише коли ввімкнено перемикач (зараз: ' . ($enabled ? 'увімкнено' : '<strong>вимкнено</strong>') . ').</p>'
        . '<p>Кампанія B чекає на <code>marketplace_public = 1</code> (зараз: ' . ($mpOpen ? 'маркетплейс відкрито — показ можливий' : '<strong>маркетплейс закрито — B не показується</strong>') . ').</p></div>';
    foreach (promo_house_campaigns($pdo) as $c) {
        $cid = (int) $c['id'];
        $crs = $pdo->prepare("SELECT * FROM ad_creatives WHERE campaign_id = :c AND creative_type = 'card' ORDER BY id");
        $crs->execute([':c' => $cid]);
        $creatives = $crs->fetchAll();
        $stats = promo_house_variant_stats($pdo, $creatives);
        $flags = promo_house_rules_flags($c['house_rules']);
        $tg = $pdo->prepare('SELECT DISTINCT placement FROM ad_targets WHERE campaign_id = :c');
        $tg->execute([':c' => $cid]);
        $places = $tg->fetchAll(PDO::FETCH_COLUMN);

        $h .= '<article class="pc-mod"><h3 class="pc-h3">#' . $cid . ' ' . $e($c['name']) . ' ' . $badge((string) $c['status'])
            . ($c['house_key'] ? ' <span class="pc-muted">' . $e($c['house_key']) . '</span>' : '') . '</h3>';
        // Статус і дії
        $h .= '<p class="pc-actions">';
        foreach (array_filter([$c['status'] === 'active' ? 'stop' : null, $c['status'] === 'paused' ? 'resume' : null]) as $op) {
            $h .= '<form method="post" action="promo-admin-action.php" class="pc-inline-form">' . $csrf
                . '<input type="hidden" name="action" value="campaign_status"><input type="hidden" name="campaign_id" value="' . $cid . '">'
                . '<input type="hidden" name="op" value="' . $op . '"><input type="hidden" name="return_tab" value="house">'
                . '<button type="submit" class="pc-btn pc-btn--small' . ($op === 'resume' ? ' pc-btn--primary' : '') . '">' . ($op === 'resume' ? 'Активувати' : 'Пауза') . '</button></form>';
        }
        foreach (['house_add_variant' => 'Додати варіант', 'house_duplicate' => 'Дублювати кампанію', 'house_preview' => 'Переглянути на сторінці'] as $act => $label) {
            $h .= '<form method="post" action="promo-admin-action.php" class="pc-inline-form"' . ($act === 'house_preview' ? ' target="_blank"' : '') . '>' . $csrf
                . '<input type="hidden" name="action" value="' . $act . '"><input type="hidden" name="campaign_id" value="' . $cid . '">'
                . '<button type="submit" class="pc-btn pc-btn--small">' . $label . '</button></form>';
        }
        $h .= '</p><p class="pc-muted">«Переглянути на сторінці» робить кампанію тестовою (is_test) і відкриває сторінку з ?promo_preview=1 — бачить лише адміністратор, без обліку.</p>';

        // Кампанія: назва, місця, умови
        $h .= '<details><summary>Назва, місця й умови показу</summary><form method="post" action="promo-admin-action.php">' . $csrf
            . '<input type="hidden" name="action" value="house_campaign_save"><input type="hidden" name="campaign_id" value="' . $cid . '">'
            . '<label class="pc-field"><span>Назва (для адмінки)</span><input type="text" name="name" maxlength="120" value="' . $e($c['name']) . '"></label><fieldset class="pc-field"><legend>Місця</legend>';
        foreach (promo_placements($pdo) as $k => $p) {
            $h .= '<label class="pc-check"><input type="checkbox" name="placements[]" value="' . $e($k) . '"' . (in_array($k, $places, true) ? ' checked' : '') . '> <span>'
                . $e($p['title_uk']) . ' <small class="pc-muted">' . $e(['catalog' => 'Каталог', 'blog' => 'Блог', 'marketplace' => 'Маркетплейс'][$p['group_key']] ?? '') . '</small></span></label>';
        }
        $h .= '</fieldset><fieldset class="pc-field"><legend>Умови показу</legend>';
        foreach (PROMO_HOUSE_RULES as $k => $label) {
            $h .= '<label class="pc-check"><input type="checkbox" name="rules[' . $k . ']" value="1"' . (!empty($flags[$k]) ? ' checked' : '') . '> <span>' . $e($label) . '</span></label>';
        }
        $h .= '</fieldset><button type="submit" class="pc-btn pc-btn--primary">Зберегти кампанію</button></form></details>';

        // Варіанти
        $h .= '<div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Варіант</th><th>Покази</th><th>Кліки</th><th>CTR</th><th>Кампаній створено</th><th>Оголошень створено</th><th>Дії</th></tr></thead><tbody>';
        foreach ($creatives as $cr) {
            $s = $stats[(int) $cr['id']];
            $hv = 'hv-' . (int) $cr['id'];
            $h .= '<tr><td data-label="Варіант"><strong>' . $e($cr['ref_code'] ?: '#' . $cr['id']) . '</strong><span class="pc-muted">' . $e($cr['title']) . '</span></td>'
                . '<td data-label="Покази">' . $s['impressions'] . '</td><td data-label="Кліки">' . $s['clicks'] . '</td>'
                . '<td data-label="CTR">' . $e(promo_ctr($s['clicks'], $s['impressions'])) . '</td>'
                . '<td data-label="Кампаній">' . $s['campaigns'] . '</td><td data-label="Оголошень">' . $s['listings'] . '</td>'
                . '<td data-label="Дії"><a class="pc-btn pc-btn--small pc-btn--primary" href="#' . $hv . '" data-pc-house-open="' . $hv . '">Редагувати текст і кнопку</a></td></tr>';
        }
        $h .= '</tbody></table></div><p class="pc-muted">' . $e(promo_house_ab_text($creatives, $stats)) . '</p>';
        foreach ($creatives as $cr) {
            $f = static fn(string $name, string $label, int $max, bool $area = false) => '<label class="pc-field"><span>' . $label . '</span>'
                . ($area ? '<textarea name="' . $name . '" maxlength="' . $max . '" rows="2">' . $e($cr[$name] ?? '') . '</textarea>'
                         : '<input type="text" name="' . $name . '" maxlength="' . $max . '" value="' . $e($cr[$name] ?? '') . '">') . '</label>';
            $h .= '<details id="hv-' . (int) $cr['id'] . '" class="pc-house-edit"><summary>Редагувати варіант ' . $e($cr['ref_code'] ?: '#' . $cr['id']) . ' (заголовок, опис, кнопка, адреса)</summary><form method="post" action="promo-admin-action.php">' . $csrf
                . '<input type="hidden" name="action" value="house_variant_save"><input type="hidden" name="creative_id" value="' . (int) $cr['id'] . '"><div class="pc-grid-2">'
                . $f('title', 'Заголовок UA (до 60)', 60) . $f('title_en', 'Заголовок EN (до 60)', 60)
                . $f('description', 'Опис UA (до 150; можна {free_until})', 150, true) . $f('description_en', 'Опис EN', 150, true)
                . $f('description_fallback', 'Запасний опис UA (коли дати немає)', 150, true) . $f('description_fallback_en', 'Запасний опис EN', 150, true)
                . $f('cta_text', 'Текст кнопки UA', 40) . $f('cta_text_en', 'Текст кнопки EN', 40)
                . $f('destination_url', 'Адреса переходу (/… або https://)', 480) . $f('ref_code', 'Код ref (house-A1)', 20)
                . '<label class="pc-field"><span>Макет</span><select name="card_layout"><option value="wide"' . ($cr['card_layout'] !== 'compact' ? ' selected' : '') . '>Широкий (стрічка/блок)</option>'
                . '<option value="compact"' . ($cr['card_layout'] === 'compact' ? ' selected' : '') . '>Компактний (картка в списку)</option></select></label>'
                . '</div><p class="pc-muted">У сітках списків картка завжди компактна. ref додається до адреси автоматично.</p>'
                . '<button type="submit" class="pc-btn pc-btn--primary">Зберегти варіант</button></form></details>';
        }
        $h .= '</article>';
    }

    // «Редагувати текст і кнопку» у рядку таблиці відкриває форму варіанта й прокручує до неї (над закріпленим підвалом).
    $h .= "<script>document.addEventListener('click',function(e){var a=e.target.closest&&e.target.closest('[data-pc-house-open]');if(!a){return;}"
        . "var d=document.getElementById(a.getAttribute('data-pc-house-open'));if(!d){return;}e.preventDefault();d.open=true;"
        . "d.scrollIntoView({block:'start'});window.scrollBy(0,-110);});</script>";

    return $h;
}

/** «Звіти»: розбивка за варіантами власної реклами (за весь час). */
function promo_house_report_html(PDO $pdo): string
{
    if (!promo_house_columns($pdo)) {
        return '';
    }
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $rows = $pdo->query(
        "SELECT cr.*, c.name AS campaign_name FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
         WHERE c.campaign_type = 'internal' AND cr.creative_type = 'card' ORDER BY c.id, cr.id"
    )->fetchAll();
    if ($rows === []) {
        return '';
    }
    $stats = promo_house_variant_stats($pdo, $rows);
    $h = '<h3 class="pc-h3">Власна реклама за варіантами (за весь час)</h3><div class="pc-table-wrap"><table class="pc-table"><thead><tr>'
        . '<th>Кампанія / варіант</th><th>Покази</th><th>Кліки</th><th>CTR</th><th>Кампаній створено</th><th>Оголошень створено</th></tr></thead><tbody>';
    foreach ($rows as $r) {
        $s = $stats[(int) $r['id']];
        $h .= '<tr><td data-label="Варіант">' . $e($r['campaign_name']) . ' · <strong>' . $e($r['ref_code'] ?: '#' . $r['id']) . '</strong></td>'
            . '<td data-label="Покази">' . $s['impressions'] . '</td><td data-label="Кліки">' . $s['clicks'] . '</td>'
            . '<td data-label="CTR">' . $e(promo_ctr($s['clicks'], $s['impressions'])) . '</td>'
            . '<td data-label="Кампаній">' . $s['campaigns'] . '</td><td data-label="Оголошень">' . $s['listings'] . '</td></tr>';
    }

    return $h . '</tbody></table></div><p class="pc-muted">«Створено» — перша кампанія чи оголошення користувача після переходу з варіанта (параметр ref у сесії). Власна реклама не входить у витрати рекламодавців.</p>';
}

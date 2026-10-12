<?php

declare(strict_types=1);

/**
 * AI LAB HUB — адмінка реклами: модерація, платежі, прайс, налаштування,
 * звіти й скарги, власна реклама сайту, екстрене вимкнення.
 * Розмітка — app/promo-admin-cabinet.php, обробник — public/promo-admin-action.php.
 *
 * Роль перевіряється за БД (promo_is_admin), а не лише за сесією: знятий з
 * посади адмін втрачає доступ одразу.
 */

require_once __DIR__ . '/promo-advertiser.php';

/** Актуальна роль admin за БД. */
function promo_is_admin(PDO $pdo, ?int $userId): bool
{
    if ($userId === null) {
        return false;
    }
    $st = $pdo->prepare('SELECT role FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return $st->fetchColumn() === 'admin';
}

/** Ключі ad_settings, які редагуються в адмінці, і їхні правила. */
const PROMO_SETTING_RULES = [
    'max_video_mb' => ['int', 1, 500],
    'max_video_sec' => ['int', 1, 300],
    'frequency_cap_per_session' => ['int', 0, 50],
    'min_topup' => ['money'],
    'payment_jar_url' => ['url'],
    'payment_instructions_uk' => ['text', 5000],
    'payment_instructions_en' => ['text', 5000],
    'prohibited_categories_text_uk' => ['text', 5000],
    'prohibited_categories_text_en' => ['text', 5000],
    'rules_text_uk' => ['text', 20000],
    'rules_text_en' => ['text', 20000],
    'moderation_time_text_uk' => ['text', 500],
    'moderation_time_text_en' => ['text', 500],
];

function promo_admin_set_setting(PDO $pdo, string $key, string $value): void
{
    $pdo->prepare(
        'INSERT INTO ad_settings (setting_key, setting_value) VALUES (:k, :v)
         ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)'
    )->execute([':k' => $key, ':v' => $value]);
    promo_settings($pdo, true);
}

/** Зберегти налаштування з форми. @return list<string> помилки */
function promo_admin_save_settings(PDO $pdo, array $in): array
{
    $errors = [];
    $values = [];
    foreach (PROMO_SETTING_RULES as $key => $rule) {
        $raw = trim(str_replace("\r\n", "\n", (string) ($in[$key] ?? '')));
        switch ($rule[0]) {
            case 'int':
                if (!preg_match('/^\d+$/', $raw) || (int) $raw < $rule[1] || (int) $raw > $rule[2]) {
                    $errors[] = "«{$key}»: ціле число від {$rule[1]} до {$rule[2]}.";
                    continue 2;
                }
                $values[$key] = (string) (int) $raw;
                break;
            case 'url':
                $p = parse_url($raw);
                if ($raw !== '' && (mb_strlen($raw) > 500 || !is_array($p) || strtolower((string) ($p['scheme'] ?? '')) !== 'https'
                    || empty($p['host']) || isset($p['user']) || preg_match('/[\s<>"\']/', $raw))) {
                    $errors[] = 'Посилання на банку для оплати реклами: повна адреса, що починається з https://, або порожньо.';
                    continue 2;
                }
                $values[$key] = $raw;
                break;
            case 'money':
                if ($raw === '') {
                    $values[$key] = '';
                    break;
                }
                $kop = promo_parse_money($raw);
                if ($kop === null || $kop <= 0) {
                    $errors[] = 'Мінімальне поповнення: сума в гривнях (напр. 500 або 500.00) або порожньо.';
                    continue 2;
                }
                $values[$key] = number_format($kop / 100, 2, '.', '');
                break;
            case 'text':
                if (mb_strlen($raw) > $rule[1]) {
                    $errors[] = "«{$key}»: не довше {$rule[1]} символів.";
                    continue 2;
                }
                $values[$key] = strip_tags($raw);
                break;
        }
    }
    if ($errors === []) {
        foreach ($values as $k => $v) {
            promo_admin_set_setting($pdo, $k, $v);
        }
    }

    return $errors;
}

/** Ліміт завантаження сервера в байтах (менший з upload_max_filesize і post_max_size). */
function promo_server_upload_limit(): int
{
    $bytes = static function (string $v): int {
        $v = trim($v);
        $n = (int) $v;
        return match (strtolower(substr($v, -1))) {
            'g' => $n * 1024 ** 3,
            'm' => $n * 1024 ** 2,
            'k' => $n * 1024,
            default => $n,
        };
    };
    $limits = array_filter([$bytes((string) ini_get('upload_max_filesize')), $bytes((string) ini_get('post_max_size'))]);

    return $limits === [] ? 0 : min($limits);
}

// --- Модерація -------------------------------------------------------------

/** Черга: креативи pending разом із кампанією та власником. */
function promo_admin_queue(PDO $pdo): array
{
    return $pdo->query(
        "SELECT cr.*, c.name AS campaign_name, c.objective, c.advertiser_category, c.stop_reason AS campaign_stop_reason, c.pricing_model, c.unit_price, c.daily_budget, c.total_budget,
                c.start_date, c.end_date, c.submitted_at, c.user_id, c.id AS cid,
                u.name AS user_name, u.email AS user_email, COALESCE(b.balance, 0) AS balance
         FROM ad_creatives cr
         JOIN ad_campaigns c ON c.id = cr.campaign_id
         LEFT JOIN users u ON u.id = c.user_id
         LEFT JOIN ad_balances b ON b.user_id = c.user_id
         WHERE cr.status = 'pending' AND c.status = 'pending_review' AND c.format = 'video'
         ORDER BY c.submitted_at, cr.id"
    )->fetchAll();
}

/** Людський опис таргету кампанії. */
function promo_admin_targets_text(PDO $pdo, int $campaignId): array
{
    $t = promo_campaign_targeting($pdo, $campaignId);
    $names = [];
    if ($t['cats'] !== []) {
        $in = implode(',', array_map('intval', $t['cats']));
        $names = array_merge($names, $pdo->query("SELECT name FROM categories WHERE id IN ($in)")->fetchAll(PDO::FETCH_COLUMN));
    }
    if ($t['subs'] !== []) {
        $in = implode(',', array_map('intval', $t['subs']));
        $names = array_merge($names, $pdo->query("SELECT CONCAT(c.name, ' → ', s.name) FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE s.id IN ($in)")->fetchAll(PDO::FETCH_COLUMN));
    }
    $prices = $pdo->prepare('SELECT placement, MAX(unit_price) FROM ad_targets WHERE campaign_id = :c GROUP BY placement');
    $prices->execute([':c' => $campaignId]);

    return [
        'placements' => $prices->fetchAll(PDO::FETCH_KEY_PAIR),
        'categories' => $names === [] ? ['усі категорії'] : $names,
        'language' => $t['language'],
        'device' => $t['device'],
    ];
}

/**
 * Схвалити або відхилити креатив. Повертає повідомлення.
 *
 * Креатив, адреса якого має прапорці перевірки (link_check_status='flagged') або
 * ще не перевірялась, схвалюється лише з явним підтвердженням адміна й причиною
 * ($confirmFlagged + $overrideReason) — рішення пишеться в promo_event_log.
 */
function promo_admin_moderate(PDO $pdo, int $adminId, int $creativeId, bool $approve, string $reason, bool $confirmFlagged = false, string $overrideReason = ''): array
{
    $reason = trim(promo_clean_text($reason));
    if (!$approve && $reason === '') {
        return [false, 'Вкажіть причину відхилення — її побачить рекламодавець.'];
    }
    $st = $pdo->prepare(
        "SELECT cr.id, cr.campaign_id, cr.link_check_status, c.advertiser_category FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
         WHERE cr.id = :id AND cr.status = 'pending' AND c.status = 'pending_review'"
    );
    $st->execute([':id' => $creativeId]);
    $row = $st->fetch();
    if ($row === false) {
        return [false, 'Креатив не знайдено або його вже розглянуто.'];
    }
    $overrideReason = trim(promo_clean_text($overrideReason));
    if ($approve && promo_category_blocked_everywhere($pdo, $row['advertiser_category'])) {
        return [false, 'Категорія реклами «' . promo_advertiser_category_label($row['advertiser_category']) . '» заборонена правилами всюди — креатив треба відхилити.'];
    }
    if ($approve && $row['link_check_status'] !== 'ok') {
        if (!$confirmFlagged || $overrideReason === '') {
            return [false, $row['link_check_status'] === 'flagged'
                ? 'Перевірка посилання має прапорці: схвалити можна лише з підтвердженням і причиною.'
                : 'Посилання ще не перевірено: перевірте ще раз або підтвердіть схвалення з причиною.'];
        }
        promo_log_event($pdo, 'approve_flagged', $creativeId, (int) $row['campaign_id'], $overrideReason, $adminId);
    }

    $pdo->beginTransaction();
    try {
        $pdo->prepare(
            'UPDATE ad_creatives SET status = :s, rejection_reason = :r, reviewed_by = :a, reviewed_at = NOW(), recheck_reason = NULL WHERE id = :id'
        )->execute([':s' => $approve ? 'approved' : 'rejected', ':r' => $approve ? null : mb_substr($reason, 0, 500), ':a' => $adminId, ':id' => $creativeId]);
        if ($approve) {
            // Схвалено → кінцевий домен останньої перевірки стає базовим для повторних перевірок.
            $pdo->prepare(
                'UPDATE ad_creatives SET link_fail_streak = 0,
                     link_final_host = COALESCE((SELECT final_host FROM ad_link_checks WHERE creative_id = :c ORDER BY id DESC LIMIT 1), link_final_host)
                 WHERE id = :id'
            )->execute([':c' => $creativeId, ':id' => $creativeId]);
        }
        $pdo->prepare(
            'UPDATE ad_campaigns SET status = :s, rejection_reason = :r, stop_reason = NULL WHERE id = :id'
        )->execute([':s' => $approve ? 'active' : 'rejected', ':r' => $approve ? null : mb_substr($reason, 0, 500), ':id' => (int) $row['campaign_id']]);
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] moderate: ' . $e->getMessage());

        return [false, 'Не вдалося зберегти рішення.'];
    }

    promo_log_event($pdo, $approve ? 'approved' : 'rejected', $creativeId, (int) $row['campaign_id'], $approve ? '' : $reason, $adminId);

    return [true, $approve
        ? 'Креатив схвалено, кампанія активна (показ почнеться з дати старту за наявності коштів на балансі).'
        : 'Креатив відхилено, рекламодавець бачить причину в кабінеті.'];
}

// --- Перевірка посилань: чорний список і скорочувачі -----------------------

function promo_admin_blocklist_add(PDO $pdo, int $adminId, string $domain, string $reason): array
{
    $domain = promo_norm_host(trim($domain));
    if (str_contains($domain, '://')) {
        $domain = promo_norm_host((string) parse_url($domain, PHP_URL_HOST));
    }
    if (!preg_match('/^(?=.{1,253}$)([a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9-]{2,63}$/', $domain)) {
        return [false, 'Вкажіть домен, напр. example.com (піддомени теж блокуються).'];
    }
    $pdo->prepare(
        'INSERT INTO ad_domain_blocklist (domain, reason, created_by, created_at) VALUES (:d, :r, :a, :t)
         ON DUPLICATE KEY UPDATE reason = VALUES(reason)'
    )->execute([':d' => $domain, ':r' => mb_substr(promo_clean_text($reason), 0, 255) ?: null, ':a' => $adminId, ':t' => promo_utc_now()]);
    promo_log_event($pdo, 'blocklist_add', null, null, $domain, $adminId);

    return [true, 'Домен ' . $domain . ' додано до чорного списку. Креативи з ним отримають прапорець під час наступної перевірки.'];
}

function promo_admin_blocklist_remove(PDO $pdo, int $adminId, int $id): array
{
    $st = $pdo->prepare('SELECT domain FROM ad_domain_blocklist WHERE id = :id');
    $st->execute([':id' => $id]);
    $domain = $st->fetchColumn();
    if ($domain === false) {
        return [false, 'Запис не знайдено.'];
    }
    $pdo->prepare('DELETE FROM ad_domain_blocklist WHERE id = :id')->execute([':id' => $id]);
    promo_log_event($pdo, 'blocklist_remove', null, null, (string) $domain, $adminId);

    return [true, 'Домен ' . $domain . ' прибрано з чорного списку.'];
}

function promo_admin_save_shorteners(PDO $pdo, string $raw): array
{
    $list = [];
    foreach (preg_split('/[\r\n,]+/', $raw) ?: [] as $line) {
        $d = promo_norm_host(trim($line));
        if ($d === '') {
            continue;
        }
        if (!preg_match('/^([a-z0-9-]+\.)+[a-z0-9-]{2,63}$/', $d)) {
            return [false, 'Некоректний домен у списку скорочувачів: ' . $d];
        }
        $list[] = $d;
    }
    promo_admin_set_setting($pdo, 'shortener_domains', implode("\n", array_values(array_unique($list))));

    return [true, 'Список скорочувачів збережено (' . count(array_unique($list)) . ').'];
}

// --- Платежі ---------------------------------------------------------------

/** Підтвердити або відхилити заявку на поповнення. */
function promo_admin_topup_decide(PDO $pdo, int $adminId, int $txId, bool $confirm, string $reason): array
{
    $reason = trim(promo_clean_text($reason));
    if (!$confirm && $reason === '') {
        return [false, 'Вкажіть причину відхилення заявки.'];
    }
    $pdo->beginTransaction();
    try {
        $st = $pdo->prepare("SELECT * FROM ad_transactions WHERE id = :id AND type = 'topup' AND status = 'pending' FOR UPDATE");
        $st->execute([':id' => $txId]);
        $tx = $st->fetch();
        if ($tx === false) {
            $pdo->rollBack();

            return [false, 'Заявку не знайдено або її вже оброблено.'];
        }
        $pdo->prepare(
            'UPDATE ad_transactions SET status = :s, reject_reason = :r, confirmed_by = :a, confirmed_at = NOW() WHERE id = :id'
        )->execute([':s' => $confirm ? 'confirmed' : 'rejected', ':r' => $confirm ? null : mb_substr($reason, 0, 500), ':a' => $adminId, ':id' => $txId]);
        if ($confirm) {
            promo_admin_balance_add($pdo, (int) $tx['user_id'], (int) $tx['amount'], (string) $tx['currency']);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] topup decide: ' . $e->getMessage());

        return [false, 'Не вдалося обробити заявку.'];
    }

    return [true, $confirm
        ? 'Поповнення підтверджено, суму зараховано на баланс ' . promo_money($tx['amount']) . '.'
        : 'Заявку відхилено.'];
}

/**
 * Змінити баланс (у вже відкритій транзакції). Після поповнення кампанії, що
 * стояли на паузі через нестачу коштів, повертаються в показ.
 */
function promo_admin_balance_add(PDO $pdo, int $userId, int $amount, string $currency = 'UAH'): void
{
    $pdo->prepare(
        'INSERT INTO ad_balances (user_id, balance, currency) VALUES (:u, :a, :c)
         ON DUPLICATE KEY UPDATE balance = balance + VALUES(balance)'
    )->execute([':u' => $userId, ':a' => $amount, ':c' => $currency]);

    $bal = promo_balance($pdo, $userId);
    if ($bal > 0) {
        $pdo->prepare(
            "UPDATE ad_campaigns SET status = 'active', stop_reason = NULL
             WHERE user_id = :u AND format = 'video' AND status = 'paused' AND stop_reason = 'balance'"
        )->execute([':u' => $userId]);
    }
}

/** Ручне коригування / повернення на баланс з обов'язковою приміткою. */
function promo_admin_adjust(PDO $pdo, int $adminId, string $who, string $type, string $amountInput, string $note): array
{
    $note = trim(promo_clean_text($note));
    if ($note === '') {
        return [false, 'Примітка обов\'язкова: за що коригування.'];
    }
    $type = $type === 'refund' ? 'refund' : 'adjust';
    $neg = str_starts_with(trim($amountInput), '-');
    $amount = promo_parse_money(ltrim(trim($amountInput), '+-'));
    if ($amount === null || $amount === 0) {
        return [false, 'Некоректна сума.'];
    }
    if ($neg && $type === 'refund') {
        return [false, 'Повернення на баланс — лише додатна сума. Для списання використайте коригування.'];
    }
    $amount = $neg ? -$amount : $amount;

    $who = trim($who);
    $st = ctype_digit($who)
        ? $pdo->prepare('SELECT id, email FROM users WHERE id = :w')
        : $pdo->prepare('SELECT id, email FROM users WHERE email = :w');
    $st->execute([':w' => $who]);
    $user = $st->fetch();
    if ($user === false) {
        return [false, 'Користувача не знайдено (вкажіть email або ID).'];
    }
    $uid = (int) $user['id'];

    $pdo->beginTransaction();
    try {
        $pdo->prepare('INSERT IGNORE INTO ad_balances (user_id, balance) VALUES (:u, 0)')->execute([':u' => $uid]);
        $b = $pdo->prepare('SELECT balance FROM ad_balances WHERE user_id = :u FOR UPDATE');
        $b->execute([':u' => $uid]);
        if ((int) $b->fetchColumn() + $amount < 0) {
            $pdo->rollBack();

            return [false, 'Баланс не може стати від\'ємним.'];
        }
        $pdo->prepare(
            "INSERT INTO ad_transactions (user_id, type, amount, status, method, note, confirmed_by, confirmed_at)
             VALUES (:u, :t, :a, 'confirmed', 'manual', :n, :by, NOW())"
        )->execute([':u' => $uid, ':t' => $type, ':a' => $amount, ':n' => mb_substr($note, 0, 500), ':by' => $adminId]);
        promo_admin_balance_add($pdo, $uid, $amount);
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] adjust: ' . $e->getMessage());

        return [false, 'Не вдалося змінити баланс.'];
    }

    return [true, 'Баланс ' . $user['email'] . ' змінено на ' . promo_money($amount) . '.'];
}

// --- Прайс -----------------------------------------------------------------

/** Зберегти прайс: price[placement][model] у гривнях; порожньо — ціна неактивна. */
function promo_admin_save_rates(PDO $pdo, array $in): array
{
    $errors = [];
    $rows = [];
    foreach (PROMO_PLACEMENTS as $pl) {
        foreach (['cpm', 'cpc'] as $m) {
            $raw = trim((string) ($in['price'][$pl][$m] ?? ''));
            if ($raw === '') {
                $rows[] = [$pl, $m, null];
                continue;
            }
            $kop = promo_parse_money($raw);
            if ($kop === null || $kop <= 0) {
                $errors[] = 'Некоректна ціна: ' . $pl . ' / ' . strtoupper($m) . '.';
                continue;
            }
            $rows[] = [$pl, $m, $kop];
        }
    }
    if ($errors !== []) {
        return $errors;
    }
    foreach ($rows as [$pl, $m, $kop]) {
        if ($kop === null) {
            // Ціну прибрано: рядок лишається (історія), але неактивний — нові кампанії з ним не стартують.
            $pdo->prepare("UPDATE ad_rate_card SET active = 0 WHERE placement = :p AND pricing_model = :m AND currency = 'UAH'")
                ->execute([':p' => $pl, ':m' => $m]);
        } else {
            $pdo->prepare(
                "INSERT INTO ad_rate_card (placement, pricing_model, price, currency, active) VALUES (:p, :m, :pr, 'UAH', 1)
                 ON DUPLICATE KEY UPDATE price = VALUES(price), active = 1"
            )->execute([':p' => $pl, ':m' => $m, ':pr' => $kop]);
        }
    }

    return [];
}

// --- Кампанії: екстрена зупинка -------------------------------------------

function promo_admin_campaign_status(PDO $pdo, int $campaignId, string $action): array
{
    $st = $pdo->prepare("SELECT * FROM ad_campaigns WHERE id = :id AND format = 'video'");
    $st->execute([':id' => $campaignId]);
    $c = $st->fetch();
    if ($c === false) {
        return [false, 'Кампанію не знайдено.'];
    }
    if ($action === 'stop') {
        if (!in_array($c['status'], ['active', 'pending_review'], true)) {
            return [false, 'Кампанія вже не показується.'];
        }
        $pdo->prepare("UPDATE ad_campaigns SET status = 'paused', stop_reason = 'admin' WHERE id = :id")->execute([':id' => $campaignId]);

        return [true, 'Кампанію #' . $campaignId . ' зупинено.'];
    }
    if ($action === 'resume') {
        if ($c['status'] !== 'paused') {
            return [false, 'Відновити можна лише кампанію на паузі.'];
        }
        $cr = promo_campaign_creative($pdo, $campaignId);
        if ($cr === null || $cr['status'] !== 'approved') {
            return [false, 'Креатив не схвалено (або призупинено) — спершу модерація.'];
        }
        $pdo->prepare("UPDATE ad_campaigns SET status = 'active', stop_reason = NULL WHERE id = :id")->execute([':id' => $campaignId]);

        return [true, 'Кампанію #' . $campaignId . ' відновлено.'];
    }

    return [false, 'Невідома дія.'];
}

// --- Скарги ----------------------------------------------------------------

/** Призупинити креатив (після скарг): зникає з показу; рекламодавець бачить «зупинено адміністратором». */
function promo_admin_suspend_creative(PDO $pdo, int $adminId, int $creativeId, string $reason): array
{
    $st = $pdo->prepare('SELECT campaign_id FROM ad_creatives WHERE id = :id');
    $st->execute([':id' => $creativeId]);
    $campaignId = $st->fetchColumn();
    if ($campaignId === false) {
        return [false, 'Креатив не знайдено.'];
    }
    $reason = trim(promo_clean_text($reason)) ?: 'Призупинено адміністратором після скарг відвідувачів.';
    $pdo->beginTransaction();
    try {
        $pdo->prepare("UPDATE ad_creatives SET status = 'suspended', rejection_reason = :r, reviewed_by = :a, reviewed_at = NOW() WHERE id = :id")
            ->execute([':r' => mb_substr($reason, 0, 500), ':a' => $adminId, ':id' => $creativeId]);
        $pdo->prepare("UPDATE ad_campaigns SET status = 'paused', stop_reason = 'admin' WHERE id = :id AND status IN ('active', 'pending_review')")
            ->execute([':id' => (int) $campaignId]);
        $pdo->prepare("UPDATE ad_reports SET status = 'reviewed' WHERE creative_id = :id")->execute([':id' => $creativeId]);
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] suspend: ' . $e->getMessage());

        return [false, 'Не вдалося призупинити креатив.'];
    }

    return [true, 'Креатив #' . $creativeId . ' призупинено, кампанію зупинено.'];
}

/** Скарги, згруповані за креативом (нові спершу). */
function promo_admin_reports(PDO $pdo): array
{
    return $pdo->query(
        "SELECT r.creative_id, cr.title, cr.status AS creative_status, c.id AS campaign_id, c.name AS campaign_name,
                c.campaign_type, u.email AS user_email,
                COUNT(*) AS total, SUM(r.status = 'new') AS new_count,
                GROUP_CONCAT(DISTINCT r.reason ORDER BY r.reason SEPARATOR ', ') AS reasons,
                MAX(r.created_at) AS last_at
         FROM ad_reports r
         JOIN ad_creatives cr ON cr.id = r.creative_id
         JOIN ad_campaigns c ON c.id = cr.campaign_id
         LEFT JOIN users u ON u.id = c.user_id
         GROUP BY r.creative_id, cr.title, cr.status, c.id, c.name, c.campaign_type, u.email
         ORDER BY new_count DESC, last_at DESC
         LIMIT 200"
    )->fetchAll();
}

// --- Звіти платформи -------------------------------------------------------

/** Підсумки платформи за період: окремо платні й власна реклама. */
function promo_admin_platform_totals(PDO $pdo, string $from, string $to): array
{
    $st = $pdo->prepare(
        "SELECT c.campaign_type, SUM(s.impressions) impressions, SUM(s.views) views, SUM(s.clicks) clicks, SUM(s.spend) spend
         FROM ad_stats_daily s JOIN ad_campaigns c ON c.id = s.campaign_id
         WHERE s.stat_date BETWEEN :f AND :t
         GROUP BY c.campaign_type"
    );
    $st->execute([':f' => $from, ':t' => $to]);
    $out = ['paid' => null, 'internal' => null];
    foreach ($st->fetchAll() as $r) {
        $out[$r['campaign_type']] = $r;
    }

    return $out;
}

function promo_admin_top_campaigns(PDO $pdo, string $from, string $to): array
{
    $st = $pdo->prepare(
        "SELECT c.id, c.name, c.status, c.campaign_type, u.email AS user_email,
                SUM(s.impressions) impressions, SUM(s.views) views, SUM(s.clicks) clicks, SUM(s.spend) spend
         FROM ad_stats_daily s JOIN ad_campaigns c ON c.id = s.campaign_id
         LEFT JOIN users u ON u.id = c.user_id
         WHERE s.stat_date BETWEEN :f AND :t
         GROUP BY c.id, c.name, c.status, c.campaign_type, u.email
         ORDER BY spend DESC, impressions DESC
         LIMIT 20"
    );
    $st->execute([':f' => $from, ':t' => $to]);

    return $st->fetchAll();
}

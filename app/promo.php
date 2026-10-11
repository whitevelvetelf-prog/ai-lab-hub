<?php

declare(strict_types=1);

/**
 * AI LAB HUB — система відеореклами (promo): налаштування, підпис токенів,
 * відбір креативу, облік подій і атомарне списання.
 *
 * Схема — database/migration-2026-10-11-promo-video.sql (ad_campaigns з
 * format='video', ad_creatives, ad_targets, ad_events, ad_stats_daily,
 * ad_balances, ad_transactions, ad_rate_card, ad_settings, ad_reports).
 *
 * Назви файлів і CSS-класів — нейтральні (promo / sponsored): шляхи з «ad»
 * блокуються розширеннями-блокувальниками реклами.
 *
 * Гроші — цілі копійки. CPM: ціна за 1000 показів, тож один показ коштує
 * unit_price/1000 копійки; частки накопичуються в ad_campaigns.cpm_accrual
 * (тисячні копійки) і списуються цілою копійкою, щойно набирається.
 *
 * Підключати після app/auth.php (потрібна сесія для session_hash):
 *   require_once __DIR__ . '/../app/auth.php';
 *   require_once __DIR__ . '/../app/promo.php';
 */

require_once __DIR__ . '/analytics.php';

const PROMO_PLACEMENTS = ['catalog_card', 'product_page', 'blog_inline'];
const PROMO_CTA_KEYS = ['learn_more', 'try', 'go', 'download'];
const PROMO_REPORT_REASONS = ['misleading', 'inappropriate', 'scam', 'irrelevant', 'other'];

/** Скільки живе токен показу (сек): події з давнішим токеном не рахуються. */
const PROMO_TOKEN_TTL = 7200;
/** Повторний клік того ж сеансу по тому ж креативу протягом цього часу (сек) не рахується. */
const PROMO_CLICK_DEDUP_SEC = 1800;
/** Ліміт подій від одного сеансу за хвилину. */
const PROMO_EVENTS_PER_MINUTE = 30;
/** Сирі події зберігаються стільки днів (агрегати в ad_stats_daily — назавжди). */
const PROMO_EVENTS_KEEP_DAYS = 30;

// --- Налаштування й секрети ------------------------------------------------

/**
 * Значення ad_settings (кеш на запит). Якщо таблиці ще немає (міграцію не
 * застосовано) — порожній масив, тобто система вимкнена.
 *
 * @return array<string,string>
 */
function promo_settings(PDO $pdo, bool $refresh = false): array
{
    static $cache = null;
    if ($cache !== null && !$refresh) {
        return $cache;
    }
    try {
        $rows = $pdo->query('SELECT setting_key, setting_value FROM ad_settings')->fetchAll(PDO::FETCH_KEY_PAIR);
        $cache = array_map('strval', $rows);
    } catch (Throwable $e) {
        error_log('[promo] settings: ' . $e->getMessage());
        $cache = [];
    }

    return $cache;
}

function promo_setting(PDO $pdo, string $key, string $default = ''): string
{
    return promo_settings($pdo)[$key] ?? $default;
}

/**
 * Глобальний перемикач реклами (ad_settings.enabled). Вимикає ВСЮ рекламу на
 * сайті — і відеорекламу, і старі банери (app/ads.php). За замовчуванням 0.
 */
function promo_enabled(PDO $pdo): bool
{
    return promo_setting($pdo, 'enabled', '0') === '1';
}

/** @return array{secret:string,cron_key:string} */
function promo_config(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $file = __DIR__ . '/../config/promo.php';
        $raw = is_file($file) ? require $file : [];
        $cfg = [
            'secret'   => is_array($raw) ? (string) ($raw['secret'] ?? '') : '',
            'cron_key' => is_array($raw) ? (string) ($raw['cron_key'] ?? '') : '',
        ];
    }

    return $cfg;
}

/** Відеореклама може працювати: перемикач увімкнено й секрет токенів задано. */
function promo_video_ready(PDO $pdo): bool
{
    return promo_enabled($pdo) && strlen(promo_config()['secret']) >= 32;
}

// --- Токени (HMAC) ---------------------------------------------------------

function promo_b64u_encode(string $bin): string
{
    return rtrim(strtr(base64_encode($bin), '+/', '-_'), '=');
}

function promo_b64u_decode(string $txt): string|false
{
    return base64_decode(strtr($txt, '-_', '+/'), true);
}

/** Короткий відбиток сеансу для токена (повний session_hash у токен не кладемо). */
function promo_session_tag(): string
{
    return substr(analytics_session_hash(), 0, 16);
}

/**
 * Підписаний токен показу: креатив, кампанія, розміщення, сеанс, час.
 *
 * @param array{c:int,k:int,p:string} $data
 */
function promo_token_make(array $data): string
{
    $payload = promo_b64u_encode((string) json_encode([
        'c' => $data['c'],
        'k' => $data['k'],
        'p' => $data['p'],
        's' => promo_session_tag(),
        't' => time(),
    ]));
    $sig = promo_b64u_encode(hash_hmac('sha256', $payload, promo_config()['secret'], true));

    return $payload . '.' . $sig;
}

/**
 * Перевірити токен. null — підпис невірний або формат зламаний (підробка).
 * Повертає дані з прапорцями fresh (не прострочений) і own (той самий сеанс).
 *
 * @return array{c:int,k:int,p:string,s:string,t:int,fresh:bool,own:bool}|null
 */
function promo_token_read(string $token): ?array
{
    $secret = promo_config()['secret'];
    if (strlen($secret) < 32 || strlen($token) > 512 || substr_count($token, '.') !== 1) {
        return null;
    }
    [$payload, $sig] = explode('.', $token);
    $expected = promo_b64u_encode(hash_hmac('sha256', $payload, $secret, true));
    if (!hash_equals($expected, $sig)) {
        return null;
    }
    $json = promo_b64u_decode($payload);
    $data = $json === false ? null : json_decode($json, true);
    if (!is_array($data) || !isset($data['c'], $data['k'], $data['p'], $data['s'], $data['t'])
        || !in_array($data['p'], PROMO_PLACEMENTS, true)) {
        return null;
    }

    return [
        'c' => (int) $data['c'],
        'k' => (int) $data['k'],
        'p' => (string) $data['p'],
        's' => (string) $data['s'],
        't' => (int) $data['t'],
        'fresh' => time() - (int) $data['t'] <= PROMO_TOKEN_TTL && (int) $data['t'] <= time() + 60,
        'own' => hash_equals(promo_session_tag(), (string) $data['s']),
    ];
}

// --- Контекст відвідувача (без персональних даних) -------------------------

/** Відомі боти, сканери й прев'ю посилань — їхні покази/кліки не рахуються. */
function promo_is_bot(): bool
{
    $ua = (string) ($_SERVER['HTTP_USER_AGENT'] ?? '');
    if ($ua === '') {
        return true;
    }

    return (bool) preg_match(
        '~bot|crawl|spider|slurp|scrap|headless|lighthouse|pagespeed|preview|facebookexternalhit|embedly|whatsapp|telegram|curl|wget|python|java/|go-http|httpclient|okhttp|axios|node-fetch|monitor|uptime~i',
        $ua
    );
}

/** mobile / desktop: явний параметр сторінки, інакше — за User-Agent. */
function promo_device(?string $param = null): string
{
    if ($param === 'mobile' || $param === 'desktop') {
        return $param;
    }

    return preg_match('~Mobi|Android|iPhone|iPad|iPod~i', (string) ($_SERVER['HTTP_USER_AGENT'] ?? '')) ? 'mobile' : 'desktop';
}

function promo_lang(?string $param = null): string
{
    if ($param === 'uk' || $param === 'en') {
        return $param;
    }

    return function_exists('current_lang') && current_lang() === 'en' ? 'en' : 'uk';
}

// --- Відбір креативу -------------------------------------------------------

/**
 * Один креатив для слота або null. Умови: система ввімкнена, кампанія
 * video/active, креатив approved, сьогодні в межах дат, не вичерпано денний і
 * загальний бюджет, є кошти на балансі (власна реклама сайту — без білінгу),
 * збіг таргету, не перевищено ліміт показів кампанії одному сеансу за добу.
 *
 * Платні кампанії мають пріоритет над власною рекламою сайту. Серед платних —
 * випадковий вибір із вагою «залишок бюджету / днів до завершення»
 * (рівномірне витрачання: кампанія з більшим денним запасом показується частіше).
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 */
function promo_pick(PDO $pdo, string $placement, array $categoryIds, array $subcategoryIds, string $lang, string $device, string $sessionHash): ?array
{
    if (!in_array($placement, PROMO_PLACEMENTS, true) || !promo_video_ready($pdo)) {
        return null;
    }

    $params = [':pl' => $placement, ':lang' => $lang, ':dev' => $device, ':sh' => $sessionHash];

    $inList = static function (string $prefix, array $ids) use (&$params): string {
        $names = [];
        foreach (array_values(array_unique(array_map('intval', $ids))) as $i => $id) {
            $names[] = ':' . $prefix . $i;
            $params[':' . $prefix . $i] = $id;
        }

        return implode(',', $names);
    };
    $catCond = $categoryIds !== [] ? '(t.category_id IS NULL OR t.category_id IN (' . $inList('c', $categoryIds) . '))' : 't.category_id IS NULL';
    $subCond = $subcategoryIds !== [] ? '(t.subcategory_id IS NULL OR t.subcategory_id IN (' . $inList('s', $subcategoryIds) . '))' : 't.subcategory_id IS NULL';

    $cap = (int) promo_setting($pdo, 'frequency_cap_per_session', '3');
    $capCond = '';
    if ($cap > 0) {
        $capCond = 'AND (SELECT COUNT(*) FROM ad_events e
                          WHERE e.session_hash = :sh AND e.campaign_id = c.id AND e.type = \'impression\'
                            AND e.created_at >= NOW() - INTERVAL 1 DAY) < ' . $cap;
    } else {
        unset($params[':sh']);
    }

    $sql = "SELECT cr.id, cr.campaign_id, cr.title, cr.description, cr.cta_key, cr.video_type,
                   cr.video_path, cr.youtube_id, cr.poster_path,
                   c.campaign_type, c.total_budget, c.spent, c.end_date, COALESCE(b.balance, 0) AS balance
            FROM ad_creatives cr
            JOIN ad_campaigns c ON c.id = cr.campaign_id
            LEFT JOIN ad_balances b ON b.user_id = c.user_id
            WHERE c.format = 'video'
              AND c.status = 'active'
              AND cr.status = 'approved'
              AND (c.start_date IS NULL OR c.start_date <= CURDATE())
              AND (c.end_date IS NULL OR c.end_date >= CURDATE())
              AND (
                    c.campaign_type = 'internal'
                 OR (    c.unit_price IS NOT NULL AND c.unit_price > 0
                     AND c.pricing_model IS NOT NULL
                     AND COALESCE(b.balance, 0) > 0
                     AND (c.total_budget IS NULL OR c.spent < c.total_budget)
                     AND (c.daily_budget IS NULL OR c.spent_today_date IS NULL
                          OR c.spent_today_date < CURDATE() OR c.spent_today < c.daily_budget))
              )
              AND EXISTS (
                    SELECT 1 FROM ad_targets t
                    WHERE t.campaign_id = c.id
                      AND t.placement = :pl
                      AND {$catCond}
                      AND {$subCond}
                      AND (t.language IS NULL OR t.language = :lang)
                      AND (t.device IS NULL OR t.device = :dev)
              )
              {$capCond}
            LIMIT 100";

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        $rows = $stmt->fetchAll();
    } catch (Throwable $e) {
        error_log('[promo] pick: ' . $e->getMessage());

        return null;
    }
    if ($rows === []) {
        return null;
    }

    $paid = array_values(array_filter($rows, static fn($r) => $r['campaign_type'] !== 'internal'));
    $pool = $paid !== [] ? $paid : $rows;

    $today = new DateTimeImmutable('today');
    $weights = [];
    foreach ($pool as $i => $r) {
        if ($r['campaign_type'] === 'internal') {
            $weights[$i] = 1.0;
            continue;
        }
        $remaining = (int) $r['balance'];
        if ($r['total_budget'] !== null) {
            $remaining = min($remaining, (int) $r['total_budget'] - (int) $r['spent']);
        }
        $daysLeft = 30;
        if ($r['end_date'] !== null) {
            $daysLeft = max(1, (int) $today->diff(new DateTimeImmutable((string) $r['end_date']))->format('%r%a') + 1);
        }
        $weights[$i] = max(1, $remaining) / $daysLeft;
    }

    $roll = mt_rand() / mt_getrandmax() * array_sum($weights);
    foreach ($weights as $i => $w) {
        $roll -= $w;
        if ($roll <= 0) {
            return $pool[$i];
        }
    }

    return $pool[array_key_last($pool)];
}

/** Публічні дані креативу для промальовування (JSON для sponsored.js). */
function promo_public_payload(array $creative, string $placement): array
{
    $isUpload = $creative['video_type'] === 'upload';

    return [
        'id'          => (int) $creative['id'],
        'token'       => promo_token_make(['c' => (int) $creative['id'], 'k' => (int) $creative['campaign_id'], 'p' => $placement]),
        'placement'   => $placement,
        'title'       => (string) $creative['title'],
        'description' => (string) $creative['description'],
        'cta'         => t('promo_cta_' . (in_array($creative['cta_key'], PROMO_CTA_KEYS, true) ? $creative['cta_key'] : 'learn_more')),
        'type'        => $isUpload ? 'upload' : 'youtube',
        'video'       => $isUpload && $creative['video_path'] ? '/' . ltrim((string) $creative['video_path'], '/') : null,
        'youtube'     => !$isUpload ? (string) $creative['youtube_id'] : null,
        'poster'      => $creative['poster_path'] ? '/' . ltrim((string) $creative['poster_path'], '/') : null,
    ];
}

/** Написи картки мовою інтерфейсу. */
function promo_labels(): array
{
    $reasons = [];
    foreach (PROMO_REPORT_REASONS as $r) {
        $reasons[$r] = t('promo_reason_' . $r);
    }

    return [
        'label'        => t('promo_label'),
        'soundOn'      => t('promo_sound_on'),
        'soundOff'     => t('promo_sound_off'),
        'play'         => t('promo_play'),
        'report'       => t('promo_report'),
        'reportSend'   => t('promo_report_send'),
        'reportCancel' => t('promo_report_cancel'),
        'reportThanks' => t('promo_report_thanks'),
        'reasons'      => $reasons,
    ];
}

// --- Облік подій і списання ------------------------------------------------

/**
 * Записати подію (impression / view / click) з перевірками на дублі та частоту,
 * оновити ad_stats_daily і списати кошти. true — подію зараховано.
 *
 * Правила: impression — не частіше раза на 10 с для пари сеанс+креатив
 * (JS шле одну на завантаження сторінки); view — лише для upload-відео і лише
 * після зарахованого показу цьому сеансу; click — повтор того ж сеансу протягом
 * PROMO_CLICK_DEDUP_SEC не рахується. Понад PROMO_EVENTS_PER_MINUTE подій
 * сеансу за хвилину — ігнор.
 */
function promo_record_event(PDO $pdo, int $creativeId, string $type, string $placement, string $sessionHash): bool
{
    if (!in_array($type, ['impression', 'view', 'click'], true) || !in_array($placement, PROMO_PLACEMENTS, true)) {
        return false;
    }

    $cr = $pdo->prepare('SELECT cr.id, cr.campaign_id, cr.video_type FROM ad_creatives cr WHERE cr.id = :id');
    $cr->execute([':id' => $creativeId]);
    $creative = $cr->fetch();
    if ($creative === false || ($type === 'view' && $creative['video_type'] !== 'upload')) {
        return false;
    }
    $campaignId = (int) $creative['campaign_id'];

    $rate = $pdo->prepare('SELECT COUNT(*) FROM ad_events WHERE session_hash = :sh AND created_at >= NOW() - INTERVAL 1 MINUTE');
    $rate->execute([':sh' => $sessionHash]);
    if ((int) $rate->fetchColumn() >= PROMO_EVENTS_PER_MINUTE) {
        return false;
    }

    $window = match ($type) {
        'impression' => 10,
        'view' => 10,
        'click' => PROMO_CLICK_DEDUP_SEC,
    };
    $dup = $pdo->prepare(
        'SELECT COUNT(*) FROM ad_events
         WHERE session_hash = :sh AND creative_id = :cr AND type = :type
           AND created_at >= NOW() - INTERVAL ' . $window . ' SECOND'
    );
    $dup->execute([':sh' => $sessionHash, ':cr' => $creativeId, ':type' => $type]);
    if ((int) $dup->fetchColumn() > 0) {
        return false;
    }

    if ($type === 'view') {
        $seen = $pdo->prepare(
            "SELECT COUNT(*) FROM ad_events
             WHERE session_hash = :sh AND creative_id = :cr AND type = 'impression'
               AND created_at >= NOW() - INTERVAL " . PROMO_TOKEN_TTL . ' SECOND'
        );
        $seen->execute([':sh' => $sessionHash, ':cr' => $creativeId]);
        if ((int) $seen->fetchColumn() === 0) {
            return false;
        }
    }

    $pdo->prepare(
        'INSERT INTO ad_events (creative_id, campaign_id, type, placement, session_hash)
         VALUES (:cr, :c, :type, :pl, :sh)'
    )->execute([':cr' => $creativeId, ':c' => $campaignId, ':type' => $type, ':pl' => $placement, ':sh' => $sessionHash]);

    $charged = promo_charge($pdo, $campaignId, $type);

    $col = ['impression' => 'impressions', 'view' => 'views', 'click' => 'clicks'][$type];
    $pdo->prepare(
        "INSERT INTO ad_stats_daily (stat_date, campaign_id, creative_id, placement, {$col}, spend)
         VALUES (CURDATE(), :c, :cr, :pl, 1, :sp)
         ON DUPLICATE KEY UPDATE {$col} = {$col} + 1, spend = spend + VALUES(spend)"
    )->execute([':c' => $campaignId, ':cr' => $creativeId, ':pl' => $placement, ':sp' => $charged]);

    return true;
}

/**
 * Атомарне списання за подію. Повертає списану суму (копійки).
 *
 * Транзакція з SELECT ... FOR UPDATE на рядку кампанії, потім балансу (завжди
 * в цьому порядку — без дедлоків): паралельні запити по одній кампанії
 * виконуються строго по черзі, тож бюджет і баланс не перевитрачаються.
 * Сума обрізається до найменшого із залишків (загальний бюджет, денний,
 * баланс). Вичерпано загальний бюджет → completed; баланс → paused
 * (stop_reason показується рекламодавцю). Денний ліміт лише виключає
 * кампанію з показу до кінця дня (promo_pick).
 *
 * Журнал: один агрегований рядок ad_transactions (type=spend) на кампанію на
 * день, reference = spend:<id>:<дата>; amount — від'ємна сума за день.
 */
function promo_charge(PDO $pdo, int $campaignId, string $type): int
{
    $ownTx = !$pdo->inTransaction();
    if ($ownTx) {
        $pdo->beginTransaction();
    }
    try {
        $st = $pdo->prepare('SELECT * FROM ad_campaigns WHERE id = :id FOR UPDATE');
        $st->execute([':id' => $campaignId]);
        $c = $st->fetch();

        $billable = $c !== false
            && $c['format'] === 'video'
            && $c['campaign_type'] !== 'internal'
            && $c['status'] === 'active'
            && $c['user_id'] !== null
            && (int) $c['unit_price'] > 0;
        $isCpm = $billable && $c['pricing_model'] === 'cpm' && $type === 'impression';
        $isCpc = $billable && $c['pricing_model'] === 'cpc' && $type === 'click';
        if (!$isCpm && !$isCpc) {
            if ($ownTx) {
                $pdo->commit();
            }

            return 0;
        }

        $accrual = (int) $c['cpm_accrual'];
        if ($isCpm) {
            $acc = $accrual + (int) $c['unit_price'];
            $amount = intdiv($acc, 1000);
            $accrual = $acc % 1000;
        } else {
            $amount = (int) $c['unit_price'];
        }

        $bal = $pdo->prepare('SELECT balance FROM ad_balances WHERE user_id = :u FOR UPDATE');
        $bal->execute([':u' => $c['user_id']]);
        $balance = (int) ($bal->fetchColumn() ?: 0);

        $today = date('Y-m-d');
        $spentToday = $c['spent_today_date'] === $today ? (int) $c['spent_today'] : 0;
        $limits = [$amount, max(0, $balance)];
        if ($c['total_budget'] !== null) {
            $limits[] = max(0, (int) $c['total_budget'] - (int) $c['spent']);
        }
        if ($c['daily_budget'] !== null) {
            $limits[] = max(0, (int) $c['daily_budget'] - $spentToday);
        }
        $amount = min($limits);

        $newSpent = (int) $c['spent'] + $amount;
        $newBalance = $balance - $amount;
        $status = 'active';
        $stopReason = null;
        if ($c['total_budget'] !== null && $newSpent >= (int) $c['total_budget']) {
            $status = 'completed';
            $stopReason = 'budget';
        } elseif ($newBalance <= 0) {
            $status = 'paused';
            $stopReason = 'balance';
        }

        $pdo->prepare(
            'UPDATE ad_campaigns
             SET spent = :spent, spent_today = :today_spent, spent_today_date = :today,
                 cpm_accrual = :acc, status = :status, stop_reason = COALESCE(:reason, stop_reason)
             WHERE id = :id'
        )->execute([
            ':spent' => $newSpent,
            ':today_spent' => $spentToday + $amount,
            ':today' => $today,
            ':acc' => $accrual,
            ':status' => $status,
            ':reason' => $stopReason,
            ':id' => $campaignId,
        ]);

        if ($amount > 0) {
            $pdo->prepare('UPDATE ad_balances SET balance = balance - :a WHERE user_id = :u')
                ->execute([':a' => $amount, ':u' => $c['user_id']]);

            $ref = 'spend:' . $campaignId . ':' . $today;
            $upd = $pdo->prepare(
                "UPDATE ad_transactions SET amount = amount - :a
                 WHERE user_id = :u AND type = 'spend' AND reference = :ref"
            );
            $upd->execute([':a' => $amount, ':u' => $c['user_id'], ':ref' => $ref]);
            if ($upd->rowCount() === 0) {
                $pdo->prepare(
                    "INSERT INTO ad_transactions (user_id, campaign_id, type, amount, currency, status, method, reference, note, confirmed_at)
                     VALUES (:u, :c, 'spend', :a, :cur, 'confirmed', 'manual', :ref, :note, NOW())"
                )->execute([
                    ':u' => $c['user_id'],
                    ':c' => $campaignId,
                    ':a' => -$amount,
                    ':cur' => $c['currency'],
                    ':ref' => $ref,
                    ':note' => 'Витрати кампанії за ' . $today,
                ]);
            }
        }

        if ($ownTx) {
            $pdo->commit();
        }

        return $amount;
    } catch (Throwable $e) {
        if ($ownTx && $pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('[promo] charge: ' . $e->getMessage());

        return 0;
    }
}

// --- Обслуговування --------------------------------------------------------

/**
 * Cron: завершити кампанії з минулою датою завершення й видалити сирі події,
 * старші за PROMO_EVENTS_KEEP_DAYS (агрегати в ad_stats_daily оновлюються в
 * момент події, тож нічого не втрачається).
 *
 * @return array{completed:int,purged:int}
 */
function promo_maintenance(PDO $pdo): array
{
    $completed = $pdo->exec(
        "UPDATE ad_campaigns SET status = 'completed', stop_reason = 'end_date'
         WHERE format = 'video' AND status IN ('active', 'paused') AND end_date IS NOT NULL AND end_date < CURDATE()"
    );
    $purged = $pdo->exec('DELETE FROM ad_events WHERE created_at < NOW() - INTERVAL ' . PROMO_EVENTS_KEEP_DAYS . ' DAY');

    return ['completed' => (int) $completed, 'purged' => (int) $purged];
}

// --- Розмітка слота --------------------------------------------------------

/**
 * Порожній слот, який sponsored.js заповнює креативом із promo-serve.php.
 * Слот прихований (display:none) доки немає реклами — порожнього місця не лишається.
 * Нічого не виводить, якщо система вимкнена.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 */
function promo_slot(PDO $pdo, string $placement, array $categoryIds = [], array $subcategoryIds = []): string
{
    static $assetsPrinted = false;
    if (!in_array($placement, PROMO_PLACEMENTS, true) || !promo_video_ready($pdo)) {
        return '';
    }

    $html = '<div class="sponsored-slot sponsored-slot--' . $placement . '" hidden'
        . ' data-placement="' . $placement . '"'
        . ' data-category="' . htmlspecialchars(implode(',', array_map('intval', $categoryIds)), ENT_QUOTES) . '"'
        . ' data-subcategory="' . htmlspecialchars(implode(',', array_map('intval', $subcategoryIds)), ENT_QUOTES) . '"'
        . ' data-lang="' . promo_lang() . '"></div>';

    if (!$assetsPrinted) {
        $assetsPrinted = true;
        $ver = static fn(string $f): string => (string) (@filemtime(__DIR__ . '/../public/assets/' . $f) ?: 1);
        $html .= '<link rel="stylesheet" href="/assets/css/sponsored.css?v=' . $ver('css/sponsored.css') . '">'
            . '<script src="/assets/js/sponsored.js?v=' . $ver('js/sponsored.js') . '" defer></script>';
    }

    return $html;
}

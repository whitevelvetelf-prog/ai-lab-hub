<?php

declare(strict_types=1);

/**
 * AI LAB HUB — механізми, які обіцяють Правила Marketplace (docs/marketplace_rules_uk.md, редакція MP_RULES_VERSION).
 *
 *  - статуси модерації (розділ 7): pending | published | needs_changes | rejected | hidden | removed | expired | archived;
 *    рішення з кодом пункту Правил (reject_code) і причиною (reject_reason), дата рішення — status_changed_at;
 *  - повідомлення автору (mp_notifications + лист через чергу mail_queue) — гачок mpl_on_log() у mp_log();
 *  - скарги (розділи 10–11): mp_complaints, від зареєстрованих або гостей з email, поля правовласника, заперечення автора;
 *  - оскарження (п. 7.5): mp_appeals;
 *  - попередження й обмеження (п. 7.3–7.4, 10.5): users.warnings_count / posting_banned_until / blocked_at, журнал mp_user_sanctions;
 *  - водяний знак на фото (п. 9.3), нагадування про закінчення строку (п. 7.6).
 *
 * Між користувачами жодних платежів через сайт немає й тут не з'являється (п. 1.4, 11.2).
 * Таблиці — database/marketplace_legal_migration.sql. Поки міграцію не застосовано, усе тут «м'яко» вимикається
 * (try/catch), щоб наявні сторінки не ламалися.
 *
 * Підключається з app/marketplace-board.php (тож доступна скрізь, де є дошка оголошень).
 */

require_once __DIR__ . '/marketplace.php';
require_once __DIR__ . '/mp-legal-i18n.php';

const MPL_COMPLAINT_REASONS = ['fraud', 'prohibited', 'copyright', 'wrong_category', 'misleading', 'other'];
const MPL_COMPLAINT_STATUSES = ['new', 'in_review', 'resolved_removed', 'resolved_kept'];
const MPL_USAGE_TERMS = ['personal', 'commercial', 'no_changes', 'other'];
/** Пункти Правил для причини рішення модерації (розділ 5 + узагальнені 4, 6, 10). */
const MPL_RULE_POINTS = ['5.1.1', '5.1.2', '5.1.3', '5.1.4', '5.1.5', '5.1.6', '5.1.7', '5.1.8', '5.1.9', '5.1.10', '5.1.11', '5.1.12', '5.1.13', '5.2', '4', '6', '10'];
/** Рішення, які автор може оскаржити (п. 7.5). */
const MPL_APPEALABLE = ['rejected', 'removed', 'hidden'];
const MPL_COMPLAINTS_PER_DAY = 10;                 // з одного акаунта чи IP за добу
const MPL_EVIDENCE_MAX_BYTES = 5 * 1024 * 1024;
const MPL_WM_SIDE = 1200;                          // довша сторона показаної копії фото, px
const MPL_BAN_FOREVER = '9999-12-31 23:59:59';
const MPL_EXPIRY_NOTICE_DAYS = 7;

// =========================================================================
// Загальне
// =========================================================================

/** Оголошення, на які поширюються Правила: користувачів (post_form='ad') і компаній (вакансії/курси/послуги). */
function mpl_target_sql(string $a = 'l'): string
{
    return "($a.post_form = 'ad' OR ($a.post_form = '' AND $a.section IN ('job', 'course', 'service')))";
}

function mpl_status_label(string $status): string
{
    return isset(MPL_I18N['st_' . $status]) ? mpl_tr('st_' . $status) : $status;
}

function mpl_rule_label(?string $code): string
{
    return $code !== null && isset(MPL_I18N['pt_' . $code]) ? mpl_tr('pt_' . $code) : '';
}

/** Текст причини рішення для показу: «пункт — пояснення». */
function mpl_reason_text(?string $code, ?string $reason, ?string $lang = null): string
{
    $lang ??= mpl_lang();
    $pt = $code !== null && isset(MPL_I18N['pt_' . $code]) ? mpl_tr_lang('pt_' . $code, $lang) : '';
    $reason = trim((string) $reason);

    return trim($pt . ($pt !== '' && $reason !== '' ? '. ' : '') . $reason);
}

/** Посилання на оголошення (відносне). */
function mpl_listing_url(array $row): string
{
    if ((string) ($row['post_form'] ?? '') === 'ad') {
        return 'marketplace-offer.php?id=' . (int) $row['id'];
    }
    $slug = (string) ($row['slug'] ?? '');

    return 'listing.php?id=' . (int) $row['id'] . ($slug !== '' ? '&s=' . rawurlencode($slug) : '');
}

/** Коротко про оголошення + власник. null — немає або це не оголошення, на яке поширюються Правила. */
function mpl_listing_brief(PDO $pdo, int $id): ?array
{
    $st = $pdo->prepare(
        "SELECT l.id, l.status, l.section, l.post_form, l.slug, l.source_lang, l.expires_at, l.published_at, l.moderated_at,
                l.reject_reason, l.reject_code, l.status_changed_at, l.updated_at, s.user_id AS owner_id, u.email AS owner_email,
                u.name AS owner_name, COALESCE(t.title, (SELECT t2.title FROM mp_listing_translations t2 WHERE t2.listing_id = l.id LIMIT 1)) AS title
         FROM mp_listings l
         LEFT JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN users u ON u.id = s.user_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE l.id = :id AND " . mpl_target_sql()
    );
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/** Хеш IP поточного запиту (IP у відкритому вигляді не зберігається). */
function mpl_ip_hash(): string
{
    return function_exists('mpb_ip_key') && function_exists('mpb_client_ip')
        ? mpb_ip_key(mpb_client_ip())
        : hash('sha256', (string) ($_SERVER['REMOTE_ADDR'] ?? ''));
}

/** Дата + N робочих днів (без субот і неділь). Повертає 'Y-m-d H:i:s'. */
function mpl_add_business_days(string $from, int $days): string
{
    $t = strtotime($from) ?: time();
    while ($days > 0) {
        $t += 86400;
        if ((int) date('N', $t) < 6) {
            $days--;
        }
    }

    return date('Y-m-d H:i:s', $t);
}

function mpl_date(?string $value): string
{
    $t = $value !== null && $value !== '' ? strtotime($value) : false;

    return $t === false ? '' : date(mpl_lang() === 'uk' ? 'd.m.Y' : 'Y-m-d', $t);
}

function mpl_site_url(): string
{
    $u = function_exists('mpv_site_url') ? mpv_site_url() : null;
    if ($u === null || $u === '') {
        require_once __DIR__ . '/mailer.php';
        $u = mail_site_url();
    }

    return rtrim((string) $u, '/');
}

// =========================================================================
// Статуси й рішення модерації (розділ 7)
// =========================================================================

/**
 * Змінює статус оголошення (лише з дозволених $from), пише код/причину рішення й журнал.
 * 'published' — при відновленні: published_at зберігається, строк — щонайменше MP_LISTING_LIFETIME_DAYS від зараз.
 */
function mpl_set_status(PDO $pdo, int $id, string $to, int $actorId, array $from, ?string $code = null, ?string $reason = null, string $logAction = ''): bool
{
    if ($from === []) {
        return false;
    }
    $code = $code !== null && in_array($code, MPL_RULE_POINTS, true) ? $code : null;
    $reason = $reason !== null ? mb_substr(trim($reason), 0, 500) : null;
    $ttl = max(1, (int) MP_LISTING_LIFETIME_DAYS);
    $in = [];
    $params = [':to' => $to, ':a' => $actorId, ':c' => $code, ':r' => $reason !== '' ? $reason : null, ':id' => $id];
    foreach (array_values($from) as $i => $f) {
        $in[] = ':f' . $i;
        $params[':f' . $i] = (string) $f;
    }
    $extra = $to === 'published'
        ? ", published_at = COALESCE(published_at, NOW()),
             expires_at = IF(expires_at IS NULL OR expires_at < NOW() + INTERVAL 1 DAY, NOW() + INTERVAL $ttl DAY, expires_at),
             reject_code = NULL, reject_reason = NULL"
        : ', reject_code = :c, reject_reason = :r';
    if ($to === 'published') {
        unset($params[':c'], $params[':r']);
    }
    $stmt = $pdo->prepare(
        "UPDATE mp_listings SET status = :to, status_changed_at = NOW(), moderated_by = :a, moderated_at = NOW() $extra
         WHERE id = :id AND status IN (" . implode(', ', $in) . ') AND ' . str_replace('l.', '', mpl_target_sql())
    );
    $stmt->execute($params);
    if ($stmt->rowCount() === 0) {
        return false;
    }
    if (function_exists('mpt_cache_reset')) {
        mpt_cache_reset();
    }
    mp_log($pdo, $id, $actorId, $logAction !== '' ? $logAction : $to, mpl_reason_text($code, $reason, 'uk') ?: null);

    return true;
}

/** Перенесення в іншу категорію (п. 4.2, 7.3): замінює набір категорій; блок дерева — за батьком нової категорії. */
function mpl_move_category(PDO $pdo, int $id, int $categoryId, int $actorId): bool
{
    $cat = $pdo->prepare('SELECT c.id, c.section, c.parent_id, p.section AS parent_section FROM mp_categories c LEFT JOIN mp_categories p ON p.id = c.parent_id WHERE c.id = :c');
    $cat->execute([':c' => $categoryId]);
    $c = $cat->fetch(PDO::FETCH_ASSOC);
    $brief = mpl_listing_brief($pdo, $id);
    if ($c === false || $brief === null) {
        return false;
    }
    $section = (string) ($c['parent_section'] ?? '') !== '' ? (string) $c['parent_section'] : (string) $c['section'];
    try {
        $pdo->beginTransaction();
        $pdo->prepare('DELETE FROM mp_listing_categories WHERE listing_id = :id')->execute([':id' => $id]);
        $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:id, :c)')->execute([':id' => $id, ':c' => $categoryId]);
        // Блок змінюємо лише в оголошень користувачів: у вакансій/курсів/послуг блок = тип оголошення.
        if ((string) $brief['post_form'] === 'ad' && $section !== '' && (!defined('MPT_SECTIONS') || in_array($section, MPT_SECTIONS, true))) {
            $pdo->prepare("UPDATE mp_listings SET section = :s WHERE id = :id AND post_form = 'ad'")->execute([':s' => $section, ':id' => $id]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('[mp-legal] move category: ' . $e->getMessage());

        return false;
    }
    if (function_exists('mpt_cache_reset')) {
        mpt_cache_reset();
    }
    $name = $pdo->prepare("SELECT COALESCE(ct.name, c.slug) FROM mp_categories c LEFT JOIN mp_category_translations ct ON ct.category_id = c.id AND ct.lang = 'uk' WHERE c.id = :c");
    $name->execute([':c' => $categoryId]);
    mp_log($pdo, $id, $actorId, 'moved', (string) $name->fetchColumn());

    return true;
}

/** Дата останнього рішення (для строку оскарження). */
function mpl_decision_at(array $row): string
{
    return (string) ($row['status_changed_at'] ?? '') !== '' ? (string) $row['status_changed_at']
        : ((string) ($row['moderated_at'] ?? '') !== '' ? (string) $row['moderated_at'] : (string) ($row['updated_at'] ?? date('Y-m-d H:i:s')));
}

// =========================================================================
// Повідомлення автору (крок 12)
// =========================================================================

/** Подія журналу модерації → повідомлення. Карта: дія mp_log() → ключ n_*. */
const MPL_LOG_EVENTS = [
    'approved' => 'approved', 'restored' => 'approved', 'rejected' => 'rejected', 'needs_changes' => 'needs_changes',
    'moved' => 'moved', 'hidden' => 'hidden', 'auto_hidden' => 'hidden', 'removed' => 'removed',
    'appeal_restored' => 'appeal_restored', 'appeal_upheld' => 'appeal_upheld',
];

/**
 * Гачок у mp_log(): оновлює дату рішення і створює повідомлення автору. Ніколи не кидає винятків.
 * Цифрові матеріали (section='asset') і рішення платформи сюди не потрапляють (mpl_listing_brief → null).
 */
function mpl_on_log(PDO $pdo, int $listingId, ?int $actorId, string $action, ?string $note): void
{
    try {
        if (in_array($action, ['approved', 'rejected', 'archived', 'expired', 'auto_pending', 'auto_hidden', 'restored'], true)) {
            $pdo->prepare('UPDATE mp_listings SET status_changed_at = NOW() WHERE id = :id')->execute([':id' => $listingId]);
        }
        $event = MPL_LOG_EVENTS[$action] ?? null;
        $brief = null;
        if ($event === null && $action === 'archived') {
            // Знято адміністрацією (lst_remove) — повідомляємо; видалено самим автором — ні.
            $brief = mpl_listing_brief($pdo, $listingId);
            if ($brief !== null && $actorId !== null && (int) $brief['owner_id'] !== $actorId) {
                $event = 'removed';
            }
        }
        if ($event === null) {
            return;
        }
        $brief ??= mpl_listing_brief($pdo, $listingId);
        if ($brief === null || $brief['owner_id'] === null || ($actorId !== null && (int) $brief['owner_id'] === $actorId)) {
            return;   // власник сам змінив своє оголошення (або staff — своє) — повідомляти нема кого
        }
        // Вакансії/курси/послуги вже мають листи про схвалення/відхилення (lst_mail) — тут лише кабінет.
        $email = !((string) $brief['post_form'] === '' && in_array($event, ['approved', 'rejected', 'removed'], true));
        mpl_notify($pdo, (int) $brief['owner_id'], $brief, $event, ['reason' => (string) $note], $email);
    } catch (Throwable $e) {
        error_log('[mp-legal] on_log: ' . $e->getMessage());
    }
}

/**
 * Повідомлення автору: запис у mp_notifications (кабінет) + лист (черга mail_queue, cron promo-mail) мовою оголошення.
 * $listing — рядок mpl_listing_brief() або null. Повертає true, якщо запис у кабінеті створено.
 */
function mpl_notify(PDO $pdo, int $userId, ?array $listing, string $event, array $vars = [], bool $email = true): bool
{
    $vars += ['title' => (string) ($listing['title'] ?? ''), 'reason' => '', 'until' => ''];
    try {
        $pdo->prepare('INSERT INTO mp_notifications (user_id, listing_id, event, params) VALUES (:u, :l, :e, :p)')
            ->execute([':u' => $userId, ':l' => $listing !== null ? (int) $listing['id'] : null, ':e' => $event, ':p' => json_encode($vars, JSON_UNESCAPED_UNICODE)]);
        $nid = (int) $pdo->lastInsertId();
    } catch (Throwable $e) {
        error_log('[mp-legal] notify: ' . $e->getMessage());

        return false;
    }
    if (!$email) {
        return true;
    }
    try {
        $u = $pdo->prepare('SELECT email, name FROM users WHERE id = :u');
        $u->execute([':u' => $userId]);
        $user = $u->fetch(PDO::FETCH_ASSOC);
        if ($user === false || filter_var((string) $user['email'], FILTER_VALIDATE_EMAIL) === false) {
            return true;
        }
        require_once __DIR__ . '/promo-mail.php';
        $lang = (string) ($listing['source_lang'] ?? 'uk') === 'en' ? 'en' : 'uk';
        $site = mpl_site_url();
        $mailVars = $vars + ['cabinet' => $site . '/marketplace-my.php', 'rules' => $site . '/marketplace-rules.php', 'abuse' => MP_ABUSE_EMAIL];
        if ($listing === null) {
            $mailVars['title'] = mpl_tr_lang('rules_title', $lang);
        }
        $subject = mpl_tr_lang('mail_subject', $lang, $mailVars);
        $text = mpl_tr_lang('n_' . $event, $lang, $mailVars) . "\n\n" . mpl_tr_lang('mail_footer', $lang, $mailVars);
        $html = '<div style="font-family:Arial,sans-serif;font-size:15px;line-height:1.55;color:#1d2433">'
            . nl2br(preg_replace('~(https?://[^\s<]+)~', '<a href="$1" style="color:#2116ad">$1</a>', htmlspecialchars($text, ENT_QUOTES)) ?? '') . '</div>';
        if (promo_mail_enqueue($pdo, (string) $user['email'], (string) $user['name'], $subject, $text, $html, $lang)) {
            $pdo->prepare('UPDATE mp_notifications SET emailed_at = NOW() WHERE id = :id')->execute([':id' => $nid]);
        }
    } catch (Throwable $e) {
        error_log('[mp-legal] notify mail: ' . $e->getMessage());
    }

    return true;
}

/** Останні повідомлення користувача з текстом мовою інтерфейсу. @return list<array{id:int,text:string,created_at:string,read:bool,listing_id:?int}> */
function mpl_notifications(PDO $pdo, int $userId, int $limit = 20): array
{
    try {
        $st = $pdo->prepare('SELECT id, listing_id, event, params, created_at, read_at FROM mp_notifications WHERE user_id = :u ORDER BY id DESC LIMIT ' . max(1, min(100, $limit)));
        $st->execute([':u' => $userId]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        return [];
    }
    $out = [];
    foreach ($rows as $r) {
        $vars = json_decode((string) $r['params'], true);
        $out[] = [
            'id' => (int) $r['id'], 'listing_id' => $r['listing_id'] !== null ? (int) $r['listing_id'] : null,
            'text' => mpl_tr_lang('n_' . $r['event'], mpl_lang(), is_array($vars) ? $vars : []),
            'created_at' => (string) $r['created_at'], 'read' => $r['read_at'] !== null,
        ];
    }

    return $out;
}

function mpl_notifications_mark_read(PDO $pdo, int $userId): void
{
    try {
        $pdo->prepare('UPDATE mp_notifications SET read_at = NOW() WHERE user_id = :u AND read_at IS NULL')->execute([':u' => $userId]);
    } catch (Throwable) {
    }
}

/**
 * Нагадування «строк закінчується за 7 днів» для оголошень користувачів (вакансії/курси/послуги — lst_daily()).
 * Одне на строк: expiry_notified_at скидається при продовженні (mpb_extend). Повертає кількість.
 */
function mpl_expiry_notices(PDO $pdo): int
{
    try {
        $ids = $pdo->query(
            "SELECT id FROM mp_listings WHERE post_form = 'ad' AND status = 'published' AND expiry_notified_at IS NULL
               AND expires_at > NOW() AND expires_at <= NOW() + INTERVAL " . MPL_EXPIRY_NOTICE_DAYS . ' DAY LIMIT 200'
        )->fetchAll(PDO::FETCH_COLUMN);
    } catch (Throwable $e) {
        error_log('[mp-legal] expiry notices: ' . $e->getMessage());

        return 0;
    }
    $n = 0;
    $mark = $pdo->prepare('UPDATE mp_listings SET expiry_notified_at = NOW() WHERE id = :id AND expiry_notified_at IS NULL');
    foreach ($ids as $id) {
        $mark->execute([':id' => (int) $id]);
        if ($mark->rowCount() === 0) {
            continue;   // паралельний запуск уже повідомив
        }
        $b = mpl_listing_brief($pdo, (int) $id);
        if ($b !== null && $b['owner_id'] !== null) {
            $lang = (string) $b['source_lang'] === 'en' ? 'en' : 'uk';
            $t = strtotime((string) $b['expires_at']) ?: time();
            mpl_notify($pdo, (int) $b['owner_id'], $b, 'expiring', ['until' => date($lang === 'uk' ? 'd.m.Y' : 'Y-m-d', $t)]);
            $n++;
        }
    }

    return $n;
}

// =========================================================================
// Оскарження (п. 7.5)
// =========================================================================

/** Останнє оскарження рішення (після дати рішення) або null. */
function mpl_last_appeal(PDO $pdo, array $row): ?array
{
    try {
        $st = $pdo->prepare('SELECT * FROM mp_appeals WHERE listing_id = :l AND created_at >= :d ORDER BY id DESC LIMIT 1');
        $st->execute([':l' => (int) $row['id'], ':d' => mpl_decision_at($row)]);
        $a = $st->fetch(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        return null;
    }

    return $a === false ? null : $a;
}

/** Кінцевий строк оскарження рішення ('Y-m-d H:i:s'). */
function mpl_appeal_deadline(array $row): string
{
    return date('Y-m-d H:i:s', (strtotime(mpl_decision_at($row)) ?: time()) + (int) MP_APPEAL_WINDOW_DAYS * 86400);
}

/** Чи можна зараз оскаржити рішення з кабінету. */
function mpl_can_appeal(PDO $pdo, array $row): bool
{
    return in_array((string) $row['status'], MPL_APPEALABLE, true)
        && strtotime(mpl_appeal_deadline($row)) >= time()
        && mpl_last_appeal($pdo, $row) === null;
}

/**
 * Нове оскарження. $source 'cabinet' — автор (перевіряються власник і строк); 'email' — вносить admin за листом
 * (строк не перевіряється: лист міг надійти вчасно). @return string ok | err_window | err_text | notfound
 */
function mpl_appeal_create(PDO $pdo, int $listingId, int $userId, string $text, string $source = 'cabinet', ?int $createdBy = null): string
{
    $text = trim($text);
    if (mb_strlen($text) < 10 || mb_strlen($text) > 3000) {
        return 'err_text';
    }
    $b = mpl_listing_brief($pdo, $listingId);
    if ($b === null || $b['owner_id'] === null) {
        return 'notfound';
    }
    if ($source === 'cabinet') {
        if ((int) $b['owner_id'] !== $userId) {
            return 'notfound';
        }
        if (!mpl_can_appeal($pdo, $b)) {
            return 'err_window';
        }
    } else {
        $last = mpl_last_appeal($pdo, $b);
        if (!in_array((string) $b['status'], MPL_APPEALABLE, true) || ($last !== null && (string) $last['status'] === 'open')) {
            return 'err_window';
        }
    }
    $pdo->prepare('INSERT INTO mp_appeals (listing_id, user_id, decision_status, text, source, created_by) VALUES (:l, :u, :d, :t, :s, :c)')
        ->execute([':l' => $listingId, ':u' => (int) $b['owner_id'], ':d' => (string) $b['status'], ':t' => $text, ':s' => $source === 'email' ? 'email' : 'cabinet', ':c' => $createdBy]);
    mp_log($pdo, $listingId, $createdBy ?? $userId, 'appeal', $source === 'email' ? 'оскарження з листа' : 'оскарження з кабінету');

    return 'ok';
}

/** Рішення за оскарженням: відновити оголошення або залишити рішення (коментар обов'язковий для «залишити»). */
function mpl_appeal_resolve(PDO $pdo, int $appealId, bool $restore, string $comment, int $actorId): bool
{
    $st = $pdo->prepare("SELECT * FROM mp_appeals WHERE id = :id AND status = 'open'");
    $st->execute([':id' => $appealId]);
    $a = $st->fetch(PDO::FETCH_ASSOC);
    $comment = mb_substr(trim($comment), 0, 1000);
    if ($a === false || (!$restore && $comment === '')) {
        return false;
    }
    $lid = (int) $a['listing_id'];
    if ($restore) {
        if (!mpl_set_status($pdo, $lid, 'published', $actorId, MPL_APPEALABLE, null, $comment, 'appeal_restored')) {
            return false;
        }
    } else {
        mp_log($pdo, $lid, $actorId, 'appeal_upheld', $comment);
    }
    $pdo->prepare('UPDATE mp_appeals SET status = :s, admin_comment = :c, resolved_at = NOW(), resolved_by = :a WHERE id = :id')
        ->execute([':s' => $restore ? 'restored' : 'upheld', ':c' => $comment !== '' ? $comment : null, ':a' => $actorId, ':id' => $appealId]);

    return true;
}

// =========================================================================
// Скарги (розділи 10–11)
// =========================================================================

/** Тека файлів-доказів (поза webroot, поруч із фото оголошень). */
function mpl_evidence_dir(): string
{
    $dir = dirname(rtrim((string) mp_config()['photo_dir'], '/\\')) . '/evidence';
    if (!is_dir($dir) && !@mkdir($dir, 0775, true) && !is_dir($dir)) {
        throw new RuntimeException('Cannot create evidence dir');
    }

    return $dir;
}

/** Перевіряє й зберігає файл доказів. @return string|null ім'я файлу; '' — файла немає; null — файл некоректний */
function mpl_save_evidence(?array $file): ?string
{
    if ($file === null || (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return '';
    }
    if ((int) $file['error'] !== UPLOAD_ERR_OK || !is_uploaded_file((string) $file['tmp_name'])) {
        return null;
    }
    $size = (int) filesize((string) $file['tmp_name']);
    $mime = mp_real_mime((string) $file['tmp_name']);
    $ext = ['application/pdf' => 'pdf', 'image/jpeg' => 'jpg', 'image/png' => 'png'][$mime] ?? null;
    if ($ext === null || $size <= 0 || $size > MPL_EVIDENCE_MAX_BYTES) {
        return null;
    }
    $name = bin2hex(random_bytes(16)) . '.' . $ext;
    if (!move_uploaded_file((string) $file['tmp_name'], mpl_evidence_dir() . '/' . $name)) {
        return null;
    }

    return $name;
}

/** Кінцевий строк заперечення автора (п. 10.3): дата скарги + MP_COUNTER_NOTICE_DAYS робочих днів. */
function mpl_counter_deadline(string $createdAt): string
{
    return mpl_add_business_days($createdAt, (int) MP_COUNTER_NOTICE_DAYS);
}

/**
 * Подання скарги. $in — поля форми; $file — $_FILES['evidence_file'] або null; $userId — null для гостя.
 * @return array{status:string,errors:list<string>}  status: ok | invalid | limit | duplicate | own | notfound | blocked | error
 */
function mpl_complaint_submit(PDO $pdo, array $in, ?array $file, ?int $userId): array
{
    $s = static fn(string $k, int $max): string => mb_substr(trim(is_string($in[$k] ?? null) ? (string) $in[$k] : ''), 0, $max);
    $id = (int) ($in['id'] ?? 0);
    $reason = $s('reason', 30);
    $note = $s('note', 2001);
    $email = $userId === null ? $s('email', 191) : '';
    $errors = [];

    $live = $pdo->prepare(
        "SELECT l.id, s.user_id AS owner FROM mp_listings l LEFT JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.id = :id AND l.status = 'published' AND l.expires_at > NOW() AND " . mpl_target_sql()
    );
    $live->execute([':id' => $id]);
    $row = $live->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return ['status' => 'notfound', 'errors' => ['c_err_notfound']];
    }
    if ($userId !== null && $row['owner'] !== null && (int) $row['owner'] === $userId) {
        return ['status' => 'own', 'errors' => ['c_err_own']];
    }
    if ($userId !== null && mpl_is_blocked($pdo, $userId)) {
        return ['status' => 'blocked', 'errors' => ['c_err_blocked']];
    }

    if (!in_array($reason, MPL_COMPLAINT_REASONS, true)) {
        $errors[] = 'c_err_reason';
    }
    if (mb_strlen($note) > 2000 || ($reason !== 'copyright' && $note === '')) {
        $errors[] = 'c_err_note';
    }
    if ($userId === null && (mb_strlen($email) > 190 || filter_var($email, FILTER_VALIDATE_EMAIL) === false)) {
        $errors[] = 'c_err_email';
    }
    $cr = ['claimant_name' => null, 'claimant_contact' => null, 'infringed_work' => null, 'evidence_url' => null, 'good_faith' => 0];
    if ($reason === 'copyright') {
        $cr['claimant_name'] = $s('claimant_name', 200);
        $cr['claimant_contact'] = $s('claimant_contact', 300);
        $cr['infringed_work'] = $s('infringed_work', 3000);
        $cr['evidence_url'] = $s('evidence_url', 500);
        $cr['good_faith'] = ($in['good_faith'] ?? '') === '1' ? 1 : 0;
        if ($cr['claimant_name'] === '') {
            $errors[] = 'c_err_cr_name';
        }
        if ($cr['claimant_contact'] === '') {
            $errors[] = 'c_err_cr_contact';
        }
        if ($cr['infringed_work'] === '') {
            $errors[] = 'c_err_cr_work';
        }
        $hasFile = $file !== null && (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
        if ($cr['evidence_url'] !== '' && !mp_is_http_url($cr['evidence_url'])) {
            $errors[] = 'c_err_cr_evidence';
        } elseif ($cr['evidence_url'] === '' && !$hasFile) {
            $errors[] = 'c_err_cr_evidence';
        }
        if ($cr['good_faith'] !== 1) {
            $errors[] = 'c_err_cr_good_faith';
        }
    }
    if ($errors !== []) {
        return ['status' => 'invalid', 'errors' => array_values(array_unique($errors))];
    }

    // Захист від спаму скаргами: ≤ MPL_COMPLAINTS_PER_DAY на добу з акаунта і з IP (staff — без ліміту).
    $ip = mpl_ip_hash();
    $isStaff = function_exists('mp_is_staff') && mp_is_staff();
    if (!$isStaff) {
        $cnt = $pdo->prepare('SELECT COUNT(*) FROM mp_complaints WHERE ' . ($userId !== null ? '(reporter_id = :u OR ip_hash = :ip)' : 'ip_hash = :ip') . ' AND created_at > NOW() - INTERVAL 1 DAY');
        $cnt->execute($userId !== null ? [':u' => $userId, ':ip' => $ip] : [':ip' => $ip]);
        if ((int) $cnt->fetchColumn() >= MPL_COMPLAINTS_PER_DAY) {
            return ['status' => 'limit', 'errors' => ['c_err_limit']];
        }
    }
    // Одна відкрита скарга від однієї особи на оголошення.
    $dup = $pdo->prepare("SELECT 1 FROM mp_complaints WHERE listing_id = :l AND status IN ('new', 'in_review') AND " . ($userId !== null ? 'reporter_id = :who' : 'reporter_email = :who') . ' LIMIT 1');
    $dup->execute([':l' => $id, ':who' => $userId ?? mb_strtolower($email)]);
    if ($dup->fetchColumn() !== false) {
        return ['status' => 'duplicate', 'errors' => ['c_err_duplicate']];
    }

    $evidenceFile = null;
    if ($reason === 'copyright') {
        $saved = mpl_save_evidence($file);
        if ($saved === null) {
            return ['status' => 'invalid', 'errors' => ['c_err_cr_file']];
        }
        $evidenceFile = $saved !== '' ? $saved : null;
    }
    try {
        $pdo->prepare(
            'INSERT INTO mp_complaints (listing_id, reporter_id, reporter_email, reason, note, claimant_name, claimant_contact, infringed_work,
                                        evidence_url, evidence_file, good_faith, ip_hash)
             VALUES (:l, :u, :e, :r, :n, :cn, :cc, :w, :eu, :ef, :gf, :ip)'
        )->execute([
            ':l' => $id, ':u' => $userId, ':e' => $userId === null ? mb_strtolower($email) : null, ':r' => $reason, ':n' => $note !== '' ? $note : null,
            ':cn' => $cr['claimant_name'] ?: null, ':cc' => $cr['claimant_contact'] ?: null, ':w' => $cr['infringed_work'] ?: null,
            ':eu' => $cr['evidence_url'] ?: null, ':ef' => $evidenceFile, ':gf' => $cr['good_faith'], ':ip' => $ip,
        ]);
        $cid = (int) $pdo->lastInsertId();
    } catch (Throwable $e) {
        error_log('[mp-legal] complaint insert: ' . $e->getMessage());

        return ['status' => 'error', 'errors' => ['c_err_save']];
    }
    if (function_exists('mpb_ip_hit') && !$isStaff) {
        mpb_ip_hit($pdo, 'report', (int) mp_config()['ip_limit_report']);   // спільний IP-лічильник скарг
    }
    mp_log($pdo, $id, $userId, 'complaint', 'скарга №' . $cid . ' (' . $reason . ')');

    // Скарга правовласника — автор отримує повідомлення і може подати заперечення (п. 10.3). Дані заявника не передаються.
    if ($reason === 'copyright') {
        $b = mpl_listing_brief($pdo, $id);
        if ($b !== null && $b['owner_id'] !== null) {
            $lang = (string) $b['source_lang'] === 'en' ? 'en' : 'uk';
            $until = strtotime(mpl_counter_deadline(date('Y-m-d H:i:s'))) ?: time();
            mpl_notify($pdo, (int) $b['owner_id'], $b, 'copyright', ['until' => date($lang === 'uk' ? 'd.m.Y' : 'Y-m-d', $until)]);
        }
    }
    mpl_complaints_auto_hide($pdo, $id);

    return ['status' => 'ok', 'errors' => []];
}

/**
 * Автоприховування (як раніше для mp_reports): ≥ reports_threshold відкритих скарг від staff або від акаунтів
 * з давно підтвердженою поштою після останньої модерації → оголошення 'hidden' до розгляду (п. 7.3, 10.2).
 */
function mpl_complaints_auto_hide(PDO $pdo, int $listingId): void
{
    try {
        $hours = max(0, (int) mp_config()['report_min_verified_hours']);
        $cnt = $pdo->prepare(
            "SELECT COUNT(DISTINCT c.reporter_id) FROM mp_complaints c
             JOIN mp_listings l ON l.id = c.listing_id
             JOIN users u ON u.id = c.reporter_id
             WHERE l.id = :id AND c.status IN ('new', 'in_review') AND c.created_at > COALESCE(l.moderated_at, '1970-01-01 00:00:00')
               AND (u.role IN ('employee', 'admin') OR EXISTS (
                     SELECT 1 FROM mp_email_verifications v
                     WHERE v.user_id = c.reporter_id AND v.email = u.email AND v.verified_at IS NOT NULL
                       AND v.verified_at < (NOW() - INTERVAL $hours HOUR)))"
        );
        $cnt->execute([':id' => $listingId]);
        $n = (int) $cnt->fetchColumn();
        if ($n >= (int) mp_config()['reports_threshold']) {
            $upd = $pdo->prepare("UPDATE mp_listings SET status = 'hidden', status_changed_at = NOW() WHERE id = :id AND status = 'published'");
            $upd->execute([':id' => $listingId]);
            if ($upd->rowCount() > 0) {
                if (function_exists('mpt_cache_reset')) {
                    mpt_cache_reset();
                }
                mp_log($pdo, $listingId, null, 'auto_hidden', 'скарг: ' . $n . ' — приховано до розгляду');
            }
        }
    } catch (Throwable $e) {
        error_log('[mp-legal] auto hide: ' . $e->getMessage());
    }
}

/**
 * Дія адміністратора зі скаргою: in_review | hide (приховати оголошення на час розгляду → in_review)
 * | resolved_removed (оголошення знято) | resolved_kept (залишено; приховане — відновлюється).
 */
function mpl_complaint_action(PDO $pdo, int $complaintId, string $action, string $note, int $actorId): bool
{
    $st = $pdo->prepare('SELECT * FROM mp_complaints WHERE id = :id');
    $st->execute([':id' => $complaintId]);
    $c = $st->fetch(PDO::FETCH_ASSOC);
    if ($c === false) {
        return false;
    }
    $lid = (int) $c['listing_id'];
    $note = mb_substr(trim($note), 0, 1000);
    $newStatus = match ($action) {
        'in_review', 'hide' => 'in_review',
        'resolved_removed' => 'resolved_removed',
        'resolved_kept' => 'resolved_kept',
        default => null,
    };
    if ($newStatus === null) {
        return false;
    }
    $code = (string) $c['reason'] === 'copyright' ? '10' : null;
    if ($action === 'hide') {
        mpl_set_status($pdo, $lid, 'hidden', $actorId, ['published', 'pending'], $code, $note !== '' ? $note : null, 'hidden');
    } elseif ($action === 'resolved_removed') {
        mpl_set_status($pdo, $lid, 'removed', $actorId, ['published', 'pending', 'hidden', 'needs_changes', 'expired'], $code, $note !== '' ? $note : null, 'removed');
    } elseif ($action === 'resolved_kept') {
        mpl_set_status($pdo, $lid, 'published', $actorId, ['hidden'], null, $note, 'restored');
    }
    $resolved = str_starts_with($newStatus, 'resolved_');
    $pdo->prepare('UPDATE mp_complaints SET status = :s, admin_note = COALESCE(:n, admin_note), resolved_at = ' . ($resolved ? 'NOW()' : 'NULL')
        . ', resolved_by = ' . ($resolved ? ':a' : 'NULL') . ' WHERE id = :id')
        ->execute($resolved ? [':s' => $newStatus, ':n' => $note !== '' ? $note : null, ':a' => $actorId, ':id' => $complaintId]
            : [':s' => $newStatus, ':n' => $note !== '' ? $note : null, ':id' => $complaintId]);

    return true;
}

/** Відкриті скарги правовласників на оголошення користувача (для кабінету; БЕЗ даних заявника). */
function mpl_owner_copyright_complaints(PDO $pdo, int $userId): array
{
    try {
        $st = $pdo->prepare(
            "SELECT c.id, c.listing_id, c.infringed_work, c.note, c.status, c.created_at, c.counter_text, c.counter_at
             FROM mp_complaints c JOIN mp_listings l ON l.id = c.listing_id JOIN mp_sellers s ON s.id = l.seller_id
             WHERE s.user_id = :u AND c.reason = 'copyright' AND c.status IN ('new', 'in_review')
             ORDER BY c.id DESC LIMIT 50"
        );
        $st->execute([':u' => $userId]);

        return $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        return [];
    }
}

/** Заперечення автора (п. 10.3). @return string ok | err_text | closed | notfound */
function mpl_counter_submit(PDO $pdo, int $complaintId, int $userId, string $text, string $url): string
{
    $text = trim($text);
    $url = trim($url);
    $st = $pdo->prepare(
        "SELECT c.id, c.created_at, c.counter_at, c.listing_id FROM mp_complaints c JOIN mp_listings l ON l.id = c.listing_id JOIN mp_sellers s ON s.id = l.seller_id
         WHERE c.id = :id AND s.user_id = :u AND c.reason = 'copyright' AND c.status IN ('new', 'in_review')"
    );
    $st->execute([':id' => $complaintId, ':u' => $userId]);
    $c = $st->fetch(PDO::FETCH_ASSOC);
    if ($c === false) {
        return 'notfound';
    }
    if ($c['counter_at'] !== null || strtotime(mpl_counter_deadline((string) $c['created_at'])) < time()) {
        return 'closed';
    }
    if (mb_strlen($text) < 10 || mb_strlen($text) > 3000 || mb_strlen($url) > 500 || !mp_is_http_url($url)) {
        return 'err_text';
    }
    $pdo->prepare("UPDATE mp_complaints SET counter_text = :t, counter_evidence_url = :u, counter_at = NOW(), status = 'in_review' WHERE id = :id")
        ->execute([':t' => $text, ':u' => $url, ':id' => $complaintId]);
    mp_log($pdo, (int) $c['listing_id'], $userId, 'counter_notice', 'заперечення до скарги №' . $complaintId);

    return 'ok';
}

// =========================================================================
// Попередження, обмеження подачі, блокування (п. 7.3–7.4, 10.5)
// =========================================================================

/** @return array{warnings:int,banned_until:?string,blocked_at:?string} */
function mpl_user_state(PDO $pdo, int $userId): array
{
    try {
        $st = $pdo->prepare('SELECT warnings_count, posting_banned_until, blocked_at FROM users WHERE id = :u');
        $st->execute([':u' => $userId]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $r = false;   // міграцію ще не застосовано
    }

    return [
        'warnings' => $r !== false ? (int) $r['warnings_count'] : 0,
        'banned_until' => $r !== false && $r['posting_banned_until'] !== null ? (string) $r['posting_banned_until'] : null,
        'blocked_at' => $r !== false && $r['blocked_at'] !== null ? (string) $r['blocked_at'] : null,
    ];
}

function mpl_is_blocked(PDO $pdo, int $userId): bool
{
    return mpl_user_state($pdo, $userId)['blocked_at'] !== null;
}

/**
 * Чи заборонено користувачу подавати оголошення зараз. Staff — ніколи.
 * @return array{type:string,until:?string,forever:bool}|null
 */
function mpl_posting_block(PDO $pdo, int $userId): ?array
{
    if (function_exists('mp_is_staff') && mp_is_staff()) {
        return null;
    }
    $s = mpl_user_state($pdo, $userId);
    if ($s['blocked_at'] !== null) {
        return ['type' => 'blocked', 'until' => null, 'forever' => true];
    }
    if ($s['banned_until'] !== null && strtotime($s['banned_until']) > time()) {
        return ['type' => 'banned', 'until' => $s['banned_until'], 'forever' => str_starts_with($s['banned_until'], '9999')];
    }

    return null;
}

/** HTML пояснення для форми подачі (п. 7.5 — посилання на оскарження). */
function mpl_posting_block_html(array $block): string
{
    $text = $block['type'] === 'blocked' ? mpl_tr('ban_blocked')
        : ($block['forever'] ? mpl_tr('ban_forever') : mpl_tr('ban_until', mpl_date($block['until'])));
    $link = '<a href="marketplace-rules.php#section-7">' . mp_e(mpl_tr('ban_appeal_link')) . '</a>';
    $mail = '<a href="mailto:' . mp_e(MP_ABUSE_EMAIL) . '">' . mp_e(MP_ABUSE_EMAIL) . '</a>';
    $appeal = sprintf(mp_e(mpl_tr('ban_appeal')), $link, $mail);   // у шаблоні лише %s — екранування не ламає підстановку

    return '<p class="mp-text">' . mp_e($text) . '</p><p class="mp-text">' . $appeal . '</p>';
}

/** Сторінка «Подачу обмежено» (403), якщо користувачу заборонено подавати. */
function mpl_require_can_post(PDO $pdo, int $userId): void
{
    $block = mpl_posting_block($pdo, $userId);
    if ($block !== null) {
        mpb_message_page(403, mpl_tr('ban_title'), mpl_posting_block_html($block), 'marketplace.php');
    }
}

/**
 * Санкція: warn | ban (на $days днів; 0 — безстроково) | block | unblock. Пише журнал і повідомляє користувача.
 */
function mpl_sanction(PDO $pdo, int $userId, string $action, int $days, string $note, int $actorId): bool
{
    $note = mb_substr(trim($note), 0, 1000);
    switch ($action) {
        case 'warn':
            $pdo->prepare('UPDATE users SET warnings_count = warnings_count + 1 WHERE id = :u')->execute([':u' => $userId]);
            $event = 'warning';
            $vars = ['reason' => $note];
            break;
        case 'ban':
            $until = $days > 0 ? date('Y-m-d H:i:s', time() + $days * 86400) : MPL_BAN_FOREVER;
            $pdo->prepare('UPDATE users SET posting_banned_until = :d WHERE id = :u')->execute([':d' => $until, ':u' => $userId]);
            $event = 'posting_banned';
            $vars = ['reason' => $note, 'until' => $days > 0 ? date('d.m.Y', strtotime($until)) : mpl_tr_lang('forever', 'uk')];
            break;
        case 'block':
            $pdo->prepare('UPDATE users SET blocked_at = NOW(), posting_banned_until = :d WHERE id = :u')->execute([':d' => MPL_BAN_FOREVER, ':u' => $userId]);
            $event = 'blocked';
            $vars = ['reason' => $note];
            break;
        case 'unblock':
            $pdo->prepare('UPDATE users SET blocked_at = NULL, posting_banned_until = NULL WHERE id = :u')->execute([':u' => $userId]);
            $event = 'unblocked';
            $vars = [];
            break;
        default:
            return false;
    }
    $pdo->prepare('INSERT INTO mp_user_sanctions (user_id, action, days, note, actor_id) VALUES (:u, :a, :d, :n, :ac)')
        ->execute([':u' => $userId, ':a' => $action, ':d' => $action === 'ban' ? $days : null, ':n' => $note !== '' ? $note : null, ':ac' => $actorId]);
    mpl_notify($pdo, $userId, null, $event, $vars);

    return true;
}

// =========================================================================
// Водяний знак (п. 9.3)
// =========================================================================

/**
 * Показана копія фото: до MPL_WM_SIDE px по довшій стороні з напівпрозорим знаком «AI LAB HUB».
 * Генерується один раз (ліниво) у photo_dir/wm/ — оригінал лишається поза webroot і назовні не віддається.
 * Потрібен лише GD (текст — вбудованим шрифтом GD, без FreeType). Повертає шлях або null (тоді — без знака).
 */
function mpl_watermarked_path(string $srcPath, string $name): ?string
{
    if (!function_exists('imagecreatetruecolor') || preg_match('/^([a-f0-9]{32})\.(jpg|png|webp)$/', $name, $m) !== 1) {
        return null;
    }
    $dir = dirname($srcPath) . '/wm';
    $ext = $m[2] === 'png' ? 'png' : 'jpg';
    $out = $dir . '/' . $m[1] . '_w.' . $ext;
    if (is_file($out) && filemtime($out) >= filemtime($srcPath)) {
        return $out;
    }
    if (!is_dir($dir) && !@mkdir($dir, 0775, true) && !is_dir($dir)) {
        return null;
    }
    $img = match ($m[2]) {
        'png' => @imagecreatefrompng($srcPath),
        'webp' => function_exists('imagecreatefromwebp') ? @imagecreatefromwebp($srcPath) : false,
        default => @imagecreatefromjpeg($srcPath),
    };
    if (!$img instanceof \GdImage) {
        return null;
    }
    $img = function_exists('mpb_gd_fit') ? mpb_gd_fit($img, MPL_WM_SIDE) : $img;
    if ($ext === 'jpg' && function_exists('mpb_gd_flatten')) {
        $img = mpb_gd_flatten($img);
    }
    imagealphablending($img, true);
    $w = imagesx($img);
    $h = imagesy($img);

    // Напис вбудованим шрифтом на малому полотні → масштабування до ~28% ширини фото.
    $text = 'AI LAB HUB';
    $font = 5;
    $tw = imagefontwidth($font) * strlen($text) + 8;
    $th = imagefontheight($font) + 6;
    $label = imagecreatetruecolor($tw, $th);
    imagealphablending($label, false);
    imagesavealpha($label, true);
    imagefill($label, 0, 0, imagecolorallocatealpha($label, 0, 3, 44, 80));          // #00032c, напівпрозоро
    imagestring($label, $font, 4, 3, $text, imagecolorallocatealpha($label, 255, 255, 255, 30));
    $scale = max(1.0, ($w * 0.28) / $tw);
    $lw = (int) round($tw * $scale);
    $lh = (int) round($th * $scale);
    $margin = (int) max(8, round(min($w, $h) * 0.03));
    // Великий знак у центрі (ледь помітний) + чіткіший у кутку.
    imagecopyresampled($img, $label, $w - $lw - $margin, $h - $lh - $margin, 0, 0, $lw, $lh, $tw, $th);
    $cw = (int) round($w * 0.6);
    $ch = (int) round($th * $cw / $tw);
    $center = imagecreatetruecolor($tw, $th);
    imagealphablending($center, false);
    imagesavealpha($center, true);
    imagefill($center, 0, 0, imagecolorallocatealpha($center, 0, 0, 0, 127));
    imagestring($center, $font, 4, 3, $text, imagecolorallocatealpha($center, 255, 255, 255, 100));
    imagecopyresampled($img, $center, (int) (($w - $cw) / 2), (int) (($h - $ch) / 2), 0, 0, $cw, $ch, $tw, $th);

    $tmp = $out . '.' . bin2hex(random_bytes(4)) . '.tmp';
    $ok = $ext === 'png' ? imagepng($img, $tmp, 6) : imagejpeg($img, $tmp, 82);
    if (!$ok || !@rename($tmp, $out)) {
        @unlink($tmp);

        return null;
    }
    @chmod($out, 0644);

    return $out;
}

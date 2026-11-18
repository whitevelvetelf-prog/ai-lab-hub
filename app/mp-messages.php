<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: внутрішні повідомлення між користувачами (етап 2 після показу контактів, 2026-11-18).
 *
 * Таблиці — database/migration-2026-11-18-marketplace-messaging.sql (№ 22): mp_conversations, mp_messages,
 * mp_conversation_state, mp_user_blocks, mp_message_reports, mp_admin_access_log, mp_notify_prefs, mp_message_emails,
 * mp_user_flags; колонка mp_listings.contact_mode (both | messages_only | contacts_only).
 *
 * Вмикання: config 'messaging_enabled' => true І публічна частина Marketplace (mp_public_enabled()) І застосована міграція.
 * Інакше все вимкнено (msg_enabled() = false): кнопок немає, сторінки повідомлень → 404.
 *
 * Правила, які тримає цей файл:
 *  - розмова — лише з оголошення (mp_listings: оголошення користувачів post_form='ad', оголошення компаній section
 *    job|course|service, матеріали платформи section='solution'); одна на пару «оголошення + покупець»;
 *  - автор оголошення = mp_sellers.user_id; NULL (продавець-платформа) → спільна скринька: відповідають employee/admin
 *    із підписом «AI LAB HUB» (sender_id NULL, sender_label); стан прочитання платформи — mp_conversation_state.user_id = 0;
 *  - участь у розмові перевіряється на сервері в КОЖНОМУ запиті (msg_access) — захист від IDOR;
 *  - текст повідомлень — лише звичайний текст: зберігається як є, виводиться через htmlspecialchars, посилання —
 *    rel="noopener noreferrer nofollow ugc" з позначкою; НЕ перекладається, НЕ передається жодним зовнішнім сервісам,
 *    не пишеться в журнали (error_log — лише id), не потрапляє в пошук, популярні запити чи статистику;
 *  - усі запити — prepared statements; іменовані параметри не повторюються (ATTR_EMULATE_PREPARES = false).
 *  - єдині DELETE — msg_retention_cleanup() (строк зберігання) і зняття блокування користувачем (mp_user_blocks).
 */

require_once __DIR__ . '/marketplace-board.php';
require_once __DIR__ . '/marketplace-email.php';

const MSG_CONTACT_MODES = ['both', 'messages_only', 'contacts_only'];
const MSG_REPORT_REASONS = ['fraud', 'harassment', 'spam', 'prohibited', 'other'];
const MSG_PLATFORM_LABEL = 'AI LAB HUB';
const MSG_PLATFORM_UID = 0;                       // «користувач» для спільного стану прочитання скриньки платформи
const MSG_FLAG_RESTRICT = 'msg_restricted';       // адміністрація: заборона надсилати повідомлення
const MSG_FLAG_NEWCONV = 'msg_newconv_limited';   // автопрапор: тимчасово без нових розмов
const MSG_PAGE_SIZE = 50;
const MSG_THREAD_LIMIT = 200;                     // скільки останніх повідомлень показує сторінка розмови
const MSG_POLL_MAX = 50;

// =========================================================================
// Увімкнення, конфіг
// =========================================================================

function msg_cfg(string $key): mixed
{
    return mp_config()[$key] ?? null;
}

/** Чи застосовано міграцію № 22 (усі таблиці й колонка contact_mode). */
function msg_ready(PDO $pdo): bool
{
    static $ready = null;
    if ($ready === null) {
        try {
            $st = $pdo->query("SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()
                               AND TABLE_NAME IN ('mp_conversations','mp_messages','mp_conversation_state','mp_user_blocks',
                                                  'mp_message_reports','mp_admin_access_log','mp_notify_prefs','mp_message_emails','mp_user_flags')");
            $col = $pdo->query("SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
                                AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_mode'");
            $ready = (int) $st->fetchColumn() === 9 && (int) $col->fetchColumn() === 1;
            if (!$ready) {
                // Прод: information_schema інколи не бачить DATABASE() — перевіряємо прямим запитом.
                $pdo->query('SELECT 1 FROM mp_conversations LIMIT 1');
                $pdo->query('SELECT 1 FROM mp_user_flags LIMIT 1');
                $pdo->query('SELECT contact_mode FROM mp_listings LIMIT 1');
                $ready = true;
            }
        } catch (Throwable) {
            $ready = false;
        }
    }

    return $ready;
}

/** Функція повідомлень увімкнена: прапорець конфігу + публічна частина Marketplace + міграція. */
function msg_enabled(?PDO $pdo = null): bool
{
    if (msg_cfg('messaging_enabled') !== true || !mp_public_enabled()) {
        return false;
    }
    try {
        $pdo ??= translation_pdo();
    } catch (Throwable) {
        return false;
    }

    return msg_ready($pdo);
}

/** Сторінки повідомлень: приватні, без кешу, без індексації. */
function msg_private_headers(): void
{
    header('Cache-Control: no-store, private');
    header('X-Robots-Tag: noindex, nofollow');
    header('Referrer-Policy: same-origin');
}

/**
 * Початок сторінки повідомлень (як mpb_open, але завжди noindex і + mp-messages.css). Закривати mpb_close().
 * Реклами на приватних сторінках немає: файли повідомлень у PROMO_AUTH_PAGES (app/promo-quiet.php).
 */
function msg_open(string $title, string $nav = 'messages'): void
{
    msg_private_headers();
    $lang = current_lang();
    echo "<!DOCTYPE html>
<html lang=\"" . mp_e($lang) . "\">
<head>
<meta charset=\"utf-8\">
"
        . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, viewport-fit=cover\">
"
        . "<meta name=\"robots\" content=\"noindex, nofollow\">
<meta name=\"referrer\" content=\"same-origin\">
"
        . '<title>' . mp_e($title) . ' — ' . mp_e(t('title_marketplace')) . "</title>
";
    include __DIR__ . '/header.php';
    echo "
<link rel=\"stylesheet\" href=\"/assets/css/site-nav.css\">
"
        . '<link rel="stylesheet" href="' . css_asset('mp-public.css') . "\">
"
        . '<link rel="stylesheet" href="' . css_asset('mp-messages.css') . "\">
</head>
<body class=\"mp-body msg-body\">
";
    include __DIR__ . '/site-header.php';
    if ($nav !== '') {
        echo mp_section_nav($nav);
    }
}

/** Сторінка-повідомлення для розділу повідомлень і вихід. */
function msg_message_page(int $status, string $title, string $bodyHtml, ?string $back = 'mp-messages.php'): never
{
    http_response_code($status);
    msg_open($title, 'messages');
    echo '<div class="mp-page mp-page--narrow"><section class="mp-panel"><h1 class="mp-panel__title">' . mp_e($title) . '</h1>' . $bodyHtml;
    if ($back !== null) {
        echo '<p class="mp-actions"><a class="mp-btn" href="' . mp_e($back) . '">' . mp_e(t('msg_back')) . '</a></p>';
    }
    echo '</section></div>';
    mpb_close();
    exit;
}

/** Вимкнено → 404 (як решта Marketplace за вимкненого перемикача). */
function msg_require_enabled(PDO $pdo): void
{
    if (!msg_enabled($pdo)) {
        msg_private_headers();
        mp_not_found();
    }
}

// =========================================================================
// Оголошення як предмет розмови
// =========================================================================

/** Оголошення, з яких можна писати (alias l). Цифрові матеріали (asset) — без повідомлень. */
function msg_listing_scope_sql(string $a = 'l'): string
{
    return "($a.post_form = 'ad' OR ($a.post_form = '' AND $a.section IN ('job', 'course', 'service', 'solution')))";
}

/**
 * Колонка дати рішення модерації (міграція Правил Marketplace). На сервері без неї — NULL AS status_changed_at,
 * і дата закриття береться з updated_at.
 */
function msg_status_changed_col(PDO $pdo): string
{
    static $has = null;
    if ($has === null) {
        try {
            $pdo->query('SELECT status_changed_at FROM mp_listings LIMIT 0');
            $has = true;
        } catch (Throwable) {
            $has = false;
        }
    }

    return $has ? 'l.status_changed_at' : 'NULL AS status_changed_at';
}

/**
 * Оголошення для розмови: назва поточною мовою, мініатюра, автор, режим звʼязку, «живе» і дата закриття.
 * null — немає або тип оголошення без повідомлень.
 *
 * @return array{id:int,section:string,post_form:string,slug:string,status:string,title:string,thumb:?string,url:string,
 *               seller_user_id:?int,is_platform:bool,contact_mode:string,live:bool,closed_at:?string}|null
 */
function msg_listing(PDO $pdo, int $listingId, ?string $lang = null): ?array
{
    $lang ??= current_lang();
    $st = $pdo->prepare(
        "SELECT l.id, l.section, l.post_form, l.slug, l.status, l.expires_at, " . msg_status_changed_col($pdo) . ", l.updated_at, l.cover_image,
                l.contact_mode, s.user_id AS seller_user_id,
                (l.status = 'published' AND (l.expires_at IS NULL OR l.expires_at > NOW())) AS live,
                (l.status = 'published' AND l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed,
                COALESCE(NULLIF(tc.title, ''), ts.title, (SELECT t2.title FROM mp_listing_translations t2 WHERE t2.listing_id = l.id LIMIT 1)) AS title,
                (SELECT p.thumb_name FROM mp_listing_photos p WHERE p.listing_id = l.id ORDER BY p.sort_order, p.id LIMIT 1) AS thumb_name
         FROM mp_listings l
         LEFT JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
         LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
         WHERE l.id = :id AND " . msg_listing_scope_sql()
    );
    $st->execute([':lang' => $lang, ':id' => $listingId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false) {
        return null;
    }
    $live = (int) $r['live'] === 1;
    $closedAt = null;
    if (!$live) {
        $closedAt = (int) $r['elapsed'] === 1 ? (string) $r['expires_at'] : (string) ($r['status_changed_at'] ?? $r['updated_at'] ?? '');
        $closedAt = $closedAt !== '' ? $closedAt : null;
    }
    $thumb = null;
    if (!empty($r['thumb_name'])) {
        $thumb = mpb_photo_url((string) $r['thumb_name']);
    } elseif (!empty($r['cover_image'])) {
        $thumb = mp_cover_url((string) $r['cover_image']);
    }
    $mode = in_array((string) $r['contact_mode'], MSG_CONTACT_MODES, true) ? (string) $r['contact_mode'] : 'both';

    return [
        'id' => (int) $r['id'], 'section' => (string) $r['section'], 'post_form' => (string) $r['post_form'],
        'slug' => (string) ($r['slug'] ?? ''), 'status' => (string) $r['status'],
        'title' => (string) ($r['title'] ?? ('#' . (int) $r['id'])), 'thumb' => $thumb, 'url' => msg_listing_url($r),
        'seller_user_id' => $r['seller_user_id'] !== null ? (int) $r['seller_user_id'] : null,
        'is_platform' => $r['seller_user_id'] === null,
        'contact_mode' => $mode, 'live' => $live, 'closed_at' => $closedAt,
    ];
}

function msg_listing_url(array $row): string
{
    if ((string) ($row['post_form'] ?? '') === 'ad' || (string) ($row['section'] ?? '') === 'solution') {
        return 'marketplace-offer.php?id=' . (int) $row['id'];
    }
    $slug = (string) ($row['slug'] ?? '');

    return 'listing.php?id=' . (int) $row['id'] . ($slug !== '' ? '&s=' . rawurlencode($slug) : '');
}

/** Режим звʼязку оголошення (без міграції — 'both'). */
function msg_contact_mode(PDO $pdo, int $listingId): string
{
    try {
        $st = $pdo->prepare('SELECT contact_mode FROM mp_listings WHERE id = :id');
        $st->execute([':id' => $listingId]);
        $m = (string) $st->fetchColumn();
    } catch (Throwable) {
        return 'both';
    }

    return in_array($m, MSG_CONTACT_MODES, true) ? $m : 'both';
}

/** Чи показувати «Показати контакт»: при messages_only (і ввімкнених повідомленнях) — ні. */
function msg_show_contacts(PDO $pdo, int $listingId): bool
{
    return !(msg_enabled($pdo) && msg_contact_mode($pdo, $listingId) === 'messages_only');
}

/** Режим із рядка mp_listings (без колонки — 'both'). */
function msg_contact_mode_value(array $row): string
{
    $m = (string) ($row['contact_mode'] ?? 'both');

    return in_array($m, MSG_CONTACT_MODES, true) ? $m : 'both';
}

/** Збереження режиму з форми подачі (лише коли повідомлення ввімкнено й міграцію застосовано). */
function msg_save_contact_mode(PDO $pdo, int $listingId, string $mode): void
{
    if (!in_array($mode, MSG_CONTACT_MODES, true) || !msg_ready($pdo)) {
        return;
    }
    $pdo->prepare('UPDATE mp_listings SET contact_mode = :m WHERE id = :id')->execute([':m' => $mode, ':id' => $listingId]);
}

/** Режим із POST форми (невідоме → 'both'). */
function msg_mode_from_post(array $post): string
{
    $m = is_string($post['contact_mode'] ?? null) ? (string) $post['contact_mode'] : 'both';

    return in_array($m, MSG_CONTACT_MODES, true) ? $m : 'both';
}

/** Перемикач режиму для форми подачі оголошення користувача (HTML). */
function msg_contact_mode_html(string $current): string
{
    $h = '<fieldset class="mp-field mp-fieldset msg-mode"><legend class="mp-label">' . mp_e(t('msg_mode_title')) . '</legend>'
        . '<p class="mp-hint">' . mp_e(t('msg_mode_hint')) . '</p>';
    foreach (MSG_CONTACT_MODES as $m) {
        $h .= '<label class="mp-check msg-mode__opt"><input type="radio" name="contact_mode" value="' . mp_e($m) . '"'
            . ($m === $current ? ' checked' : '') . '> <span>' . mp_e(t('msg_mode_' . $m)) . '</span></label>';
    }

    return $h . '</fieldset>';
}

/** HTML кнопки «Написати автору» (див. mp_write_button_html() в app/marketplace.php). */
function msg_write_button_html(PDO $pdo, int $listingId, int $sellerId = 0): string
{
    if (!msg_enabled($pdo)) {
        return '';
    }
    $uid = auth_user_id();
    if ($sellerId > 0) {
        $target = 'mp-thread.php?seller=' . $sellerId;
    } else {
        $listing = msg_listing($pdo, $listingId);
        if ($listing === null || !$listing['live'] || $listing['contact_mode'] === 'contacts_only') {
            return '';
        }
        if ($uid !== null && ($listing['is_platform'] ? mp_is_staff() : $listing['seller_user_id'] === $uid)) {
            return '';
        }
        $target = 'mp-thread.php?listing=' . $listingId;
    }
    if ($uid === null) {
        return '<a class="mp-btn mp-btn--lg msg-write" href="' . mp_e(auth_login_url($target)) . '" rel="nofollow">' . mp_e(t('msg_login_to_write')) . '</a>';
    }

    return '<a class="mp-btn mp-btn--primary mp-btn--lg msg-write" href="' . mp_e($target) . '" rel="nofollow">' . mp_e(t('msg_write_author')) . '</a>';
}

/** Чи розмова лише для читання: закрита або оголошення закрито довше за msg_readonly_after_days. */
function msg_is_readonly(array $conv, ?array $listing): bool
{
    if ((string) $conv['status'] === 'closed' || $listing === null) {
        return true;
    }
    if ($listing['live']) {
        return false;
    }
    $closed = $listing['closed_at'] !== null ? strtotime($listing['closed_at']) : false;
    $days = max(0, (int) msg_cfg('msg_readonly_after_days'));

    return $closed === false || $closed + $days * 86400 < time();
}

// =========================================================================
// Розмови й доступ
// =========================================================================

function msg_conversation(PDO $pdo, int $convId): ?array
{
    $st = $pdo->prepare('SELECT * FROM mp_conversations WHERE id = :id');
    $st->execute([':id' => $convId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/**
 * Роль поточного користувача в розмові: buyer | seller | platform (staff у розмові з оголошенням платформи) | null.
 * Повний перегляд чужої розмови адміністрацією — ЛИШЕ через mp-message-reports.php з причиною (журнал), не тут.
 */
function msg_access(array $conv, int $userId): ?string
{
    if ((int) $conv['buyer_id'] === $userId) {
        return 'buyer';
    }
    if ($conv['seller_user_id'] !== null && (int) $conv['seller_user_id'] === $userId) {
        return 'seller';
    }
    if ($conv['seller_user_id'] === null && mp_is_staff()) {
        return 'platform';
    }

    return null;
}

/** id учасника для стану (прочитане, сховано): користувач або 0 для скриньки платформи. */
function msg_state_uid(string $role, int $userId): int
{
    return $role === 'platform' ? MSG_PLATFORM_UID : $userId;
}

/** id співрозмовника (null — платформа або видалений користувач). */
function msg_counterpart_id(array $conv, string $role): ?int
{
    if ($role === 'buyer') {
        return $conv['seller_user_id'] !== null ? (int) $conv['seller_user_id'] : null;
    }

    return (int) $conv['buyer_id'];
}

/** Імʼя для показу: «AI LAB HUB», імʼя користувача або «Видалений користувач». */
function msg_user_label(PDO $pdo, ?int $userId, bool $platform = false): string
{
    if ($platform) {
        return MSG_PLATFORM_LABEL;
    }
    if ($userId === null) {
        return t('msg_deleted_user');
    }
    static $cache = [];
    if (!array_key_exists($userId, $cache)) {
        $st = $pdo->prepare('SELECT name FROM users WHERE id = :u');
        $st->execute([':u' => $userId]);
        $n = $st->fetchColumn();
        $cache[$userId] = $n === false ? null : trim((string) $n);
    }
    $n = $cache[$userId];

    return $n === null ? t('msg_deleted_user') : ($n !== '' ? mb_substr($n, 0, 60) : t('msg_user') . ' #' . $userId);
}

/** Стан учасника (рядок mp_conversation_state або нулі). */
function msg_state(PDO $pdo, int $convId, int $stateUid): array
{
    $st = $pdo->prepare('SELECT last_read_message_id, hidden_up_to_message_id, is_muted FROM mp_conversation_state WHERE conversation_id = :c AND user_id = :u');
    $st->execute([':c' => $convId, ':u' => $stateUid]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? ['last_read_message_id' => 0, 'hidden_up_to_message_id' => 0, 'is_muted' => 0] : array_map('intval', $r);
}

function msg_state_set(PDO $pdo, int $convId, int $stateUid, string $field, int $value): void
{
    if (!in_array($field, ['last_read_message_id', 'hidden_up_to_message_id', 'is_muted'], true)) {
        return;
    }
    $sql = "INSERT INTO mp_conversation_state (conversation_id, user_id, $field) VALUES (:c, :u, :v)
            ON DUPLICATE KEY UPDATE $field = " . ($field === 'last_read_message_id' ? 'GREATEST(last_read_message_id, VALUES(last_read_message_id))' : 'VALUES(' . $field . ')');
    $pdo->prepare($sql)->execute([':c' => $convId, ':u' => $stateUid, ':v' => $value]);
}

/** Позначити прочитаним до $messageId (не зменшує). */
function msg_mark_read(PDO $pdo, int $convId, int $stateUid, int $messageId): void
{
    if ($messageId > 0) {
        msg_state_set($pdo, $convId, $stateUid, 'last_read_message_id', $messageId);
        if ($stateUid !== MSG_PLATFORM_UID) {
            unset($_SESSION['msg_unread_cache']);
        }
    }
}

// =========================================================================
// Блокування, прапори
// =========================================================================

function msg_is_blocked_by(PDO $pdo, int $recipientId, int $senderId): bool
{
    $st = $pdo->prepare('SELECT 1 FROM mp_user_blocks WHERE blocker_id = :r AND blocked_id = :s');
    $st->execute([':r' => $recipientId, ':s' => $senderId]);

    return $st->fetchColumn() !== false;
}

function msg_block(PDO $pdo, int $blockerId, int $blockedId): bool
{
    if ($blockerId === $blockedId || $blockedId <= 0) {
        return false;
    }
    $pdo->prepare('INSERT IGNORE INTO mp_user_blocks (blocker_id, blocked_id) VALUES (:a, :b)')->execute([':a' => $blockerId, ':b' => $blockedId]);

    return true;
}

/** Зняти блокування (рядок видаляється — це запис самого користувача, а не дані розмов). */
function msg_unblock(PDO $pdo, int $blockerId, int $blockedId): void
{
    $pdo->prepare('DELETE FROM mp_user_blocks WHERE blocker_id = :a AND blocked_id = :b')->execute([':a' => $blockerId, ':b' => $blockedId]);
}

/** @return list<array{user_id:int,label:string,created_at:string}> */
function msg_blocks(PDO $pdo, int $blockerId): array
{
    $st = $pdo->prepare('SELECT blocked_id, created_at FROM mp_user_blocks WHERE blocker_id = :a ORDER BY created_at DESC LIMIT 200');
    $st->execute([':a' => $blockerId]);
    $out = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $out[] = ['user_id' => (int) $r['blocked_id'], 'label' => msg_user_label($pdo, (int) $r['blocked_id']), 'created_at' => (string) $r['created_at']];
    }

    return $out;
}

/** Активний прапор користувача (не прострочений) або null. */
function msg_flag(PDO $pdo, int $userId, string $flag): ?array
{
    $st = $pdo->prepare('SELECT id, until_at, note FROM mp_user_flags WHERE user_id = :u AND flag = :f AND is_active = 1
                         AND (until_at IS NULL OR until_at > NOW()) ORDER BY id DESC LIMIT 1');
    $st->execute([':u' => $userId, ':f' => $flag]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

function msg_flag_set(PDO $pdo, int $userId, string $flag, ?int $hours, string $note, ?int $actorId): void
{
    $until = $hours !== null && $hours > 0 ? date('Y-m-d H:i:s', time() + $hours * 3600) : null;
    $pdo->prepare('INSERT INTO mp_user_flags (user_id, flag, until_at, note, created_by) VALUES (:u, :f, :t, :n, :a)')
        ->execute([':u' => $userId, ':f' => $flag, ':t' => $until, ':n' => mb_substr($note, 0, 300), ':a' => $actorId]);
}

/** Зняти прапор (is_active = 0; рядки не видаляються — історія). */
function msg_flag_clear(PDO $pdo, int $flagId): void
{
    $pdo->prepare('UPDATE mp_user_flags SET is_active = 0 WHERE id = :id')->execute([':id' => $flagId]);
}

// =========================================================================
// Текст: перевірки й показ
// =========================================================================

/** Нормалізація тексту: без керівних символів (крім \n і \t), CRLF → LF, обрізання пробілів по краях. */
function msg_clean_body(string $body): string
{
    $body = str_replace(["\r\n", "\r"], "\n", $body);
    $body = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', '', $body) ?? '';
    $body = preg_replace("/\n{4,}/", "\n\n\n", $body) ?? $body;

    return trim($body);
}

function msg_has_phone(string $text): bool
{
    return preg_match('/(?:\+?\d[\s\-().]*){9,}/', $text) === 1;
}

function msg_has_link(string $text): bool
{
    return mpb_count_links($text) > 0 || preg_match('~\b[a-z0-9-]+\.(?:com|net|org|ua|ru|io|me|link|ly|to|app|site|online|info|biz|top|xyz)\b~iu', $text) === 1;
}

/** Акаунт молодший за msg_young_days. */
function msg_is_young(PDO $pdo, int $userId): bool
{
    $days = max(0, (int) msg_cfg('msg_young_days'));
    $st = $pdo->prepare('SELECT created_at > (NOW() - INTERVAL ' . $days . ' DAY) FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return (int) $st->fetchColumn() === 1;
}

/**
 * HTML тексту повідомлення: екранування + перенос рядків + безпечні посилання (лише http/https; ім'я хоста як текст;
 * rel="noopener noreferrer nofollow ugc", target _blank, позначка «зовнішнє посилання»).
 */
function msg_body_html(string $body): string
{
    $parts = preg_split('~((?:https?://|www\.)[^\s<>"\']+)~iu', $body, -1, PREG_SPLIT_DELIM_CAPTURE) ?: [$body];
    $html = '';
    foreach ($parts as $i => $part) {
        if ($i % 2 === 0) {
            $html .= nl2br(htmlspecialchars($part, ENT_QUOTES | ENT_SUBSTITUTE), false);
            continue;
        }
        $trail = '';
        if (preg_match('~[.,;:!?)\]]+$~u', $part, $m) === 1) {
            $trail = $m[0];
            $part = mb_substr($part, 0, mb_strlen($part) - mb_strlen($trail));
        }
        $href = stripos($part, 'www.') === 0 ? 'https://' . $part : $part;
        if (filter_var($href, FILTER_VALIDATE_URL) === false || !preg_match('~^https?://~i', $href)) {
            $html .= htmlspecialchars($part . $trail, ENT_QUOTES | ENT_SUBSTITUTE);
            continue;
        }
        $html .= '<a class="msg-link" href="' . htmlspecialchars($href, ENT_QUOTES | ENT_SUBSTITUTE) . '" target="_blank" rel="noopener noreferrer nofollow ugc">'
            . htmlspecialchars($part, ENT_QUOTES | ENT_SUBSTITUTE) . '</a><span class="msg-ext" title="' . mp_e(t('msg_external_link')) . '"> ↗ '
            . mp_e(t('msg_external_short')) . '</span>' . htmlspecialchars($trail, ENT_QUOTES | ENT_SUBSTITUTE);
    }

    return $html;
}

/** Короткий фрагмент для списку розмов (звичайний текст, без посилань). */
function msg_preview(string $body, int $len = 90): string
{
    $one = preg_replace('/\s+/u', ' ', $body) ?? $body;

    return mb_strlen($one) > $len ? mb_substr($one, 0, $len - 1) . '…' : $one;
}

/**
 * Перевірка нового повідомлення від звичайного користувача. Повертає '' (можна) або ключ помилки t().
 * $isNewConv — це перше повідомлення нової розмови.
 */
function msg_check_send(PDO $pdo, int $userId, string $body, bool $isNewConv): string
{
    $len = mb_strlen($body);
    if ($len < 1) {
        return 'msg_err_empty';
    }
    if ($len > max(1, (int) msg_cfg('msg_max_len'))) {
        return 'msg_err_long';
    }
    if (mpl_is_blocked($pdo, $userId)) {
        return 'msg_err_account_blocked';
    }
    if (msg_flag($pdo, $userId, MSG_FLAG_RESTRICT) !== null) {
        return 'msg_err_restricted';
    }
    $young = msg_is_young($pdo, $userId);
    if ($isNewConv) {
        if (msg_flag($pdo, $userId, MSG_FLAG_NEWCONV) !== null) {
            return 'msg_err_newconv_limited';
        }
        $limit = (int) msg_cfg($young ? 'msg_new_conv_per_day_young' : 'msg_new_conv_per_day');
        $st = $pdo->prepare('SELECT COUNT(*) FROM mp_conversations WHERE buyer_id = :u AND created_at > (NOW() - INTERVAL 1 DAY)');
        $st->execute([':u' => $userId]);
        if ((int) $st->fetchColumn() >= $limit) {
            return 'msg_err_newconv_day';
        }
    }
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_messages WHERE sender_id = :u AND created_at > (NOW() - INTERVAL 1 HOUR)');
    $st->execute([':u' => $userId]);
    if ((int) $st->fetchColumn() >= (int) msg_cfg('msg_per_hour')) {
        return 'msg_err_hour';
    }
    if ($young && mpb_count_links($body) > (int) msg_cfg('msg_young_max_links')) {
        return 'msg_err_links';
    }
    $repeat = max(1, (int) msg_cfg('msg_repeat_max'));
    $st = $pdo->prepare('SELECT body FROM mp_messages WHERE sender_id = :u ORDER BY id DESC LIMIT ' . $repeat);
    $st->execute([':u' => $userId]);
    $last = $st->fetchAll(PDO::FETCH_COLUMN);
    if (count($last) >= $repeat) {
        $same = true;
        foreach ($last as $b) {
            if (mb_strtolower(trim((string) $b)) !== mb_strtolower($body)) {
                $same = false;
                break;
            }
        }
        if ($same) {
            return 'msg_err_repeat';
        }
    }
    $phrases = msg_cfg('msg_stop_phrases');
    if (is_array($phrases) && $phrases !== []) {
        $hay = mb_strtolower($body);
        foreach ($phrases as $p) {
            $p = mb_strtolower(trim((string) $p));
            if ($p !== '' && str_contains($hay, $p)) {
                return 'msg_err_stop';
            }
        }
    }
    if (!mpb_ip_hit($pdo, 'msg', (int) msg_cfg('ip_limit_msg'))) {
        return 'mpb_rate_limited';
    }

    return '';
}

// =========================================================================
// Створення розмови й надсилання
// =========================================================================

/**
 * Чи може користувач почати розмову з оголошення. '' — так; інакше ключ помилки t().
 * Перевіряє: оголошення живе, режим не contacts_only, не власне, не заблоковано автором.
 */
function msg_can_start(PDO $pdo, int $userId, ?array $listing): string
{
    if ($listing === null) {
        return 'msg_err_listing';
    }
    if (!$listing['live']) {
        return 'msg_err_listing_closed';
    }
    if ($listing['contact_mode'] === 'contacts_only') {
        return 'msg_err_no_messages';
    }
    if ($listing['is_platform'] ? mp_is_staff() : $listing['seller_user_id'] === $userId) {
        return 'msg_err_own';
    }
    if (!$listing['is_platform'] && msg_is_blocked_by($pdo, (int) $listing['seller_user_id'], $userId)) {
        return 'msg_err_not_accepting';
    }

    return '';
}

/** Наявна розмова користувача щодо оголошення або null. */
function msg_find_conversation(PDO $pdo, int $listingId, int $buyerId): ?int
{
    $st = $pdo->prepare("SELECT id FROM mp_conversations WHERE listing_source = 'mp' AND listing_id = :l AND buyer_id = :b");
    $st->execute([':l' => $listingId, ':b' => $buyerId]);
    $id = $st->fetchColumn();

    return $id === false ? null : (int) $id;
}

/**
 * Перше повідомлення: створює розмову (або бере наявну) і додає текст.
 * @return array{status:string,conv_id:?int}  status: ok | <ключ помилки t()>
 */
function msg_start(PDO $pdo, int $userId, array $listing, string $body): array
{
    $body = msg_clean_body($body);
    $err = msg_can_start($pdo, $userId, $listing);
    if ($err !== '') {
        return ['status' => $err, 'conv_id' => null];
    }
    $existing = msg_find_conversation($pdo, $listing['id'], $userId);
    if ($existing !== null) {
        $conv = msg_conversation($pdo, $existing);

        return $conv === null ? ['status' => 'msg_err_save', 'conv_id' => null] : msg_send_in_conv($pdo, $conv, 'buyer', $userId, $body);
    }
    $lock = 'mp_msg_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return ['status' => 'mpb_rate_limited', 'conv_id' => null];
    }
    try {
        $err = msg_check_send($pdo, $userId, $body, true);
        if ($err !== '') {
            return ['status' => $err, 'conv_id' => null];
        }
        $pdo->beginTransaction();
        try {
            $pdo->prepare("INSERT INTO mp_conversations (listing_source, listing_id, buyer_id, seller_user_id, status) VALUES ('mp', :l, :b, :s, 'open')")
                ->execute([':l' => $listing['id'], ':b' => $userId, ':s' => $listing['seller_user_id']]);
            $convId = (int) $pdo->lastInsertId();
            $msgId = msg_insert($pdo, $convId, $userId, null, $body, false);
            $pdo->commit();
        } catch (PDOException $e) {
            $pdo->rollBack();
            if ((int) ($e->errorInfo[1] ?? 0) === 1062) {   // паралельний запит уже створив розмову
                $id = msg_find_conversation($pdo, $listing['id'], $userId);

                return ['status' => $id !== null ? 'ok' : 'msg_err_save', 'conv_id' => $id];
            }
            throw $e;
        }
        msg_mark_read($pdo, $convId, $userId, $msgId);
        msg_check_suspicious($pdo, $userId);
    } finally {
        mpb_unlock($pdo, $lock);
    }
    msg_after_message($pdo, $convId, $msgId, 'buyer');

    return ['status' => 'ok', 'conv_id' => $convId];
}

/** Вставка повідомлення + оновлення last_message_* розмови. Повертає id повідомлення. */
function msg_insert(PDO $pdo, int $convId, ?int $senderId, ?string $label, string $body, bool $system): int
{
    $pdo->prepare('INSERT INTO mp_messages (conversation_id, sender_id, sender_label, body, is_system) VALUES (:c, :s, :l, :b, :y)')
        ->execute([':c' => $convId, ':s' => $senderId, ':l' => $label, ':b' => $body, ':y' => $system ? 1 : 0]);
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare('UPDATE mp_conversations SET last_message_id = :m, last_message_at = NOW() WHERE id = :c')->execute([':m' => $id, ':c' => $convId]);

    return $id;
}

/**
 * Відповідь у наявній розмові. $role — з msg_access(). Платформа (staff у скриньці платформи) пише від «AI LAB HUB»
 * без лімітів користувача; дія staff записується в mp_admin_access_log (бачить лише admin).
 *
 * @return array{status:string,conv_id:?int,message_id?:int}
 */
function msg_send_in_conv(PDO $pdo, array $conv, string $role, int $userId, string $body): array
{
    $convId = (int) $conv['id'];
    $body = msg_clean_body($body);
    $listing = msg_listing($pdo, (int) $conv['listing_id']);
    if (msg_is_readonly($conv, $listing)) {
        return ['status' => 'msg_err_readonly', 'conv_id' => $convId];
    }
    if ($role === 'platform') {
        $len = mb_strlen($body);
        if ($len < 1 || $len > max(1, (int) msg_cfg('msg_max_len'))) {
            return ['status' => $len < 1 ? 'msg_err_empty' : 'msg_err_long', 'conv_id' => $convId];
        }
        $msgId = msg_insert($pdo, $convId, null, MSG_PLATFORM_LABEL, $body, false);
        msg_mark_read($pdo, $convId, MSG_PLATFORM_UID, $msgId);
        msg_access_log($pdo, $userId, $convId, 'platform_reply', 'shared inbox');
        msg_after_message($pdo, $convId, $msgId, 'platform');

        return ['status' => 'ok', 'conv_id' => $convId, 'message_id' => $msgId];
    }
    $other = msg_counterpart_id($conv, $role);
    if ($other !== null && msg_is_blocked_by($pdo, $other, $userId)) {
        return ['status' => 'msg_err_not_accepting', 'conv_id' => $convId];
    }
    if ($role === 'buyer' && $conv['seller_user_id'] !== null && !msg_user_exists($pdo, (int) $conv['seller_user_id'])) {
        return ['status' => 'msg_err_not_accepting', 'conv_id' => $convId];
    }
    $lock = 'mp_msg_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return ['status' => 'mpb_rate_limited', 'conv_id' => $convId];
    }
    try {
        $err = msg_check_send($pdo, $userId, $body, false);
        if ($err !== '') {
            return ['status' => $err, 'conv_id' => $convId];
        }
        $msgId = msg_insert($pdo, $convId, $userId, null, $body, false);
        msg_mark_read($pdo, $convId, $userId, $msgId);
    } finally {
        mpb_unlock($pdo, $lock);
    }
    msg_after_message($pdo, $convId, $msgId, $role);

    return ['status' => 'ok', 'conv_id' => $convId, 'message_id' => $msgId];
}

function msg_user_exists(PDO $pdo, int $userId): bool
{
    $st = $pdo->prepare('SELECT 1 FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return $st->fetchColumn() !== false;
}

/**
 * Автопрапор «Підозріла активність»: молодий акаунт за добу почав розмови з посиланнями чи телефонами з N+ різними
 * авторами → тимчасово без нових розмов (mp_user_flags). Акаунт не блокується.
 */
function msg_check_suspicious(PDO $pdo, int $userId): void
{
    if (!msg_is_young($pdo, $userId) || msg_flag($pdo, $userId, MSG_FLAG_NEWCONV) !== null) {
        return;
    }
    $st = $pdo->prepare(
        'SELECT c.seller_user_id, c.listing_id, m.body FROM mp_conversations c
         JOIN mp_messages m ON m.id = (SELECT MIN(m2.id) FROM mp_messages m2 WHERE m2.conversation_id = c.id AND m2.sender_id = :u1)
         WHERE c.buyer_id = :u2 AND c.created_at > (NOW() - INTERVAL 1 DAY)'
    );
    $st->execute([':u1' => $userId, ':u2' => $userId]);
    $targets = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $b = (string) $r['body'];
        if (msg_has_link($b) || msg_has_phone($b)) {
            $targets[$r['seller_user_id'] !== null ? 'u' . $r['seller_user_id'] : 'p'] = true;
        }
    }
    $need = max(1, (int) msg_cfg('msg_suspicious_targets'));
    if (count($targets) >= $need) {
        $hours = max(1, (int) msg_cfg('msg_suspicious_hours'));
        msg_flag_set($pdo, $userId, MSG_FLAG_NEWCONV, $hours, 'auto: ' . count($targets) . ' authors with links/phones in 24h', null);
        error_log('[messages] suspicious activity flag: user=' . $userId . ' targets=' . count($targets));   // без тексту
    }
}

/** Після нового повідомлення: розмова знову видима відправнику (якщо ховав) і листи отримувачам. */
function msg_after_message(PDO $pdo, int $convId, int $msgId, string $senderRole): void
{
    unset($_SESSION['msg_unread_cache']);
    try {
        msg_notify_email($pdo, $convId, $msgId, $senderRole);
    } catch (Throwable $e) {
        error_log('[messages] email notify failed: conv=' . $convId . ' ' . get_class($e));
    }
}

// =========================================================================
// Читання
// =========================================================================

/**
 * Повідомлення розмови для показу: id > $sinceId, не більше $limit (найновіші), у хронологічному порядку.
 * @return list<array{id:int,mine:bool,label:string,html:string,time:string,iso:string,system:bool}>
 */
function msg_messages(PDO $pdo, array $conv, string $role, int $viewerId, int $sinceId = 0, int $limit = MSG_THREAD_LIMIT): array
{
    $limit = max(1, min(MSG_THREAD_LIMIT, $limit));
    $st = $pdo->prepare('SELECT id, sender_id, sender_label, body, is_system, created_at FROM mp_messages
                         WHERE conversation_id = :c AND id > :s ORDER BY id DESC LIMIT ' . $limit);
    $st->execute([':c' => (int) $conv['id'], ':s' => $sinceId]);
    $rows = array_reverse($st->fetchAll(PDO::FETCH_ASSOC));
    $out = [];
    foreach ($rows as $r) {
        $out[] = msg_render_row($pdo, $conv, $role, $viewerId, $r);
    }

    return $out;
}

function msg_render_row(PDO $pdo, array $conv, string $role, int $viewerId, array $r): array
{
    $system = (int) $r['is_system'] === 1;
    $fromPlatform = $r['sender_id'] === null && !$system;
    if ($role === 'platform' || $role === 'admin') {
        $mine = $role === 'platform' && $fromPlatform;
    } else {
        $mine = $r['sender_id'] !== null && (int) $r['sender_id'] === $viewerId;
    }
    $label = $system ? '' : ($fromPlatform ? MSG_PLATFORM_LABEL : ($mine ? t('msg_you') : msg_user_label($pdo, (int) $r['sender_id'])));
    $ts = strtotime((string) $r['created_at']) ?: time();

    return [
        'id' => (int) $r['id'], 'mine' => $mine, 'label' => $label, 'platform' => $fromPlatform,
        'html' => msg_body_html((string) $r['body']), 'time' => date(current_lang() === 'uk' ? 'd.m.Y H:i' : 'Y-m-d H:i', $ts),
        'iso' => date('c', $ts), 'system' => $system,
    ];
}

/** id останнього повідомлення розмови (0 — немає). */
function msg_last_id(PDO $pdo, int $convId): int
{
    $st = $pdo->prepare('SELECT COALESCE(MAX(id), 0) FROM mp_messages WHERE conversation_id = :c');
    $st->execute([':c' => $convId]);

    return (int) $st->fetchColumn();
}

/**
 * Список розмов користувача (покупець або автор). $tab: all | unread | archive.
 * Архів — розмови, які користувач сховав (і відтоді нових повідомлень немає), або лише для читання.
 *
 * @return list<array<string,mixed>>
 */
function msg_inbox(PDO $pdo, int $userId, string $tab, int $page = 1): array
{
    return msg_inbox_query($pdo, 'user', $userId, $tab, $page);
}

/** Скринька платформи для employee/admin (розмови з оголошеннями платформи). */
function msg_inbox_platform(PDO $pdo, string $tab, int $page = 1): array
{
    return msg_inbox_query($pdo, 'platform', MSG_PLATFORM_UID, $tab, $page);
}

function msg_inbox_query(PDO $pdo, string $mode, int $userId, string $tab, int $page): array
{
    $page = max(1, $page);
    $offset = ($page - 1) * MSG_PAGE_SIZE;
    if ($mode === 'platform') {
        $where = 'c.seller_user_id IS NULL';
        $params = [':su' => MSG_PLATFORM_UID];
        $unreadCond = 'm.sender_id = c.buyer_id';
    } else {
        $where = '(c.buyer_id = :u1 OR c.seller_user_id = :u2)';
        $params = [':u1' => $userId, ':u2' => $userId, ':su' => $userId, ':me' => $userId];
        $unreadCond = '(m.sender_id IS NULL OR m.sender_id <> :me)';
    }
    $sql = "SELECT c.*, COALESCE(s.last_read_message_id, 0) AS last_read, COALESCE(s.hidden_up_to_message_id, 0) AS hidden_up_to,
                   COALESCE(s.is_muted, 0) AS muted,
                   (SELECT COUNT(*) FROM mp_messages m WHERE m.conversation_id = c.id AND m.id > COALESCE(s.last_read_message_id, 0) AND $unreadCond) AS unread,
                   lm.body AS last_body, lm.sender_id AS last_sender_id, lm.is_system AS last_system
            FROM mp_conversations c
            LEFT JOIN mp_conversation_state s ON s.conversation_id = c.id AND s.user_id = :su
            LEFT JOIN mp_messages lm ON lm.id = c.last_message_id
            WHERE $where AND c.last_message_id IS NOT NULL
            ORDER BY c.last_message_at DESC, c.id DESC LIMIT 500";
    $st = $pdo->prepare($sql);
    $st->execute($params);
    $rows = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $c) {
        $listing = msg_listing($pdo, (int) $c['listing_id']);
        $readonly = msg_is_readonly($c, $listing);
        $hidden = (int) $c['hidden_up_to'] >= (int) $c['last_message_id'];
        $archived = $hidden || $readonly;
        if (($tab === 'archive') !== $archived && $tab !== 'unread') {
            continue;
        }
        if ($tab === 'unread' && ((int) $c['unread'] === 0 || $hidden)) {
            continue;
        }
        $role = $mode === 'platform' ? 'platform' : ((int) $c['buyer_id'] === $userId ? 'buyer' : 'seller');
        $otherId = msg_counterpart_id($c, $role);
        $rows[] = [
            'id' => (int) $c['id'], 'listing' => $listing, 'role' => $role,
            'counterpart' => $role === 'buyer' && $c['seller_user_id'] === null ? MSG_PLATFORM_LABEL : msg_user_label($pdo, $otherId),
            'preview' => (int) $c['last_system'] === 1 ? t('msg_system_note') : msg_preview((string) $c['last_body']),
            'last_mine' => $mode === 'platform' ? $c['last_sender_id'] === null : ($c['last_sender_id'] !== null && (int) $c['last_sender_id'] === $userId),
            'time' => (string) $c['last_message_at'], 'unread' => (int) $c['unread'], 'muted' => (int) $c['muted'] === 1, 'readonly' => $readonly,
        ];
    }

    return array_slice($rows, $offset, MSG_PAGE_SIZE + 1);
}

/** Непрочитані для шапки й меню (без розмов «без сповіщень» і схованих), кеш у сесії на 30 с. */
function msg_unread_total(PDO $pdo, int $userId): int
{
    $c = $_SESSION['msg_unread_cache'] ?? null;
    if (is_array($c) && (int) ($c['u'] ?? 0) === $userId && (int) ($c['t'] ?? 0) > time() - 30) {
        return (int) $c['n'];
    }
    $st = $pdo->prepare(
        'SELECT COUNT(*) FROM mp_messages m
         JOIN mp_conversations c ON c.id = m.conversation_id
         LEFT JOIN mp_conversation_state s ON s.conversation_id = c.id AND s.user_id = :su
         WHERE (c.buyer_id = :u1 OR c.seller_user_id = :u2) AND m.id > COALESCE(s.last_read_message_id, 0)
           AND (m.sender_id IS NULL OR m.sender_id <> :me) AND COALESCE(s.is_muted, 0) = 0'
    );
    $st->execute([':su' => $userId, ':u1' => $userId, ':u2' => $userId, ':me' => $userId]);
    $n = (int) $st->fetchColumn();
    $_SESSION['msg_unread_cache'] = ['u' => $userId, 't' => time(), 'n' => $n];

    return $n;
}

/** Непрочитані в скриньці платформи (для CRM-меню). */
function msg_platform_unread(PDO $pdo): int
{
    $st = $pdo->query(
        'SELECT COUNT(*) FROM mp_messages m
         JOIN mp_conversations c ON c.id = m.conversation_id
         LEFT JOIN mp_conversation_state s ON s.conversation_id = c.id AND s.user_id = 0
         WHERE c.seller_user_id IS NULL AND m.sender_id = c.buyer_id AND m.id > COALESCE(s.last_read_message_id, 0)'
    );

    return (int) $st->fetchColumn();
}

/** Нові скарги на повідомлення (для CRM-меню). */
function msg_reports_new(PDO $pdo): int
{
    return (int) $pdo->query("SELECT COUNT(*) FROM mp_message_reports WHERE status = 'new'")->fetchColumn();
}

/** Значок непрочитаних для шапки сайту (порожній рядок, якщо вимкнено чи нуль). */
function msg_header_badge_html(): string
{
    try {
        if (!auth_check() || !msg_enabled()) {
            return '';
        }
        $n = msg_unread_total(translation_pdo(), (int) auth_user_id());
    } catch (Throwable) {
        return '';
    }
    if ($n <= 0) {
        return '';
    }

    return ' <span class="msg-badge" aria-label="' . mp_e(sprintf(t('msg_unread_aria'), $n)) . '">' . ($n > 99 ? '99+' : $n) . '</span>';
}

// =========================================================================
// Скарги, журнал доступу
// =========================================================================

/**
 * Скарга учасника розмови: зберігає знімок до 30 останніх повідомлень (JSON).
 * @return string ok | invalid | rate | duplicate
 */
function msg_report(PDO $pdo, array $conv, string $role, int $userId, string $reason, string $note, ?int $messageId): string
{
    if (!in_array($reason, MSG_REPORT_REASONS, true)) {
        return 'invalid';
    }
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_message_reports WHERE reporter_id = :u AND created_at > (NOW() - INTERVAL 1 DAY)');
    $st->execute([':u' => $userId]);
    if ((int) $st->fetchColumn() >= 10 || !mpb_ip_hit($pdo, 'report', (int) mp_config()['ip_limit_report'])) {
        return 'rate';
    }
    $st = $pdo->prepare("SELECT 1 FROM mp_message_reports WHERE conversation_id = :c AND reporter_id = :u AND status = 'new'");
    $st->execute([':c' => (int) $conv['id'], ':u' => $userId]);
    if ($st->fetchColumn() !== false) {
        return 'duplicate';
    }
    if ($messageId !== null) {
        $chk = $pdo->prepare('SELECT 1 FROM mp_messages WHERE id = :m AND conversation_id = :c');
        $chk->execute([':m' => $messageId, ':c' => (int) $conv['id']]);
        if ($chk->fetchColumn() === false) {
            $messageId = null;
        }
    }
    $snap = $pdo->prepare('SELECT id, sender_id, sender_label, body, is_system, created_at FROM mp_messages WHERE conversation_id = :c ORDER BY id DESC LIMIT 30');
    $snap->execute([':c' => (int) $conv['id']]);
    $rows = array_reverse($snap->fetchAll(PDO::FETCH_ASSOC));
    $pdo->prepare('INSERT INTO mp_message_reports (conversation_id, message_id, reporter_id, reason, note, snapshot) VALUES (:c, :m, :u, :r, :n, :s)')
        ->execute([
            ':c' => (int) $conv['id'], ':m' => $messageId, ':u' => $userId, ':r' => $reason,
            ':n' => trim($note) !== '' ? mb_substr(trim($note), 0, 500) : null,
            ':s' => json_encode(['buyer_id' => (int) $conv['buyer_id'], 'seller_user_id' => $conv['seller_user_id'] !== null ? (int) $conv['seller_user_id'] : null,
                'listing_id' => (int) $conv['listing_id'], 'messages' => $rows], JSON_UNESCAPED_UNICODE),
        ]);

    return 'ok';
}

function msg_access_log(PDO $pdo, int $adminId, int $convId, string $action, string $reason): void
{
    $pdo->prepare('INSERT INTO mp_admin_access_log (admin_id, conversation_id, action, reason) VALUES (:a, :c, :ac, :r)')
        ->execute([':a' => $adminId, ':c' => $convId, ':ac' => mb_substr($action, 0, 30), ':r' => mb_substr($reason, 0, 300)]);
}

// =========================================================================
// Листи про нові повідомлення
// =========================================================================

/** Підпис відписки (HMAC). Порожній секрет → листів немає. */
function msg_unsub_token(int $userId): ?string
{
    $secret = (string) msg_cfg('messaging_secret');
    if (strlen($secret) < 16) {
        return null;
    }

    return $userId . '.' . substr(hash_hmac('sha256', 'msg-unsub|' . $userId, $secret), 0, 32);
}

/** Перевірка токена відписки → id користувача або null. */
function msg_unsub_verify(string $token): ?int
{
    if (preg_match('/^(\d{1,10})\.([a-f0-9]{32})$/', $token, $m) !== 1) {
        return null;
    }
    $expected = msg_unsub_token((int) $m[1]);

    return $expected !== null && hash_equals($expected, $token) ? (int) $m[1] : null;
}

function msg_email_pref(PDO $pdo, int $userId): bool
{
    $st = $pdo->prepare('SELECT email_new_message FROM mp_notify_prefs WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return (int) $st->fetchColumn() === 1;
}

function msg_set_email_pref(PDO $pdo, int $userId, bool $on): void
{
    $pdo->prepare('INSERT INTO mp_notify_prefs (user_id, email_new_message) VALUES (:u, :v) ON DUPLICATE KEY UPDATE email_new_message = VALUES(email_new_message)')
        ->execute([':u' => $userId, ':v' => $on ? 1 : 0]);
}

/**
 * Лист отримувачу (лише messaging_email_enabled + згода + не «без сповіщень»): не частіше 1 на розмову за
 * msg_email_min_minutes і не більше msg_email_max_per_day на добу. Лист не містить тексту повідомлення й імені
 * відправника — лише назву оголошення, посилання на розмову й підписану відписку. Скринька платформи листів не отримує.
 */
function msg_notify_email(PDO $pdo, int $convId, int $msgId, string $senderRole): void
{
    if (msg_cfg('messaging_email_enabled') !== true || msg_unsub_token(1) === null) {
        return;
    }
    $conv = msg_conversation($pdo, $convId);
    if ($conv === null) {
        return;
    }
    $recipient = $senderRole === 'buyer' ? ($conv['seller_user_id'] !== null ? (int) $conv['seller_user_id'] : null) : (int) $conv['buyer_id'];
    if ($recipient === null || !msg_email_pref($pdo, $recipient) || msg_state($pdo, $convId, $recipient)['is_muted'] === 1) {
        return;
    }
    $min = max(1, (int) msg_cfg('msg_email_min_minutes'));
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_message_emails WHERE user_id = :u AND conversation_id = :c AND created_at > (NOW() - INTERVAL ' . $min . ' MINUTE)');
    $st->execute([':u' => $recipient, ':c' => $convId]);
    if ((int) $st->fetchColumn() > 0) {
        return;
    }
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_message_emails WHERE user_id = :u AND created_at > (NOW() - INTERVAL 1 DAY)');
    $st->execute([':u' => $recipient]);
    if ((int) $st->fetchColumn() >= max(1, (int) msg_cfg('msg_email_max_per_day'))) {
        return;
    }
    $u = $pdo->prepare('SELECT email FROM users WHERE id = :u');
    $u->execute([':u' => $recipient]);
    $email = (string) $u->fetchColumn();
    $site = mpv_site_url();
    $token = msg_unsub_token($recipient);
    if ($site === null || $token === null || filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        return;
    }
    $listing = msg_listing($pdo, (int) $conv['listing_id'], 'uk');
    $title = $listing['title'] ?? ('#' . (int) $conv['listing_id']);
    $link = $site . '/mp-thread.php?id=' . $convId;
    $unsub = $site . '/mp-notify-settings.php?unsub=' . rawurlencode($token);
    $subject = 'Нове повідомлення щодо оголошення «' . mb_substr($title, 0, 120) . '»';
    $text = $subject . "\n\nВідкрити розмову: " . $link . "\n\n"
        . 'New message about the listing “' . mb_substr($title, 0, 120) . '”. Open: ' . $link . "\n\n"
        . 'Не отримувати такі листи / Unsubscribe: ' . $unsub . "\n";
    $h = static fn(string $s): string => htmlspecialchars($s, ENT_QUOTES);
    $html = '<div style="font-family:Arial,sans-serif;font-size:15px;line-height:1.55;color:#00032c">'
        . '<p>' . $h($subject) . '</p><p><a href="' . $h($link) . '" style="color:#2116ad">Відкрити розмову</a></p>'
        . '<p style="color:#555">New message about the listing “' . $h(mb_substr($title, 0, 120)) . '”. <a href="' . $h($link) . '" style="color:#2116ad">Open</a></p>'
        . '<p style="font-size:12px;color:#777"><a href="' . $h($unsub) . '" style="color:#777">Не отримувати такі листи / Unsubscribe</a></p></div>';
    if (mpv_deliver($email, $subject, $html, $text)) {
        $pdo->prepare('INSERT INTO mp_message_emails (user_id, conversation_id) VALUES (:u, :c)')->execute([':u' => $recipient, ':c' => $convId]);
        $pdo->prepare('INSERT INTO mp_notify_prefs (user_id, email_new_message, last_email_at) VALUES (:u, 1, NOW()) ON DUPLICATE KEY UPDATE last_email_at = NOW()')
            ->execute([':u' => $recipient]);
    }
}

// =========================================================================
// Строк зберігання
// =========================================================================

/**
 * Видаляє розмови без активності довше за messages_retention_days разом із повідомленнями, станами, обліком листів
 * і знімками ЗАКРИТИХ скарг (snapshot = NULL; відкриті скарги зберігають знімок до розгляду).
 * Єдині DELETE даних розмов. Пакетами по 200. @return array{conversations:int,messages:int}
 */
function msg_retention_cleanup(PDO $pdo, ?int $days = null): array
{
    $days = max(1, $days ?? (int) msg_cfg('messages_retention_days'));
    $total = ['conversations' => 0, 'messages' => 0];
    for ($i = 0; $i < 50; $i++) {
        // Розмови з відкритою скаргою не чіпаємо, доки її не розглянуто.
        $st = $pdo->prepare("SELECT c.id FROM mp_conversations c WHERE COALESCE(c.last_message_at, c.created_at) < (NOW() - INTERVAL $days DAY)
                             AND NOT EXISTS (SELECT 1 FROM mp_message_reports r WHERE r.conversation_id = c.id AND r.status = 'new')
                             ORDER BY c.id LIMIT 200");
        $st->execute();
        $ids = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN));
        if ($ids === []) {
            break;
        }
        $in = implode(',', $ids);   // лише цілі числа з БД
        $pdo->beginTransaction();
        $total['messages'] += $pdo->exec("DELETE FROM mp_messages WHERE conversation_id IN ($in)") ?: 0;
        $pdo->exec("DELETE FROM mp_conversation_state WHERE conversation_id IN ($in)");
        $pdo->exec("DELETE FROM mp_message_emails WHERE conversation_id IN ($in)");
        $pdo->exec("UPDATE mp_message_reports SET snapshot = NULL WHERE status <> 'new' AND conversation_id IN ($in)");
        $total['conversations'] += $pdo->exec("DELETE FROM mp_conversations WHERE id IN ($in)") ?: 0;
        $pdo->commit();
        if (count($ids) < 200) {
            break;
        }
    }

    return $total;
}

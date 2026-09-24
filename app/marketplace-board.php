<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace, етап 4: дошка оголошень (публікують користувачі). Хелпери.
 *
 * Розділ mp_listings.section = 'board'. Міграція — database/migration-2026-09-21-marketplace-classifieds.sql.
 * Підключати після app/auth.php і app/translations.php:
 *   require_once __DIR__ . '/../app/marketplace-board.php';   // сам підключає app/marketplace.php
 *
 * Правила, які тримає цей файл:
 *  - публічно видно лише status='published' І expires_at > NOW() (не залежить від cron);
 *  - контакти НІКОЛИ не потрапляють у публічні SELECT — тільки mpb_contacts() / mp-contact.php;
 *  - усі запити — prepared statements (у config/database.php ATTR_EMULATE_PREPARES = false, тож
 *    іменовані параметри не повторюються в межах одного запиту).
 */

require_once __DIR__ . '/marketplace.php';

const MPB_SECTION = 'board';
const MPB_PRICE_TYPES = ['none', 'free', 'fixed', 'negotiable', 'exchange'];   // 'none' — ціну не вказано
const MPB_CURRENCIES = ['UAH' => '₴', 'USD' => '$', 'EUR' => '€'];
const MPB_REPORT_REASONS = ['fraud', 'prohibited', 'spam', 'wrong_category', 'other'];
const MPB_PER_PAGE = 12;
const MPB_PHOTO_NAME_RE = '/^[a-f0-9]{32}(?:_t)?\.(?:jpg|png|webp)$/';

// =========================================================================
// Оболонка сторінок, повідомлення, доступ
// =========================================================================

function mpb_is_staff(): bool
{
    return mp_is_staff();   // роль з БД, а не з сесії
}

/**
 * Іменоване блокування MySQL (GET_LOCK) — серіалізує «перевірив ліміт → виконав дію» для одного користувача.
 * Без нього N паралельних запитів (з різних сесій одного акаунта) усі бачать «ліміт ще не вичерпано».
 * Блокування сесійне: звільняється mpb_unlock() або закриттям з'єднання наприкінці запиту.
 */
function mpb_lock(PDO $pdo, string $name, int $timeoutSec = 10): bool
{
    $stmt = $pdo->prepare('SELECT GET_LOCK(:n, :t)');
    $stmt->execute([':n' => substr($name, 0, 64), ':t' => $timeoutSec]);

    return (int) $stmt->fetchColumn() === 1;
}

function mpb_unlock(PDO $pdo, string $name): void
{
    $stmt = $pdo->prepare('SELECT RELEASE_LOCK(:n)');
    $stmt->execute([':n' => substr($name, 0, 64)]);
}

// =========================================================================
// IP-ліміти (другий шар; основні ліміти — на акаунт)
// =========================================================================

/**
 * IP клієнта. За замовчуванням — REMOTE_ADDR. Заголовок проксі береться ЛИШЕ якщо в конфігу
 * 'trusted_proxy_header' задано (напр. 'X-Forwarded-For'); тоді — його ОСТАННІЙ елемент (додає довірений проксі),
 * і лише якщо це коректний IP. Інакше — REMOTE_ADDR.
 */
function mpb_client_ip(): string
{
    $ip = (string) ($_SERVER['REMOTE_ADDR'] ?? '');
    $hdr = trim((string) mp_config()['trusted_proxy_header']);
    if ($hdr !== '' && preg_match('/^[A-Za-z0-9-]+$/', $hdr) === 1) {
        $key = 'HTTP_' . strtoupper(str_replace('-', '_', $hdr));
        $val = $_SERVER[$key] ?? '';
        if (is_string($val) && $val !== '') {
            $parts = explode(',', $val);
            $last = trim((string) end($parts));
            if (filter_var($last, FILTER_VALIDATE_IP) !== false) {
                $ip = $last;
            }
        }
    }

    return $ip;
}

/**
 * Ключ для БД: sha256(нормалізований IP + сіль). IPv6 зводиться до /64 (одна домашня мережа = один ключ),
 * IPv4-mapped IPv6 — до IPv4. IP у відкритому вигляді ніде не зберігається й не логується.
 */
function mpb_ip_key(string $ip): string
{
    $bin = @inet_pton($ip);
    if ($bin === false) {
        $norm = 'invalid:' . $ip;
    } else {
        if (strlen($bin) === 16 && str_starts_with($bin, "\0\0\0\0\0\0\0\0\0\0\xff\xff")) {
            $bin = substr($bin, 12);
        } elseif (strlen($bin) === 16) {
            $bin = substr($bin, 0, 8);
        }
        $norm = bin2hex($bin);
    }
    $salt = (string) mp_config()['rate_limit_salt'];
    if ($salt === '') {
        $salt = 'mp-rl-default:' . dirname(__DIR__);   // запасна сіль; на сервері задайте власну в конфігу
    }

    return hash('sha256', $norm . '|' . $salt);
}

/**
 * Реєструє спробу дії з цього IP у добовому вікні й каже, чи вона дозволена (true) або ліміт перевищено (false).
 * Лічильник — атомарний upsert у mp_rate_limits. Немає таблиці (міграція 12 не застосована) → дозволено + запис у лог.
 * Виклик — лише для не-staff і лише в момент, коли дія справді виконується.
 */
function mpb_ip_hit(PDO $pdo, string $action, int $limit): bool
{
    $key = mpb_ip_key(mpb_client_ip());
    try {
        $pdo->prepare(
            'INSERT INTO mp_rate_limits (key_hash, action, window_start, hits) VALUES (:k, :a, CURDATE(), 1)
             ON DUPLICATE KEY UPDATE hits = hits + 1'
        )->execute([':k' => $key, ':a' => $action]);
        $sel = $pdo->prepare('SELECT hits FROM mp_rate_limits WHERE key_hash = :k AND action = :a AND window_start = CURDATE()');
        $sel->execute([':k' => $key, ':a' => $action]);
        $hits = (int) $sel->fetchColumn();
    } catch (PDOException $e) {
        error_log('[marketplace] ip rate limit unavailable: ' . $e->getMessage());

        return true;
    }
    if ($hits > $limit) {
        error_log(sprintf('[marketplace] ip rate limit exceeded: action=%s hits=%d limit=%d ip_key=%s user=%s', $action, $hits, $limit, substr($key, 0, 12), (string) (auth_user_id() ?? '-')));

        return false;
    }

    return true;
}

/** Прибирає лічильники IP-лімітів старші за 3 доби (єдиний DELETE цього етапу). Повертає кількість рядків. */
function mpb_rate_cleanup(PDO $pdo): int
{
    try {
        $stmt = $pdo->prepare('DELETE FROM mp_rate_limits WHERE window_start < (NOW() - INTERVAL 3 DAY)');
        $stmt->execute();

        return $stmt->rowCount();
    } catch (PDOException $e) {
        error_log('[marketplace] rate limit cleanup failed: ' . $e->getMessage());

        return 0;
    }
}

/**
 * Чи може ПОТОЧНИЙ користувач створювати/редагувати оголошення: подачу відкрито для всіх (posting_enabled)
 * або він employee/admin (роль — з БД). Серверна перевірка; інтерфейс лише відображає її.
 */
function mpb_posting_open(): bool
{
    return mp_posting_enabled() || mpb_is_staff();
}

/** Сторінка «Подача оголошень відкриється згодом» (403) і завершення скрипта. */
function mpb_posting_closed_page(): never
{
    $body = '<p class="mp-text">' . mp_e(t('mpb_posting_closed')) . '</p>';
    if (!auth_check()) {
        $body .= '<p class="mp-note">' . mp_e(t('mpb_posting_staff_login')) . ' <a href="login.php">' . mp_e(t('nav_login')) . '</a></p>';
    }
    mpb_message_page(403, t('mpb_posting_closed_title'), $body, 'marketplace.php');
}

/** Разове повідомлення для наступної сторінки (сесія). */
function mpb_flash(string $type, string $text): void
{
    $_SESSION['mpb_flash'][] = ['type' => $type === 'error' ? 'error' : 'ok', 'text' => $text];
}

/** HTML розкладених повідомлень (і очищення). */
function mpb_flash_html(): string
{
    $items = $_SESSION['mpb_flash'] ?? [];
    unset($_SESSION['mpb_flash']);
    $html = '';
    if (is_array($items)) {
        foreach ($items as $it) {
            $html .= '<div class="mp-alert mp-alert--' . mp_e($it['type'] ?? 'ok') . '" role="status">' . mp_e($it['text'] ?? '') . '</div>';
        }
    }

    return $html;
}

/** Початок HTML-сторінки: <head>, шапка сайту. Закривати mpb_close(). */
function mpb_open(string $title, bool $noindex = true): void
{
    $lang = current_lang();
    echo "<!DOCTYPE html>\n<html lang=\"" . mp_e($lang) . "\">\n<head>\n<meta charset=\"utf-8\">\n"
        . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
        . ($noindex ? "<meta name=\"robots\" content=\"noindex, nofollow\">\n" : '')
        . '<title>' . mp_e($title) . ' — ' . mp_e(t('title_marketplace')) . "</title>\n";
    include __DIR__ . '/header.php';
    echo "\n<link rel=\"stylesheet\" href=\"/assets/css/site-nav.css\">\n"
        . '<link rel="stylesheet" href="' . css_asset('mp-public.css') . "\">\n</head>\n<body class=\"mp-body\">\n";
    include __DIR__ . '/site-header.php';
}

function mpb_close(): void
{
    include __DIR__ . '/footer.php';
    echo "\n</body>\n</html>\n";
}

/** Сторінка-повідомлення (заголовок + HTML тіла) і завершення скрипта. */
function mpb_message_page(int $status, string $title, string $bodyHtml, ?string $backHref = 'marketplace.php'): never
{
    http_response_code($status);
    mpb_open($title);
    echo '<div class="mp-page mp-page--narrow">';
    if ($backHref !== null) {
        echo '<a class="mp-back" href="' . mp_e($backHref) . '">' . mp_e(t('mp_back')) . '</a>';
    }
    echo '<section class="mp-panel"><h1 class="mp-panel__title">' . mp_e($title) . '</h1>' . $bodyHtml . '</section></div>';
    mpb_close();
    exit;
}

/** Гість → пропозиція увійти. Повертає id користувача, якщо вхід є. */
function mpb_require_login(): int
{
    $uid = auth_user_id();
    if ($uid !== null) {
        return $uid;
    }
    mpb_message_page(
        401,
        t('mpb_login_title'),
        '<p class="mp-text">' . mp_e(t('mpb_login_text')) . '</p>'
        . '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="login.php">' . mp_e(t('nav_login')) . '</a>'
        . '<a class="mp-btn" href="register.php">' . mp_e(t('mp_register')) . '</a></p>'
    );
}

/** Лише POST з CSRF; інакше 405/403 і вихід. */
function mpb_require_post(bool $json = false): void
{
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        http_response_code(405);
        header('Allow: POST');
        if ($json) {
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['ok' => false, 'error' => 'method']);
        }
        exit;
    }
    if (!mp_csrf_verify()) {
        http_response_code(403);
        if ($json) {
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['ok' => false, 'error' => 'csrf', 'message' => t('mpb_err_csrf')]);
        } else {
            echo 'Forbidden';
        }
        exit;
    }
}

/** Безпечний редірект на внутрішню сторінку (без схеми/хоста). */
function mpb_redirect(string $to): never
{
    if (!preg_match('~^[A-Za-z0-9_\-]+\.php(?:\?[A-Za-z0-9_=&%\-\.]*)?$~', $to)) {
        $to = 'marketplace.php';
    }
    header('Location: ' . $to, true, 303);
    exit;
}

// =========================================================================
// Ціна, посилання, фото-URL
// =========================================================================

/** Підпис ціни для картки/сторінки; '' — ціну не вказано (рядок ціни не показується). */
function mpb_price_label(array $row): string
{
    switch ((string) ($row['price_type'] ?? 'free')) {
        case 'none':
            return '';
        case 'fixed':
            $amount = (float) ($row['price_amount'] ?? 0);
            $cur = (string) ($row['currency'] ?? 'UAH');
            $num = number_format($amount, floor($amount) === $amount ? 0 : 2, ',', ' ');

            return $num . "\u{00A0}" . (MPB_CURRENCIES[$cur] ?? $cur);
        case 'negotiable':
            return t('mpb_price_negotiable');
        case 'exchange':
            return t('mpb_price_exchange');
        default:
            return t('price_free');
    }
}

/** Локація для картки: «Київ · дистанційно» тощо. */
function mpb_location_label(array $row): string
{
    $parts = [];
    if (!empty($row['city'])) {
        $parts[] = (string) $row['city'];
    }
    if ((int) ($row['is_remote'] ?? 0) === 1) {
        $parts[] = t('mpb_remote');
    }

    return implode(' · ', $parts);
}

/**
 * URL фото оголошення. Фото лежать ПОЗА webroot (photo_dir), віддає їх public/mp-photo.php з перевіркою прав:
 * .htaccess-заборону виконання PHP у публічній теці shared-хостинг (adm.tools) не підтримує.
 */
function mpb_photo_url(string $name): ?string
{
    if (preg_match(MPB_PHOTO_NAME_RE, $name) !== 1) {
        return null;
    }

    return '/mp-photo.php?f=' . $name;
}

// =========================================================================
// Продавець і власність
// =========================================================================

/** Профіль mp_sellers користувача (створюється автоматично). */
function mpb_seller_for_user(PDO $pdo, int $userId, string $name): int
{
    $sel = $pdo->prepare('SELECT id FROM mp_sellers WHERE user_id = :u ORDER BY id LIMIT 1');
    $sel->execute([':u' => $userId]);
    $id = $sel->fetchColumn();
    if ($id !== false) {
        return (int) $id;
    }
    $display = mb_substr(trim($name) !== '' ? trim($name) : 'User ' . $userId, 0, 150);
    try {
        $ins = $pdo->prepare("INSERT INTO mp_sellers (user_id, display_name, slug, is_platform, is_verified, status) VALUES (:u, :n, :s, 0, 0, 'active')");
        $ins->execute([':u' => $userId, ':n' => $display, ':s' => 'u' . $userId]);

        return (int) $pdo->lastInsertId();
    } catch (PDOException $e) {
        // паралельний запит уже створив профіль (unique slug) — беремо його
        $sel->execute([':u' => $userId]);
        $id = $sel->fetchColumn();
        if ($id === false) {
            throw $e;
        }

        return (int) $id;
    }
}

/** Власне оголошення користувача (усі поля рядка mp_listings) або null. */
function mpb_own_listing(PDO $pdo, int $id, int $userId): ?array
{
    $stmt = $pdo->prepare(
        "SELECT l.*, (l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.id = :id AND l.section = 'board' AND s.user_id = :u"
    );
    $stmt->execute([':id' => $id, ':u' => $userId]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    return $row === false ? null : $row;
}

// =========================================================================
// Вибірки для публічної частини
// =========================================================================

/** Умова видимості в публічних запитах (alias l). */
function mpb_visible_sql(): string
{
    return "l.section = 'board' AND l.status = 'published' AND l.expires_at > NOW()";
}

/** Кількість скарг після останньої модерації (alias l). */
function mpb_reports_sql(): string
{
    return "(SELECT COUNT(*) FROM mp_reports r WHERE r.listing_id = l.id AND r.created_at > COALESCE(l.moderated_at, '1970-01-01 00:00:00'))";
}

/** SELECT-частина з текстами поточною мовою (запасний варіант — мова оригіналу). БЕЗ контактів. */
function mpb_select_sql(): string
{
    return "SELECT l.id, l.status, l.seller_id, l.price_type, l.price_amount, l.currency, l.is_remote, l.city,
                   l.published_at, l.expires_at, l.created_at, l.views_count, l.source_lang, l.reject_reason,
                   s.display_name AS seller_name, s.user_id AS seller_user_id,
                   COALESCE(NULLIF(tc.title, ''), ts.title)           AS title,
                   COALESCE(NULLIF(tc.short_desc, ''), ts.short_desc) AS short_desc,
                   COALESCE(NULLIF(tc.full_desc, ''), ts.full_desc)   AS full_desc,
                   IF(tc.title IS NULL OR tc.title = '', l.source_lang, tc.lang) AS text_lang,
                   (l.status = 'published' AND l.expires_at > NOW()) AS is_live,
                   (SELECT p.thumb_name FROM mp_listing_photos p WHERE p.listing_id = l.id ORDER BY p.sort_order, p.id LIMIT 1) AS cover_thumb
            FROM mp_listings l
            LEFT JOIN mp_sellers s ON s.id = l.seller_id
            LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
            LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang";
}

/**
 * Пошук для marketplace.php. Фільтри: category(int), price_type, min/max (?float), city, remote(bool), q; sort: new|cheap|expensive.
 * Ефективна ціна: free → 0, fixed → price_amount, решта (договірна/обмін) → NULL (у діапазон не потрапляє, у сортуванні — в кінці).
 *
 * @return array{rows:list<array<string,mixed>>,total:int,pages:int,page:int}
 */
function mpb_search(PDO $pdo, string $lang, array $f, int $page): array
{
    $eff = "(CASE l.price_type WHEN 'free' THEN 0 WHEN 'fixed' THEN l.price_amount ELSE NULL END)";
    $where = [mpb_visible_sql()];
    $params = [];

    $cat = (int) ($f['category'] ?? 0);
    if ($cat > 0) {
        $where[] = 'EXISTS (SELECT 1 FROM mp_listing_categories x WHERE x.listing_id = l.id AND x.category_id = :cat)';
        $params[':cat'] = $cat;
    }
    $pt = (string) ($f['price_type'] ?? '');
    if (in_array($pt, MPB_PRICE_TYPES, true)) {
        $where[] = 'l.price_type = :pt';
        $params[':pt'] = $pt;
    }
    if (($f['min'] ?? null) !== null) {
        $where[] = "$eff >= :pmin";
        $params[':pmin'] = (float) $f['min'];
    }
    if (($f['max'] ?? null) !== null) {
        $where[] = "$eff <= :pmax";
        $params[':pmax'] = (float) $f['max'];
    }
    $city = trim((string) ($f['city'] ?? ''));
    $remote = (bool) ($f['remote'] ?? false);
    if ($city !== '' && $remote) {
        $where[] = "(l.city LIKE :city ESCAPE '\\\\' OR l.is_remote = 1)";
        $params[':city'] = addcslashes($city, '%_\\') . '%';
    } elseif ($city !== '') {
        $where[] = "l.city LIKE :city ESCAPE '\\\\'";
        $params[':city'] = addcslashes($city, '%_\\') . '%';
    } elseif ($remote) {
        $where[] = 'l.is_remote = 1';
    }
    $q = trim((string) ($f['q'] ?? ''));
    if ($q !== '') {
        $where[] = "(tc.title LIKE :q1 ESCAPE '\\\\' OR ts.title LIKE :q2 ESCAPE '\\\\')";
        $like = '%' . addcslashes($q, '%_\\') . '%';
        $params[':q1'] = $like;
        $params[':q2'] = $like;
    }
    $order = match ((string) ($f['sort'] ?? 'new')) {
        'cheap'     => "($eff IS NULL) ASC, $eff ASC, l.published_at DESC, l.id DESC",
        'expensive' => "($eff IS NULL) ASC, $eff DESC, l.published_at DESC, l.id DESC",
        default     => 'l.published_at DESC, l.id DESC',
    };
    $whereSql = implode(' AND ', $where);
    $from = "FROM mp_listings l
             LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
             LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
             WHERE $whereSql AND COALESCE(NULLIF(tc.title, ''), ts.title) IS NOT NULL";

    $cnt = $pdo->prepare("SELECT COUNT(*) $from");
    $cnt->execute($params + [':lang' => $lang]);
    $total = (int) $cnt->fetchColumn();
    $pages = max(1, (int) ceil($total / MPB_PER_PAGE));
    $page = max(1, min($page, $pages));

    // mpb_select_sql() уже містить FROM/JOIN — тож фільтри додаємо як WHERE до нього.
    $sql = mpb_select_sql() . " WHERE $whereSql AND COALESCE(NULLIF(tc.title, ''), ts.title) IS NOT NULL
            ORDER BY $order LIMIT " . MPB_PER_PAGE . ' OFFSET ' . (($page - 1) * MPB_PER_PAGE);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params + [':lang' => $lang]);
    $rows = mp_attach_categories($pdo, $stmt->fetchAll(PDO::FETCH_ASSOC), $lang);

    return ['rows' => $rows, 'total' => $total, 'pages' => $pages, 'page' => $page];
}

/** Категорії дошки з назвами поточною мовою (без лічильників). @return list<array{id:int,slug:string,name:string}> */
function mpb_categories(PDO $pdo, string $lang): array
{
    $stmt = $pdo->prepare(
        "SELECT c.id, c.slug, COALESCE(NULLIF(tl.name, ''), NULLIF(ts.name, ''), c.slug) AS name
         FROM mp_categories c
         LEFT JOIN mp_category_translations tl ON tl.category_id = c.id AND tl.lang = :lang
         LEFT JOIN mp_category_translations ts ON ts.category_id = c.id AND ts.lang = :src
         WHERE c.section = :section AND c.is_active = 1
         ORDER BY c.sort_order, c.id"
    );
    $stmt->execute([':lang' => $lang, ':src' => mp_source_lang(), ':section' => MPB_SECTION]);

    return array_map(
        static fn(array $r): array => ['id' => (int) $r['id'], 'slug' => (string) $r['slug'], 'name' => (string) $r['name']],
        $stmt->fetchAll(PDO::FETCH_ASSOC)
    );
}

/** Оголошення за id з текстами (без контактів) — будь-який статус; видимість перевіряє викликач. */
function mpb_listing(PDO $pdo, int $id, string $lang): ?array
{
    $stmt = $pdo->prepare(mpb_select_sql() . " WHERE l.id = :id AND l.section = 'board'");
    $stmt->execute([':lang' => $lang, ':id' => $id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return null;
    }
    $row = mp_attach_categories($pdo, [$row], $lang)[0];
    $row['photos'] = mpb_photos($pdo, $id);

    return $row;
}

/** Чи публічно видиме оголошення (за даними рядка з mpb_listing()). */
function mpb_row_is_live(array $row): bool
{
    return (int) ($row['is_live'] ?? 0) === 1;   // рахується в SQL (NOW()) — без різниці часових поясів PHP/MySQL
}

/** Інші живі оголошення продавця. @return list<array<string,mixed>> */
function mpb_seller_other(PDO $pdo, int $sellerId, int $exceptId, string $lang, int $limit = 6): array
{
    $stmt = $pdo->prepare(
        mpb_select_sql() . ' WHERE ' . mpb_visible_sql() . ' AND l.seller_id = :sid AND l.id <> :ex
         ORDER BY l.published_at DESC, l.id DESC LIMIT ' . max(1, min(12, $limit))
    );
    $stmt->execute([':lang' => $lang, ':sid' => $sellerId, ':ex' => $exceptId]);

    return mp_attach_categories($pdo, $stmt->fetchAll(PDO::FETCH_ASSOC), $lang);
}

/** Лічильник переглядів: не частіше 1 разу на сесію на оголошення; власник не рахується. */
function mpb_count_view(PDO $pdo, int $id, ?int $sellerUserId): void
{
    if ($sellerUserId !== null && $sellerUserId === auth_user_id()) {
        return;
    }
    if (!empty($_SESSION['mpb_viewed'][$id])) {
        return;
    }
    $_SESSION['mpb_viewed'][$id] = 1;
    $stmt = $pdo->prepare('UPDATE mp_listings SET views_count = views_count + 1 WHERE id = :id');
    $stmt->execute([':id' => $id]);
}

// =========================================================================
// Фото
// =========================================================================

/** @return list<array{id:int,file_name:string,thumb_name:string,sort_order:int}> */
function mpb_photos(PDO $pdo, int $listingId): array
{
    $stmt = $pdo->prepare('SELECT id, file_name, thumb_name, sort_order FROM mp_listing_photos WHERE listing_id = :l ORDER BY sort_order, id');
    $stmt->execute([':l' => $listingId]);

    return array_map(
        static fn(array $r): array => ['id' => (int) $r['id'], 'file_name' => (string) $r['file_name'], 'thumb_name' => (string) $r['thumb_name'], 'sort_order' => (int) $r['sort_order']],
        $stmt->fetchAll(PDO::FETCH_ASSOC)
    );
}

/** Тека фото (поза webroot): створює її за потреби, повертає шлях. */
function mpb_photo_dir(): string
{
    $dir = rtrim((string) mp_config()['photo_dir'], '/\\');
    if (!is_dir($dir) && !mkdir($dir, 0775, true) && !is_dir($dir)) {
        throw new RuntimeException('Cannot create photo dir');
    }

    return $dir;
}

/** Повний шлях до наявного файлу фото за іменем (лише MPB_PHOTO_NAME_RE) або null. */
function mpb_photo_path(string $name): ?string
{
    if (preg_match(MPB_PHOTO_NAME_RE, $name) !== 1) {
        return null;
    }
    $path = rtrim((string) mp_config()['photo_dir'], '/\\') . '/' . $name;

    return is_file($path) ? $path : null;
}

/**
 * Перевірка одного завантаженого фото (без збереження).
 *
 * @return array{tmp:string,mime:string}|string  масив, або ключ помилки (t())
 */
function mpb_inspect_photo(array $file): array|string
{
    $cfg = mp_config();
    $err = (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE);
    if ($err === UPLOAD_ERR_INI_SIZE || $err === UPLOAD_ERR_FORM_SIZE) {
        return 'mpb_err_photo_size';
    }
    if ($err !== UPLOAD_ERR_OK) {
        return 'mpb_err_photo_upload';
    }
    $tmp = (string) ($file['tmp_name'] ?? '');
    if (!is_uploaded_file($tmp)) {
        return 'mpb_err_photo_upload';
    }
    $size = (int) filesize($tmp);
    if ($size <= 0) {
        return 'mpb_err_photo_type';
    }
    if ($size > (int) $cfg['photo_max_bytes']) {
        return 'mpb_err_photo_size';
    }
    $ext = strtolower(pathinfo(mp_clean_filename((string) ($file['name'] ?? '')), PATHINFO_EXTENSION));
    $mime = mp_real_mime($tmp);
    if (!in_array($ext, ['jpg', 'jpeg', 'png', 'webp'], true) || !in_array($mime, ['image/jpeg', 'image/png', 'image/webp'], true)) {
        return 'mpb_err_photo_type';
    }
    $dims = @getimagesize($tmp);
    if ($dims === false || $dims[0] < 1 || $dims[1] < 1 || $dims[0] * $dims[1] > 16_000_000) {
        return 'mpb_err_photo_type';
    }

    return ['tmp' => $tmp, 'mime' => $mime];
}

/** Масштабує GD-зображення так, щоб довша сторона ≤ $maxSide (не збільшує); зберігає альфу. */
function mpb_gd_fit(\GdImage $img, int $maxSide): \GdImage
{
    $w = imagesx($img);
    $h = imagesy($img);
    $long = max($w, $h);
    if ($long <= $maxSide) {
        return $img;
    }
    $ratio = $maxSide / $long;
    $nw = max(1, (int) round($w * $ratio));
    $nh = max(1, (int) round($h * $ratio));
    $dst = imagecreatetruecolor($nw, $nh);
    imagealphablending($dst, false);
    imagesavealpha($dst, true);
    imagefill($dst, 0, 0, imagecolorallocatealpha($dst, 0, 0, 0, 127));
    imagecopyresampled($dst, $img, 0, 0, 0, 0, $nw, $nh, $w, $h);

    return $dst;
}

/** Копія на білому тлі (для JPEG, який не має прозорості). */
function mpb_gd_flatten(\GdImage $img): \GdImage
{
    $w = imagesx($img);
    $h = imagesy($img);
    $dst = imagecreatetruecolor($w, $h);
    imagefill($dst, 0, 0, imagecolorallocate($dst, 255, 255, 255));
    imagecopy($dst, $img, 0, 0, 0, 0, $w, $h);

    return $dst;
}

/**
 * Перекодовує фото через GD (прибирає EXIF та будь-який вбудований код), робить мініатюру,
 * зберігає під випадковими іменами. Формат зберігається (jpg/png/webp); мініатюра — завжди jpg.
 *
 * @return array{file_name:string,thumb_name:string}
 */
function mpb_process_photo(string $tmp, string $mime): array
{
    $cfg = mp_config();
    $dir = mpb_photo_dir();
    $img = match ($mime) {
        'image/jpeg' => @imagecreatefromjpeg($tmp),
        'image/png'  => @imagecreatefrompng($tmp),
        'image/webp' => function_exists('imagecreatefromwebp') ? @imagecreatefromwebp($tmp) : false,
        default      => false,
    };
    if (!$img instanceof \GdImage) {
        throw new RuntimeException('Cannot decode image');
    }
    // Орієнтація з EXIF (сам EXIF після перекодування зникає) — лише для JPEG і якщо є розширення exif.
    if ($mime === 'image/jpeg' && function_exists('exif_read_data')) {
        $exif = @exif_read_data($tmp);
        $rot = match ((int) ($exif['Orientation'] ?? 1)) {
            3 => 180,
            6 => -90,
            8 => 90,
            default => 0,
        };
        if ($rot !== 0) {
            $r = imagerotate($img, $rot, 0);
            if ($r instanceof \GdImage) {
                $img = $r;
            }
        }
    }

    $base = bin2hex(random_bytes(16));
    $ext = $mime === 'image/png' ? 'png' : ($mime === 'image/webp' && function_exists('imagewebp') ? 'webp' : 'jpg');
    $fileName = $base . '.' . $ext;
    $thumbName = $base . '_t.jpg';
    $full = mpb_gd_fit($img, (int) $cfg['photo_max_side']);
    $thumb = mpb_gd_flatten(mpb_gd_fit($img, (int) $cfg['photo_thumb_side']));

    $ok = match ($ext) {
        'png'   => imagepng($full, $dir . '/' . $fileName, 6),
        'webp'  => imagewebp($full, $dir . '/' . $fileName, 82),
        default => imagejpeg(mpb_gd_flatten($full), $dir . '/' . $fileName, 85),
    };
    $ok = $ok && imagejpeg($thumb, $dir . '/' . $thumbName, 82);
    if (!$ok) {
        mpb_delete_photo_files($fileName, $thumbName);
        throw new RuntimeException('Cannot write image');
    }
    @chmod($dir . '/' . $fileName, 0644);
    @chmod($dir . '/' . $thumbName, 0644);

    return ['file_name' => $fileName, 'thumb_name' => $thumbName];
}

function mpb_delete_photo_files(string ...$names): void
{
    $dir = rtrim((string) mp_config()['photo_dir'], '/\\');
    foreach ($names as $n) {
        if (preg_match(MPB_PHOTO_NAME_RE, $n) === 1 && is_file($dir . '/' . $n)) {
            @unlink($dir . '/' . $n);
        }
    }
}

/** Розкладає $_FILES['photos'] у список окремих файлів (без порожніх слотів). @return list<array<string,mixed>> */
function mpb_uploaded_photos(string $field = 'photos'): array
{
    $f = $_FILES[$field] ?? null;
    if (!is_array($f) || !isset($f['name']) || !is_array($f['name'])) {
        return [];
    }
    $out = [];
    foreach (array_keys($f['name']) as $i) {
        if ((int) ($f['error'][$i] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
            continue;
        }
        $out[] = ['name' => $f['name'][$i] ?? '', 'tmp_name' => $f['tmp_name'][$i] ?? '', 'error' => $f['error'][$i] ?? UPLOAD_ERR_NO_FILE, 'size' => $f['size'][$i] ?? 0];
    }

    return $out;
}

// =========================================================================
// Валідація форми
// =========================================================================

/** Контакти з форми → нормалізований масив; помилки (ключі t()) додає в $errors. */
function mpb_normalize_contacts(array $in, array &$errors): array
{
    $name = mb_substr(trim((string) ($in['contact_name'] ?? '')), 0, 100);

    $phone = trim((string) ($in['contact_phone'] ?? ''));
    if ($phone !== '') {
        $digits = preg_replace('/\D+/', '', $phone) ?? '';
        if (preg_match('/^\+?[0-9\s()\-]{7,25}$/', $phone) !== 1 || strlen($digits) < 7 || strlen($digits) > 15) {
            $errors[] = 'mpb_err_phone';
            $phone = '';
        }
    }

    $tg = trim((string) ($in['contact_telegram'] ?? ''));
    if ($tg !== '') {
        $tg = preg_replace('~^(?:https?://)?(?:t\.me/|telegram\.me/)~i', '', $tg) ?? '';
        $tg = ltrim($tg, '@');
        if (preg_match('/^[A-Za-z0-9_]{5,32}$/', $tg) !== 1) {
            $errors[] = 'mpb_err_telegram';
            $tg = '';
        }
    }

    $email = trim((string) ($in['contact_email'] ?? ''));
    if ($email !== '' && (mb_strlen($email) > 190 || filter_var($email, FILTER_VALIDATE_EMAIL) === false)) {
        $errors[] = 'mpb_err_email';
        $email = '';
    }

    if ($phone === '' && $tg === '' && $email === '' && !in_array('mpb_err_phone', $errors, true)
        && !in_array('mpb_err_telegram', $errors, true) && !in_array('mpb_err_email', $errors, true)) {
        $errors[] = 'mpb_err_contact_required';
    }

    return ['name' => $name, 'phone' => mb_substr($phone, 0, 40), 'telegram' => $tg, 'email' => $email];
}

function mpb_count_links(string $text): int
{
    return (int) preg_match_all('~(?:https?://|www\.)\S+~iu', $text);
}

/** Перше знайдене стоп-слово (конфіг) або null. */
function mpb_stop_word(string ...$texts): ?string
{
    $words = mp_config()['stop_words'];
    if (!is_array($words) || $words === []) {
        return null;
    }
    $hay = mb_strtolower(implode("\n", $texts));
    foreach ($words as $w) {
        $w = mb_strtolower(trim((string) $w));
        if ($w !== '' && str_contains($hay, $w)) {
            return $w;
        }
    }

    return null;
}

/** Активні (pending+published) оголошення користувача, не рахуючи $exceptId. */
function mpb_active_count(PDO $pdo, int $userId, int $exceptId = 0): int
{
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.section = 'board' AND l.status IN ('pending', 'published') AND l.id <> :ex"
    );
    $stmt->execute([':u' => $userId, ':ex' => $exceptId]);

    return (int) $stmt->fetchColumn();
}

/** Нових оголошень користувача за останні 24 год. */
function mpb_new_today_count(PDO $pdo, int $userId): int
{
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.section = 'board' AND l.created_at > (NOW() - INTERVAL 1 DAY)"
    );
    $stmt->execute([':u' => $userId]);

    return (int) $stmt->fetchColumn();
}

/**
 * Чи є в продавця інше АКТИВНЕ (draft/pending/published) оголошення з такою самою (нормалізованою) назвою.
 * Заархівовані, відхилені й завершені не рахуються — назву можна використати знову.
 */
function mpb_seller_has_title(PDO $pdo, int $sellerId, string $title, int $exceptId): bool
{
    $norm = mp_norm_title($title);
    if ($norm === '') {
        return false;
    }
    $stmt = $pdo->prepare(
        "SELECT t.title FROM mp_listing_translations t JOIN mp_listings l ON l.id = t.listing_id
         WHERE l.seller_id = :sid AND l.section = 'board' AND l.status IN ('draft', 'pending', 'published') AND l.id <> :ex LIMIT 500"
    );
    $stmt->execute([':sid' => $sellerId, ':ex' => $exceptId]);
    foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $existing) {
        if (mp_norm_title((string) $existing) === $norm) {
            return true;
        }
    }

    return false;
}

// =========================================================================
// Збереження оголошення
// =========================================================================

/**
 * Створює/оновлює оголошення користувача разом із текстами, категоріями та фото — однією транзакцією.
 * Файли фото вже перекодовані й лежать на диску ($newPhotos); при збої в БД вони видаляються.
 *
 * @param array<string,mixed> $d       нормалізовані поля форми
 * @param list<array{file_name:string,thumb_name:string}> $newPhotos
 * @param list<int> $deletePhotoIds    id фото, які треба видалити
 * @param list<int> $photoOrder        бажаний порядок id наявних фото (перше — обкладинка)
 * @return int id оголошення
 */
function mpb_save_listing(PDO $pdo, array $d, ?array $existing, int $userId, int $sellerId, string $lang, array $newPhotos, array $deletePhotoIds, array $photoOrder): int
{
    $isStaff = mpb_is_staff();
    if (!$isStaff && !mp_posting_enabled()) {
        // Найнижчий рівень захисту: навіть якщо якась сторінка забуде перевірку, збереження від не-staff неможливе.
        throw new RuntimeException('Listing submission is closed for regular users');
    }
    $ttl = max(1, (int) mp_config()['listing_ttl_days']);
    $filesToDelete = [];
    // Версія Правил, з якими погодився автор (config 'rules_version'); порожня → NULL.
    $rv = trim((string) mp_config()['rules_version']);
    $rv = $rv !== '' ? mb_substr($rv, 0, 20) : null;

    try {
        $pdo->beginTransaction();

        if ($existing === null) {
            $status = $isStaff ? 'published' : 'pending';
            // Дати — на боці SQL (NOW()), щоб не залежати від часового поясу PHP.
            $modAt = $isStaff ? 'NOW()' : 'NULL';
            $expAt = $isStaff ? "NOW() + INTERVAL $ttl DAY" : 'NULL';
            $ins = $pdo->prepare(
                "INSERT INTO mp_listings
                   (section, seller_id, status, pricing_model, price_type, price_amount, currency, delivery_type, source_lang,
                    is_remote, city, contact_name, contact_phone, contact_telegram, contact_email, rules_accepted_at, rules_version,
                    created_by, moderated_by, moderated_at, published_at, expires_at)
                 VALUES ('board', :sid, :st, 'free', :pt, :pa, :cur, 'contact', :lang,
                    :rem, :city, :cn, :cp, :ct, :ce, NOW(), :rv,
                    :cb, :mb, $modAt, $modAt, $expAt)"
            );
            $ins->execute([
                ':sid' => $sellerId, ':st' => $status, ':pt' => $d['price_type'], ':pa' => $d['price_amount'], ':cur' => $d['currency'],
                ':lang' => $lang, ':rem' => $d['is_remote'] ? 1 : 0, ':city' => $d['city'],
                ':cn' => $d['contact']['name'] ?: null, ':cp' => $d['contact']['phone'] ?: null,
                ':ct' => $d['contact']['telegram'] ?: null, ':ce' => $d['contact']['email'] ?: null,
                ':rv' => $rv,
                ':cb' => $userId,
                ':mb' => $isStaff ? $userId : null,
            ]);
            $id = (int) $pdo->lastInsertId();
            $textLang = $lang;
            mp_log($pdo, $id, $userId, 'created', $isStaff ? 'опубліковано без модерації (employee/admin)' : 'на модерації');
        } else {
            $id = (int) $existing['id'];
            $textLang = (string) $existing['source_lang'];
            // Користувач: будь-яка зміна → знову на модерацію. Employee/admin: лишається/стає опублікованим.
            $status = $isStaff ? 'published' : 'pending';
            $keepExpiry = $isStaff && (string) $existing['status'] === 'published'
                && $existing['expires_at'] !== null && strtotime((string) $existing['expires_at']) > time();
            $modSql = $isStaff ? 'NOW()' : 'moderated_at';
            $pubSql = $isStaff ? 'COALESCE(published_at, NOW())' : 'published_at';
            $expSql = !$isStaff ? 'NULL' : ($keepExpiry ? 'expires_at' : "NOW() + INTERVAL $ttl DAY");
            $upd = $pdo->prepare(
                "UPDATE mp_listings SET status = :st, price_type = :pt, price_amount = :pa, currency = :cur,
                        is_remote = :rem, city = :city, contact_name = :cn, contact_phone = :cp, contact_telegram = :ct,
                        contact_email = :ce, rules_accepted_at = NOW(), rules_version = :rv, reject_reason = NULL,
                        moderated_by = :mb, moderated_at = $modSql, published_at = $pubSql, expires_at = $expSql
                 WHERE id = :id AND section = 'board'"
            );
            $upd->execute([
                ':st' => $status, ':pt' => $d['price_type'], ':pa' => $d['price_amount'], ':cur' => $d['currency'],
                ':rem' => $d['is_remote'] ? 1 : 0, ':city' => $d['city'],
                ':cn' => $d['contact']['name'] ?: null, ':cp' => $d['contact']['phone'] ?: null,
                ':ct' => $d['contact']['telegram'] ?: null, ':ce' => $d['contact']['email'] ?: null,
                ':rv' => $rv,
                ':mb' => $isStaff ? $userId : $existing['moderated_by'],
                ':id' => $id,
            ]);
            mp_log($pdo, $id, $userId, 'edited', $isStaff ? 'employee/admin: без повторної модерації' : 'після редагування — на модерації');
        }

        // Тексти мовою оригіналу
        $tr = $pdo->prepare(
            "INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, is_auto)
             VALUES (:id, :lang, :t, :s, :f, 0)
             ON DUPLICATE KEY UPDATE title = VALUES(title), short_desc = VALUES(short_desc), full_desc = VALUES(full_desc), is_auto = 0"
        );
        $tr->execute([':id' => $id, ':lang' => $textLang, ':t' => $d['title'], ':s' => $d['short_desc'], ':f' => $d['full_desc'] !== '' ? $d['full_desc'] : null]);

        // Категорії: замінюємо набір
        $pdo->prepare('DELETE FROM mp_listing_categories WHERE listing_id = :id')->execute([':id' => $id]);
        $lc = $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:id, :c)');
        foreach ($d['categories'] as $cid) {
            $lc->execute([':id' => $id, ':c' => (int) $cid]);
        }

        // Фото: видалення → порядок → нові в кінець → перенумерація
        $current = $existing === null ? [] : mpb_photos($pdo, $id);
        $byId = [];
        foreach ($current as $p) {
            $byId[$p['id']] = $p;
        }
        foreach ($deletePhotoIds as $pid) {
            if (isset($byId[$pid])) {
                $pdo->prepare('DELETE FROM mp_listing_photos WHERE id = :p AND listing_id = :l')->execute([':p' => $pid, ':l' => $id]);
                $filesToDelete[] = $byId[$pid]['file_name'];
                $filesToDelete[] = $byId[$pid]['thumb_name'];
                unset($byId[$pid]);
            }
        }
        $ordered = [];
        foreach ($photoOrder as $pid) {
            if (isset($byId[$pid])) {
                $ordered[] = $pid;
                unset($byId[$pid]);
            }
        }
        foreach (array_keys($byId) as $pid) {   // ті, що не потрапили в порядок — у прежньому порядку
            $ordered[] = $pid;
        }
        $upSort = $pdo->prepare('UPDATE mp_listing_photos SET sort_order = :s WHERE id = :p AND listing_id = :l');
        $n = 0;
        foreach ($ordered as $pid) {
            $upSort->execute([':s' => ++$n, ':p' => $pid, ':l' => $id]);
        }
        $insP = $pdo->prepare('INSERT INTO mp_listing_photos (listing_id, file_name, thumb_name, sort_order) VALUES (:l, :f, :t, :s)');
        foreach ($newPhotos as $ph) {
            $insP->execute([':l' => $id, ':f' => $ph['file_name'], ':t' => $ph['thumb_name'], ':s' => ++$n]);
        }

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        foreach ($newPhotos as $ph) {
            mpb_delete_photo_files($ph['file_name'], $ph['thumb_name']);
        }
        throw $e;
    }
    // Файли видалених фото прибираємо вже після коміту.
    mpb_delete_photo_files(...$filesToDelete);

    return $id;
}

// =========================================================================
// Дії власника: продовжити / архівувати
// =========================================================================

/** @return string 'ok' або ключ помилки (t()) */
function mpb_extend(PDO $pdo, array $own, int $userId): string
{
    if (!mpb_posting_open()) {
        return 'mpb_posting_closed';
    }
    $ttl = max(1, (int) mp_config()['listing_ttl_days']);
    $id = (int) $own['id'];
    $status = (string) $own['status'];
    // «Опубліковано», але термін уже минув (cron ще не встиг) — те саме, що expired.
    if ($status === 'published' && (int) ($own['elapsed'] ?? 0) === 1) {
        $status = 'expired';
    }
    if ($status === 'expired') {
        if (!mpb_is_staff() && mpb_active_count($pdo, $userId, $id) >= (int) mp_config()['max_active_per_user']) {
            return 'mpb_err_limit_active';
        }
        $stmt = $pdo->prepare(
            "UPDATE mp_listings SET status = 'published', expires_at = NOW() + INTERVAL $ttl DAY
             WHERE id = :id AND section = 'board' AND status IN ('expired', 'published')"
        );
        $stmt->execute([':id' => $id]);
    } elseif ($status === 'published') {
        // Не більше двох термінів уперед — щоб не «накопичувати» безкінечно.
        $stmt = $pdo->prepare(
            "UPDATE mp_listings SET expires_at = expires_at + INTERVAL $ttl DAY
             WHERE id = :id AND section = 'board' AND status = 'published'
               AND expires_at IS NOT NULL AND expires_at + INTERVAL $ttl DAY <= NOW() + INTERVAL " . ($ttl * 2) . ' DAY'
        );
        $stmt->execute([':id' => $id]);
        if ($stmt->rowCount() === 0) {
            return 'mpb_err_extend_early';
        }
    } else {
        return 'mpb_err_extend_status';
    }
    mp_log($pdo, $id, $userId, 'extended', '+' . $ttl . ' днів');

    return 'ok';
}

function mpb_archive(PDO $pdo, array $own, int $userId): bool
{
    $stmt = $pdo->prepare(
        "UPDATE mp_listings SET status = 'archived'
         WHERE id = :id AND section = 'board' AND status IN ('pending', 'published', 'expired', 'rejected')"
    );
    $stmt->execute([':id' => (int) $own['id']]);
    if ($stmt->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, (int) $own['id'], $userId, 'archived');

    return true;
}

// =========================================================================
// Модерація
// =========================================================================

/** pending → published (+термін). false, якщо оголошення вже не pending (перегонів немає: умова в UPDATE). */
function mpb_approve(PDO $pdo, int $id, int $actorId): bool
{
    $ttl = max(1, (int) mp_config()['listing_ttl_days']);
    $stmt = $pdo->prepare(
        "UPDATE mp_listings SET status = 'published', published_at = NOW(), expires_at = NOW() + INTERVAL $ttl DAY,
                moderated_by = :a, moderated_at = NOW(), reject_reason = NULL
         WHERE id = :id AND section = 'board' AND status = 'pending'"
    );
    $stmt->execute([':a' => $actorId, ':id' => $id]);
    if ($stmt->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'approved', 'опубліковано на ' . $ttl . ' днів');

    return true;
}

/** pending або published (зі скаргами) → rejected із причиною. */
function mpb_reject(PDO $pdo, int $id, int $actorId, string $reason): bool
{
    $reason = mb_substr(trim($reason), 0, 500);
    if ($reason === '') {
        return false;
    }
    $stmt = $pdo->prepare(
        "UPDATE mp_listings SET status = 'rejected', reject_reason = :r, moderated_by = :a, moderated_at = NOW()
         WHERE id = :id AND section = 'board' AND status IN ('pending', 'published')"
    );
    $stmt->execute([':r' => $reason, ':a' => $actorId, ':id' => $id]);
    if ($stmt->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'rejected', $reason);

    return true;
}

/** Скарги розглянуто, оголошення лишається як є: скидає лічильник (moderated_at = зараз). */
function mpb_dismiss_reports(PDO $pdo, int $id, int $actorId): bool
{
    $stmt = $pdo->prepare(
        "UPDATE mp_listings SET moderated_by = :a, moderated_at = NOW()
         WHERE id = :id AND section = 'board' AND status IN ('pending', 'published')"
    );
    $stmt->execute([':a' => $actorId, ':id' => $id]);
    if ($stmt->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'reports_dismissed');

    return true;
}

/** published з минулим expires_at → expired (+запис у журнал). Повертає кількість. */
function mpb_expire_due(PDO $pdo): int
{
    $ids = $pdo->query(
        "SELECT id FROM mp_listings WHERE section = 'board' AND status = 'published' AND expires_at IS NOT NULL AND expires_at <= NOW()"
    )->fetchAll(PDO::FETCH_COLUMN);
    $n = 0;
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'expired'
         WHERE id = :id AND section = 'board' AND status = 'published' AND expires_at IS NOT NULL AND expires_at <= NOW()"
    );
    foreach ($ids as $id) {
        $upd->execute([':id' => (int) $id]);
        if ($upd->rowCount() > 0) {
            mp_log($pdo, (int) $id, null, 'expired', 'термін минув');
            $n++;
        }
    }

    return $n;
}

// =========================================================================
// Скарги, вибране, контакти
// =========================================================================

/** @return string ok | duplicate | own | invalid | notfound | rate */
function mpb_report(PDO $pdo, int $listingId, int $userId, string $reason, string $note): string
{
    if (!in_array($reason, MPB_REPORT_REASONS, true)) {
        return 'invalid';
    }
    $stmt = $pdo->prepare(
        'SELECT l.id, s.user_id AS owner FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.id = :id AND ' . mpb_visible_sql()
    );
    $stmt->execute([':id' => $listingId]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return 'notfound';
    }
    if ($row['owner'] !== null && (int) $row['owner'] === $userId) {
        return 'own';
    }
    if (!mpb_is_staff() && !mpb_ip_hit($pdo, 'report', (int) mp_config()['ip_limit_report'])) {
        return 'rate';
    }
    try {
        $ins = $pdo->prepare('INSERT INTO mp_reports (listing_id, reporter_id, reason, note) VALUES (:l, :u, :r, :n)');
        $ins->execute([':l' => $listingId, ':u' => $userId, ':r' => $reason, ':n' => $note !== '' ? mb_substr($note, 0, 500) : null]);
    } catch (PDOException $e) {
        if ((int) ($e->errorInfo[1] ?? 0) === 1062) {
            return 'duplicate';
        }
        throw $e;
    }

    // Для автозняття рахуються лише скарги від staff і користувачів, чий email підтверджено давніше за
    // report_min_verified_hours (свіжі акаунти не можуть «знести» оголошення хвилею скарг).
    $hours = max(0, (int) mp_config()['report_min_verified_hours']);
    $cnt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_reports r
         JOIN mp_listings l ON l.id = r.listing_id
         JOIN users u ON u.id = r.reporter_id
         WHERE l.id = :id AND r.created_at > COALESCE(l.moderated_at, '1970-01-01 00:00:00')
           AND (u.role IN ('employee', 'admin') OR EXISTS (
                 SELECT 1 FROM mp_email_verifications v
                 WHERE v.user_id = r.reporter_id AND v.email = u.email AND v.verified_at IS NOT NULL
                   AND v.verified_at < (NOW() - INTERVAL $hours HOUR)))"
    );
    $cnt->execute([':id' => $listingId]);
    $n = (int) $cnt->fetchColumn();
    if ($n >= (int) mp_config()['reports_threshold']) {
        $upd = $pdo->prepare("UPDATE mp_listings SET status = 'pending' WHERE id = :id AND section = 'board' AND status = 'published'");
        $upd->execute([':id' => $listingId]);
        if ($upd->rowCount() > 0) {
            mp_log($pdo, $listingId, null, 'auto_pending', 'скарг: ' . $n . ' — повернуто на модерацію');
        }
    }

    return 'ok';
}

function mpb_is_favorite(PDO $pdo, int $userId, int $listingId): bool
{
    $stmt = $pdo->prepare('SELECT 1 FROM mp_favorites WHERE user_id = :u AND listing_id = :l');
    $stmt->execute([':u' => $userId, ':l' => $listingId]);

    return $stmt->fetchColumn() !== false;
}

/** Перемикає вибране; повертає новий стан (true = у вибраному). Додати можна лише видиме оголошення. */
function mpb_toggle_favorite(PDO $pdo, int $userId, int $listingId): ?bool
{
    if (mpb_is_favorite($pdo, $userId, $listingId)) {
        $pdo->prepare('DELETE FROM mp_favorites WHERE user_id = :u AND listing_id = :l')->execute([':u' => $userId, ':l' => $listingId]);

        return false;
    }
    $chk = $pdo->prepare('SELECT 1 FROM mp_listings l WHERE l.id = :id AND ' . mpb_visible_sql());
    $chk->execute([':id' => $listingId]);
    if ($chk->fetchColumn() === false) {
        return null;
    }
    $pdo->prepare('INSERT IGNORE INTO mp_favorites (user_id, listing_id) VALUES (:u, :l)')->execute([':u' => $userId, ':l' => $listingId]);

    return true;
}

/**
 * Контакти оголошення (окремий запит — у публічні SELECT вони не входять).
 *
 * @return list<array{type:string,label:string,value:string,href:?string}>
 */
function mpb_contacts(PDO $pdo, int $listingId): array
{
    $stmt = $pdo->prepare('SELECT contact_name, contact_phone, contact_telegram, contact_email FROM mp_listings WHERE id = :id AND section = \'board\'');
    $stmt->execute([':id' => $listingId]);
    $r = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($r === false) {
        return [];
    }
    $out = [];
    if (!empty($r['contact_name'])) {
        $out[] = ['type' => 'name', 'label' => t('mpb_contact_name'), 'value' => (string) $r['contact_name'], 'href' => null];
    }
    if (!empty($r['contact_phone'])) {
        $out[] = ['type' => 'phone', 'label' => t('mpb_contact_phone'), 'value' => (string) $r['contact_phone'], 'href' => 'tel:' . preg_replace('/[^\d+]/', '', (string) $r['contact_phone'])];
    }
    if (!empty($r['contact_telegram'])) {
        $out[] = ['type' => 'telegram', 'label' => 'Telegram', 'value' => '@' . $r['contact_telegram'], 'href' => 'https://t.me/' . rawurlencode((string) $r['contact_telegram'])];
    }
    if (!empty($r['contact_email'])) {
        $out[] = ['type' => 'email', 'label' => 'Email', 'value' => (string) $r['contact_email'], 'href' => 'mailto:' . $r['contact_email']];
    }

    return $out;
}

/**
 * Розкриття контактів. Гість сюди не доходить (перевіряє mp-contact.php).
 * Власник і employee/admin бачать без обліку; решта — з лімітом за добу.
 * Повторний показ того самого оголошення тому ж користувачу за добу ліміт не з'їдає.
 *
 * @return array{status:string,contacts:list<array<string,mixed>>}  status: ok | notfound | limit | rate
 */
function mpb_reveal(PDO $pdo, int $listingId, int $userId): array
{
    $stmt = $pdo->prepare(
        "SELECT l.id, (l.status = 'published' AND l.expires_at > NOW()) AS live, s.user_id AS owner
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE l.id = :id AND l.section = 'board'"
    );
    $stmt->execute([':id' => $listingId]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return ['status' => 'notfound', 'contacts' => []];
    }
    $isOwner = $row['owner'] !== null && (int) $row['owner'] === $userId;
    if ($isOwner || mpb_is_staff()) {
        return ['status' => 'ok', 'contacts' => mpb_contacts($pdo, $listingId)];
    }
    if ((int) $row['live'] !== 1) {
        return ['status' => 'notfound', 'contacts' => []];
    }

    // «Перевірка ліміту + запис» — під блокуванням користувача, щоб паралельні запити не обходили ліміт.
    $lock = 'mp_reveal_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return ['status' => 'limit', 'contacts' => []];
    }
    try {
        $seen = $pdo->prepare('SELECT 1 FROM mp_contact_reveals WHERE listing_id = :l AND user_id = :u AND created_at > (NOW() - INTERVAL 1 DAY) LIMIT 1');
        $seen->execute([':l' => $listingId, ':u' => $userId]);
        if ($seen->fetchColumn() === false) {
            $cnt = $pdo->prepare('SELECT COUNT(*) FROM mp_contact_reveals WHERE user_id = :u AND created_at > (NOW() - INTERVAL 1 DAY)');
            $cnt->execute([':u' => $userId]);
            if ((int) $cnt->fetchColumn() >= (int) mp_config()['reveals_per_day']) {
                return ['status' => 'limit', 'contacts' => []];
            }
            if (!mpb_ip_hit($pdo, 'reveal', (int) mp_config()['ip_limit_reveal'])) {
                return ['status' => 'rate', 'contacts' => []];
            }
            $pdo->prepare('INSERT INTO mp_contact_reveals (listing_id, user_id) VALUES (:l, :u)')->execute([':l' => $listingId, ':u' => $userId]);
        }
    } finally {
        mpb_unlock($pdo, $lock);
    }

    return ['status' => 'ok', 'contacts' => mpb_contacts($pdo, $listingId)];
}

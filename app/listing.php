<?php

declare(strict_types=1);

/**
 * AI LAB HUB — оголошення компаній: вакансії, курси, послуги у сфері AI (блок M1). Хелпери.
 *
 * Рядки mp_listings з section = 'job' | 'course' | 'service' (міграція
 * database/migration-2026-10-19-marketplace-listings.sql). Спільне з дошкою оголошень — продавці
 * (mp_sellers), тексти (mp_listing_translations), скарги, журнал модерації, IP-ліміти, підтвердження email.
 *
 * Відповідність статусів завдання: approved = 'published', removed = 'archived'.
 * Публічно видно лише status='published' І expires_at > NOW() (не залежить від cron).
 * Текст оголошення — лише простий текст (теги прибираються); посилання — лише https і лише через
 * listing-go.php (облік переходів). Персональних даних відвідувачів статистика не зберігає.
 *
 * Підключати після app/auth.php і app/translations.php:
 *   require_once __DIR__ . '/../app/listing.php';
 */

require_once __DIR__ . '/marketplace-email.php';   // підключає marketplace-board.php і marketplace.php
require_once __DIR__ . '/site-settings.php';
require_once __DIR__ . '/listing-i18n.php';

const LST_TYPES = ['job', 'course', 'service'];
const LST_TITLE_MAX = 120;
const LST_SHORT_MAX = 300;
const LST_DESC_MAX = 3000;
const LST_COMPANY_MAX = 150;
const LST_MAX_PENDING = 3;          // оголошень на модерації одночасно від одного користувача
const LST_MIN_FILL_SEC = 5;         // мінімальний час заповнення форми
const LST_PER_PAGE = 12;
const LST_EXTEND_WINDOW_DAYS = 7;   // продовжити можна, коли до кінця терміну лишилося ≤ N днів або термін минув
const LST_EXPIRY_NOTICE_DAYS = 3;   // лист «скоро спливає термін» — за N днів
const LST_REPORT_AFTER_DAYS = 30;   // звіт власнику — через N днів після публікації
const LST_LANGS = ['uk', 'en', 'other'];
const LST_CURRENCIES = ['USD', 'EUR', 'UAH', 'GBP', 'PLN'];

/** Специфічні поля за типами: ключ → допустимі значення (списки) або тип ('int', 'date', 'text:N', 'currency'). */
const LST_DETAILS = [
    'job' => [
        'employment' => ['full_time', 'part_time', 'contract', 'internship', 'temporary'],
        'level' => ['junior', 'middle', 'senior', 'lead', 'any'],
        'salary_min' => 'int',
        'salary_max' => 'int',
        'salary_currency' => 'currency',
        'salary_period' => ['MONTH', 'YEAR', 'HOUR'],
        'city' => 'text:120',
        'apply_until' => 'date',
    ],
    'course' => [
        'format' => ['online', 'offline', 'hybrid'],
        'level' => ['beginner', 'intermediate', 'advanced', 'any'],
        'duration' => 'text:60',
        'is_free' => ['0', '1'],
        'price' => 'int',
        'currency' => 'currency',
        'start_date' => 'date',
        'city' => 'text:120',
    ],
    'service' => [
        'service_type' => ['consulting', 'development', 'automation', 'training', 'content', 'data', 'other'],
        'price_from' => 'int',
        'currency' => 'currency',
        'delivery_time' => 'text:60',
    ],
];

/** Країни для форми й фільтра (ISO 3166-1 alpha-2) → [uk, en]. Невеликий список; 'XX' — «міжнародно / не прив'язано». */
const LST_COUNTRIES = [
    'UA' => ['Україна', 'Ukraine'], 'PL' => ['Польща', 'Poland'], 'DE' => ['Німеччина', 'Germany'],
    'GB' => ['Велика Британія', 'United Kingdom'], 'US' => ['США', 'United States'], 'CA' => ['Канада', 'Canada'],
    'NL' => ['Нідерланди', 'Netherlands'], 'FR' => ['Франція', 'France'], 'ES' => ['Іспанія', 'Spain'],
    'IT' => ['Італія', 'Italy'], 'PT' => ['Португалія', 'Portugal'], 'IE' => ['Ірландія', 'Ireland'],
    'CZ' => ['Чехія', 'Czechia'], 'SK' => ['Словаччина', 'Slovakia'], 'RO' => ['Румунія', 'Romania'],
    'LT' => ['Литва', 'Lithuania'], 'LV' => ['Латвія', 'Latvia'], 'EE' => ['Естонія', 'Estonia'],
    'SE' => ['Швеція', 'Sweden'], 'FI' => ['Фінляндія', 'Finland'], 'DK' => ['Данія', 'Denmark'],
    'NO' => ['Норвегія', 'Norway'], 'CH' => ['Швейцарія', 'Switzerland'], 'AT' => ['Австрія', 'Austria'],
    'BE' => ['Бельгія', 'Belgium'], 'IL' => ['Ізраїль', 'Israel'], 'AE' => ['ОАЕ', 'United Arab Emirates'],
    'IN' => ['Індія', 'India'], 'SG' => ['Сінгапур', 'Singapore'], 'JP' => ['Японія', 'Japan'],
    'AU' => ['Австралія', 'Australia'], 'XX' => ['Міжнародно / без прив\'язки', 'International / any'],
];

/** Шаблони причин відхилення (ключі lst_tr('rej_*')). */
const LST_REJECT_TEMPLATES = ['prohibited', 'misleading', 'not_ai', 'broken_link', 'incomplete', 'duplicate', 'unverified', 'other'];

/** Безкоштовні поштові сервіси: збіг домену з ними — не підтвердження компанії. */
const LST_FREE_MAIL = ['gmail.com', 'googlemail.com', 'yahoo.com', 'outlook.com', 'hotmail.com', 'live.com', 'icloud.com', 'me.com',
    'proton.me', 'protonmail.com', 'ukr.net', 'i.ua', 'meta.ua', 'gmx.com', 'gmx.de', 'mail.com', 'aol.com', 'yandex.ru', 'mail.ru', 'zoho.com'];

/**
 * Слова-сигнали заборонених категорій (лише СИГНАЛ модератору, не автоматична відмова):
 * оплата за подачу заявки, MLM, піраміди, «швидкі гроші», криптосхеми, дорослий контент, гарантії результату.
 */
const LST_RISK_WORDS = [
    'mlm', 'multi-level', 'network marketing', 'мережевий маркетинг', 'багаторівнев', 'піраміда', 'pyramid',
    'швидкі гроші', 'easy money', 'fast money', 'пасивний дохід', 'passive income', 'гарантований дохід',
    'guaranteed income', 'guaranteed result', 'гарантуємо результат', '100% гарант', 'заробіток від',
    'crypto signal', 'крипто-сигнал', 'forex', 'форекс', 'airdrop', 'casino', 'казино', 'ставки', 'betting',
    'adult', '18+', 'onlyfans', 'оплата за співбесіду', 'внесок за навчання перед', 'application fee',
    'registration fee', 'pay to apply', 'reshipping', 'переказ коштів',
];

// =========================================================================
// Налаштування й довідники
// =========================================================================

/** @return array{free_until:string,days:int,review_hours:int} */
function lst_settings(PDO $pdo): array
{
    $free = trim(site_setting($pdo, 'marketplace_free_until', ''));
    $d = DateTime::createFromFormat('!Y-m-d', $free);
    if ($d === false || $d->format('Y-m-d') !== $free) {
        $free = '';
    }

    return [
        'free_until' => $free,
        'days' => max(1, min(365, (int) site_setting($pdo, 'marketplace_listing_days', '60'))),
        'review_hours' => max(1, min(720, (int) site_setting($pdo, 'marketplace_review_hours', '48'))),
    ];
}

/** Дата у форматі мови інтерфейсу (дд.мм.рррр для uk, YYYY-MM-DD → «Oct 19, 2026» для en). */
function lst_date(?string $value): string
{
    if ($value === null || $value === '') {
        return '';
    }
    $ts = strtotime($value);
    if ($ts === false) {
        return '';
    }

    return lst_lang() === 'en' ? date('M j, Y', $ts) : date('d.m.Y', $ts);
}

/** «Безкоштовне розміщення до {дата}» або '' (дату не задано чи вона минула). */
function lst_free_label(PDO $pdo): string
{
    $free = lst_settings($pdo)['free_until'];
    if ($free === '' || $free < date('Y-m-d')) {
        return '';
    }

    return lst_tr('free_until', lst_date($free));
}

function lst_type_valid(string $type): bool
{
    return in_array($type, LST_TYPES, true);
}

function lst_country_name(?string $code): string
{
    $code = strtoupper((string) $code);
    if (!isset(LST_COUNTRIES[$code])) {
        return '';
    }

    return LST_COUNTRIES[$code][lst_lang() === 'en' ? 1 : 0];
}

/** Теги «AI-спрямування» з назвами мовою інтерфейсу. @return list<array{id:int,slug:string,name:string}> */
function lst_focus_tags(PDO $pdo): array
{
    $lang = lst_lang();
    $stmt = $pdo->prepare(
        "SELECT c.id, c.slug, COALESCE(NULLIF(tl.name, ''), NULLIF(ts.name, ''), c.slug) AS name
         FROM mp_categories c
         LEFT JOIN mp_category_translations tl ON tl.category_id = c.id AND tl.lang = :lang
         LEFT JOIN mp_category_translations ts ON ts.category_id = c.id AND ts.lang = 'uk'
         WHERE c.section = 'focus' AND c.is_active = 1 ORDER BY c.sort_order, c.id"
    );
    $stmt->execute([':lang' => $lang]);

    return array_map(
        static fn(array $r): array => ['id' => (int) $r['id'], 'slug' => (string) $r['slug'], 'name' => (string) $r['name']],
        $stmt->fetchAll(PDO::FETCH_ASSOC)
    );
}

/** Адреса сторінки оголошення (відносна). */
function lst_url(array $row): string
{
    $slug = (string) ($row['slug'] ?? '');

    return 'listing.php?id=' . (int) $row['id'] . ($slug !== '' ? '&s=' . rawurlencode($slug) : '');
}

/** Транслітерований slug (лише для читабельності адреси; ідентифікатор — id). */
function lst_slug(string $title): string
{
    $map = ['а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'h', 'ґ' => 'g', 'д' => 'd', 'е' => 'e', 'є' => 'ie', 'ж' => 'zh', 'з' => 'z',
        'и' => 'y', 'і' => 'i', 'ї' => 'i', 'й' => 'i', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p',
        'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'kh', 'ц' => 'ts', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'shch',
        'ь' => '', 'ю' => 'iu', 'я' => 'ia', 'ё' => 'e', 'ы' => 'y', 'э' => 'e', 'ъ' => ''];
    $s = strtr(mb_strtolower($title), $map);
    $s = preg_replace('~[^a-z0-9]+~', '-', $s) ?? '';
    $s = trim(substr($s, 0, 120), '-');

    return $s !== '' ? $s : 'listing';
}

// =========================================================================
// Вибірки
// =========================================================================

/** Умова публічної видимості (alias l). */
function lst_visible_sql(): string
{
    return "l.section IN ('job', 'course', 'service') AND l.status = 'published' AND l.expires_at > NOW()";
}

/** SELECT з текстами поточною мовою (запасний варіант — мова оригіналу). */
function lst_select_sql(): string
{
    return "SELECT l.id, l.section, l.status, l.seller_id, l.company_name, l.country, l.offer_lang, l.is_remote, l.details, l.slug,
                   l.delivery_url, l.free_until, l.published_at, l.expires_at, l.created_at, l.updated_at, l.source_lang,
                   l.reject_reason, l.link_check_status, l.link_check_json, l.link_checked_at, l.moderated_at,
                   s.user_id AS seller_user_id,
                   COALESCE(NULLIF(tc.title, ''), ts.title)           AS title,
                   COALESCE(NULLIF(tc.short_desc, ''), ts.short_desc) AS short_desc,
                   COALESCE(NULLIF(tc.full_desc, ''), ts.full_desc)   AS full_desc,
                   IF(tc.title IS NULL OR tc.title = '', l.source_lang, tc.lang) AS text_lang,
                   IF(tc.title IS NULL OR tc.title = '', 0, tc.is_auto)          AS text_is_auto,
                   (l.status = 'published' AND l.expires_at > NOW()) AS is_live
            FROM mp_listings l
            LEFT JOIN mp_sellers s ON s.id = l.seller_id
            LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
            LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang";
}

/** details (JSON) → масив; некоректне → []. */
function lst_details(array $row): array
{
    $d = json_decode((string) ($row['details'] ?? ''), true);

    return is_array($d) ? $d : [];
}

/** Додає 'detail' (масив) і категорії-теги до рядків. */
function lst_hydrate(PDO $pdo, array $rows, string $lang): array
{
    foreach ($rows as &$r) {
        $r['detail'] = lst_details($r);
    }
    unset($r);

    return mp_attach_categories($pdo, mp_auto_translate($pdo, $rows, $lang, ['title', 'short_desc', 'full_desc']), $lang);
}

/**
 * Публічний список одного типу. Фільтри: q, lang (uk|en|other), country, remote (bool), focus (id тегу),
 * для курсів — price ('free' | 'paid') і max (макс. ціна).
 *
 * @return array{rows:list<array<string,mixed>>,total:int,pages:int,page:int}
 */
function lst_search(PDO $pdo, string $lang, string $type, array $f, int $page): array
{
    $where = [lst_visible_sql(), 'l.section = :type'];
    $params = [':type' => $type];
    if (in_array((string) ($f['lang'] ?? ''), LST_LANGS, true)) {
        $where[] = 'l.offer_lang = :olang';
        $params[':olang'] = (string) $f['lang'];
    }
    $country = strtoupper((string) ($f['country'] ?? ''));
    if (isset(LST_COUNTRIES[$country])) {
        $where[] = 'l.country = :country';
        $params[':country'] = $country;
    }
    if (!empty($f['remote'])) {
        $where[] = 'l.is_remote = 1';
    }
    $focus = (int) ($f['focus'] ?? 0);
    if ($focus > 0) {
        $where[] = 'EXISTS (SELECT 1 FROM mp_listing_categories x WHERE x.listing_id = l.id AND x.category_id = :focus)';
        $params[':focus'] = $focus;
    }
    if ($type === 'course') {
        // Ціна курсу — у details (завжди валідний JSON від json_encode); JSON_EXTRACT є в MySQL 5.7+ / MariaDB 10.2+.
        $price = (string) ($f['price'] ?? '');
        if ($price === 'free') {
            $where[] = "JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.is_free')) = '1'";
        } elseif ($price === 'paid') {
            $where[] = "COALESCE(JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.is_free')), '0') <> '1'";
        }
        if (($f['max'] ?? null) !== null) {
            $where[] = "(JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.is_free')) = '1' OR CAST(JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.price')) AS UNSIGNED) <= :pmax)";
            $params[':pmax'] = (int) $f['max'];
        }
    }
    $q = trim((string) ($f['q'] ?? ''));
    if ($q !== '') {
        $where[] = "(tc.title LIKE :q1 ESCAPE '\\\\' OR ts.title LIKE :q2 ESCAPE '\\\\' OR l.company_name LIKE :q3 ESCAPE '\\\\')";
        $like = '%' . addcslashes($q, '%_\\') . '%';
        $params[':q1'] = $like;
        $params[':q2'] = $like;
        $params[':q3'] = $like;
    }
    $whereSql = implode(' AND ', $where) . " AND COALESCE(NULLIF(tc.title, ''), ts.title) IS NOT NULL";
    $cnt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l
         LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
         LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
         WHERE $whereSql"
    );
    $cnt->execute($params + [':lang' => $lang]);
    $total = (int) $cnt->fetchColumn();
    $pages = max(1, (int) ceil($total / LST_PER_PAGE));
    $page = max(1, min($page, $pages));
    $stmt = $pdo->prepare(lst_select_sql() . " WHERE $whereSql ORDER BY l.published_at DESC, l.id DESC LIMIT " . LST_PER_PAGE . ' OFFSET ' . (($page - 1) * LST_PER_PAGE));
    $stmt->execute($params + [':lang' => $lang]);

    return ['rows' => lst_hydrate($pdo, $stmt->fetchAll(PDO::FETCH_ASSOC), $lang), 'total' => $total, 'pages' => $pages, 'page' => $page];
}

/** Оголошення за id (будь-який статус) або null; видимість перевіряє викликач. */
function lst_listing(PDO $pdo, int $id, string $lang): ?array
{
    $stmt = $pdo->prepare(lst_select_sql() . " WHERE l.id = :id AND l.section IN ('job', 'course', 'service')");
    $stmt->execute([':lang' => $lang, ':id' => $id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    return $row === false ? null : lst_hydrate($pdo, [$row], $lang)[0];
}

/** Власне оголошення користувача (рядок mp_listings + elapsed) або null. */
function lst_own(PDO $pdo, int $id, int $userId): ?array
{
    $stmt = $pdo->prepare(
        "SELECT l.*, (l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.id = :id AND l.section IN ('job', 'course', 'service') AND s.user_id = :u"
    );
    $stmt->execute([':id' => $id, ':u' => $userId]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    return $row === false ? null : $row;
}

/** Усі оголошення користувача (для кабінету) з текстами мовою оригіналу. @return list<array<string,mixed>> */
function lst_user_listings(PDO $pdo, int $userId): array
{
    $stmt = $pdo->prepare(
        "SELECT l.id, l.section, l.status, l.slug, l.company_name, l.published_at, l.expires_at, l.created_at, l.reject_reason,
                (l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed, t.title
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE s.user_id = :u AND l.section IN ('job', 'course', 'service')
         ORDER BY FIELD(l.status, 'pending', 'published', 'rejected', 'expired', 'draft', 'archived'), l.id DESC LIMIT 200"
    );
    $stmt->execute([':u' => $userId]);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// =========================================================================
// Валідація форми
// =========================================================================

/** Лише https-адреса без логіна/пароля, з хостом, ≤ 500 символів. */
function lst_url_valid(string $url): bool
{
    if ($url === '' || mb_strlen($url) > 500 || preg_match('/[\x00-\x20\x7F]/', $url) === 1) {
        return false;
    }
    $p = parse_url($url);

    return is_array($p) && strtolower((string) ($p['scheme'] ?? '')) === 'https' && !empty($p['host'])
        && !isset($p['user']) && !isset($p['pass']) && str_contains((string) $p['host'], '.');
}

/** Простий текст: без тегів і керівних символів (крім переносів рядка). */
function lst_plain(string $text): string
{
    $text = strip_tags($text);
    $text = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', '', $text) ?? '';
    $text = str_replace("\r\n", "\n", $text);

    return trim(preg_replace("/\n{3,}/", "\n\n", $text) ?? '');
}

/**
 * Специфічні поля типу з POST ($in['d'][...]) → нормалізований масив (лише заповнені). Помилки → $errors (ключі lst_tr).
 *
 * @return array<string,string|int>
 */
function lst_details_normalize(string $type, array $in, array &$errors): array
{
    $out = [];
    foreach (LST_DETAILS[$type] ?? [] as $key => $rule) {
        $raw = is_string($in[$key] ?? null) ? trim((string) $in[$key]) : '';
        if ($raw === '') {
            continue;
        }
        if (is_array($rule)) {
            if (in_array($raw, $rule, true)) {
                $out[$key] = $raw;
            }
        } elseif ($rule === 'int') {
            $num = str_replace([' ', "\u{00A0}", ','], '', $raw);
            if (preg_match('/^\d{1,9}$/', $num) === 1) {
                $out[$key] = (int) $num;
            } else {
                $errors[] = 'err_number';
            }
        } elseif ($rule === 'currency') {
            if (in_array($raw, LST_CURRENCIES, true)) {
                $out[$key] = $raw;
            }
        } elseif ($rule === 'date') {
            $d = DateTime::createFromFormat('!Y-m-d', $raw);
            if ($d !== false && $d->format('Y-m-d') === $raw) {
                $out[$key] = $raw;
            } else {
                $errors[] = 'err_date';
            }
        } elseif (str_starts_with($rule, 'text:')) {
            $out[$key] = mb_substr(lst_plain($raw), 0, (int) substr($rule, 5));
        }
    }
    // Узгодженість: зарплата min ≤ max; для зарплати/ціни потрібна валюта.
    if ($type === 'job') {
        if (isset($out['salary_min'], $out['salary_max']) && $out['salary_min'] > $out['salary_max']) {
            $errors[] = 'err_salary_range';
        }
        if ((isset($out['salary_min']) || isset($out['salary_max'])) && !isset($out['salary_currency'])) {
            $out['salary_currency'] = 'USD';
        }
        if ((isset($out['salary_min']) || isset($out['salary_max'])) && !isset($out['salary_period'])) {
            $out['salary_period'] = 'MONTH';
        }
        if (isset($out['apply_until']) && $out['apply_until'] < date('Y-m-d')) {
            $errors[] = 'err_apply_past';
        }
    } elseif ($type === 'course') {
        if (($out['is_free'] ?? '0') === '1') {
            unset($out['price'], $out['currency']);
        } elseif (isset($out['price']) && !isset($out['currency'])) {
            $out['currency'] = 'USD';
        }
    } elseif ($type === 'service' && isset($out['price_from']) && !isset($out['currency'])) {
        $out['currency'] = 'USD';
    }

    return $out;
}

/** Хост без www. */
function lst_host(string $url): string
{
    $h = strtolower((string) parse_url($url, PHP_URL_HOST));

    return str_starts_with($h, 'www.') ? substr($h, 4) : $h;
}

/** Чи збігається домен пошти з доменом сайту (host закінчується доменом пошти або навпаки). */
function lst_domain_matches(string $email, string $url): bool
{
    $md = strtolower(substr((string) strrchr($email, '@'), 1));
    $host = lst_host($url);
    if ($md === '' || $host === '' || in_array($md, LST_FREE_MAIL, true)) {
        return false;
    }

    return $host === $md || str_ends_with($host, '.' . $md) || str_ends_with($md, '.' . $host);
}

/** Знайдені слова-сигнали заборонених категорій. @return list<string> */
function lst_risk_words(string ...$texts): array
{
    $hay = mb_strtolower(implode("\n", $texts));
    $found = [];
    foreach (LST_RISK_WORDS as $w) {
        if (str_contains($hay, $w)) {
            $found[] = $w;
        }
    }

    return $found;
}

/**
 * Перевірка посилання наявним сервісом (app/promo-linkcheck.php: SSRF-захист, редиректи, чорний список
 * доменів, скорочувачі, Safe Browsing / Web Risk — якщо ключ налаштовано).
 *
 * @return array{status:string,flags:list<string>,notes:list<string>,final_url:?string,http_status:?int}
 */
function lst_link_check(PDO $pdo, string $url): array
{
    require_once __DIR__ . '/promo-linkcheck.php';
    try {
        $r = promo_link_checker($pdo)->check($url);
    } catch (Throwable $e) {
        error_log('[listing] link check: ' . $e->getMessage());

        return ['status' => 'error', 'flags' => ['fetch_error'], 'notes' => ['Перевірку не виконано'], 'final_url' => null, 'http_status' => null];
    }
    $flags = $r['flags'];
    $status = $r['error'] ? 'error' : ($flags === [] ? 'ok' : 'flagged');
    if ($status === 'ok' && $r['safe_browsing_status'] === 'skipped') {
        $status = 'ok';   // Safe Browsing без ключа — не помилка; модератор бачить примітку
    }

    return ['status' => $status, 'flags' => $flags, 'notes' => array_values(array_filter($r['notes'])), 'final_url' => $r['final_url'], 'http_status' => $r['http_status']];
}

/** Прапорці, з якими оголошення не приймається взагалі (ключ помилки) або null. */
function lst_link_hard_fail(array $check): ?string
{
    foreach (['ssrf_blocked', 'blocklisted', 'safe_browsing'] as $f) {
        if (in_array($f, $check['flags'], true)) {
            return 'err_link_blocked';
        }
    }

    return null;
}

/**
 * Сигнали ризику для черги модерації (не відмова, а підказка модератору).
 *
 * @return list<string> готові українські рядки (адмінка лише українською)
 */
function lst_risk_signals(PDO $pdo, array $row): array
{
    require_once __DIR__ . '/promo-linkcheck.php';
    $out = [];
    $owner = null;
    if (!empty($row['seller_user_id'])) {
        $st = $pdo->prepare('SELECT email, created_at FROM users WHERE id = :u');
        $st->execute([':u' => (int) $row['seller_user_id']]);
        $owner = $st->fetch(PDO::FETCH_ASSOC) ?: null;
    }
    $url = (string) ($row['delivery_url'] ?? '');
    if ($owner !== null) {
        $md = strtolower(substr((string) strrchr((string) $owner['email'], '@'), 1));
        if (in_array($md, LST_FREE_MAIL, true)) {
            $out[] = 'Пошта автора на безкоштовному сервісі (' . $md . ') — домен компанії не підтверджено';
        } elseif (!lst_domain_matches((string) $owner['email'], $url)) {
            $out[] = 'Домен пошти автора (' . $md . ') не збігається з доменом посилання (' . lst_host($url) . ') — перевірте вручну';
        }
        if (strtotime((string) $owner['created_at']) > time() - 86400) {
            $out[] = 'Акаунт створено менше доби тому';
        }
    }
    $check = json_decode((string) ($row['link_check_json'] ?? ''), true);
    if (is_array($check)) {
        foreach ((array) ($check['flags'] ?? []) as $f) {
            $out[] = 'Посилання: ' . (PROMO_LINK_FLAG_LABELS[$f] ?? $f);
        }
    } elseif ($url !== '') {
        $out[] = 'Посилання ще не перевірено';
    }
    $words = lst_risk_words((string) ($row['title'] ?? ''), (string) ($row['short_desc'] ?? ''), (string) ($row['full_desc'] ?? ''), (string) ($row['company_name'] ?? ''));
    if ($words !== []) {
        $out[] = 'Слова-сигнали заборонених категорій: ' . implode(', ', $words);
    }
    $links = mpb_count_links((string) ($row['full_desc'] ?? '') . "\n" . (string) ($row['short_desc'] ?? ''));
    if ($links > 0) {
        $out[] = 'Посилань в описі: ' . $links;
    }
    if (!empty($row['id'])) {
        $rep = $pdo->prepare("SELECT COUNT(*) FROM mp_reports WHERE listing_id = :id AND created_at > COALESCE(:m, '1970-01-01')");
        $rep->execute([':id' => (int) $row['id'], ':m' => $row['moderated_at'] ?? null]);
        $n = (int) $rep->fetchColumn();
        if ($n > 0) {
            $out[] = 'Скарг після останньої модерації: ' . $n;
        }
    }

    return $out;
}

/** Кількість оголошень користувача на модерації (крім $exceptId). */
function lst_pending_count(PDO $pdo, int $userId, int $exceptId = 0): int
{
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.section IN ('job', 'course', 'service') AND l.status = 'pending' AND l.id <> :ex"
    );
    $stmt->execute([':u' => $userId, ':ex' => $exceptId]);

    return (int) $stmt->fetchColumn();
}

/** Нових оголошень користувача за 24 год. */
function lst_new_today_count(PDO $pdo, int $userId): int
{
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.section IN ('job', 'course', 'service') AND l.created_at > (NOW() - INTERVAL 1 DAY)"
    );
    $stmt->execute([':u' => $userId]);

    return (int) $stmt->fetchColumn();
}

/** Підписаний час відкриття форми (мінімальний час заповнення). */
function lst_form_stamp(): string
{
    $t = (string) time();

    return $t . '.' . substr(hash_hmac('sha256', $t, mp_csrf_token()), 0, 16);
}

/** Чи минуло достатньо часу від відкриття форми (і чи підпис коректний). */
function lst_form_stamp_ok(string $stamp): bool
{
    if (preg_match('/^(\d{9,11})\.([a-f0-9]{16})$/', $stamp, $m) !== 1) {
        return false;
    }
    if (!hash_equals(substr(hash_hmac('sha256', $m[1], mp_csrf_token()), 0, 16), $m[2])) {
        return false;
    }
    $age = time() - (int) $m[1];

    return $age >= LST_MIN_FILL_SEC && $age <= 86400;
}

// =========================================================================
// Збереження й життєвий цикл
// =========================================================================

/**
 * Створює/оновлює оголошення (одна транзакція). Будь-яке збереження → status='pending' (модерація), зокрема
 * редагування схваленого оголошення. Перевірку посилання робить викликач і передає в $d['check'].
 *
 * @param array<string,mixed> $d нормалізовані поля: type, title, short_desc, full_desc, company_name, url, country,
 *                               offer_lang, is_remote, details (array), focus (list<int>), check (array)
 */
function lst_save(PDO $pdo, array $d, ?array $existing, int $userId, int $sellerId, string $lang): int
{
    $settings = lst_settings($pdo);
    $rv = trim((string) mp_config()['rules_version']);
    $rv = $rv !== '' ? mb_substr($rv, 0, 20) : null;
    $details = json_encode($d['details'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    $common = [
        ':company' => $d['company_name'], ':url' => $d['url'], ':country' => $d['country'], ':olang' => $d['offer_lang'],
        ':rem' => $d['is_remote'] ? 1 : 0, ':details' => $details, ':slug' => lst_slug($d['title']),
        ':lcs' => $d['check']['status'], ':lcj' => json_encode($d['check'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES), ':rv' => $rv,
    ];
    try {
        $pdo->beginTransaction();
        if ($existing === null) {
            $ins = $pdo->prepare(
                "INSERT INTO mp_listings
                   (section, seller_id, status, pricing_model, price_type, delivery_type, delivery_url, source_lang, is_remote,
                    company_name, country, offer_lang, details, slug, free_until, link_check_status, link_check_json, link_checked_at,
                    rules_accepted_at, rules_version, created_by)
                 VALUES (:type, :sid, 'pending', 'free', 'none', 'link', :url, :lang, :rem,
                    :company, :country, :olang, :details, :slug, :free, :lcs, :lcj, NOW(), NOW(), :rv, :cb)"
            );
            $ins->execute($common + [':type' => $d['type'], ':sid' => $sellerId, ':lang' => $lang, ':free' => $settings['free_until'] !== '' ? $settings['free_until'] : null, ':cb' => $userId]);
            $id = (int) $pdo->lastInsertId();
            $textLang = $lang;
            mp_log($pdo, $id, $userId, 'created', 'на модерації (' . $d['type'] . ')');
        } else {
            $id = (int) $existing['id'];
            $textLang = (string) $existing['source_lang'];
            $upd = $pdo->prepare(
                "UPDATE mp_listings SET status = 'pending', delivery_url = :url, is_remote = :rem, company_name = :company,
                        country = :country, offer_lang = :olang, details = :details, slug = :slug, link_check_status = :lcs,
                        link_check_json = :lcj, link_checked_at = NOW(), rules_accepted_at = NOW(), rules_version = :rv,
                        reject_reason = NULL
                 WHERE id = :id AND section IN ('job', 'course', 'service')"
            );
            $upd->execute($common + [':id' => $id]);
            mp_log($pdo, $id, $userId, 'edited', 'після редагування — на модерації (було: ' . $existing['status'] . ')');
        }

        $pdo->prepare(
            "INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, is_auto)
             VALUES (:id, :lang, :t, :s, :f, 0)
             ON DUPLICATE KEY UPDATE title = VALUES(title), short_desc = VALUES(short_desc), full_desc = VALUES(full_desc), is_auto = 0"
        )->execute([':id' => $id, ':lang' => $textLang, ':t' => $d['title'], ':s' => $d['short_desc'], ':f' => $d['full_desc'] !== '' ? $d['full_desc'] : null]);
        $pdo->prepare('DELETE FROM mp_listing_translations WHERE listing_id = :id AND lang <> :lang AND is_auto = 1')
            ->execute([':id' => $id, ':lang' => $textLang]);

        $pdo->prepare('DELETE FROM mp_listing_categories WHERE listing_id = :id')->execute([':id' => $id]);
        $lc = $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:id, :c)');
        foreach ($d['focus'] as $cid) {
            $lc->execute([':id' => $id, ':c' => (int) $cid]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }

    return $id;
}

/** Строк дії від зараз: строк оголошення, але не пізніше дати закінчення подання (вакансія). SQL-вираз. */
function lst_expiry_sql(PDO $pdo, array $row): string
{
    $days = lst_settings($pdo)['days'];
    $expr = "NOW() + INTERVAL $days DAY";
    $apply = (string) (lst_details($row)['apply_until'] ?? '');
    if (($row['section'] ?? '') === 'job' && preg_match('/^\d{4}-\d{2}-\d{2}$/', $apply) === 1) {
        $expr = "LEAST($expr, '" . $apply . " 23:59:59')";
    }

    return $expr;
}

/** pending → published. false — оголошення вже не pending. */
function lst_approve(PDO $pdo, int $id, int $actorId): bool
{
    $st = $pdo->prepare("SELECT * FROM mp_listings WHERE id = :id AND section IN ('job', 'course', 'service')");
    $st->execute([':id' => $id]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return false;
    }
    $exp = lst_expiry_sql($pdo, $row);
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'published', published_at = COALESCE(published_at, NOW()), expires_at = $exp,
                moderated_by = :a, moderated_at = NOW(), reject_reason = NULL, expiry_notified_at = NULL
         WHERE id = :id AND status = 'pending' AND section IN ('job', 'course', 'service')"
    );
    $upd->execute([':a' => $actorId, ':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'approved');
    lst_mail($pdo, $id, 'approved');

    return true;
}

/** pending або published → rejected із причиною (шаблон + необов'язковий коментар). */
function lst_reject(PDO $pdo, int $id, int $actorId, string $reason): bool
{
    $reason = mb_substr(trim($reason), 0, 500);
    if ($reason === '') {
        return false;
    }
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'rejected', reject_reason = :r, moderated_by = :a, moderated_at = NOW()
         WHERE id = :id AND status IN ('pending', 'published') AND section IN ('job', 'course', 'service')"
    );
    $upd->execute([':r' => $reason, ':a' => $actorId, ':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'rejected', $reason);
    lst_mail($pdo, $id, 'rejected', ['reason' => $reason]);

    return true;
}

/** Зняти з публікації (власник або модератор): → archived. */
function lst_remove(PDO $pdo, int $id, int $actorId, string $note = ''): bool
{
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'archived'
         WHERE id = :id AND status IN ('draft', 'pending', 'published', 'expired', 'rejected') AND section IN ('job', 'course', 'service')"
    );
    $upd->execute([':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'archived', $note !== '' ? $note : null);

    return true;
}

/** Продовжити (поки безкоштовно). @return string 'ok' або ключ помилки lst_tr */
function lst_extend(PDO $pdo, array $own, int $userId): string
{
    $status = (string) $own['status'];
    if ($status === 'published' && (int) ($own['elapsed'] ?? 0) === 1) {
        $status = 'expired';
    }
    if (!in_array($status, ['published', 'expired'], true)) {
        return 'err_extend_status';
    }
    if ($status === 'published' && strtotime((string) $own['expires_at']) > time() + LST_EXTEND_WINDOW_DAYS * 86400) {
        return 'err_extend_early';
    }
    $apply = (string) (lst_details($own)['apply_until'] ?? '');
    if ($own['section'] === 'job' && $apply !== '' && $apply < date('Y-m-d')) {
        return 'err_extend_deadline';
    }
    $exp = lst_expiry_sql($pdo, $own);
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'published', expires_at = $exp, expiry_notified_at = NULL
         WHERE id = :id AND status IN ('published', 'expired') AND section IN ('job', 'course', 'service')"
    );
    $upd->execute([':id' => (int) $own['id']]);
    if ($upd->rowCount() === 0) {
        return 'err_extend_status';
    }
    mp_log($pdo, (int) $own['id'], $userId, 'extended');

    return 'ok';
}

/** published із минулим expires_at → expired. */
function lst_expire_due(PDO $pdo): int
{
    $ids = $pdo->query(
        "SELECT id FROM mp_listings WHERE section IN ('job', 'course', 'service') AND status = 'published'
           AND expires_at IS NOT NULL AND expires_at <= NOW()"
    )->fetchAll(PDO::FETCH_COLUMN);
    $upd = $pdo->prepare("UPDATE mp_listings SET status = 'expired' WHERE id = :id AND status = 'published' AND expires_at <= NOW()");
    $n = 0;
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
// Статистика: перегляди й переходи (без персональних даних)
// =========================================================================

/** Чи рахувати цей запит: не бот, не власник. */
function lst_countable(?int $ownerUserId): bool
{
    require_once __DIR__ . '/analytics.php';
    if (analytics_device_class() === 'bot') {
        return false;
    }

    return !($ownerUserId !== null && $ownerUserId === auth_user_id());
}

function lst_stat_bump(PDO $pdo, int $id, string $col): void
{
    $col = $col === 'clicks' ? 'clicks' : 'views';
    try {
        $pdo->prepare("INSERT INTO mp_listing_stats_daily (listing_id, day, $col) VALUES (:id, CURDATE(), 1)
                       ON DUPLICATE KEY UPDATE $col = $col + 1")->execute([':id' => $id]);
    } catch (Throwable $e) {
        error_log('[listing] stats: ' . $e->getMessage());
    }
}

/** Перегляд: 1 раз на сесію на оголошення. */
function lst_count_view(PDO $pdo, int $id, ?int $ownerUserId): void
{
    if (!empty($_SESSION['lst_viewed'][$id]) || !lst_countable($ownerUserId)) {
        return;
    }
    $_SESSION['lst_viewed'][$id] = 1;
    lst_stat_bump($pdo, $id, 'views');
}

/** Перехід: не частіше 1 разу на 30 хв у сесії на оголошення. */
function lst_count_click(PDO $pdo, int $id, ?int $ownerUserId): void
{
    $last = (int) ($_SESSION['lst_clicked'][$id] ?? 0);
    if ($last > time() - 1800 || !lst_countable($ownerUserId)) {
        return;
    }
    $_SESSION['lst_clicked'][$id] = time();
    lst_stat_bump($pdo, $id, 'clicks');
}

/** Сума переглядів і переходів за N днів. @param list<int> $ids @return array<int,array{views:int,clicks:int}> */
function lst_stats(PDO $pdo, array $ids, int $days = 30): array
{
    $ids = array_values(array_unique(array_map('intval', $ids)));
    if ($ids === []) {
        return [];
    }
    $in = implode(',', array_fill(0, count($ids), '?'));
    $st = $pdo->prepare(
        "SELECT listing_id, SUM(views) AS v, SUM(clicks) AS c FROM mp_listing_stats_daily
         WHERE listing_id IN ($in) AND day > (CURDATE() - INTERVAL " . max(1, $days) . ' DAY) GROUP BY listing_id'
    );
    $st->execute($ids);
    $out = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $out[(int) $r['listing_id']] = ['views' => (int) $r['v'], 'clicks' => (int) $r['c']];
    }

    return $out;
}

// =========================================================================
// Скарги
// =========================================================================

/** @return string ok | duplicate | own | invalid | notfound | rate */
function lst_report(PDO $pdo, int $listingId, int $userId, string $reason, string $note): string
{
    if (!in_array($reason, MPB_REPORT_REASONS, true)) {
        return 'invalid';
    }
    $st = $pdo->prepare('SELECT l.id, s.user_id AS owner FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE l.id = :id AND ' . lst_visible_sql());
    $st->execute([':id' => $listingId]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return 'notfound';
    }
    if ($row['owner'] !== null && (int) $row['owner'] === $userId) {
        return 'own';
    }
    if (!mp_is_staff() && !mpb_ip_hit($pdo, 'report', (int) mp_config()['ip_limit_report'])) {
        return 'rate';
    }
    try {
        $pdo->prepare('INSERT INTO mp_reports (listing_id, reporter_id, reason, note) VALUES (:l, :u, :r, :n)')
            ->execute([':l' => $listingId, ':u' => $userId, ':r' => $reason, ':n' => $note !== '' ? mb_substr($note, 0, 500) : null]);
    } catch (PDOException $e) {
        if ((int) ($e->errorInfo[1] ?? 0) === 1062) {
            return 'duplicate';
        }
        throw $e;
    }
    // Достатньо унікальних скарг після останньої модерації → назад на модерацію.
    $cnt = $pdo->prepare("SELECT COUNT(*) FROM mp_reports r JOIN mp_listings l ON l.id = r.listing_id
                          WHERE l.id = :id AND r.created_at > COALESCE(l.moderated_at, '1970-01-01 00:00:00')");
    $cnt->execute([':id' => $listingId]);
    if ((int) $cnt->fetchColumn() >= (int) mp_config()['reports_threshold']) {
        $upd = $pdo->prepare("UPDATE mp_listings SET status = 'pending' WHERE id = :id AND status = 'published'");
        $upd->execute([':id' => $listingId]);
        if ($upd->rowCount() > 0) {
            mp_log($pdo, $listingId, null, 'auto_pending', 'скарги — повернуто на модерацію');
        }
    }

    return 'ok';
}

// =========================================================================
// Розмітка schema.org (лише з повними даними)
// =========================================================================

/** Абсолютна адреса сайту без кінцевого «/». */
function lst_site_url(): string
{
    $u = mpv_site_url();
    if ($u === null || $u === '') {
        require_once __DIR__ . '/mailer.php';
        $u = mail_site_url();
    }

    return rtrim((string) $u, '/');
}

/** Дата-час у ISO 8601 зі зсувом часового поясу PHP. */
function lst_iso(string $value): string
{
    $ts = strtotime($value);

    return $ts === false ? '' : date('c', $ts);
}

/** Опис як HTML-абзаци (Google вимагає HTML з розривами абзаців для JobPosting.description). */
function lst_desc_html(string $text): string
{
    $paras = preg_split("/\n{2,}/", trim($text)) ?: [];

    return implode('', array_map(static fn(string $p): string => '<p>' . nl2br(htmlspecialchars(trim($p), ENT_QUOTES)) . '</p>', $paras));
}

/**
 * JSON-LD для сторінки оголошення або null, якщо обов'язкових полів не вистачає / оголошення не живе.
 *
 * JobPosting (Google): обов'язкові title, description, datePosted, hiringOrganization, jobLocation
 * (для 100% віддалених — замість нього jobLocationType=TELECOMMUTE + applicantLocationRequirements);
 * validThrough — обов'язкове для оголошень із терміном (у нас термін є завжди).
 * Course: name, description, provider.
 */
function lst_jsonld(array $row): ?array
{
    if ((int) ($row['is_live'] ?? 0) !== 1) {
        return null;
    }
    $title = trim((string) ($row['title'] ?? ''));
    $desc = trim((string) ($row['full_desc'] ?? '')) !== '' ? (string) $row['full_desc'] : (string) ($row['short_desc'] ?? '');
    $company = trim((string) ($row['company_name'] ?? ''));
    $d = $row['detail'] ?? lst_details($row);
    $url = lst_site_url() . '/' . lst_url($row);
    if ($title === '' || trim($desc) === '' || trim($desc) === $title || $company === '') {
        return null;
    }

    if ($row['section'] === 'job') {
        $country = strtoupper((string) ($row['country'] ?? ''));
        if (empty($row['published_at']) || empty($row['expires_at']) || !isset(LST_COUNTRIES[$country]) || $country === 'XX') {
            return null;
        }
        $validThrough = (string) $row['expires_at'];
        $ld = [
            '@context' => 'https://schema.org/',
            '@type' => 'JobPosting',
            'title' => $title,
            'description' => lst_desc_html($desc),
            'datePosted' => date('Y-m-d', (int) strtotime((string) $row['published_at'])),
            'validThrough' => lst_iso($validThrough),
            'hiringOrganization' => ['@type' => 'Organization', 'name' => $company],
            'directApply' => false,
            'url' => $url,
        ];
        if ((int) $row['is_remote'] === 1) {
            $ld['jobLocationType'] = 'TELECOMMUTE';
            $ld['applicantLocationRequirements'] = ['@type' => 'Country', 'name' => $country];
        } else {
            $addr = ['@type' => 'PostalAddress', 'addressCountry' => $country];
            if (!empty($d['city'])) {
                $addr['addressLocality'] = (string) $d['city'];
            }
            $ld['jobLocation'] = ['@type' => 'Place', 'address' => $addr];
        }
        $emp = ['full_time' => 'FULL_TIME', 'part_time' => 'PART_TIME', 'contract' => 'CONTRACTOR', 'internship' => 'INTERN', 'temporary' => 'TEMPORARY'];
        if (isset($emp[$d['employment'] ?? ''])) {
            $ld['employmentType'] = $emp[$d['employment']];
        }
        if (isset($d['salary_min']) || isset($d['salary_max'])) {
            $val = ['@type' => 'QuantitativeValue', 'unitText' => (string) ($d['salary_period'] ?? 'MONTH')];
            if (isset($d['salary_min'], $d['salary_max'])) {
                $val['minValue'] = (int) $d['salary_min'];
                $val['maxValue'] = (int) $d['salary_max'];
            } else {
                $val['value'] = (int) ($d['salary_min'] ?? $d['salary_max']);
            }
            $ld['baseSalary'] = ['@type' => 'MonetaryAmount', 'currency' => (string) ($d['salary_currency'] ?? 'USD'), 'value' => $val];
        }

        return $ld;
    }

    if ($row['section'] === 'course') {
        $provider = ['@type' => 'Organization', 'name' => $company];
        $host = lst_host((string) ($row['delivery_url'] ?? ''));
        if ($host !== '') {
            $provider['sameAs'] = 'https://' . $host;
        }

        return [
            '@context' => 'https://schema.org/',
            '@type' => 'Course',
            'name' => $title,
            'description' => mb_substr(trim(preg_replace('/\s+/u', ' ', $desc) ?? ''), 0, 500),
            'provider' => $provider,
            'url' => $url,
        ];
    }

    return null;   // для послуг Google окремого розширеного результату не має — розмітку не виводимо
}

// =========================================================================
// Листи власнику (черга mail_queue, відправляє cron/promo-mail.php)
// =========================================================================

/**
 * Лист власнику оголошення. $event: received | approved | rejected | expiring | report.
 * Мова листа — мова тексту оголошення (en → англійська, інакше українська).
 */
function lst_mail(PDO $pdo, int $id, string $event, array $extra = []): bool
{
    require_once __DIR__ . '/promo-mail.php';
    $st = $pdo->prepare(
        "SELECT l.id, l.section, l.slug, l.source_lang, l.expires_at, l.published_at, u.email, u.name, t.title
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id JOIN users u ON u.id = s.user_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE l.id = :id"
    );
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false || filter_var((string) $r['email'], FILTER_VALIDATE_EMAIL) === false) {
        return false;
    }
    $lang = (string) $r['source_lang'] === 'en' ? 'en' : 'uk';
    $site = lst_site_url();
    $vars = [
        'title' => (string) $r['title'],
        'url' => $site . '/' . lst_url($r),
        'cabinet' => $site . '/account.php#acc-listings',
        'expires' => lst_date_lang((string) $r['expires_at'], $lang),
        'reason' => (string) ($extra['reason'] ?? ''),
        'views' => (string) ($extra['views'] ?? '0'),
        'clicks' => (string) ($extra['clicks'] ?? '0'),
        'rules' => $site . '/marketplace-rules.php',
    ];
    $subject = lst_tr_lang('mail_' . $event . '_subject', $lang, $vars);
    $body = lst_tr_lang('mail_' . $event . '_body', $lang, $vars) . "\n\n" . lst_tr_lang('mail_footer', $lang, $vars);
    $html = '<div style="font-family:Arial,sans-serif;font-size:15px;line-height:1.55;color:#1d2433">'
        . nl2br(preg_replace('~(https?://[^\s<]+)~', '<a href="$1" style="color:#2f5bd3">$1</a>', htmlspecialchars($body, ENT_QUOTES)) ?? '') . '</div>';

    return promo_mail_enqueue($pdo, (string) $r['email'], (string) $r['name'], $subject, $body, $html, $lang);
}

function lst_date_lang(string $value, string $lang): string
{
    $ts = strtotime($value);
    if ($value === '' || $ts === false) {
        return '';
    }

    return $lang === 'en' ? date('M j, Y', $ts) : date('d.m.Y', $ts);
}

// =========================================================================
// Щоденне обслуговування (cron/marketplace-daily.php)
// =========================================================================

/** Прострочення, листи «скоро спливає» й звіти за 30 днів. Повертає короткий підсумок для cron_runs. */
function lst_daily(PDO $pdo): string
{
    // Дати в mp_listings пишуться з NOW() вебзапитів (часовий пояс сервера БД) — у cron повертаємо той самий пояс.
    try {
        $pdo->exec('SET time_zone = @@global.time_zone');
    } catch (Throwable) {
    }
    $expired = lst_expire_due($pdo);

    $notice = 0;
    $rows = $pdo->query(
        "SELECT id FROM mp_listings WHERE section IN ('job', 'course', 'service') AND status = 'published'
           AND expiry_notified_at IS NULL AND expires_at > NOW() AND expires_at <= NOW() + INTERVAL " . LST_EXPIRY_NOTICE_DAYS . ' DAY LIMIT 200'
    )->fetchAll(PDO::FETCH_COLUMN);
    foreach ($rows as $id) {
        if (lst_mail($pdo, (int) $id, 'expiring')) {
            $notice++;
        }
        $pdo->prepare('UPDATE mp_listings SET expiry_notified_at = NOW() WHERE id = :id')->execute([':id' => (int) $id]);
    }

    $reports = 0;
    $rows = $pdo->query(
        "SELECT id FROM mp_listings WHERE section IN ('job', 'course', 'service') AND status IN ('published', 'expired')
           AND report_sent_at IS NULL AND published_at IS NOT NULL AND published_at <= NOW() - INTERVAL " . LST_REPORT_AFTER_DAYS . ' DAY LIMIT 200'
    )->fetchAll(PDO::FETCH_COLUMN);
    $stats = lst_stats($pdo, array_map('intval', $rows), LST_REPORT_AFTER_DAYS);
    foreach ($rows as $id) {
        $s = $stats[(int) $id] ?? ['views' => 0, 'clicks' => 0];
        if (lst_mail($pdo, (int) $id, 'report', ['views' => $s['views'], 'clicks' => $s['clicks']])) {
            $reports++;
        }
        $pdo->prepare('UPDATE mp_listings SET report_sent_at = NOW() WHERE id = :id')->execute([':id' => (int) $id]);
    }

    return 'expired=' . $expired . ' expiring_mails=' . $notice . ' reports=' . $reports;
}

// =========================================================================
// Відображення (спільне для списку, сторінки, кабінету й адмінки)
// =========================================================================

/** Підпис значення зі списку деталей (v_*), або саме значення. */
function lst_v(string $value): string
{
    return isset(LST_I18N['v_' . $value]) ? lst_tr('v_' . $value) : $value;
}

function lst_money(int $amount, string $currency): string
{
    return number_format($amount, 0, ',', "\u{00A0}") . "\u{00A0}" . $currency;
}

/** Ціна / зарплата одним рядком або ''. */
function lst_price_label(array $row): string
{
    $d = $row['detail'] ?? lst_details($row);
    switch ($row['section']) {
        case 'job':
            if (!isset($d['salary_min']) && !isset($d['salary_max'])) {
                return '';
            }
            $cur = (string) ($d['salary_currency'] ?? 'USD');
            $txt = isset($d['salary_min'], $d['salary_max'])
                ? number_format((int) $d['salary_min'], 0, ',', "\u{00A0}") . '–' . lst_money((int) $d['salary_max'], $cur)
                : (isset($d['salary_min']) ? lst_tr('from', lst_money((int) $d['salary_min'], $cur)) : lst_money((int) $d['salary_max'], $cur));

            return $txt . ' ' . lst_tr('per', lst_v((string) ($d['salary_period'] ?? 'MONTH')));
        case 'course':
            if (($d['is_free'] ?? '0') === '1') {
                return lst_tr('free');
            }

            return isset($d['price']) ? lst_money((int) $d['price'], (string) ($d['currency'] ?? 'USD')) : '';
        default:
            return isset($d['price_from']) ? lst_tr('from', lst_money((int) $d['price_from'], (string) ($d['currency'] ?? 'USD'))) : '';
    }
}

/** Місце: «Київ, Україна · віддалено». */
function lst_location_label(array $row): string
{
    $d = $row['detail'] ?? lst_details($row);
    $parts = [];
    if (!empty($d['city'])) {
        $parts[] = (string) $d['city'];
    }
    $c = lst_country_name($row['country'] ?? null);
    if ($c !== '') {
        $parts[] = $c;
    }
    $txt = implode(', ', $parts);
    if ((int) ($row['is_remote'] ?? 0) === 1) {
        $txt .= ($txt !== '' ? ' · ' : '') . lst_tr('remote');
    }

    return $txt;
}

/** Факти для сторінки оголошення. @return list<array{0:string,1:string}> */
function lst_facts(array $row): array
{
    $d = $row['detail'] ?? lst_details($row);
    $f = [];
    if (!empty($row['company_name'])) {
        $f[] = [lst_tr('company'), (string) $row['company_name']];
    }
    $loc = lst_location_label($row);
    if ($loc !== '') {
        $f[] = [lst_tr('location'), $loc];
    }
    $price = lst_price_label($row);
    $map = [
        'job' => ['employment' => 'd_employment', 'level' => 'd_level'],
        'course' => ['format' => 'd_format', 'level' => 'd_level', 'duration' => 'd_duration', 'start_date' => 'd_start_date'],
        'service' => ['service_type' => 'd_service_type', 'delivery_time' => 'd_delivery_time'],
    ][$row['section']] ?? [];
    foreach ($map as $k => $label) {
        if (isset($d[$k]) && $d[$k] !== '') {
            $val = $k === 'start_date' ? lst_date((string) $d[$k]) : lst_v((string) $d[$k]);
            $f[] = [lst_tr($label), $val];
        }
    }
    if ($price !== '') {
        $f[] = [lst_tr($row['section'] === 'job' ? 'd_salary' : 'd_price'), $price];
    }
    if (!empty($row['offer_lang'])) {
        $f[] = [lst_tr('f_lang'), lst_tr('lang_' . $row['offer_lang'])];
    }
    if ($row['section'] === 'job' && !empty($d['apply_until'])) {
        $f[] = [lst_tr('d_apply_until'), lst_date((string) $d['apply_until'])];
    }

    return $f;
}

/** Картка для списку. */
function lst_card_html(array $row): string
{
    $url = lst_url($row);
    $meta = array_filter([lst_location_label($row), !empty($row['published_at']) ? lst_date((string) $row['published_at']) : '']);
    $price = lst_price_label($row);
    $lang = (string) ($row['text_lang'] ?? '') !== current_lang() ? ' lang="' . lst_e($row['text_lang']) . '"' : '';
    $tags = '';
    foreach (array_slice($row['categories'] ?? [], 0, 3) as $c) {
        $tags .= '<span class="mp-badge">' . lst_e($c['name']) . '</span> ';
    }

    return '<article class="mp-card lst-card">'
        . '<p class="mp-card__tag">' . lst_e(lst_tr('type1_' . $row['section'])) . ' · ' . lst_e((string) $row['company_name']) . '</p>'
        . '<h3 class="mp-card__name"><a href="' . lst_e($url) . '"' . $lang . '>' . lst_e($row['title']) . '</a></h3>'
        . (!empty($row['short_desc']) ? '<p class="mp-card__desc mp-card__info"' . $lang . '>' . lst_e($row['short_desc']) . '</p>' : '')
        . ($price !== '' ? '<p class="mp-card__price mp-card__info">' . lst_e($price) . '</p>' : '')
        . ($tags !== '' ? '<p class="lst-card__tags">' . $tags . '</p>' : '')
        . '<div class="mp-card__meta mp-card__info">' . implode('', array_map(static fn($m) => '<span>' . lst_e($m) . '</span>', $meta)) . '</div>'
        . '</article>';
}

/** Перемикач розділів (вакансії / курси / послуги). */
function lst_type_nav(string $active, string $base = 'listings.php'): string
{
    $html = '<nav class="mp-tabs lst-types" aria-label="' . lst_e(lst_tr('other_types')) . '">';
    foreach (LST_TYPES as $t) {
        $html .= '<a class="mp-tab' . ($t === $active ? ' is-active' : '') . '" href="' . $base . '?type=' . $t . '"'
            . ($t === $active ? ' aria-current="page"' : '') . '>' . lst_e(lst_tr('type_' . $t)) . '</a>';
    }

    return $html . '</nav>';
}

/** Блок «Що не можна розміщувати». */
function lst_rules_html(): string
{
    $items = array_map(static fn(string $l): string => '<li>' . lst_e($l) . '</li>', explode("\n", lst_tr('rules_list')));

    return '<details class="mp-report lst-rules"><summary>' . lst_e(lst_tr('rules_title')) . '</summary><ul>' . implode('', $items)
        . '</ul><p class="mp-hint"><a href="marketplace-rules.php">' . lst_e(lst_tr('f_rules_link')) . '</a></p></details>';
}

/**
 * Початок сторінки розділу, як mpb_open(), але з додатковими тегами в <head> (canonical, JSON-LD).
 * $head — уже екранований HTML. Закривати mpb_close().
 */
function lst_open(string $title, bool $noindex, string $head = '', string $nav = 'board'): void
{
    $lang = current_lang();
    echo "<!DOCTYPE html>\n<html lang=\"" . lst_e($lang) . "\">\n<head>\n<meta charset=\"utf-8\">\n"
        . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
        . ($noindex ? "<meta name=\"robots\" content=\"noindex, nofollow\">\n" : '')
        . '<title>' . lst_e($title) . ' — ' . lst_e(t('title_marketplace')) . "</title>\n" . $head . "\n";
    include __DIR__ . '/header.php';
    echo "\n<link rel=\"stylesheet\" href=\"/assets/css/site-nav.css\">\n"
        . '<link rel="stylesheet" href="' . css_asset('mp-public.css') . "\">\n</head>\n<body class=\"mp-body\">\n";
    include __DIR__ . '/site-header.php';
    if ($nav !== '') {
        echo mp_section_nav($nav);
    }
}

<?php

declare(strict_types=1);

/**
 * AI LAB HUB — донати.
 *
 * Публікується ЛИШЕ посилання на банку monobank (рішення власниці, 2026-11-15):
 * номер картки, IBAN, ПІБ тощо на сайті не показуються й формою не редагуються.
 *
 * Значення живуть в одному місці — таблиці site_settings (ключі donate_*), яку
 * не чіпають ні релізи (scripts/build-deploy.ps1 не містить config/ і жодних
 * значень), ні SQL-міграції (лише INSERT IGNORE для відсутніх ключів). Вводить
 * їх адмін у кабінеті (розділ «Донати»). Жодних реальних значень у коді, git чи SQL.
 *
 * Сторінка — public/donate.php, адмінка — app/donations-admin.php,
 * обробник форми — public/donations-admin-action.php,
 * перевірка «наживо» — scripts/check-donate-live.php.
 */

require_once __DIR__ . '/site-settings.php';

/**
 * Поля, які редагує форма й читає сторінка (ключ site_settings → правило).
 * Інші старі ключі donate_* (картка, IBAN, ПІБ…) у БД не зачіпаються: форма їх
 * не перезаписує, сторінка не показує.
 */
const DONATE_FIELDS = [
    'donate_enabled'  => 'flag',
    'donate_jar_url'  => 'jar',
    'donate_show_qr'  => 'flag',
    'donate_text_uk'  => 'longtext:2000',
    'donate_text_en'  => 'longtext:2000',
];

/** Дозволені хости посилання на банку. */
const DONATE_JAR_HOSTS = ['send.monobank.ua', 'monobank.ua'];

/** Чи це коректне посилання на банку monobank (https, хост зі списку, без логіна/пробілів/лапок). */
function donate_jar_url_ok(string $url): bool
{
    if ($url === '' || mb_strlen($url) > 500 || preg_match('/[\s<>"\'\\\\]/', $url)) {
        return false;
    }
    $p = parse_url($url);
    if (!is_array($p) || strtolower((string) ($p['scheme'] ?? '')) !== 'https'
        || isset($p['user']) || isset($p['pass']) || isset($p['port'])) {
        return false;
    }

    return in_array(strtolower((string) ($p['host'] ?? '')), DONATE_JAR_HOSTS, true);
}

/**
 * Перевірити й нормалізувати форму адмінки.
 *
 * @return array{0:array<string,string>,1:list<string>} [значення для збереження, помилки]
 */
function donate_validate(array $in): array
{
    $values = [];
    $errors = [];
    $labels = donate_field_labels();
    foreach (DONATE_FIELDS as $key => $rule) {
        $raw = trim(str_replace("\r\n", "\n", is_string($in[$key] ?? null) ? $in[$key] : ''));
        [$type, $max] = array_pad(explode(':', $rule, 2), 2, null);
        $label = $labels[$key] ?? $key;

        if ($type === 'flag') {
            $values[$key] = !empty($in[$key]) ? '1' : '0';
            continue;
        }
        if ($raw === '') {
            $values[$key] = '';
            continue;
        }
        if (!mb_check_encoding($raw, 'UTF-8')) {
            $errors[] = "{$label}: текст містить некоректні символи (кодування). Введіть його ще раз.";
            continue;
        }
        if ($type === 'jar') {
            if (!donate_jar_url_ok($raw)) {
                $errors[] = "{$label}: потрібна повна адреса https:// на send.monobank.ua або monobank.ua.";
                continue;
            }
            $values[$key] = $raw;
            continue;
        }
        // longtext
        $txt = strip_tags($raw);
        if (mb_strlen($txt) > (int) $max) {
            $errors[] = "{$label}: не довше {$max} символів.";
            continue;
        }
        $values[$key] = $txt;
    }

    return [$values, $errors];
}

/** @return array<string,string> */
function donate_field_labels(): array
{
    return [
        'donate_enabled' => 'Увімкнути сторінку донатів',
        'donate_jar_url' => 'Посилання на банку monobank',
        'donate_show_qr' => 'Показувати QR-код для посилання',
        'donate_text_uk' => 'Додатковий текст (UA)',
        'donate_text_en' => 'Додатковий текст (EN)',
    ];
}

/** Поточні значення (з порожніми за замовчуванням). @return array<string,string> */
function donate_config(PDO $pdo): array
{
    $all = site_settings($pdo);
    $out = [];
    foreach (array_keys(DONATE_FIELDS) as $k) {
        $out[$k] = (string) ($all[$k] ?? '');
    }

    return $out;
}

/**
 * Стан налаштування без значень: для сторінки «Стан сайту» в CRM і перевірок.
 *
 * @return array{configured:bool,enabled:bool,jar:string} jar: 'є' | 'порожнє' | 'відсутнє' | 'некоректне'
 */
function donate_status(PDO $pdo): array
{
    $all = site_settings($pdo);
    $enabled = ($all['donate_enabled'] ?? '') === '1';
    if (!array_key_exists('donate_jar_url', $all)) {
        $jar = 'відсутнє';
    } elseif (trim($all['donate_jar_url']) === '') {
        $jar = 'порожнє';
    } elseif (!donate_jar_url_ok(trim($all['donate_jar_url']))) {
        $jar = 'некоректне';
    } else {
        $jar = 'є';
    }

    return ['configured' => $enabled && $jar === 'є', 'enabled' => $enabled, 'jar' => $jar];
}

/** HTML-попередження для адмінки, якщо донати не налаштовані ('' — усе гаразд). */
function donate_status_warning_html(PDO $pdo): string
{
    $s = donate_status($pdo);
    if ($s['configured']) {
        return '';
    }
    $why = [];
    if (!$s['enabled']) {
        $why[] = 'сторінку вимкнено';
    }
    if ($s['jar'] !== 'є') {
        $why[] = 'посилання на банку: ' . $s['jar'];
    }

    return '<p class="dn-warn" role="alert" style="margin:0 0 12px;padding:10px 14px;border-radius:10px;'
        . 'background:rgba(251,191,36,.16);border:1px solid rgba(251,191,36,.6);color:#fff;">'
        . '⚠ <strong>Донати не налаштовано</strong> (' . htmlspecialchars(implode(', ', $why), ENT_QUOTES)
        . '): на <a href="donate.php" style="color:#ffe08a">donate.php</a> відвідувачі бачать «Скоро». '
        . 'Вставте посилання в <a href="account.php#acc-donate" style="color:#ffe08a">Кабінет → Донати</a>.</p>';
}

/** Актуальна роль admin за БД. */
function donate_is_admin(PDO $pdo, ?int $userId): bool
{
    if ($userId === null) {
        return false;
    }
    $st = $pdo->prepare('SELECT role FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return $st->fetchColumn() === 'admin';
}

function donate_csrf_token(): string
{
    if (empty($_SESSION['donate_csrf']) || !is_string($_SESSION['donate_csrf'])) {
        $_SESSION['donate_csrf'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['donate_csrf'];
}

function donate_csrf_verify(): bool
{
    $sent = $_POST['csrf'] ?? '';

    return is_string($sent) && $sent !== '' && hash_equals(donate_csrf_token(), $sent);
}
